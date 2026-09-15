# proscan

QR code scanner and generator application

## Details
-This flutter app has the scan QR code and create QR code features.
  -The scan QR code feature uses the Mobile scanner package to detect qr codes and spit out the result as a string.The mobile scanner is also used to analyze images from the  phone gallery by detecting qr codes in them.Images in the phone gallery are accessed  using the image picker flutter package.After detection the decoded content is  displayed in subsequent screen and also saved in Hive storage.
-The create Qr feature utilizes the flutter_qr package to generate Qr codes from the user input(text). The generated codes can optionally be saved to phone gallery via the the gal package after using the RepaintBoundary widget and a global key which identifies the widget in the widget tree.

-Storage of data
   -Hive
   -Shared Preferences

-Architechture used
    -clean architecture with riverpod providers

## Running the app
 -Clone the repository.
 -Make sure flutter SDK is installed on your computer
 -open app in an IDE e.g VS code.
 -Run flutter pub get to link the dependencies in pubspec.yaml to the app.
 -Connect your phone to the laptop via USB,check that Vs code detects it then run `flutter run -d "device number at the bottom right of the vs code window`.
