# VersionUpdata

第二种版本升级提示参考:https://github.com/CoderZhuXH/XHVersion


手动


1.将 XHVersion 文件夹添加到工程目录中

2.导入 XHVersion.h



Pod


1.在 Podfile 中添加 pod 'XHVersion'

2.执行 pod install 或 pod update

3.导入 XHVersion.h


Tips
1.如果发现pod search XHVersion 搜索出来的不是最新版本，需要在终端执行cd ~/desktop退回到desktop，然后执行pod setup命令更新本地spec缓存（需要几分钟），然后再搜索就可以了

2.如果你发现你执行pod install后,导入的不是最新版本,请删除Podfile.lock文件,在执行一次 pod install

