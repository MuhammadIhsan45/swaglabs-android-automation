*** Settings ***
Library     AppiumLibrary
Resource    locators.robot

*** Variables ***
${REMOTE_URL}     http://127.0.0.1:4723
${PLATFORM}       Android
${DEVICE}         emulator-5554
${APP}            ${CURDIR}/../app/Android.SauceLabs.Mobile.Sample.app.2.7.1.apk
${PKG}            com.swaglabsmobileapp
${ACT}            com.swaglabsmobileapp.SplashActivity

*** Keywords ***
# ================= APP MANAGEMENT =================
Start App
    Open Application    ${REMOTE_URL}
    ...    platformName=${PLATFORM}
    ...    deviceName=${DEVICE}
    ...    app=${APP}
    ...    automationName=UiAutomator2
    ...    appPackage=${PKG}
    ...    appActivity=${ACT}
    ...    autoGrantPermissions=true

Stop App
    Close Application

# ================= LOGIN ACTIONS =================
Login With Credentials
    [Arguments]    ${username}    ${password}
    Wait Until Element Is Visible    ${LOGIN_INPUT_USERNAME}    10s
    Input Text    ${LOGIN_INPUT_USERNAME}    ${username}
    Input Text    ${LOGIN_INPUT_PASSWORD}    ${password}
    Click Element    ${LOGIN_BTN_SUBMIT}

Verify Login Result
    [Arguments]    ${expected_output}
    # Logic Assertion: Cek apakah outputnya text PRODUCTS (Sukses) atau Error Message
    Run Keyword If    '${expected_output}' == 'PRODUCTS'
    ...    Validate Login Success    ${expected_output}
    ...    ELSE
    ...    Validate Login Error      ${expected_output}

Validate Login Success
    [Arguments]    ${expected_text}
    Wait Until Element Is Visible    ${HOME_TITLE_PRODUCTS}    10s
    Element Text Should Be           ${HOME_TITLE_PRODUCTS}    ${expected_text}
    Log    Login Berhasil dan masuk ke dashboard

Validate Login Error
    [Arguments]    ${expected_error_text}
    Wait Until Element Is Visible    ${LOGIN_ERROR_MESSAGE}    10s
    Element Text Should Be           ${LOGIN_ERROR_MESSAGE}    ${expected_error_text}
    Log    Login Gagal sesuai ekspektasi dengan pesan: ${expected_error_text}

# ================= SHOPPING ACTIONS =================
Add First Product To Cart
    [Documentation]    Klik tombol Add to Cart pada produk pertama
    Wait Until Element Is Visible    ${HOME_BTN_ADD_CART_ITEM_1}    10s
    Click Element    ${HOME_BTN_ADD_CART_ITEM_1}

Add Two Products To Cart
    [Documentation]    Klik tombol Add to Cart pada produk pertama DAN kedua
    Wait Until Element Is Visible    ${HOME_BTN_ADD_CART_ITEM_1}    10s
    Click Element    ${HOME_BTN_ADD_CART_ITEM_1}
    Wait Until Element Is Visible    ${HOME_BTN_ADD_CART_ITEM_2}    5s
    Click Element    ${HOME_BTN_ADD_CART_ITEM_2}

Remove First Product
    [Documentation]    Klik tombol Remove pada produk pertama
    Wait Until Element Is Visible    ${HOME_BTN_REMOVE}    10s
    Click Element                    ${HOME_BTN_REMOVE}

Verify Cart Badge Shows
    [Arguments]    ${expected_number}
    [Documentation]    Memastikan angka merah di keranjang sesuai (misal: 1)
    Wait Until Element Is Visible    ${HOME_CART_BADGE}    5s
    Element Text Should Be           ${HOME_CART_BADGE}    ${expected_number}

Verify Cart Badge Is Hidden
    [Documentation]    Memastikan angka merah hilang (saat keranjang kosong)
    Wait Until Page Does Not Contain Element    ${HOME_CART_BADGE}    5s

# ================= CHECKOUT ACTIONS =================
Go To Cart Page
    Click Element    ${HOME_ICON_CART}

Go To Cart Page 2
    Click Element    ${HOME_ICON_CART}
    # Kita coba Swipe maksimal 5 kali
    FOR    ${i}    IN RANGE    0    5
        # 1. Cek apakah tombol FINISH sudah muncul?
        ${is_visible}=    Run Keyword And Return Status    Element Should Be Visible    ${OVERVIEW_BTN_FINISH}
        
        # 2. Jika sudah muncul, hentikan looping (Break)
        Exit For Loop If    ${is_visible}
        
        # 3. Jika belum muncul, Lakukan Swipe (Scroll ke Bawah)
        # Koordinat: Tarik dari Y=1500 (Bawah) ke Y=500 (Atas)
        Swipe    500    1500    500    500    1000
        Sleep    1s
    END
    Wait Until Element Is Visible    ${CART_BTN_CHECKOUT}    10s

Proceed To Checkout
    Wait Until Element Is Visible    ${CART_BTN_CHECKOUT}    10s
    Click Element    ${CART_BTN_CHECKOUT}
    Wait Until Element Is Visible    ${CHECKOUT_INPUT_FIRSTNAME}    10s

Input Shipping Information
    [Arguments]    ${fname}    ${lname}    ${zip}
    Input Text    ${CHECKOUT_INPUT_FIRSTNAME}    ${fname}
    Input Text    ${CHECKOUT_INPUT_LASTNAME}     ${lname}
    Input Text    ${CHECKOUT_INPUT_ZIP}          ${zip}
    
    Hide Keyboard
    
    # Scroll ke tombol Continue jika tertutup layar
    ${android_scroll}=    Set Variable    new UiScrollable(new UiSelector().scrollable(true)).scrollIntoView(new UiSelector().description("test-CONTINUE"))
    
    Click Element    ${CHECKOUT_BTN_CONTINUE}

Click Continue Button
    [Documentation]    Keyword khusus untuk TC04 (Test Negatif) tanpa input data
    # Scroll ke tombol Continue
    ${android_scroll}=    Set Variable    new UiScrollable(new UiSelector().scrollable(true)).scrollIntoView(new UiSelector().description("test-CONTINUE"))
    Click Element    ${CHECKOUT_BTN_CONTINUE}

Click Finish Button
    [Documentation]    Melakukan Swipe manual dari bawah ke atas sampai tombol Finish terlihat
    
    # Kita coba Swipe maksimal 5 kali
    FOR    ${i}    IN RANGE    0    5
        # 1. Cek apakah tombol FINISH sudah muncul?
        ${is_visible}=    Run Keyword And Return Status    Element Should Be Visible    ${OVERVIEW_BTN_FINISH}
        
        # 2. Jika sudah muncul, hentikan looping (Break)
        Exit For Loop If    ${is_visible}
        
        # 3. Jika belum muncul, Lakukan Swipe (Scroll ke Bawah)
        # Koordinat: Tarik dari Y=1500 (Bawah) ke Y=500 (Atas)
        Swipe    500    1500    500    500    1000
        Sleep    1s
    END
    
    # 4. Setelah looping selesai/tombol ketemu, baru kita klik
    Wait Until Element Is Visible    ${OVERVIEW_BTN_FINISH}    10s
    Click Element    ${OVERVIEW_BTN_FINISH}

Verify Checkout Completed
    Wait Until Element Is Visible    ${COMPLETE_HEADER}    10s
    Log    Checkout Berhasil!

Verify Checkout Error
    [Arguments]    ${expected_error}
    Wait Until Element Is Visible    ${CHECKOUT_ERROR_MSG}    5s
    Element Text Should Be           ${CHECKOUT_ERROR_MSG}    ${expected_error}


# ================= SORTING ACTIONS =================
Open Filter Menu
    [Documentation]    Klik tombol filter icon
    Wait Until Element Is Visible    ${HOME_BTN_FILTER}    10s
    Click Element                    ${HOME_BTN_FILTER}

Select Sort Option
    [Arguments]    ${sort_option_locator}
    [Documentation]    Memilih opsi sort (misal: Price Low to High)
    
    # 1. Buka Menu
    Open Filter Menu
    
    # 2. Tunggu opsi muncul & Klik
    Wait Until Element Is Visible    ${sort_option_locator}    10s
    Click Element                    ${sort_option_locator}
    
    # 3. Tunggu sebentar agar list produk refresh
    Sleep    1s

Verify First Item Name
    [Arguments]    ${expected_name}
    [Documentation]    Validasi Nama Barang paling atas harus sesuai ekspektasi
    Wait Until Element Is Visible    ${INVENTORY_ITEM_NAME_1}    10s
    Element Text Should Be           ${INVENTORY_ITEM_NAME_1}    ${expected_name}
    Log    Validasi Sort Berhasil. Barang teratas: ${expected_name}

Verify First Item Price
    [Arguments]    ${expected_price}
    [Documentation]    Validasi Harga Barang paling atas harus sesuai ekspektasi
    Wait Until Element Is Visible    ${INVENTORY_ITEM_PRICE_1}    10s
    Element Text Should Be           ${INVENTORY_ITEM_PRICE_1}    ${expected_price}
    Log    Validasi Sort Berhasil. Harga teratas: ${expected_price}


Click Cancel Button In Overview
    [Documentation]    Scroll ke bawah cari tombol Cancel, lalu klik
    # Kita gunakan logic Swipe Loop yang sama dengan Finish Button
    FOR    ${i}    IN RANGE    0    5
        ${is_visible}=    Run Keyword And Return Status    Element Should Be Visible    ${OVERVIEW_BTN_CANCEL}
        Exit For Loop If    ${is_visible}
        Swipe    500    1500    500    500    1000
        Sleep    1s
    END
    Click Element    ${OVERVIEW_BTN_CANCEL}

Verify Item In Checkout Overview
    [Arguments]    ${expected_item_name}
    [Documentation]    Memastikan barang yang mau dibayar benar
    Wait Until Element Is Visible    ${OVERVIEW_ITEM_NAME}    10s
    Element Text Should Be           ${OVERVIEW_ITEM_NAME}    ${expected_item_name}

Verify Total Price Is Visible
    [Documentation]    Memastikan ringkasan harga (Tax + Total) muncul
    # Perlu scroll ke bawah dulu
    FOR    ${i}    IN RANGE    0    5
        ${is_visible}=    Run Keyword And Return Status    Element Should Be Visible    ${OVERVIEW_LABEL_TOTAL}
        Exit For Loop If    ${is_visible}
        Swipe    500    1500    500    500    1000
    END
    Element Should Be Visible    ${OVERVIEW_LABEL_TOTAL}


# ================= DETAIL PAGE ACTIONS =================
Open First Product Detail
    [Documentation]    Klik Judul Produk pertama untuk masuk ke detail
    Wait Until Element Is Visible    ${INVENTORY_ITEM_NAME_1}    10s
    Click Element                    ${INVENTORY_ITEM_NAME_1}
    Wait Until Element Is Visible    ${DETAIL_BTN_BACK}    10s

Get First Product Name
    [Documentation]    Mengambil teks nama produk di halaman list untuk disimpan
    Wait Until Element Is Visible    ${INVENTORY_ITEM_NAME_1}    10s
    ${text}=    Get Text    ${INVENTORY_ITEM_NAME_1}
    [Return]    ${text}

Get First Product Price
    [Documentation]    Mengambil teks harga produk di halaman list untuk disimpan
    Wait Until Element Is Visible    ${INVENTORY_ITEM_PRICE_1}    10s
    ${text}=    Get Text    ${INVENTORY_ITEM_PRICE_1}
    [Return]    ${text}

Verify Detail Page Data matches List Data
    [Arguments]    ${expected_name}    ${expected_price}
    [Documentation]    Validasi Nama & Harga di detail SAMA dengan yang ada di List
    
    # 1. Validasi Nama
    Wait Until Element Is Visible    ${DETAIL_TXT_NAME}    10s
    Element Text Should Be           ${DETAIL_TXT_NAME}    ${expected_name}
    
    # 2. Validasi Harga
    Element Text Should Be           ${DETAIL_TXT_PRICE}    ${expected_price}
    Log    Data Integrity Valid: Nama & Harga konsisten.

Verify Detail Page Elements Exist
    [Documentation]    Memastikan Gambar dan Deskripsi tidak hilang/broken
    Element Should Be Visible    ${DETAIL_IMG_ITEM}
    Element Should Be Visible    ${DETAIL_TXT_DESC}

Click Back To Products
    Click Element    ${DETAIL_BTN_BACK}
    Wait Until Element Is Visible    ${HOME_TITLE_PRODUCTS}    10s

Add Product From Detail Page
    [Documentation]    Scroll ke bawah pakai Swipe Loop cari tombol Add to Cart, lalu klik
    
    FOR    ${i}    IN RANGE    0    5
        # 1. Cek apakah tombol ADD TO CART sudah muncul?
        ${is_visible}=    Run Keyword And Return Status    Element Should Be Visible    ${DETAIL_BTN_ADD_TO_CART}
        
        # 2. Jika sudah muncul, stop scroll
        Exit For Loop If    ${is_visible}
        
        # 3. Jika belum, Swipe dari Bawah (Y=1500) ke Atas (Y=500)
        Swipe    500    1500    500    500    1000
        Sleep    1s
    END
    
    # 4. Klik tombolnya
    Wait Until Element Is Visible    ${DETAIL_BTN_ADD_TO_CART}    10s
    Click Element                    ${DETAIL_BTN_ADD_TO_CART}

Remove Product From Detail Page
    [Documentation]    Scroll ke bawah pakai Swipe Loop cari tombol Remove, lalu klik
    
    FOR    ${i}    IN RANGE    0    5
        # 1. Cek apakah tombol REMOVE sudah muncul?
        ${is_visible}=    Run Keyword And Return Status    Element Should Be Visible    ${DETAIL_BTN_REMOVE}
        
        # 2. Jika sudah muncul, stop scroll
        Exit For Loop If    ${is_visible}
        
        # 3. Jika belum, Swipe lagi
        Swipe    500    1500    500    500    1000
        Sleep    1s
    END
    
    # 4. Klik tombolnya
    Wait Until Element Is Visible    ${DETAIL_BTN_REMOVE}    10s
    Click Element                    ${DETAIL_BTN_REMOVE}