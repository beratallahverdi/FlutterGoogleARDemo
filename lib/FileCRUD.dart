import 'package:path_provider/path_provider.dart';
import 'dart:io';
import 'dart:convert'; //to convert json to maps and vice versa
import 'package:flutter/foundation.dart';

class FileIO
{
    Directory dir;
    String dirPath;

    FileIO._create() {
        print("_create() (private constructor)");
    }
    // https://stackoverflow.com/questions/38933801/calling-an-async-method-from-component-constructor-in-dart
    static Future<FileIO> create() async {
        print("create() (public factory)");

        // Call the private constructor
        var component = FileIO._create();

        // Do initialization that requires async
        //await component._complexAsyncInit();

        await getApplicationDocumentsDirectory().then((Directory directory) {
            component.dir = directory;
            component.dirPath = directory.path;
        });
        
        // Return the fully initialized object
        return component;
    }
      
    Future<String> downloadFileGetFilePath(String url, String fileName) async 
    {
        var httpClient = new HttpClient();
        var request = await httpClient.getUrl(Uri.parse(url));
        var response = await request.close();
        var bytes = await consolidateHttpClientResponseBytes(response);
        File file = new File("${this.dirPath}/$fileName");
        await file.writeAsBytes(bytes);
        return file.path;
    }

    Future<bool> fileExist(String fileName) async
    {
        bool isFile =  new File("${this.dirPath}/$fileName").existsSync();
        print("$fileName = FileExists $isFile");
        return isFile;
    }
}











