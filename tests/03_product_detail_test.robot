*** Settings ***
Documentation     Test Suite Khusus Checkout Flow (End-to-End)
Resource          ../resources/keywords.robot
Test Setup        Start App
Test Teardown     Stop App

*** Test Cases ***

# TC-01: Checkout Sukses dengan 1 Barang (Happy Path Utama)
TC01 Successful Checkout Single Item
    [Documentation]    User membeli 1 barang (Backpack) sampai sukses
    Login With Credentials    standard_user    secret_sauce
    Verify Login Result       PRODUCTS
    
    Add First Product To Cart
    Go To Cart Page
    Proceed To Checkout
    
    Input Shipping Information    Ihsan    Syarifudin    12345
    
    # Validasi dulu di halaman Overview sebelum klik Finish
    Verify Item In Checkout Overview    Sauce Labs Backpack
    
    Click Finish Button
    Verify Checkout Completed

# TC-02: Checkout Sukses dengan 2 Barang (Multiple Items)
TC02 Successful Checkout Multiple Items
    [Documentation]    Memastikan sistem bisa menghandle checkout lebih dari 1 barang
    Login With Credentials    standard_user    secret_sauce
    Verify Login Result       PRODUCTS
    
    Add Two Products To Cart
    Go To Cart Page 2
    Proceed To Checkout
    
    Input Shipping Information    User    Dua    55183
    Click Finish Button
    Verify Checkout Completed

# TC-03: Validasi Form Kosong (Negative Test)
TC03 Checkout Fails With Empty Fields
    [Documentation]    User tidak boleh lanjut jika data pengiriman kosong
    Login With Credentials    standard_user    secret_sauce
    Verify Login Result       PRODUCTS
    
    Add First Product To Cart
    Go To Cart Page
    Proceed To Checkout
    
    Click Continue Button
    
    # Validasi Error Muncul
    Verify Checkout Error    First Name is required

# TC-04: User Membatalkan Checkout (Cancellation Flow)
TC04 User Cancels Checkout In Overview
    [Documentation]    User berubah pikiran di halaman konfirmasi terakhir dan menekan Cancel
    Login With Credentials    standard_user    secret_sauce
    Verify Login Result       PRODUCTS
    
    Add First Product To Cart
    Go To Cart Page
    Proceed To Checkout
    Input Shipping Information    Batal    Beli    00000
    
    Click Cancel Button In Overview
    
    # Validasi: User harusnya kembali ke halaman "PRODUCTS" / Home
    Validate Login Success    PRODUCTS

# TC-05: Validasi Ringkasan Pembayaran (Data Integrity)
TC05 Verify Payment Summary Exists
    [Documentation]    Memastikan label Total Harga muncul sebelum user menekan Finish
    Login With Credentials    standard_user    secret_sauce
    Verify Login Result       PRODUCTS
    
    Add First Product To Cart
    Go To Cart Page
    Proceed To Checkout
    Input Shipping Information    Cek    Harga    11111
    
    # Scroll ke bawah dan pastikan Label Total ($) muncul
    Verify Total Price Is Visible
    
    Click Finish Button
    Verify Checkout Completed