@echo off
setlocal EnableExtensions DisableDelayedExpansion

title Windows File Organizer

echo.
echo ==========================================
echo       WINDOWS FILE ORGANIZER
echo ==========================================
echo.
echo Organizing files in:
echo %CD%
echo.

set "MOVED=0"
set "SKIPPED=0"
set "ERRORS=0"

for %%F in (*) do (
    rem Skip directories
    if not exist "%%~fF\" (

        rem Skip this batch file
        if /I not "%%~fF"=="%~f0" (

            rem Process only files that have an extension
            if not "%%~xF"=="" (

                rem Create a folder using the file extension
                if not exist "%%~xF\" (
                    mkdir "%%~xF" 2>nul
                )

                rem Check whether the destination file already exists
                if exist "%%~xF\%%~nxF" (

                    echo [SKIP] "%%~nxF"
                    echo        Destination already exists.
                    set /A SKIPPED+=1

                ) else (

                    rem Move the file
                    move "%%~fF" "%%~xF\" >nul 2>&1

                    if errorlevel 1 (
                        echo [ERROR] Could not move "%%~nxF"
                        set /A ERRORS+=1
                    ) else (
                        echo [MOVED] "%%~nxF" ^> %%~xF\
                        set /A MOVED+=1
                    )
                )
            )
        )
    )
)

echo.
echo ==========================================
echo              ORGANIZATION COMPLETE
echo ==========================================
echo.
echo Files moved   : %MOVED%
echo Files skipped : %SKIPPED%
echo Errors        : %ERRORS%
echo.
echo Files without extensions were left unchanged.
echo Existing destination files were not overwritten.
echo.
pause
endlocal
