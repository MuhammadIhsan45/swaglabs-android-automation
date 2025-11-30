## 🤖 SwagLabs Android Automation

Project ini adalah *Automation Testing Suite* untuk aplikasi Android **SwagLabs (Sauce Labs Demo App)** menggunakan **Robot Framework** dan **Appium**.

Project ini menerapkan konsep **Page Object Model (POM)** untuk struktur kode yang rapi, *maintainable*, dan *scalable*.

## 📋 Prasyarat (Prerequisites)

Sebelum menjalankan script, pastikan komputer kamu sudah terinstal:

1.  **Python 3.8+**
2.  **Node.js** (untuk menjalankan Appium)
3.  **Java JDK & Android SDK** (Environment Variable `ANDROID_HOME` & `JAVA_HOME` sudah diset)
4.  **Emulator Android** atau Device Fisik yang aktif.

## ⚙️ Instalasi

1.  **Clone Repository ini:**
    ```bash
    git clone [https://github.com/USERNAME_GITHUB_KAMU/NAMA_REPO.git](https://github.com/USERNAME_GITHUB_KAMU/NAMA_REPO.git)
    cd NAMA_REPO
    ```

2.  **Install Library Python:**
    Install Robot Framework dan Appium Library melalui terminal:
    ```bash
    pip install robotframework
    pip install robotframework-appiumlibrary
    ```

3.  **Install Appium Server & Driver:**
    ```bash
    npm install -g appium
    appium driver install uiautomator2
    ```

## 📱 Konfigurasi Device

Sebelum menjalankan test, pastikan konfigurasi device di file **`resources/keywords.robot`** sudah sesuai dengan emulator kamu.

Buka file `resources/keywords.robot` dan cek bagian Variables:

```robotframework
*** Variables ***
${DEVICE_NAME}    Pixel 6 Pro API 33  <-- Ganti sesuai nama emulator kamu
${UDID}           emulator-5554       <-- Cek dengan perintah 'adb devices'
