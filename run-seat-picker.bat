@echo off
setlocal
cd /d "%~dp0"

set PORT=8000
set URL=http://localhost:%PORT%/seat-picker-experiment.html

echo.
echo ======================================
echo   Seat Picker Experiment - Local Server
echo ======================================
echo.
echo Serving from: %CD%
echo URL:          %URL%
echo.
echo Press Ctrl+C to stop the server.
echo.

REM Open the page in the default browser after a short delay
start "" /b cmd /c "timeout /t 2 /nobreak >nul && start "" "%URL%""

REM Try Python 3 (py launcher), then python, then node (npx http-server)
where py >nul 2>nul
if %errorlevel%==0 (
    py -3 -m http.server %PORT%
    goto :end
)

where python >nul 2>nul
if %errorlevel%==0 (
    python -m http.server %PORT%
    goto :end
)

where npx >nul 2>nul
if %errorlevel%==0 (
    npx --yes http-server -p %PORT% -c-1
    goto :end
)

echo ERROR: No Python or Node found. Install Python from https://python.org or Node from https://nodejs.org
pause

:end
endlocal
