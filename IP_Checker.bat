@echo off
cls

echo -----------------------------------------------------------------------------------
echo -----------------------------------------------------------------------------------
echo Testando conexao com o servidor pelo IP - IPCheck v1 - Stefan Oliveira - 29/03/2019
echo -----------------------------------------------------------------------------------
echo -----------------------------------------------------------------------------------

color 2

:opcStart
echo      Escolha uma opcao:
echo ==================================
echo * 1 - Efetuar testes             *
echo * 2 - Sair do Programa           *
echo ==================================

set /p opcao= Escolha uma opcao:
echo ----------------------------
IF %opcao%==1 (
	goto opcao1
) ELSE (
    goto opcao2
)

:opcao1
cls
echo Computador: %computername%        Usuario: %username%
date /t

:pingIPSrv1
echo =====================================================
echo ================"Nome do Seu Servidor"================
echo =====================================================
pause
ping -n 3 <IP do Seu Servidor>
IF %errorlevel%==0 (
	goto echoSRV1
) ELSE (
	echo Falha, verifique a conexao de rede e tente novamente
	pause
	goto opcao2
)
:echoSRV1
echo ------------------------------------------------------------------------------------------------------------------
echo -------------- Teste concluido, nenhuma falha encontrada, proximo teste: Servidor de banco de dados! -------------
echo ------------------------------------------------------------------------------------------------------------------
pause
goto pingIPSrv2

:pingIPSrv2
echo =======================================================================
echo ================"Nome do Seu Segundo Servidor"================
echo =======================================================================
pause
ping -n 3 <IP do Seu Servidor>
IF %errorlevel%==0 (
	goto echoSRV2
) ELSE (
	echo --  Falha, verifique a conexão de rede e tente novamente -- 
	pause
	goto opcao2
)
:echoSRV2
echo -------------------------------------------------------------------------------------------------
echo -------------- Teste concluido, nenhuma falha encontrada, iniciando testes de DNS! --------------
echo -------------------------------------------------------------------------------------------------
pause
echo ----------------------------------------------------------------------------
echo -------------- Testando conexao com o servidor pelo Host/Nome --------------
echo ----------------------------------------------------------------------------
pause
goto pingHostSrv1

:pingHostSrv1
echo ====================================================================
echo ================"Nome do Seu Servidor"================
echo ====================================================================
pause
ping -n 3 -a <HOST_Servidor>
IF %errorlevel%==0 (
	goto HostSrv1
) ELSE (
	echo -- Falha, verifique a conexao de rede e tente novamente --
	pause
	goto dnsCheck
)
:HostSrv1
echo ------------------------------------------------------------------------
echo -------------- Teste concluido, nenhuma falha encontrada! --------------
echo ------------------------------------------------------------------------
pause
echo --------------------------------------------------------------------
echo -------------- Testando conexao com o banco de dados! --------------
echo --------------------------------------------------------------------
pause
goto pingHostSrv2

:pingHostSrv2
echo ==========================================================================
echo ================"Nome do Seu Segundo Servidor"================
echo ==========================================================================
pause
ping -n 3 -a <HOST_Servidor>
IF %errorlevel%==0 (
		goto HostSrv2
) ELSE (
		echo --  Falha ao resolver o nome, provavel erro no DNS -- 
		pause
		goto dnsCheck
)
:HostSrv2
echo -----------------------------------------------------------------------------
echo -------------- Checagem concluida, nenhum problema encontrado! --------------
echo -----------------------------------------------------------------------------
pause
echo Saindo!
pause
cls
goto opcStart

:dnsCheck
echo =======================
echo Checando endereço de IP
echo =======================
pause
ipconfig /all
pause

echo ==================
echo Limpando cache DNS
echo ==================
ipconfig /flushdns
pause

echo =============
echo Registrar DNS
echo =============
ipconfig /registerdns

echo Testes concluidos! 
pause
goto opcStart


:opcao2
cls
exit