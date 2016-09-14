//
//  AppDelegate.m
//  MCCamleTools
//
//  Created by Marcus on 16/5/31.
//  Copyright © 2016年 Marcus. All rights reserved.
//

#import "AppDelegate.h"

@interface AppDelegate ()

@end

@implementation AppDelegate

- (void)applicationDidFinishLaunching:(NSNotification *)aNotification
{
    // Insert code here to initialize your application
}

- (void)applicationWillTerminate:(NSNotification *)aNotification {
    // Insert code here to tear down your application
}
-(BOOL)applicationShouldHandleReopen:(NSApplication *)theApplication hasVisibleWindows:(BOOL)flag
{
    //[[NSApplication sharedApplication] makeKeyAndOrderFront:nil];
    return YES;
}



- (BOOL)applicationShouldTerminateAfterLastWindowClosed:(NSApplication *)theApplication {
   
    return YES;
}


@end
