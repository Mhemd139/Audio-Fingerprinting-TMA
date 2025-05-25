# 🎵 Audio Fingerprinting TMA Project

An academic project developed by **Tasbih**, **Muhammed**, and **Amina**, designed to perform **real-time audio recognition** using signal processing and mobile integration. The system detects and identifies music tracks from short recorded clips by converting audio to spectral fingerprints and matching them in a backend database.

---

## 🧠 How It Works

The system is split into two major components:

### 📱 Flutter Mobile App
- Record a short audio snippet using the device microphone.
- Send the clip to the backend server.
- Receive the closest matching audio result (e.g., song name).
- Modern UI with favorites, playback, and recording history.

> _📸 UI Placeholder Images (add yours if available):_
> - `mobile-ui-home.png` – Main screen showing recorded clips.
> - `mobile-ui-record.png` – Recording interface.
> - `mobile-ui-results.png` – Match result display.
> - `mobile-ui-favorites.png` – List of favorited audio matches.

---

### 🖥️ Python Server (Backend)

The backend is responsible for:
- **Audio Fingerprinting** – Transforming sound waves into compact, unique digital "fingerprints."
- **Matching** – Comparing input fingerprints to a stored database using fast hashing techniques.
- **Response** – Returning a JSON with the best match and confidence level.

#### 🔬 Techniques Implemented

1. **Short-Time Fourier Transform (STFT)**  
   Breaks audio into overlapping windows → transforms each to frequency domain.

2. **Constant-Q Transform (CQT)**  
   Like STFT, but uses a **logarithmic frequency scale**, improving low-frequency resolution.

3. **MFCCs (Mel-Frequency Cepstral Coefficients)**  
   Captures human-perceived frequency features for compact signal representation.

> Backend uses Python, NumPy, and LibROSA.  
> See: `server/README.md` for more on scripts and tools.

---

## 📊 System Architecture

![System Flow](![image](https://github.com/user-attachments/assets/8766efa9-a0ce-4971-98a7-ce768fabe198)
)  
_**Figure 1**: Audio flows through a fingerprinting process → hash → matching → result._

---

## 📈 Signal Processing Visuals

### 1. Spectrogram in 3D  
Visualizes frequency over time + amplitude in 3D.  
![3D Spectrogram](./spectrogram-3d.png)

---

### 2. Spectrogram with Peak Detection  
Used to extract fingerprint-relevant peaks.  
![Blurred Lines Spectrogram](./spectrogram-blurred-lines.png)

---

### 3. Waveform to Frequency Spectrum  
Raw waveform (left) → frequency domain (right).  
This FFT process is foundational for fingerprinting.  
![Waveform to FFT](./waveform-to-spectrum.png)

---

## 📁 Project Structure

