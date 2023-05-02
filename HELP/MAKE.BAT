@echo off
copy calmira.rtf calmira0.rtf
c:\programs\delphi\bin\hcp calmira.hpj
del calmira0.rtf
echo.
echo Done!
