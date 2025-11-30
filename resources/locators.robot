*** Variables ***
# ================= LOGIN PAGE =================
${LOGIN_INPUT_USERNAME}      accessibility_id=test-Username
${LOGIN_INPUT_PASSWORD}      accessibility_id=test-Password
${LOGIN_BTN_SUBMIT}          accessibility_id=test-LOGIN
${LOGIN_ERROR_MESSAGE}       xpath=//android.view.ViewGroup[@content-desc="test-Error message"]//android.widget.TextView

# ================= HOME / PRODUCTS PAGE =================
${HOME_TITLE_PRODUCTS}       xpath=//android.widget.TextView[@text="PRODUCTS"]

# Tombol Add Cart (Barang ke-1) - Digunakan untuk "Add First Product"
${HOME_BTN_ADD_TO_CART}      xpath=(//android.view.ViewGroup[@content-desc="test-ADD TO CART"])[1]

# Tombol Add Cart Spesifik (Barang 1 dan 2) - Digunakan untuk "Add Two Products"
${HOME_BTN_ADD_CART_ITEM_1}  xpath=(//android.view.ViewGroup[@content-desc="test-ADD TO CART"])[1]
${HOME_BTN_ADD_CART_ITEM_2}  xpath=//android.view.ViewGroup[@content-desc="test-ADD TO CART"]

# Tombol Remove (Barang ke-1)
${HOME_BTN_REMOVE}           xpath=(//android.view.ViewGroup[@content-desc="test-REMOVE"])[1]

# Ikon Keranjang (Untuk diklik pindah halaman)
${HOME_ICON_CART}            xpath=//android.view.ViewGroup[@content-desc="test-Cart"]

# Badge Angka Merah di Keranjang (Untuk validasi jumlah)
${HOME_CART_BADGE}           xpath=//android.view.ViewGroup[@content-desc="test-Cart"]//android.widget.TextView

# ================= CART PAGE =================
${CART_BTN_CHECKOUT}         accessibility_id=test-CHECKOUT
${CART_ITEM_TITLE}           xpath=//android.view.ViewGroup[@content-desc="test-Description"]/android.widget.TextView[1]

# ================= CHECKOUT: INFORMATION =================
${CHECKOUT_INPUT_FIRSTNAME}  accessibility_id=test-First Name
${CHECKOUT_INPUT_LASTNAME}   accessibility_id=test-Last Name
${CHECKOUT_INPUT_ZIP}        accessibility_id=test-Zip/Postal Code
${CHECKOUT_BTN_CONTINUE}     accessibility_id=test-CONTINUE
${CHECKOUT_ERROR_MSG}        xpath=//android.view.ViewGroup[@content-desc="test-Error message"]//android.widget.TextView

# ================= CHECKOUT: OVERVIEW & FINISH =================
${OVERVIEW_BTN_FINISH}       accessibility_id=test-FINISH
${COMPLETE_HEADER}           xpath=//android.widget.TextView[@text="THANK YOU FOR YOU ORDER"]


# ================= SORTING / FILTER =================
# Tombol Icon Filter di pojok kanan atas list produk
${HOME_BTN_FILTER}           xpath=//android.view.ViewGroup[@content-desc="test-Modal Selector Button"]

# Pilihan Opsi di dalam Menu Sortir
${SORT_OPTION_AZ}            xpath=//android.widget.TextView[@text="Name (A to Z)"]
${SORT_OPTION_ZA}            xpath=//android.widget.TextView[@text="Name (Z to A)"]
${SORT_OPTION_LOW_HIGH}      xpath=//android.widget.TextView[@text="Price (low to high)"]
${SORT_OPTION_HIGH_LOW}      xpath=//android.widget.TextView[@text="Price (high to low)"]

# Locator Barang Urutan Pertama (Untuk Validasi)
# Kita ambil Nama Barang ke-1
${INVENTORY_ITEM_NAME_1}     xpath=(//android.widget.TextView[@content-desc="test-Item title"])[1]
# Kita ambil Harga Barang ke-1
${INVENTORY_ITEM_PRICE_1}    xpath=(//android.widget.TextView[@content-desc="test-Price"])[1]



# ================= CHECKOUT: OVERVIEW PAGE =================
# Tombol Cancel (Untuk membatalkan transaksi)
${OVERVIEW_BTN_CANCEL}       accessibility_id=test-CANCEL

# Label Nama Produk di halaman Overview (Untuk validasi barang sebelum bayar)
${OVERVIEW_ITEM_NAME}        xpath=//android.view.ViewGroup[@content-desc="test-Description"]/android.widget.TextView[1]

# Label Total Harga (Payment Info)
${OVERVIEW_LABEL_TOTAL}      xpath=//android.widget.TextView[contains(@text, "Total: $")]



# ================= PRODUCT DETAIL PAGE =================
# Tombol Back (Kembali ke list)
${DETAIL_BTN_BACK}           accessibility_id=test-BACK TO PRODUCTS

# Informasi Produk di Halaman Detail
${DETAIL_IMG_ITEM}           accessibility_id=test-Image Container
${DETAIL_TXT_NAME}           xpath=//android.view.ViewGroup[@content-desc="test-Description"]/android.widget.TextView[1]
${DETAIL_TXT_DESC}           xpath=//android.view.ViewGroup[@content-desc="test-Description"]/android.widget.TextView[2]
${DETAIL_TXT_PRICE}          accessibility_id=test-Price

# Tombol Add to Cart & Remove (Khusus di halaman detail)
${DETAIL_BTN_ADD_TO_CART}    accessibility_id=test-ADD TO CART
${DETAIL_BTN_REMOVE}         accessibility_id=test-REMOVE