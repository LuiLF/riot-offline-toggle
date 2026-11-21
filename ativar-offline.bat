
@echo off
setlocal EnableExtensions

:: Verifica privilegios administrativos
fltmc >nul 2>&1
if errorlevel 1 (
    echo [ERRO] Execute como administrador.
    pause
    exit /b 1
)

echo [INFO] Aplicando bloqueio do chat Riot...

:: Remove regras anteriores com os mesmos nomes
netsh advfirewall firewall delete rule name="LoL_Offline_Portas" >nul 2>&1
netsh advfirewall firewall delete rule name="LoL_Offline_IP" >nul 2>&1
netsh advfirewall firewall delete rule name="LoL_Offline_v6" >nul 2>&1

:: Bloqueia portas TCP relacionadas ao chat
netsh advfirewall firewall add rule name="LoL_Offline_Portas" dir=out action=block protocol=TCP remoteport=5222,5223
if errorlevel 1 goto :erro

:: Descobre o IPv4 atual do servidor de chat
set "IP_LOL="
for /f "tokens=2 delims=[]" %%a in ('ping -n 1 -4 br.chat.si.riotgames.com ^| findstr /C:"["') do set "IP_LOL=%%a"

if not defined IP_LOL (
    echo [AVISO] Nao foi possivel identificar o IPv4 do servidor.
    echo [AVISO] Somente o bloqueio por portas foi aplicado.
) else (
    echo [INFO] IPv4 identificado: %IP_LOL%
    netsh advfirewall firewall add rule name="LoL_Offline_IP" dir=out action=block protocol=TCP remoteip=%IP_LOL%
    if errorlevel 1 goto :erro
)

echo.
echo [OK] Regras aplicadas.
echo Reinicie o Riot Client e os jogos para testar.
pause
exit /b 0

:erro
echo.
echo [ERRO] Falha ao configurar uma regra do firewall.
echo Verifique as mensagens anteriores.
pause
exit /b 1
