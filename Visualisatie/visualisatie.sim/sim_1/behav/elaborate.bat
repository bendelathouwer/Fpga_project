@echo off
set xv_path=C:\\Vivado\\2015.4\\bin
call %xv_path%/xelab  -wto 272df2b37cbf4abd945b2ec15369c7e6 -m64 --debug typical --relax --mt 2 -L xil_defaultlib -L secureip --snapshot Vga_TB_behav xil_defaultlib.Vga_TB -log elaborate.log
if "%errorlevel%"=="0" goto SUCCESS
if "%errorlevel%"=="1" goto END
:END
exit 1
:SUCCESS
exit 0
