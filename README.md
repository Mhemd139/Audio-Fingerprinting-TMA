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

![image](https://github.com/user-attachments/assets/8766efa9-a0ce-4971-98a7-ce768fabe198)


_**Figure 1**: Audio flows through a fingerprinting process → hash → matching → result._

---

## 📈 Signal Processing Visuals

### 1. Spectrogram in 3D  
Visualizes frequency over time + amplitude in 3D.  
![image](https://github.com/user-attachments/assets/434e85da-0f8c-408c-a143-de1daf1acd41)


---

### 2. Spectrogram with Peak Detection  
Used to extract fingerprint-relevant peaks.  
![image](https://github.com/user-attachments/assets/40e71284-cb8b-437f-8a81-8aa729e08287)


---

### 3. Waveform to Frequency Spectrum  
Raw waveform (left) → frequency domain (right).  
This FFT process is foundational for fingerprinting.  
![image](https://github.com/user-attachments/assets/8f5a4d45-f770-463a-ae33-614ae7f4b8e1)


---

## 📁 Project Structure
📦 Audio-Fingerprinting-TMA/
├── 📁 android/ # Flutter Android project
├── 📁 lib/ # Flutter source code (UI, logic)
├── 📁 assets/ # App images and fonts
├── 📁 server/ # Python backend (fingerprinting + matching)
├── 📄 pubspec.yaml # Flutter dependencies
├── 📸 Screenshot.jpg # UI or diagram image
└── 📄 README.md 









---

## 👥 Authors

| Name               | Role                     |
|--------------------|--------------------------|
| **Muhammed Masarwa** | Backend Developer (Python) |
| **Tasbih**           | Flutter App Lead           |
| **Amina**            | UI/UX + QA & Testing       |

---

## 📌 Project Notes

- Created as a final senior-year project.
- Built for educational and demonstration purposes.
- Source code may contain legacy or unfinished components.

---

## 🔗 Acknowledgments

- [LibROSA](https://librosa.org/) – Music and audio analysis in Python  
- [NumPy](https://numpy.org/) – Scientific computing  
- [Flutter](https://flutter.dev/) – Cross-platform mobile framework

---

## 📨 Contact

For inquiries or collaboration: [github.com/Mhemd139](https://github.com/Mhemd139)

