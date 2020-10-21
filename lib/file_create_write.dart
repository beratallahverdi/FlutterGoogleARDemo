import 'package:path_provider/path_provider.dart';
import 'dart:io';
import 'dart:convert'; //to convert json to maps and vice versa
import 'package:flutter/foundation.dart';

class FileIO
{
    Map<String, dynamic> tojson;
    File jsonFile;
    Directory dir;
    bool fileExists = false;


      
  Future<String> downloadFile(String url, String filename) async {
     var httpClient = new HttpClient();
     var request = await httpClient.getUrl(Uri.parse(url));
      var response = await request.close();
      var bytes = await consolidateHttpClientResponseBytes(response);
      String dir = (await getApplicationDocumentsDirectory()).path;
      File file = new File('$dir/$filename');
      await file.writeAsBytes(bytes);
      return file.path;
}

    List<dynamic> getData(String fileName)
    {
        List<dynamic> fileContent = new List<dynamic>();
        getApplicationDocumentsDirectory().then((Directory directory) {
            dir = directory;
            print(dir.path + "/" + fileName);
            jsonFile = new File(dir.path + "/" + fileName);
            if (jsonFile.existsSync())
            {
                fileContent = jsonDecode(jsonFile.readAsStringSync(encoding: utf8));
                print(fileContent.length);
                fileContent.forEach((element) {
                    print('$element');
                });
            }
            else {
            }
        });

        return fileContent;
    }

    Future<bool> fileExist(String fileName) async
    {
        bool fileExists = false;
        await getApplicationDocumentsDirectory().then((Directory directory) {
            dir = directory;
            print(dir.path + "/" + fileName);
            jsonFile = new File(dir.path + "/" + fileName);
            fileExists = jsonFile.existsSync();
        });

        print("$fileName = FileExists $fileExists");

        return fileExists;
    }

    Future<void> createFile(List<Map<String, dynamic>> content, String fileName) async
    {
        print("Creating file!");
        content.forEach((element) {element.forEach((key, value) {print('$key = $value');}); });

        await getApplicationDocumentsDirectory().then((Directory directory) {
            dir = directory;
            File file = new File(dir.path + "/" + fileName);
            file.createSync();
            file.writeAsStringSync(jsonEncode(content,toEncodable: myEncode));
        });
    }


   dynamic myEncode(dynamic item) {
        if(item is DateTime) {
            return item.toIso8601String();
        }
        return item;
    }


    // void writeToFile(String key, String value) {
    //     print("Writing to file!");
    //     Map<String, String> content = {key: value};
    //     if (fileExists) {
    //     print("File exists");
    //     Map<String, String> jsonFileContent = json.decode(jsonFile.readAsStringSync());
    //     jsonFileContent.addAll(content);
    //     jsonFile.writeAsStringSync(jsonEncode(jsonFileContent));
    //     } else {
    //     print("File does not exist!");
    //     createFile(allContent, dir, fileName);
    //     }
    //     this.setState(() => fileContent = jsonDecode(jsonFile.readAsStringSync()));
    //     print(fileContent);
    // }
}











