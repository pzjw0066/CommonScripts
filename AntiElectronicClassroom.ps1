Set-Location $env:TEMP # �л�����ʱĿ¼��
Invoke-WebRequest -Uri 'https://ghproxy.com/https://github.com/imengyu/JiYuTrainer/releases/download/1.7.6/JiYuTrainer.exe' -OutFile .\JiYuTrainer.exe # ���ط��������
Start-Process -FilePath .\JiYuTrainer.exe # �������������
Stop-Service TDFileFilter # �رռ��������
Remove-Item -Recurse -Path C:\Windows\System32\GroupPolicy\* # ɾ������������
gpupdate /force # ˢ�������
Write-Output Complete!
Read-Host -Prompt "���س����Լ���"