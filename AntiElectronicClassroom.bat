@echo off
cd %temp% & rem 切换到临时目录下
echo 反极域软件下载中...
curl https://ghproxy.com/https://github.com/imengyu/JiYuTrainer/releases/download/1.7.6/JiYuTrainer.exe -o .\JiYuTrainer.exe > nul & rem 下载反极域软件
echo 反极域软件下载完毕!
start "" .\JiYuTrainer.exe & rem 启动反极域软件
echo 反极域软件启动中...
sc stop TDFileFilter > nul & rem 关闭极域程序锁
echo 极域程序锁关闭完成!
del /S /Q C:\Windows\System32\GroupPolicy\* > nul & rem 删除计算机组策略
gpupdate /force > nul & rem 刷新组策略
echo 组策略删除成功!
echo 完成所有操作!
pause