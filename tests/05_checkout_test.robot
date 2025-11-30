*** Settings ***
Documentation     Test Suite untuk fitur Product Sorting (Filter)
Resource          ../resources/keywords.robot
Test Setup        Start App
Test Teardown     Stop App

*** Test Cases ***

# TC-21: User Bisa Sortir Harga Terendah ke Tertinggi (Low to High)
TC21 Sort Products Price Low to High
    [Documentation]    Validasi barang termurah (Onesie) muncul paling atas
    Login With Credentials    standard_user    secret_sauce
    Verify Login Result       PRODUCTS
    
    Select Sort Option        ${SORT_OPTION_LOW_HIGH}
    
    # Validasi: Barang pertama harus "Sauce Labs Onesie" seharga "$7.99"
    Verify First Item Name    Sauce Labs Onesie
    Verify First Item Price   $7.99

# TC-22: User Bisa Sortir Harga Tertinggi ke Terendah (High to Low)
TC22 Sort Products Price High to Low
    [Documentation]    Validasi barang termahal (Fleece Jacket) muncul paling atas
    Login With Credentials    standard_user    secret_sauce
    Verify Login Result       PRODUCTS
    
    Select Sort Option        ${SORT_OPTION_HIGH_LOW}
    
    # Validasi: Barang pertama harus "Sauce Labs Fleece Jacket" seharga "$49.99"
    Verify First Item Name    Sauce Labs Fleece Jacket
    Verify First Item Price   $49.99

# TC-23: User Bisa Sortir Nama Z ke A (Descending)
TC23 Sort Products Name Z to A
    [Documentation]    Validasi barang abjad akhir (T-Shirt Red) muncul paling atas
    Login With Credentials    standard_user    secret_sauce
    Verify Login Result       PRODUCTS
    
    Select Sort Option        ${SORT_OPTION_ZA}
    
    Verify First Item Name    Test.allTheThings() T-Shirt (Red)

# TC-24: User Bisa Mengembalikan Sortir ke Default (A to Z)
TC24 Sort Products Name A to Z (Default)
    [Documentation]    Test Flow: Z-A dulu, lalu balikan ke A-Z
    Login With Credentials    standard_user    secret_sauce
    Verify Login Result       PRODUCTS
    
    Select Sort Option        ${SORT_OPTION_ZA}
    Verify First Item Name    Test.allTheThings() T-Shirt (Red)
    
    Select Sort Option        ${SORT_OPTION_AZ}
    
    # 3. Validasi barang pertama kembali "Sauce Labs Backpack"
    Verify First Item Name    Sauce Labs Backpack

# TC-25: Sortir Tidak Berubah Saat Pindah Halaman (Persistence Test)
TC25 Sort Selection Should Persist After Navigation
    [Documentation]    Memastikan sort tidak reset saat user masuk ke detail barang lalu kembali
    Login With Credentials    standard_user    secret_sauce
    Verify Login Result       PRODUCTS
    
    Select Sort Option        ${SORT_OPTION_LOW_HIGH}
    Verify First Item Name    Sauce Labs Onesie
    
    Click Element             ${INVENTORY_ITEM_NAME_1}
    Wait Until Element Is Visible    accessibility_id=test-BACK TO PRODUCTS    5s
    
    Click Element             accessibility_id=test-BACK TO PRODUCTS
    
    # 4. Validasi sorting MASIH Low to High (Tidak reset)
    Verify First Item Name    Sauce Labs Onesie
    Verify First Item Price   $7.99