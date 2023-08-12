function varargout = adquisicion(varargin)
% ADQUISICION MATLAB code for adquisicion.fig
%      ADQUISICION, by itself, creates a new ADQUISICION or raises the existing
%      singleton*.
%
%      H = ADQUISICION returns the handle to a new ADQUISICION or the handle to
%      the existing singleton*.
%
%      ADQUISICION('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in ADQUISICION.M with the given input arguments.
%
%      ADQUISICION('Property','Value',...) creates a new ADQUISICION or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before adquisicion_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to adquisicion_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help adquisicion

% Last Modified by GUIDE v2.5 20-Jun-2023 22:17:07

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @adquisicion_OpeningFcn, ...
                   'gui_OutputFcn',  @adquisicion_OutputFcn, ...
                   'gui_LayoutFcn',  [] , ...
                   'gui_Callback',   []);
if nargin && ischar(varargin{1})
    gui_State.gui_Callback = str2func(varargin{1});
end

if nargout
    [varargout{1:nargout}] = gui_mainfcn(gui_State, varargin{:});
else
    gui_mainfcn(gui_State, varargin{:});
end
% End initialization code - DO NOT EDIT
end

% --- Executes just before adquisicion is made visible.
function adquisicion_OpeningFcn(hObject,eventdata, handles, varargin)

% Choose default command line output for adquisicion
handles.output = hObject;
global gds_interface n_canales
% sensorhandles=guidata(sensors_eeg);
% tabla=get(sensorhandles.tbl_location,'Data');
% n_canales=length(tabla(:,1));
n_canales=4;
a = imread('play.png');
[r,c]=size(a);
x= ceil(r/21);
y= ceil(c/81);
g=a(1:x:end,1:y:end,:);
g(g==255)=0.8*255;
set(handles.btn_iniciar,'CData',g);
a = imread('pausa.jpg');
[r,c]=size(a);
x= ceil(r/21);
y= ceil(c/81);
g=a(1:x:end,1:y:end,:);
g(g==255)=0.8*255;
set(handles.btn_pausa,'CData',g);
a = imread('stop.jpg');
[r,c]=size(a);
x= ceil(r/21);
y= ceil(c/81);
g=a(1:x:end,1:y:end,:);
g(g==255)=0.8*255;
set(handles.btn_stop,'CData',g);

%---------------------------------------------
gds_interface = gtecDeviceInterface(); % create gtecDeviceInterface object

gds_interface.IPAddressHost = '127.0.0.1'; % define connection settings (loopback)
gds_interface.IPAddressLocal = '127.0.0.1';
gds_interface.LocalPort = 50224;
gds_interface.HostPort = 50223;

connected_devices = gds_interface.GetConnectedDevices(); % get connected devices

% create g.USBamp configuration object
gusbamp_config = gUSBampDeviceConfiguration();
% set serial number in g.USBamp device configuration
gusbamp_config.Name = connected_devices(1,1).Name;

% set configuration to use functions in gds interface which require device connection
gds_interface.DeviceConfigurations = gusbamp_config;

% get available channels
available_channels = gds_interface.GetAvailableChannels();

% edit configuration to have a sampling rate of 256Hz, 8 scans and to record all 16 analog channels.
% Acquire all available channels of g.USBamp with the internal signal generator of g.USBamp+/- 200mV, 10Hz) and the counter on channel 16.
gusbamp_config.SamplingRate = 256;
gusbamp_config.NumberOfScans = 8;
gusbamp_config.CommonGround = false(1,4);
gusbamp_config.CommonReference = false(1,4);
gusbamp_config.ShortCutEnabled = false;
gusbamp_config.CounterEnabled = true;
gusbamp_config.TriggerEnabled = false;
gusbamp_siggen = gUSBampInternalSignalGenerator();
gusbamp_siggen.Enabled = false;
gusbamp_siggen.Frequency = 10;
gusbamp_siggen.WaveShape = 3;
gusbamp_siggen.Amplitude = 200;
gusbamp_siggen.Offset = 0;
gusbamp_config.InternalSignalGenerator = gusbamp_siggen;

for i=1:size(gusbamp_config.Channels,2)
    if (available_channels(1,i))
    	gusbamp_config.Channels(1,i).Available = true;
        gusbamp_config.Channels(1,i).Acquire = true;
        % do not use filters
        gusbamp_config.Channels(1,i).BandpassFilterIndex = -1;
        gusbamp_config.Channels(1,i).NotchFilterIndex = -1;
        % do not use a bipolar channel
        gusbamp_config.Channels(1,i).BipolarChannel = 0;
    end
end

% apply configuration to the gds interface
gds_interface.DeviceConfigurations = gusbamp_config;
% set configuration provided in DeviceConfigurations
gds_interface.SetConfiguration();
%----------------------------------------------------------
% Update handles structure
guidata(hObject, handles);
end
% UIWAIT makes adquisicion wait for user response (see UIRESUME)
% uiwait(handles.figure1);

% --- Outputs from this function are returned to the command line.
function varargout = adquisicion_OutputFcn(hObject, eventdata, handles) 
% Get default command line output from handles structure
varargout{1} = handles.output;
end

function pup_tiempo_Callback(hObject, eventdata, handles)

global seg
seg= get(hObject,'String');
end

% --- Executes on button press in btn_iniciar.
function btn_iniciar_Callback(hObject, eventdata, handles)

global gds_interface seg n_canales grabar data_received time_now
% start data acquisition
grabar=get(hObject,'Value');
seg = str2double(seg);
fs = 256;
muestras = fs*3600;
samples_acquired = 0;
data_received = [];
time_now = strings();
counter = 1;
wt=30;
gds_interface.StartDataAcquisition();

try
    while (grabar==1 && samples_acquired < muestras)
        
        try
            [scans_received, data] = gds_interface.GetData(8);
            data_received((samples_acquired + 1) : (samples_acquired + scans_received), :) = data;
            time_now((samples_acquired + 1) : (samples_acquired + scans_received)) = datestr(now,'dd-mm-yyyy HH:MM:SS FFF');     
            counter = counter + 1;
        catch ME
            disp(ME.message);
            break;
        end
        samples_acquired = samples_acquired + double(scans_received);
                
        if mod(samples_acquired,fs*1)==0 % Condición cada segundo
            
            if samples_acquired > fs*wt % Para ventanas mayores a 30, proyecta de 1:30.
                %timeoffset = floor(double(samples_acquired)/(fs*wt)); % Contador: si 31-60 -> 1, si 61-90 -> 2 etc
                samples_acquired1 = samples_acquired - (fs*wt*(ceil(samples_acquired/(fs*wt))-1));
                %data_time = (0:(fs*wt)-1)/fs;
            else
                timeoffset = 0;%floor(double(samples_acquired)/(fs*wt)); % 0
                samples_acquired1 = samples_acquired;
                %data_time = (0:samples_acquired1-1)/fs;
            end
            
            data_mean = mean(data_received(9:end,1:n_canales));
            data_show = data_received((timeoffset*fs*wt)+1:(timeoffset*fs*wt)+samples_acquired1,1:n_canales) - data_mean;
            if samples_acquired == fs*1
                data_max = max(max(data_show(9:end,1:n_canales)));
                axes(handles.axes1);
            end
            data_offset = repmat((0:n_canales-1)*data_max,samples_acquired1,1);
            data_show=data_show+data_offset;
            data_time = (0:samples_acquired1-1)/fs;
            plot(data_time,data_show);
            box off;
            xlim([0 30]);
            ylim([0-data_max,(n_canales-1)*data_max+data_max]);
            %ylim([0-data_max,2000]);
            timeoffset = floor(double(samples_acquired)/(fs*wt));
        end
    end
catch ME
    gds_interface.StopDataAcquisition();
    disp(ME.message);
end
% stop data acquisition
gds_interface.StopDataAcquisition();
end

% --- Executes on button press in btn_pausa.
function btn_pausa_Callback(hObject, eventdata, handles)
global grabar gds_interface
grabar=0;
gds_interface.StopDataAcquisition();
end

% --- Executes on button press in btn_stop.
function btn_stop_Callback(hObject, eventdata, handles)
global grabar gds_interface data_received time_now
grabar=0;
gds_interface.StopDataAcquisition();

data_received = double(data_received);
data_received = string(data_received);

size(data_received)
size(time_now')

data_received_2_save = [data_received time_now'];

size(data_received_2_save)

name_part_1 = 'eeg_data_';
name_part_2 = datestr(now,'dd_mm_yyyy_HH_MM_SS');
name_end = '.csv';
dir_name = strcat(name_part_1,name_part_2,name_end)

fid = fopen( dir_name, 'w' );
M = data_received_2_save;
for j = 1 : length( M )
    fprintf( fid, '%s;%s;%s;%s;%s;%s;%s;%s;%s;%s;%s;%s;%s;%s;%s;%s;%s;\n', ... 
    M{j,1}, M{j,2},M{j,3},M{j,4},M{j,5},M{j,6},M{j,7},M{j,8},...
    M{j,9}, M{j,10},M{j,11},M{j,12},M{j,13},M{j,14},M{j,15},M{j,16},...
    M{j,17});
end
fclose( fid );

end

% --- Executes during object creation, after setting all properties.
function pup_tiempo_CreateFcn(hObject, eventdata, handles)
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end
end

function sensores_int_Callback(hObject, eventdata, handles)
% hObject    handle to sensores_int (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
sensors_eeg
end
%--------------------------------------------------------------------
%         if i<=256*5
%             axes(handles.axes1);
%             plot(t(9:end),data_show(9:end,:))
%             xlim([0,t(i)])
%         else
%             axes(handles.axes1);
%             plot(t(9:end),data_show(9:end,:))
%             xlim([t(i-(256*5)),t(i)])
%         end
%         %i-(256*6)
% --------------------------------------------------------------------
