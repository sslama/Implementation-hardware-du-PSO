@echo off
REM ****************************************************************************
REM Vivado (TM) v2018.1 (64-bit)
REM
REM Filename    : elaborate.bat
REM Simulator   : Xilinx Vivado Simulator
REM Description : Script for elaborating the compiled design
REM
REM Generated by Vivado on Fri Jul 12 11:55:43 +0200 2019
REM SW Build 2188600 on Wed Apr  4 18:40:38 MDT 2018
REM
REM Copyright 1986-2018 Xilinx, Inc. All Rights Reserved.
REM
REM usage: elaborate.bat
REM
REM ****************************************************************************
call xelab  -wto fe738af53c4a4f8dab40d1f26870dba1 --incr --debug typical --relax --mt 2 -L xil_defaultlib -L secureip --snapshot Update_Velocity_tb_behav xil_defaultlib.Update_Velocity_tb -log elaborate.log
if "%errorlevel%"=="0" goto SUCCESS
if "%errorlevel%"=="1" goto END
:END
exit 1
:SUCCESS
exit 0
