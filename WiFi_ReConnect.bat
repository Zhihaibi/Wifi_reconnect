@echo off
rem @date: 2022.05.18
rem @note: WiFi Reconnect

rem 修改您需要连接的wifi名称
set wifi_name="iFudanNG.1x"


set log_file=wifi.log
set try_cnt=1

if [%1] == [] (echo default_wifi>nul) || (
	set wifi_name=%1
)

echo [%date% %time%] Start connect wifi:%wifi_name% >>%log_file%


:mainloop
	(netsh WLAN show interfaces | findStr %wifi_name% >nul && (echo already connected.
	) )  || (
	set /a try_cnt+=1
	echo [%date% %time%] try to connect...[%try_cnt%]
	echo [%date% %time%] try to connect...[%try_cnt%] >>%log_file%
	netsh wlan connect ssid=%wifi_name% name=%wifi_name% >>%log_file%
	)

	choice /t 30 /d y /n >nul
goto mainloop
