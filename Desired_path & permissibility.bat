@echo off
setlocal EnableExtensions EnableDelayedExpansion

cls && mode con cols=120 lines=7 & cd /d "%~dp0"

set /p "userPath=Enter the desired path (e.g., C:\example): "
set "_target_directory=!userPath!"
set "_hash_data=D:\hash.txt"
set "_csv_file_path=C:\output\app_remover_%date:~-4%%date:~-7,2%%date:~-10,2%_%time:~0,2%%time:~3,2%%time:~6,2%.csv"

if not exist "%_target_directory%" (
    echo Target directory "%_target_directory%" does not exist.
    goto :_end_of_file_:
)

if not exist "%_hash_data%" (
    echo Hash data file "%_hash_data%" not found.
    goto :_end_of_file_:
)

echo "Action","File Path","Hash Value" > "%_csv_file_path%"

for /f %%i in ('dir /b /a-d "%_target_directory%" 2^>nul ^| find /c /v ""') do set "total_files=%%i"

for /r "%_target_directory%" %%i in (*) do (
    if /i not "%%~nxi" == "%~nx0" (
        set "_hash="
        for /f %%j in ('powershell -Command "Get-FileHash '%%i' -Algorithm SHA256 | Select-Object -ExpandProperty Hash"') do (
            set "_hash=%%j"
        )

        findstr /i /c:"!_hash!" "%_hash_data%" >nul
        if !errorlevel! equ 0 (
            echo "Delete (Y/N)","%%i","!_hash!" >> "%_csv_file_path%"
            echo Deleting "%%i" with hash value !_hash!
            choice /C YN /N /M "Do you want to delete this file? (Y/N)"
            if errorlevel 2 (
                echo "Not Deleted","%%i","!_hash!" >> "%_csv_file_path%"
                echo Not deleting "%%i" with hash value !_hash!
            ) else (
                echo "Deleted","%%i","!_hash!" >> "%_csv_file_path%"
                icacls "%%i" /inheritance:r >nul 2>&1
                del /q /f "%%i"
            )
        ) else (
            echo "Not Deleted","%%i","!_hash!" >> "%_csv_file_path%"
            echo Not deleting "%%i" with hash value !_hash!
        )
    )
)

echo Total files scanned: %total_files%

:_end_of_file_:
pause