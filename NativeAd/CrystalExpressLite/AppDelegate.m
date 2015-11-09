//
//  AppDelegate.m
//  CrystalExpressLite
//
//  Created by roylo on 2015/10/20.
//  Copyright © 2015年 intowow. All rights reserved.
//

#import "AppDelegate.h"
#import "I2WAPI.h"

@interface AppDelegate ()

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    // Override point for customization after application launch.
    
    // init I2WAPI to allow CrystalExpress start prefetch native ads
    // @"6783f14a3c6345a39661021bc0b84d21" is a native ad demo crystalId, do "NOT" use it as your production deploy!!
    [I2WAPI initWithVerboseLog:YES isTestMode:NO crystalId:@"6783f14a3c6345a39661021bc0b84d21"];
    
//    Or you can replace with the following line to enable test mode
//    [I2WAPI initWithVerboseLog:YES isTestMode:YES crystalId:@"6783f14a3c6345a39661021bc0b84d21"];
    
    return YES;
}

/// Enable deeplink for adpreview & better remote debug mechanism
#pragma mark - deeplinking
- (BOOL)application:(UIApplication *)application
            openURL:(NSURL *)url
  sourceApplication:(NSString *)sourceApplication
         annotation:(id)annotation
{
    [I2WAPI handleDeepLinkWithUrl:url sourceApplication:sourceApplication];
    return YES;
}


@end
