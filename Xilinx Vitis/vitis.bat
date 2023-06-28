@echo off
rem #
rem # COPYRIGHT NOTICE
rem # Copyright 1986-2018 Xilinx, Inc. All Rights Reserved.
rem #
set RDI_EXIT=

rem # JD
rem # avoid PATH overflow
set PATH=

setlocal enableextensions enabledelayedexpansion

rem # RDI_ARGS_FUNCTION must be cleared here, otherwise child
rem # planAhead processes will inherit the parent's args.
set RDI_ARGS_FUNCTION=

if not defined _RDI_SETENV_RUN (
  call "%~dp0/setupEnv.bat"
)
if defined _RDI_SETENV_RUN (
  set _RDI_SETENV_RUN=
)

set _RDI_DONT_SET_XILINX_AS_PATH=True
set XIL_NO_OVERRIDE=0
set XIL_SUPPRESS_OVERRIDE_WARNINGS=1
set RDI_NO_JRE=1
set RDI_USE_JDK11=1

if defined RDI_EXIT (
  goto :EOF
)

set RDI_OS_ARCH=64
set RDI_OPT_EXT=.o

rem #
rem # If True check for the existence of RDI_PROG prior to calling into
rem # rdiArgs.bat
rem #
set RDI_CHECK_PROG=True

set RDI_DEPENDENCY=XILINX_VIVADO_HLS;XILINX_HLS

set XILINX_VIVADO=%RDI_INSTALLROOT%/Vivado/%RDI_INSTALLVER%
set XILINX_VIVADO_HLS=%RDI_INSTALLROOT%/Vivado/%RDI_INSTALLVER%

if defined VITIS_SDK (
  set XILINX_VITIS=%VITIS_SDK%
) else (
  set XILINX_VITIS=%RDI_INSTALLROOT%/Vitis/%RDI_INSTALLVER%
)

set XILINX_VITIS=%RDI_APPROOT%


set XILINX_VITIS_VERSION=UnknownVersion
if exist "%RDI_BINROOT%/unwrapped/win64.o/prodversion.exe" (
    for /F "delims=" %%i in ('%RDI_BINROOT%/loader.bat -exec prodversion Vitis') do set XILINX_VITIS_VERSION=%%i
)
if exist "%RDI_APPROOT%/data/version.bat" (
  call "%RDI_APPROOT%/data/version.bat"
)

if exist "%RDI_INSTALLROOT%/Vitis/%RDI_INSTALLVER%" (
	SET XILINX_VITIS=%RDI_INSTALLROOT%/Vitis/%RDI_INSTALLVER%
	SET XILINX_VITIS=%RDI_INSTALLROOT%/Vitis/%RDI_INSTALLVER%
)

set PATH=%XILINX_VIVADO_HLS%/bin;!PATH!
set PATH=%XILINX_VIVADO%/bin;!PATH!
set PATH=%XILINX_VITIS%/bin;!PATH!
set PATH=%XILINX_VITIS%/tps/win64/libxslt/bin;!PATH!
set PATH=%XILINX_VITIS%/lib/win64.o;!PATH!

set NOSPLASH=false

for %%x in (%*) do (
   if "%%~x" == "-nosplash" (
	set NOSPLASH=true
	GOTO:doneProcessing
   )
)
:doneProcessing

if [!NOSPLASH!] == [true] (
 GOTO:launch
)



echo.
echo ****** Xilinx Vitis Development Environment
echo %XILINX_VITIS_VERSION%
echo|set /p="****** " || cmd /c "exit /b 0"
rem # Need to pass args, in particular -dbg, otherwise the executable might not be found
rem # sdsbuildinfo itself ignores all arguments, so extra arguments should be safe.
call %RDI_BINROOT%/buildinfo.bat %*
echo     ** Copyright 1986-2021 Xilinx, Inc. All Rights Reserved.
echo.
rem # echo Loading Vitis plugins ...
:launch
set RDI_PROG=%~n0
call "%RDI_BINROOT%/loader.bat" -exec rdi_vitis %*
