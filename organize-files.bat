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

                rem Remove the leading dot from the extension
                for /f "tokens=1 delims=." %%E in ("%%~xF") do (

                    rem Create extension folder without the dot
                    if not exist "%%E\" (
                        mkdir "%%E" 2>nul
                    )

                    rem Check whether the destination file already exists
                    if exist "%%E\%%~nxF" (

                        echo [SKIP] "%%~nxF"
                        echo        Destination already exists.
                        set /A SKIPPED+=1

                    ) else (

                        rem Move the file
                        move "%%~fF" "%%E\" >nul 2>&1

                        if errorlevel 1 (
                            echo [ERROR] Could not move "%%~nxF"
                            set /A ERRORS+=1
                        ) else (
                            echo [MOVED] "%%~nxF" ^> %%E\
                            set /A MOVED+=1
                        )
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
