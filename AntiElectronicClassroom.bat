@echo off
cd %temp% & rem �л�����ʱĿ¼��
echo ���������������...
curl https://ghproxy.com/https://github.com/imengyu/JiYuTrainer/releases/download/1.7.6/JiYuTrainer.exe -o .\JiYuTrainer.exe > nul & rem ���ط��������
echo ����������������!
start "" .\JiYuTrainer.exe & rem �������������
echo ���������������...
sc stop TDFileFilter > nul & rem �رռ��������
echo ����������ر����!
del /S /Q C:\Windows\System32\GroupPolicy\* > nul & rem ɾ������������
gpupdate /force > nul & rem ˢ�������
echo �����ɾ���ɹ�!
echo ������в���!
pause