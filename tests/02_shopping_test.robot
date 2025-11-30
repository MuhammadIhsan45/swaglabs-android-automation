*** Settings ***
Documentation     Test Suite Belanja (Shopping Flow)
Resource          ../resources/keywords.robot
Test Setup        Start App
Test Teardown     Stop App

*** Test Cases ***

# TC-01: User Bisa Tambah & Hapus Barang (Basic)
TC01 User Should Be Able To Add And Remove Item
    Login With Credentials    standard_user    secret_sauce
    Verify Login Result       PRODUCTS
    Add First Product To Cart
    Verify Cart Badge Shows    1
    Remove First Product
    Verify Cart Badge Is Hidden

# TC-02: User Bisa Menambah 2 Barang Sekaligus
TC02 User Should Be Able To Add Multiple Items
    Login With Credentials    standard_user    secret_sauce
    Verify Login Result       PRODUCTS
    Add Two Products To Cart
    Verify Cart Badge Shows    2

# TC-03: User Bisa Checkout Sampai Selesai (End-to-End)
TC03 User Should Be Able To Complete Checkout
    [Documentation]    Happy Path: Login -> Add -> Cart -> Input Info -> Finish
    Login With Credentials    standard_user    secret_sauce
    Verify Login Result       PRODUCTS
    
    Add First Product To Cart
    Go To Cart Page
    Proceed To Checkout
    Input Shipping Information    Ihsan    Syarifudin    55183
    Click Finish Button
    Verify Checkout Completed

# TC-04: User Gagal Checkout Jika Data Kosong (Negative Test)
TC04 Checkout Should Fail With Empty Information
    [Documentation]    Memastikan error muncul jika langsung klik Continue tanpa isi data
    Login With Credentials    standard_user    secret_sauce
    Verify Login Result       PRODUCTS
    
    Add First Product To Cart
    Go To Cart Page
    Proceed To Checkout
    
    Click Continue Button
    
    # Validasi Error Message ("Error: First Name is required")
    Verify Checkout Error    First Name is required

# TC-05: Validasi Produk di Halaman Cart
TC05 Verify Product Added To Cart Is Correct
    [Documentation]    Memastikan barang yang dipilih muncul di halaman Cart
    Login With Credentials    standard_user    secret_sauce
    Verify Login Result       PRODUCTS
    
    Add First Product To Cart
    Go To Cart Page
    
    # Validasi nama barang ada di halaman Cart
    Wait Until Element Is Visible    ${CART_ITEM_TITLE}    10s
    Element Should Contain Text      ${CART_ITEM_TITLE}    Sauce Labs Backpack