//
//  CodFisHelperAppDelegate.m
//  CodFis-Helper
//
//  Created by Giuseppe Nucifora on 07/08/2015.
//  Copyright (c) 2015 Giuseppe Nucifora. All rights reserved.
//

#import "CodFisHelperAppDelegate.h"
#import "CodFis+Helper.h"
#import "VatNumber+Helper.h"

@implementation CodFisHelperAppDelegate

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    // Override point for customization after application launch.
    
    CodFis_Helper *helper = [[CodFis_Helper alloc] init];
    
    [helper setSurname:@"Rossi"];
    
    [helper setName:@"Mario"];
    
    [helper setBirthDay:15];
    
    [helper setBirthMonth:11];
    
    [helper setBirthYear:83];
    
    [helper setGender:Gender_Man];
    
    [helper setState:Italy];
    
    [helper setPlace:@"Milano"];
    
    CodFisResponse *response = [helper calculate];
    
    NSLog(@"%@",[response responseErrors]);
    NSLog(@"%@",[response response]);
    
    NSLog(@"%@",[NSNumber numberWithBool:[helper check:@"TESTCFASDASDASD"]]);
    
    NSLog(@"%@",[VatNumber_Helper evaluate:@"050 27300879"]);
    
    return YES;
}

- (void)applicationWillResignActive:(UIApplication *)application
{
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application
{
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

- (void)applicationWillEnterForeground:(UIApplication *)application
{
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application
{
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application
{
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

@end
