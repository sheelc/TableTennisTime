//
//  TTTAppDelegate.m
//  TableTennisMatchup
//
//  Created by Sheel Choksi on 5/18/13.
//  Copyright (c) 2013 Sheel's Code. All rights reserved.
//

#import "TTTAppDelegate.h"
#import "TTTStatusMenuController.h"

@implementation TTTAppDelegate
{
    NSUserDefaults *userSettings;
    TTTStatusMenuController *statusMenuController;
}

- (void)applicationDidFinishLaunching:(NSNotification *)aNotification
{
    userSettings = [[NSUserDefaults alloc] init];
    statusMenuController = [[TTTStatusMenuController alloc] initWithUserSettings:userSettings];
}

- (void)applicationWillTerminate:(NSNotification *)aNotification
{
    [userSettings synchronize];
}

@end
