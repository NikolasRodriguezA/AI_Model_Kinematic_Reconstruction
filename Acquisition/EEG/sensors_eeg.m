
function varargout = sensors_eeg(varargin)
% SENSORS_EEG MATLAB code for sensors_eeg.fig
%      SENSORS_EEG, by itself, creates a new SENSORS_EEG or raises the existing
%      singleton*.
%
%      H = SENSORS_EEG returns the handle to a new SENSORS_EEG or the handle to
%      the existing singleton*.
%
%      SENSORS_EEG('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in SENSORS_EEG.M with the given input arguments.
%
%      SENSORS_EEG('Property','Value',...) creates a new SENSORS_EEG or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before sensors_eeg_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to sensors_eeg_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help sensors_eeg

% Last Modified by GUIDE v2.5 06-Jun-2023 19:17:22

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @sensors_eeg_OpeningFcn, ...
                   'gui_OutputFcn',  @sensors_eeg_OutputFcn, ...
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

% --- Executes just before sensors_eeg is made visible.
function sensors_eeg_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to sensors_eeg (see VARARGIN)

% Choose default command line output for sensors_eeg
handles.output = hObject;
%poner la imagen
eeg = imread('64.jpg');
eeg=im2double(eeg);
axes(handles.ax1);
imshow(eeg);
global cor rad Loc cord radi
global gds_interface gusbamp_config channel_selected
[cor,rad]=imfindcircles(eeg,[50 60],'ObjectPolarity','bright','sensitivity',.95);
cord=[];
radi=[];
Loc={'FC3' 'CP3' 'CP4' ...
    'CP6' 'FCz' 'CP5' 'FC5' 'FC4' ... %bien
    'FC1' 'FC6' 'P7' 'Fpz' 'Pz' 'T8' 'F6' 'C1' 'P1' 'TP8' 'TP10' ... %bien
    'AF8' 'F9' 'F4' 'TP7' 'F2' 'P10' 'PO10' 'CP1' 'F7' 'O1' 'C4' ... %bien
    'AFz' 'F10' 'Iz' 'AF4' 'Fz' 'PO3' 'AF3' 'Fp1' 'F5' ... %bien
    'O10' 'AF7' 'P6' 'TP9' 'C5' 'F1' 'FT8' 'C3' 'FT7' 'P4' 'P8' ... %bien
    'PO9' 'F8' 'F3' 'P9' 'P2' 'Fp2' 'PO4' 'Oz' 'FT10' 'CPz' 'P5' ... %bien
    'P3' 'C2' 'PO7' 'CP2' 'Cz' 'O9' 'FC2' ... %bien
    'PO8' 'O2' 'T7' 'C6' 'FT9' ...
    'POz'};
% Loc={'Fp1' 'Fpz' 'Fp2' 
%     'AF7' 'AF3' 'AFz' 'AF4' 'AF8' ...
%     'F9' 'F7' 'F5' 'F3' 'F1' 'Fz' 'F2' 'F4' 'F6' 'F8' 'F10' ...
%     'FT9' 'FT7' 'FC5' 'FC3' 'FC1' 'FCz' 'FC2' 'FC4' 'FC6' 'FT8' 'FT10' ...
%     'T7' 'C5' 'C3' 'C1' 'Cz' 'C2' 'C4' 'C6' 'T8' ...
%     'TP9' 'TP7' 'CP5' 'CP3' 'CP1' 'CPz' 'CP2' 'CP4' 'CP6' 'TP8' 'TP10' ...
%     'P9' 'P7' 'P5' 'P3' 'P1' 'Pz' 'P2' 'P4' 'P6' 'P8' 'P10' ...
%     'PO9' 'PO7' 'PO3' 'POz' 'PO4' 'PO8' 'PO10' ...
%     'O9' 'O1' 'Oz' 'O2' 'O10' ...
%     'Iz'};
%---------------------------------------------------------
%gUSBampAPi
% create gtecDeviceInterface object
gds_interface = gtecDeviceInterface();

% define connection settings (loopback)
gds_interface.IPAddressHost = '127.0.0.1';
gds_interface.IPAddressLocal = '127.0.0.1';
gds_interface.LocalPort = 50224;
gds_interface.HostPort = 50223;

% get connected devices
connected_devices = gds_interface.GetConnectedDevices();

% create g.USBamp configuration object
gusbamp_config = gUSBampDeviceConfiguration();
% set serial number in g.USBamp device configuration
gusbamp_config.Name = connected_devices(1,1).Name;

% set configuration to use functions in gds interface which require device
% connection
gds_interface.DeviceConfigurations = gusbamp_config;

% get available channels
available_channels = gds_interface.GetAvailableChannels();
% Set up a random device configuration for g.USBamp and configure device
gusbamp_config.SamplingRate = 256;
gusbamp_config.NumberOfScans = 8;
gusbamp_config.CommonGround = false(1,4);
gusbamp_config.CommonReference = false(1,4);
gusbamp_config.ShortCutEnabled = false;
gusbamp_config.CounterEnabled = true;
gusbamp_config.TriggerEnabled = false;
gusbamp_siggen = gUSBampInternalSignalGenerator();
gusbamp_siggen.Enabled = true;
gusbamp_siggen.Frequency = 10;
gusbamp_siggen.WaveShape = 3;
gusbamp_siggen.Amplitude = 200;
gusbamp_siggen.Offset = 0;
gusbamp_config.InternalSignalGenerator = gusbamp_siggen;
channel_selected = zeros(1,size(available_channels(available_channels == true), 2));
for i=1:size(gusbamp_config.Channels,2)
    if (available_channels(1,i))
    	gusbamp_config.Channels(1,i).Available = true;
        gusbamp_config.Channels(1,i).Acquire = true;
        channel_selected(1,i) = i;
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
% ----------------------------------------------------------------
% Update handles structure
guidata(hObject, handles);
end

% UIWAIT makes sensors_eeg wait for user response (see UIRESUME)
% uiwait(handles.figure1);

% --- Outputs from this function are returned to the command line.
function varargout = sensors_eeg_OutputFcn(hObject, eventdata, handles) 
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;
end

% --- Executes on selection change in pmenu_ncnl.
function pmenu_ncnl_Callback(hObject, eventdata, handles)
% Hints: contents = cellstr(get(hObject,'String')) returns pmenu_ncnl contents as cell array
%        contents{get(hObject,'Value')} returns selected item from pmenu_ncnl
global datos pos
pos=0;
contenido= get(hObject,'String');
N_canales= get(hObject,'Value');
A=str2num(cell2mat(contenido(N_canales)));
sensor=cell(A,1);
impedances=cell(A,1);
n_canales=1:A;
canal=num2cell(n_canales');
datos=[canal sensor impedances];
set(handles.tbl_location,'Data',datos,'ColumnEditable',[false true]);

end
% --- Executes during object creation, after setting all properties.
function pmenu_ncnl_CreateFcn(hObject, eventdata, handles)
% Hint: popupmenu controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end
end


% --- Executes when entered data in editable cell(s) in tbl_location.
function tbl_location_CellEditCallback(hObject, eventdata, handles)
%UBICA LOS SENSORES
global cor rad Loc cord radi pos
new=eventdata.NewData;
k=strcmp(Loc,new);
if find(pos==find(k))~=0
    t=1;
else
    pos=vertcat(pos,find(k));
    co =cor.*k';
    ra =rad.*k';
    c=find(co(:,1)>0);
    cord=vertcat(cord,co(c,:));
    radi=vertcat(radi,ra(c));
end
viscircles(cord,radi,'Edgecolor','b','Linewidth',3)
end

% --- Executes on button press in btn_limpiar.
function btn_limpiar_Callback(hObject, eventdata, handles)
% hObject    handle to btn_limpiar (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global cord radi datos
cord=[];
radi=[];
set(handles.tbl_location,'Data',datos,'ColumnEditable',[false true]);
eeg = imread('64.jpg');
eeg=im2double(eeg);
axes(handles.ax1);
imshow(eeg);
end

% --- Executes on button press in btn_limpiar.
function btn_impedancia_Callback(hObject, eventdata, handles)
% global gds_interface
% gUSBampAPi
% create gtecDeviceInterface object
set(handles.btn_impedancia,'BackgroundColor',[1 130/255 130/255])
global gds_interface gusbamp_config 
global cord radi 
b=length(radi);
numcha=(1:b);
impedances = gds_interface.GetImpedance(gusbamp_config.Name,numcha);
% impedances=[1 2 3 4 5 6 7 8 9 10 11 12 13 14 15 16];value=[4 5 6 7 10 11 12 13 14 15 16 17 17 17 17 17];
% impedances =vertcat(impedances, value);
% impe=abs(value);
% per=impe<=9700; per=per.*impe>0;
% ok=impe<=9800; ok=ok.*impe>=9700;
% no=impe>=9800;
impe=abs(impedances(2,:));
per=impe<=5000;
per=per.*impe>0;
ok=impe<=10000;
ok=ok.*impe>5000;
no=impe>=10000;
viscircles(cord.*[per' per'],radi.*per','Color','g','Linewidth',3)
viscircles(cord.*[ok' ok'],radi.*ok','Color','y','Linewidth',3)
viscircles(cord.*[no' no'],radi.*no','Color','r','Linewidth',3)
data=get(handles.tbl_location,'Data');
data(:,3)= num2cell(impe(1,1:b));
datos=data;
set(handles.tbl_location,'Data',datos,'ColumnEditable',[false true true]);
set(handles.btn_impedancia,'BackgroundColor',[0.94 0.94 0.94])
end

% --------------------------------------------------------------------
%MENU
function m_sensores_Callback(hObject, eventdata, handles)
% hObject    handle to m_sensores (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
sensors_eeg
end


% --------------------------------------------------------------------
function m_adquisicion_Callback(hObject, eventdata, handles)
% hObject    handle to m_adquisicion (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
adquisicion
end


% --------------------------------------------------------------------
function m_sproce_Callback(hObject, eventdata, handles)
% hObject    handle to m_sproce (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
end
