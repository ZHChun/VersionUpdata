//
//  ViewController.m
//  VersionUpdata
//
//  Created by shen on 17/4/18.
//  Copyright © 2017年 shen. All rights reserved.
//

#import "ViewController.h"
#import "XHVersion.h"
#import "ZWAppStore.h"
@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
//    self.title = @"版本检测更新";


    
    
 
}


- (IBAction)selfcheckVersion:(id)sender {
    
    [self checkVersion];
}

//这个似乎不能用了
- (IBAction)btn2Buttonclick:(id)sender {
    //参考https://github.com/CoderZhuXH/XHVersion
    
    //请在你需要检测更新的位置添加下面代码
    //1.新版本检测(使用默认提示框)
    [XHVersion checkNewVersion];
    
    //2.如果你需要自定义提示框,请使用下面方法
    [XHVersion checkNewVersionAndCustomAlert:^(XHAppInfo *appInfo) {
        
        //appInfo为新版本在AppStore相关信息
        //请在此处自定义您的提示框
        NSLog(@"新版本信息:\n 版本号 = %@ \n 更新时间 = %@\n 更新日志 = %@ \n 在AppStore中链接 = %@\n AppId = %@ \n bundleId = %@" ,
              appInfo.version,
              appInfo.currentVersionReleaseDate,
              appInfo.releaseNotes,
              appInfo.trackViewUrl,
              appInfo.trackId,
              appInfo.bundleId
              );
        
    }];
    
}

//https://github.com/wangziwu/ZWAppStore
- (IBAction)actionCheckVersion:(id)sender {
    [ZWCheckVersion zw_checkVersionItunesId:@"1278730860"];
    //    [ZWCheckVersion zw_autoCheckVersionHandleView:^(ZWAppStoreModel *appModel) {
    //        //需要更新版本、自定义更新视图
    //    }];
    //推荐方法、自动检测APP
    //    [ZWCheckVersion zw_autoCheckVersion];
}
- (IBAction)actionShowReview:(id)sender {
    [ZWActionReview instanceReview].probabilityDaliy = 1.f;
    [ZWActionReview instanceReview].maxNumDaliy = 3;
    [ZWActionReview instanceReview].maxTotalNum = 100;
    [[ZWActionReview instanceReview] zw_actionRequestReview:@"1278730860"];
    //推荐方法、自动检测APP
    //    [[ZWActionReview instanceReview] zw_actionRequestReview];
}
- (IBAction)actionSkipWriteReview:(id)sender {
    [[ZWActionReview instanceReview] zw_skipToAppStoreReview:@"1278730860"];
    //推荐方法、自动检测APP
    //    [[ZWActionReview instanceReview] zw_skipToAppStoreReview];
}

-(void)checkVersion{
    
    NSString *newVersion;
    NSURL *url = [NSURL URLWithString:@"http://itunes.apple.com/cn/lookup?id=1278730860"];
    //这个URL地址是该app在iTunes connect里面的相关配置信息。其中id是该app在app store唯一的ID编号。
    NSString *jsonResponseString = [NSString stringWithContentsOfURL:url encoding:NSUTF8StringEncoding error:nil];
    NSLog(@"通过appStore获取的数据信息：%@",jsonResponseString);
    
    NSData *data = [jsonResponseString dataUsingEncoding:NSUTF8StringEncoding];
    id json = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error:nil];
    NSArray *array = json[@"results"];
    for (NSDictionary *dic in array) {
        newVersion = [dic valueForKey:@"version"];
    }
    
    NSLog(@"通过appStore获取的版本号是：%@",newVersion);
    //获取本地软件的版本号
    NSString *localVersion = [[[NSBundle mainBundle]infoDictionary] objectForKey:@"CFBundleVersion"];
    
    NSString *msg = [NSString stringWithFormat:@"你当前的版本是V%@，发现新版本V%@，是否下载新版本？",localVersion,newVersion];
    
    //对比发现的新版本和本地的版本
    if ([newVersion floatValue] > [localVersion floatValue]){
        UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"升级提示"message:msg preferredStyle:UIAlertControllerStyleAlert];
        
        [self presentViewController:alert animated:YES completion:nil];
        
        [alert addAction:[UIAlertAction actionWithTitle:@"现在升级" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
            
            [[UIApplication sharedApplication] openURL:[NSURL URLWithString:@"https://itunes.apple.com/cn/app/id1278730860?mt=8"]];
            
//            这里写的URL地址是该app在app store里面的下载链接地址，其中ID是该app在app store对应的唯一的ID编号。
            NSLog(@"点击现在升级按钮");
        }]];
        
        [alert addAction:[UIAlertAction actionWithTitle:@"下次再说" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
            
            NSLog(@"点击下次再说按钮");
            
            
        }]];
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
