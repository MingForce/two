//
//  AppDelegate.m
//  collectionView显示图片
//
//  Created by 罗金明 on 15/9/8.
//  Copyright (c) 2015年 ming. All rights reserved.
//

#import "AppDelegate.h"
#import "ImageListCollectionView.h"

@interface AppDelegate ()

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    // Override point for customization after application launch.
    

    self.window=[[UIWindow alloc]initWithFrame:[UIScreen mainScreen].bounds];
    ImageListCollectionView*imgController=[[ImageListCollectionView alloc]init];
    self.window.rootViewController=imgController;
    [self.window makeKeyAndVisible];
    
    //网络请求
//    NSString *httpUrl = @"http://apis.baidu.com/heweather/pro/weather";
//    NSString *httpArg = @"city=beijing";
//    [self request: httpUrl withHttpArg: httpArg];

    [self conectWith:@"http://124.173.80.179/yacai/lyda/index.php/Api/diy_zs_product/68EECCA7A5E6F9F96A24F3BB898B0FC1"];
    return YES;
}

- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}


-(void)request: (NSString*)httpUrl withHttpArg: (NSString*)HttpArg  {
    NSString *urlStr = [[NSString alloc]initWithFormat: @"%@?%@", httpUrl, HttpArg];
    NSURL *url = [NSURL URLWithString: urlStr];
    NSMutableURLRequest *request = [[NSMutableURLRequest alloc]initWithURL: url cachePolicy: NSURLRequestUseProtocolCachePolicy timeoutInterval: 10];
    [request setHTTPMethod: @"GET"];
    [request addValue: @"d8b6ee95f07cdb26d3681aa85f016f63" forHTTPHeaderField: @"apikey"];
    [NSURLConnection sendAsynchronousRequest: request
                                       queue: [NSOperationQueue mainQueue]
                           completionHandler: ^(NSURLResponse *response, NSData *data, NSError *error){
                               if (error) {
                                   NSLog(@"Httperror: %@%ld", error.localizedDescription, error.code);
                               } else {
                                   NSInteger responseCode = [(NSHTTPURLResponse *)response statusCode];
                                   NSString *responseString = [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
                                   NSLog(@"HttpResponseCode:%ld", responseCode);
                                   NSLog(@"HttpResponseBody %@",responseString);
                               }
                           }];
}
-(void)conectWith:(NSString*)urlStr{
    
    NSURL *url = [NSURL URLWithString: urlStr];
    NSMutableURLRequest *request = [[NSMutableURLRequest alloc]initWithURL: url cachePolicy: NSURLRequestUseProtocolCachePolicy timeoutInterval: 10];
    [request setHTTPMethod: @"GET"];
    [NSURLConnection sendAsynchronousRequest: request
                                       queue: [NSOperationQueue mainQueue]
                           completionHandler: ^(NSURLResponse *response, NSData *data, NSError *error){
                               if (error) {
                                   NSLog(@"app-------Httperror: %@%ld", error.localizedDescription, error.code);
                               } else {
//              NSString *responseString = [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
//               NSLog(@"HttpResponseBody %@",responseString);

                                   
                                   NSArray *result = [NSJSONSerialization JSONObjectWithData:data options:0 error:NULL];
                                      NSLog(@"%@",result);
                                   
                                   //
                                   //
                               }
                           }];
    
    
}


@end
