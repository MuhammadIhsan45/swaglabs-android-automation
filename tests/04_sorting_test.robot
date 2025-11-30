*** Settings ***
Documentation     Test Suite Validasi Halaman Detail Produk
Resource          ../resources/keywords.robot
Test Setup        Start App
Test Teardown     Stop App

*** Test Cases ***

# TC-16: Validasi Integritas Data (Nama & Harga)
TC16 Verify Product Name and Price Consistency
    [Documentation]    Memastikan Nama & Harga di Dashboard SAMA dengan di Detail Page
    Login With Credentials    standard_user    secret_sauce
    Verify Login Result       PRODUCTS
    
    ${list_name}=     Get First Product Name
    ${list_price}=    Get First Product Price
    Log    Barang yang dipilih: ${list_name} dengan harga ${list_price}
    
    Open First Product Detail
    
    Verify Detail Page Data matches List Data    ${list_name}    ${list_price}

# TC-17: Validasi Elemen UI (Gambar & Deskripsi)
TC17 Verify Product Image and Description Exist
    [Documentation]    Memastikan halaman detail tidak error (Gambar muncul, Deskripsi ada)
    Login With Credentials    standard_user    secret_sauce
    Verify Login Result       PRODUCTS
    
    Open First Product Detail
    Verify Detail Page Elements Exist

# TC-18: User Bisa Add to Cart dari Halaman Detail
TC18 User Should Be Able To Add To Cart From Detail Page
    [Documentation]    Fungsionalitas tombol Add to Cart di dalam halaman detail
    Login With Credentials    standard_user    secret_sauce
    Verify Login Result       PRODUCTS
    
    Open First Product Detail
    
    Add Product From Detail Page
    
    # Validasi Badge Cart jadi "1"
    Verify Cart Badge Shows    1

# TC-19: User Bisa Remove dari Halaman Detail
TC19 User Should Be Able To Remove From Detail Page
    [Documentation]    Memastikan toggle tombol Add/Remove berfungsi
    Login With Credentials    standard_user    secret_sauce
    Verify Login Result       PRODUCTS
    
    Open First Product Detail
    
    # Add dulu
    Add Product From Detail Page
    Verify Cart Badge Shows    1
    
    # Lalu Remove
    Remove Product From Detail Page
    Verify Cart Badge Is Hidden

# TC-20: Navigasi Tombol Back
TC20 User Should Be Able To Navigate Back To List
    [Documentation]    Memastikan tombol 'Back to Products' berfungsi
    Login With Credentials    standard_user    secret_sauce
    Verify Login Result       PRODUCTS
    
    Open First Product Detail
    
    Click Back To Products
    
    # Validasi sudah kembali ke halaman dashboard
    Validate Login Success    PRODUCTS