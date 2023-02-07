@echo off
REM ****************************************************************************
REM Vivado (TM) v2022.1 (64-bit)
REM
REM Filename    : simulate.bat
REM Simulator   : Xilinx Vivado Simulator
REM Description : Script for simulating the design by launching the simulator
REM
REM Generated by Vivado on Fri Jan 20 13:17:30 +0200 2023
REM SW Build 3526262 on Mon Apr 18 15:48:16 MDT 2022
REM
REM IP Build 3524634 on Mon Apr 18 20:55:01 MDT 2022
REM
REM usage: simulate.bat
REM
REM ****************************************************************************
REM simulate design
echo "xsim RISC_V_TB_behav -key {Behavioral:sim_1:Functional:RISC_V_TB} -tclbatch RISC_V_TB.tcl -view D:/Cursuri/Anul_3/Semestru_1/CN2/Lucrare3/RISC_V_IF_ID - Copy - Copy/RISC_V_TB_behav2.wcfg -log simulate.log"
call xsim  RISC_V_TB_behav -key {Behavioral:sim_1:Functional:RISC_V_TB} -tclbatch RISC_V_TB.tcl -view D:/Cursuri/Anul_3/Semestru_1/CN2/Lucrare3/RISC_V_IF_ID - Copy - Copy/RISC_V_TB_behav2.wcfg -log simulate.log
if "%errorlevel%"=="0" goto SUCCESS
if "%errorlevel%"=="1" goto END
:END
exit 1
:SUCCESS
exit 0
