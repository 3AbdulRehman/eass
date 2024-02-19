  import 'package:gsheets/gsheets.dart';

  class StudentRecordsSheet {
    static final _credentials = r'''
      {
        "type": "service_account",
        "project_id": "gsheet-414518",
        "private_key_id": "91d92e31484165d771f5e637b95997ed0c6e9671",
        "private_key": "-----BEGIN PRIVATE KEY-----\nMIIEvgIBADANBgkqhkiG9w0BAQEFAASCBKgwggSkAgEAAoIBAQC9/Q5w53GHGWXe\nKz751WG2hr9PLgBLqCK3toOP/XXR9xFI0sMBGb02skCycDw/3MXRlpvQN1PyV5Qv\nwAWeneMNd94AUqudvTyok7wMg4Dy70bzNdCErC904NZitubeX6e934/mWIvGGJId\n9uFIqDyKgp0e8YKlAdMsVE01jKkjS5s580oDXrgvdDB2pCO9JUd07/wBb7NiKxjp\nUhWRU/Mgg5e/ahVNTujfUc8BDEXQSsiCAW0qb+F84DorcUmtIjB/Q+ulE2+NZ5xe\nOprGqZYTit6W5x2r8pi5ZEt0ULt+ti1PaDQQoSUN6gFWJHnA7cKMkNiQDGO/gEnY\nI/YiDlnFAgMBAAECggEARfe1g0gBC8+DMAQ+L5TxZN6QAvF+g15a1sx8/CDMbLRw\nJaEU1slrYQLZh72EusIsCglMvaw6mrO9K66sgyNDVJjx5a2MbU2dUroBlZwyd4U+\nXGBTuCCPY5xP58/TC08v/+Ge5aZzZ1NyMF3UzsTCcwIyKgyoX+thoWA0hQWV3pyd\njG06/eboP8EA79HfkJpuMmhkzOUZuEGqTNcRLfbQpHiyRlAEZXdg57C5CNEv0lGN\nU6RRIuQHmbvKdlvXHEQvAJuP8AL/ddE0rdj5y9F73EadzWTxdUWKLOW0xtIKbuGF\nu2mrkm7Qyfn30acQW0sCo5h7kqRiibQTL3XwijeL6wKBgQDfg5djFgyfkZX0ThpT\n/dSXzP6WnSI4pL7IylQj4p/BeaIQQ64WTb+AtnF/fBvJT+z56no/1ZVeCGCNfIar\nZpl3XI1Qo8eg1J9vN00njIugKw3drlJ7HItZWySKpNQFfcCdKUQYrgIeSeERX952\nvU74oP+QagYrtJVrQPMJfZMA0wKBgQDZmg/8IOsfuLS1GUhQ289zLuRfwFFKl4rN\nM5TFtjE8dmNy+D/k/vU+c/yeJELz3WOmWQPzyvKeFKLCe+JQQDsD2hvz68J+Dcsl\ndM5i+WxdMF7mkl8SgzHmulqypnDa7UHyVi98+4IwhYVnobpiTTuVkGE0beAFoK8c\nsAfnE9zcBwKBgQCxVDqYT1cGhj+9SvXSa1DueqIFpncPD42ZygRFUDhFDJZKZxfH\n9DkaCiUz6qg06Gdvw9rnqDFQID9SIVjKxaS+MTygnL/11psDZpGc7gGcumvO0832\nhKf95bSxFqJsFN/rEGFJX0yo8R5SZYgfFoR/92OrFKL+q8/b/vSTNACcJwKBgB6T\nmHVsRr3BXZso/1FlYcQkrbCKvKGHo9hrzBbwIAEH/bd1DL1n2hw5fiDWpZXQ4STJ\n01VZijgOXESJ1eZC8Ef9SPpAgabm10nfHPUpaUG6/0rU/IkEaGmse/woiSkqN58O\n30NnsAaTbIiAYElZ4uqETDRq0BTaXGDil2mwD9PXAoGBAKY9rfOuc11QLzfZ9ykC\nggmjYP50e2o3zMZNcuxxAkMZVjykVOhB20PJGEwAL1iKLyK8UIOtpbNlV1+JE8M/\nbH3G6uaOXwtOxD3pK42XHEKxWqaTmC3B69W2DKLQpeXkQr+ox2lobB7ebhO1bqc8\nRgdvKNeUT4UAKBdABQGbx/Qp\n-----END PRIVATE KEY-----\n",
        "client_email": "gsheets@gsheet-414518.iam.gserviceaccount.com",
        "client_id": "105448849774243617915",
        "auth_uri": "https://accounts.google.com/o/oauth2/auth",
        "token_uri": "https://oauth2.googleapis.com/token",
        "auth_provider_x509_cert_url": "https://www.googleapis.com/oauth2/v1/certs",
        "client_x509_cert_url": "https://www.googleapis.com/robot/v1/metadata/x509/gsheets%40gsheet-414518.iam.gserviceaccount.com",
        "universe_domain": "googleapis.com"
      }
    ''';

    static final _spreadsheetId = '1tkqWM7Dg5yk1OJWTX5do7xbPHoVl5W-3d0JzPIjxUMo';
    static final _gsheets = GSheets(_credentials);
    static Worksheet? _usersheet;

    static Future init() async {
      try {
        final spreadsheet = await _gsheets.spreadsheet(_spreadsheetId);
        _usersheet = await _getWorkSheet(spreadsheet, title: 'students records');

        // Initialize header row if the sheet is empty
        if (_usersheet== null|| _usersheet!.values == null ) {
          await _usersheet!.values!.insertRow(1, ['RollNo', 'Name', 'Department','Semester',
            'Paper1','Paper2','Paper3','Paper4'
          ]);
        }
      } catch (e) {
        print("init Error : $e");
      }
    }

    static Future<Worksheet> _getWorkSheet(Spreadsheet spreadsheet,
        {required String title}) async {
      try {
        return await spreadsheet.addWorksheet(title);
      } catch (e) {
        return spreadsheet.worksheetByTitle(title)!;
      }
    }

    static Future<Map<String, dynamic>?> getById(String rollNo) async {
      if (_usersheet == null) return null;

      final values = await _usersheet!.values.map.allRows();
      for (var row in values!) {
        if (row['RollNo'] == rollNo) {
          return {'Name': row['Name'], 'Department': row['Department'], 'Semester': row['Semester'],
            'Paper1': row['Paper1'],'Paper2': row['Paper2'],'Paper3':row['Paper3'],'Paper4':row['Paper4'],
            'Room No1':row['Room No1'],'Room No2':row['Room No2'],'Room No3':row['Room No3'],'Room No4':row['Room No4'],'Room No5':row['Room No5'],
            "Invagilator1": row['Invagilator1'],"Invagilator2": row['Invagilator2'],"Invagilator3": row['Invagilator3'],

          };
        }
      }
      return null; // RollNo not found
    }


    static Future<void> insert(String rollNo, String name, String department,String Semester,
        String Paper1,String Paper2,String Paper3,String Paper4) async {
      if (_usersheet == null) return;


      await _usersheet!.values.map.appendRow({'RollNo': rollNo, 'Name': name, 'Department': department,'Semester':Semester,
        'Paper1':Paper1,'Paper2':Paper2,'Paper3':Paper3,'Paper4':Paper4,

      });
    }
    ////////////////////////////// update not working complety
    /*static Future<void> update(String rollNo, String name, String department) async {
      if (_usersheet == null) return;

      final values = await _usersheet!.values.map.allRows();
      for (var row in values!) {
          if (row['RollNo'] == rollNo) {
          row['Name'] = name;
          row['Department'] = department;
          await _usersheet!.values.map.appendRow(row);
          return;
        }
      }
    }
    /////////////////////////////// delete
    static Future<void> delete(String rollNo) async {
      if (_usersheet == null) return;

      final values = await _usersheet!.values.map.allRows();
      for (var i = 0; i < values!.length; i++) {
        if (values[i]['RollNo'] == rollNo) {
          await _usersheet!.deleteRow(i + 1); // Rows are 1-indexed
          return;
        }
      }
    }


*/
  }
