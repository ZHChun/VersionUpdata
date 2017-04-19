# VersionUpdata

第二种版本升级提示参考:https://github.com/CoderZhuXH/XHVersion


手动\n
\n1.将 XHVersion 文件夹添加到工程目录中
\n2.导入 XHVersion.h



Pod\n
\n1.在 Podfile 中添加 pod 'XHVersion'
\n2.执行 pod install 或 pod update
\n3.导入 XHVersion.h

Tips\n
\n1.如果发现pod search XHVersion 搜索出来的不是最新版本，需要在终端执行cd ~/desktop退回到desktop，然后执行pod setup命令更新本地spec缓存（需要几分钟），然后再搜索就可以了
\n2.如果你发现你执行pod install后,导入的不是最新版本,请删除Podfile.lock文件,在执行一次 pod install
\n3.如果在使用过程中遇到BUG，希望你能Issues我，谢谢（或者尝试下载最新的代码看看BUG修复没有）
