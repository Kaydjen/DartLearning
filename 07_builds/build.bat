@echo off
echo Building to specific folder...
set DESTINATION=%USERPROFILE%\Desktop\dart_learning.exe 
:: Desktop: %USERPROFILE%\Desktop\dart_learning.exe      
:: Documents: %USERPROFILE%\Documents\dart_learning.exe          
:: Current directory: dart_learning.exe         
:: Current directory: 07_builds\dart_learning.exe         
dart compile exe Program.dart -o %DESTINATION%
echo Build complete! Executable: %DESTINATION%