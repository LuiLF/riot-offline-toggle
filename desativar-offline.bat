
@echo off
setlocal EnableExtensions

:: Verifica privilegios administrativos
fltmc >nul 2>&1
if errorlevel 1 (
    echo [ERRO] Execute como administrador.
    pause
    exit /b 1
)

echo [INFO] Removendo bloqueios do chat Riot...

netsh advfirewall firewall delete rule name="LoL_Offline_Portas"
netsh advfirewall firewall delete rule name="LoL_Offline_IP"
netsh advfirewall firewall delete rule name="LoL_Offline_v6"

echo.
echo [INFO] Remocao solicitada.
echo Reinicie o Riot Client para atualizar o status.
pause
