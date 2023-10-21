Set-Location $env:TEMP # 切换到临时目录下
Invoke-WebRequest -Uri 'https://ghproxy.com/https://github.com/imengyu/JiYuTrainer/releases/download/1.7.6/JiYuTrainer.exe' -OutFile .\JiYuTrainer.exe # 下载反极域软件
Start-Process -FilePath .\JiYuTrainer.exe # 启动反极域软件
Stop-Service TDFileFilter # 关闭极域程序锁
Remove-Item -Recurse -Path C:\Windows\System32\GroupPolicy\* # 删除计算机组策略
gpupdate /force # 刷新组策略
Write-Output Complete!
Read-Host -Prompt "按回车键以继续"