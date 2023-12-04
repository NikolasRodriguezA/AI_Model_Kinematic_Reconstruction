"""
Feature Extraction from EMG signals and Neural Net model to make a 
regression to 42 (x,y,z) fingers articulation based on a /Data

@author: Nikolas Rodriguez
"""

import os 
import pandas as pd 
import numpy as np

import numpy as np
import biosppy.signals.emg as bse
from scipy.fft import fft
from scipy.signal import welch

from sklearn.model_selection import cross_val_score
from sklearn.multioutput import MultiOutputRegressor
from sklearn.linear_model import LinearRegression

from sklearn.ensemble import RandomForestRegressor
from sklearn.model_selection import cross_val_predict, train_test_split
from sklearn.metrics import mean_squared_error


class FolderReader:
    def __init__(self, folder_path):
        self.folder_path = folder_path
        self.dataframes = []

    def read_dataframes(self):
        for archivo in os.listdir(self.folder_path):
            if archivo.endswith('.csv'):
                ruta_archivo = os.path.join(self.folder_path, archivo)
                df = pd.read_csv(ruta_archivo)
                self.dataframes.append(df)

    def get_dataframe(self, index):
        if 0 <= index < len(self.dataframes):
            return self.dataframes[index]
        else:
            return None

    def get_dataframe_names(self):
        return [df.columns.tolist() for df in self.dataframes]
        


carpeta = '../Data' 

folder_reader = FolderReader(carpeta)
folder_reader.read_dataframes()

df = pd.concat(folder_reader.dataframes)

emg_names = ['EMG_CHANNEL_' + str(i+1) for i in range(0,8)]
targets = ["THUMBFLEX1","THUMBFLEX2","INDEXFLEX1","INDEXFLEX2","INDEXFLEX3","MIDDLEFLEX1","MIDDLEFLEX2","MIDDLEFLEX3","RINGFLEX1","RINGFLEX2","RINGFLEX3",
           "LITTLEFLEX1","LITTLEFLEX2","LITTLEFLEX3"]

total_cols = emg_names + targets

df_emg_channels = df[total_cols]


fs_emg = 256
seconds = 3
window_size = (seconds*fs_emg)  # en milisegundos

df_emg_channels = df_emg_channels.reset_index(drop=True)

windows = []

features = []
for i in range(0, len(df_emg_channels), window_size):
    window = df_emg_channels.iloc[i:i+window_size]

    ts, filtered, _ = bse.emg(signal=window['EMG_CHANNEL_1'].values, sampling_rate=256, show=False)
    window['mav'] = np.mean(np.abs(filtered))
    window['wamp'] = np.sum(np.abs(np.diff(filtered) > 0))
    window['var'] = np.var(filtered)
    window['wl'] = np.sum(np.abs(np.diff(filtered)))
    # Características frecuenciales
    fft_signal = fft(filtered)
    freqs, psd = welch(filtered, fs=fs_emg)
    max_psd_idx = np.argmax(psd)

    window['max_psd_freq'] = freqs[max_psd_idx]
    window['max_psd_amp'] = psd[max_psd_idx]
    window['mean_freq'] = np.average(freqs, weights=psd)


    windows.append(window)

features_df = pd.concat(windows)


X = features_df.drop(targets, axis=1)
y = df_emg_channels[targets]
regressor = MultiOutputRegressor(LinearRegression())
scores = cross_val_score(regressor, X, y, cv=5, scoring='neg_mean_squared_error')

print('Scores:', scores)
print('Mean score:', np.mean(scores))


X_train, X_test, y_train, y_test = train_test_split(X, y, test_size=0.2)

rf = RandomForestRegressor()

rf.fit(X_train, y_train)

y_pred_test = rf.predict(X_test)
mse = mean_squared_error(y_test, y_pred_test)
print("MSE en el conjunto de test:", mse)



X = features_df.values
y = df_emg_channels[targets].values

sequence_length = 256 * 3  # 3 segundos
X_seq = []
y_seq = []
for i in range(sequence_length, len(X)):
    X_seq.append(X[i-sequence_length:i])
    y_seq.append(y[i])

X_seq = np.array(X_seq)
y_seq = np.array(y_seq)

train_size = int(len(X_seq) * 0.8)
X_train, X_test = X_seq[:train_size], X_seq[train_size:]
y_train, y_test = y_seq[:train_size], y_seq[train_size:]

model = keras.Sequential()
model.add(layers.LSTM(64, input_shape=(X_train.shape[1], X_train.shape[2])))
model.add(layers.Dense(13))

model.compile(loss='mse', optimizer='adam')

history = model.fit(X_train, y_train, epochs=50, batch_size=64, validation_data=(X_test, y_test))

mse = model.evaluate(X_test, y_test)
print("MSE en el conjunto de test:", mse)



