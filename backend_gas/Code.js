/**
 * ===================================================================
 * HOMIE LAUNDRY SAMARINDA - GOOGLE SHEETS BACKEND & PROMO API
 * ===================================================================
 * Script ID: 1qWI7yT5Sev3HN9l__eki2HYJfTW1F04TlT3Lrzvrrhl-4dZ3RsHyYUnp
 * 
 * Fitur:
 * 1. setupSheet() : Mengatur header, lebar kolom, dropdown status, 
 *    warna cond-formatting, dan mengisi default promo.
 * 2. onOpen()     : Menambahkan menu khusus di toolbar Google Sheets.
 * 3. doGet(e)     : Web API endpoint yang mengembalikan JSON/CSV promo aktif
 *    ke aplikasi Flutter tanpa perlu server terpisah.
 * ===================================================================
 */

const SHEET_NAME = 'Promo';
const HEADERS = ['judul_promo', 'keterangan', 'kode_promo', 'badge', 'status'];

const DEFAULT_PROMOS = [
  [
    'Jumat Berkah Cuci Sepatu',
    'Diskon 20% khusus order antar-jemput cuci sepatu di hari Jumat.',
    'JUMATBERKAH',
    'DISKON 20%',
    'Aktif'
  ],
  [
    'Weekend Cuci Sepatu & Tas',
    'Treatment deep clean & unyellowing bikin sepatu kinclong akhir pekan.',
    'WEEKENDCLEAN',
    'SPECIAL',
    'Aktif'
  ],
  [
    'Cuci Ambal & Sajadah Suci',
    'Sedot debu mendalam, basmi tungau & wangi segar tahan lama.',
    'AMBALSUCI',
    'POPULER',
    'Aktif'
  ],
  [
    'Express 3 Jam & Same Day',
    'Baju bersih, rapi setrika uap, dan wangi siap pakai dalam hitungan jam.',
    'EXPRESSKILAT',
    'KILAT',
    'Aktif'
  ]
];

/**
 * Menu otomatis saat Google Sheet dibuka
 */
function onOpen() {
  try {
    const ui = SpreadsheetApp.getUi();
    ui.createMenu('🧺 Homie Laundry')
      .addItem('🚀 Setup / Format Ulang Sheet Promo', 'setupSheet')
      .addItem('📋 Lihat URL Web API untuk Aplikasi', 'showApiUrl')
      .addToUi();
  } catch (e) {
    Logger.log('onOpen notice: ' + e.message);
  }
}

/**
 * Mendapatkan referensi Sheet Promo
 */
function getPromoSheet() {
  const ss = SpreadsheetApp.getActiveSpreadsheet();
  if (!ss) return null;

  let sheet = ss.getSheetByName(SHEET_NAME);
  if (!sheet) {
    // Gunakan sheet pertama jika belum ada sheet bernama Promo
    const sheets = ss.getSheets();
    if (sheets.length > 0) {
      sheet = sheets[0];
      sheet.setName(SHEET_NAME);
    } else {
      sheet = ss.insertSheet(SHEET_NAME);
    }
  }
  return sheet;
}

/**
 * Setup format tampilan dan data awal Google Sheet
 */
function setupSheet() {
  const sheet = getPromoSheet();
  if (!sheet) {
    Logger.log('Spreadsheet aktif tidak ditemukan.');
    return;
  }

  // 1. Tulis Header jika kosong atau perlu pembaruan
  const headerRange = sheet.getRange(1, 1, 1, HEADERS.length);
  headerRange.setValues([HEADERS]);

  // Format Header (Biru Khas Homie Laundry, Teks Putih Tebal)
  headerRange
    .setBackground('#0284C7')
    .setFontColor('#FFFFFF')
    .setFontWeight('bold')
    .setFontSize(11)
    .setHorizontalAlignment('center')
    .setVerticalAlignment('middle');
  sheet.setRowHeight(1, 38);
  sheet.setFrozenRows(1);

  // 2. Jika baris data masih kosong, masukkan default promo
  const lastRow = sheet.getLastRow();
  if (lastRow <= 1) {
    const dataRange = sheet.getRange(2, 1, DEFAULT_PROMOS.length, HEADERS.length);
    dataRange.setValues(DEFAULT_PROMOS);

    for (let r = 2; r <= DEFAULT_PROMOS.length + 1; r++) {
      sheet.setRowHeight(r, 32);
    }
  }

  // 3. Format Penjajaran Kolom
  const maxRows = Math.max(sheet.getLastRow(), 10);
  sheet.getRange(2, 1, maxRows - 1, 2)
    .setHorizontalAlignment('left')
    .setVerticalAlignment('middle');
  sheet.getRange(2, 3, maxRows - 1, 3)
    .setHorizontalAlignment('center')
    .setVerticalAlignment('middle');

  // 4. Pengaturan Lebar Kolom yang Ideal
  sheet.setColumnWidth(1, 230); // judul_promo
  sheet.setColumnWidth(2, 380); // keterangan
  sheet.setColumnWidth(3, 140); // kode_promo
  sheet.setColumnWidth(4, 130); // badge
  sheet.setColumnWidth(5, 110); // status

  // 5. Dropdown Validasi untuk Kolom Status (Aktif / Nonaktif)
  const statusRule = SpreadsheetApp.newDataValidation()
    .requireValueInList(['Aktif', 'Nonaktif'], true)
    .setAllowInvalid(false)
    .setHelpText('Pilih status: Aktif atau Nonaktif')
    .build();
  sheet.getRange(2, 5, 100, 1).setDataValidation(statusRule);

  // 6. Conditional Formatting untuk Status
  sheet.clearConditionalFormatRules();
  const statusRange = sheet.getRange('E2:E100');

  const ruleAktif = SpreadsheetApp.newConditionalFormatRule()
    .whenTextEqualTo('Aktif')
    .setBackground('#DCFCE7') // Hijau muda segar
    .setFontColor('#15803D')
    .setRanges([statusRange])
    .build();

  const ruleNonaktif = SpreadsheetApp.newConditionalFormatRule()
    .whenTextEqualTo('Nonaktif')
    .setBackground('#F1F5F9') // Abu-abu muted
    .setFontColor('#64748B')
    .setRanges([statusRange])
    .build();

  sheet.setConditionalFormatRules([ruleAktif, ruleNonaktif]);

  try {
    SpreadsheetApp.getActiveSpreadsheet().toast(
      'Sheet Promo berhasil diformat & disiapkan!',
      '🧺 Homie Laundry',
      4
    );
  } catch (e) {
    Logger.log('Setup selesai.');
  }
}

/**
 * Dialog panduan URL Web API
 */
function showApiUrl() {
  const ui = SpreadsheetApp.getUi();
  const scriptId = ScriptApp.getScriptId();
  const html = `
    <div style="font-family: Arial, sans-serif; padding: 15px; color: #1e293b;">
      <h3 style="color: #0284c7; margin-top: 0;">🧺 Web API Promo Homie Laundry</h3>
      <p style="font-size: 13px;">Gunakan URL deployment Web App di bawah ini untuk dimasukkan ke konfigurasi aplikasi Flutter (<code>app_config.dart</code>):</p>
      <div style="background: #f8fafc; border: 1px solid #cbd5e1; border-radius: 6px; padding: 10px; font-size: 12px; word-break: break-all; margin: 10px 0;">
        https://script.google.com/macros/s/${scriptId}/exec
      </div>
      <p style="font-size: 11px; color: #64748b;">
        Setiap kali Anda mengubah data promo di sheet ini, banner promo di aplikasi pelanggan akan otomatis terbarui secara real-time!
      </p>
    </div>
  `;
  const output = HtmlService.createHtmlOutput(html).setWidth(480).setHeight(240);
  ui.showModalDialog(output, 'Homie Laundry Samarinda');
}

/**
 * ===================================================================
 * WEB API ENDPOINT (GET)
 * ===================================================================
 * Menerima request dari Flutter:
 * - Default: Mengembalikan JSON daftar promo yang berstatus "Aktif"
 * - Parameter ?format=csv: Mengembalikan format CSV
 * - Parameter ?all=true: Mengembalikan semua baris termasuk Nonaktif
 */
function doGet(e) {
  try {
    const sheet = getPromoSheet();
    if (!sheet) {
      return createJsonResponse({
        status: 'error',
        message: 'Sheet "Promo" tidak ditemukan'
      });
    }

    const lastRow = sheet.getLastRow();
    if (lastRow <= 1) {
      return createJsonResponse({
        status: 'success',
        count: 0,
        data: []
      });
    }

    const values = sheet.getRange(2, 1, lastRow - 1, 5).getValues();
    const promos = [];

    const showAll = e && e.parameter && e.parameter.all === 'true';

    for (let i = 0; i < values.length; i++) {
      const row = values[i];
      const title = String(row[0] || '').trim();
      const description = String(row[1] || '').trim();
      const promoCode = String(row[2] || '').trim();
      const badge = String(row[3] || 'PROMO').trim();
      const status = String(row[4] || '').trim();

      if (!title) continue;

      const isActive = status.toLowerCase() === 'aktif' || status.toLowerCase() === 'active';

      if (isActive || showAll) {
        promos.push({
          judul_promo: title,
          keterangan: description,
          kode_promo: promoCode,
          badge: badge,
          status: status || 'Aktif',
          is_active: isActive
        });
      }
    }

    // Format output CSV jika diminta
    if (e && e.parameter && e.parameter.format === 'csv') {
      let csv = 'judul_promo,keterangan,kode_promo,badge,status\n';
      promos.forEach(p => {
        const cleanTitle = p.judul_promo.replace(/"/g, '""');
        const cleanDesc = p.keterangan.replace(/"/g, '""');
        csv += `"${cleanTitle}","${cleanDesc}","${p.kode_promo}","${p.badge}","${p.status}"\n`;
      });
      return ContentService.createTextOutput(csv)
        .setMimeType(ContentService.MimeType.CSV);
    }

    // Default output JSON
    return createJsonResponse({
      status: 'success',
      timestamp: new Date().toISOString(),
      count: promos.length,
      data: promos
    });

  } catch (err) {
    return createJsonResponse({
      status: 'error',
      message: err.toString()
    });
  }
}

function createJsonResponse(data) {
  return ContentService.createTextOutput(JSON.stringify(data, null, 2))
    .setMimeType(ContentService.MimeType.JSON);
}
