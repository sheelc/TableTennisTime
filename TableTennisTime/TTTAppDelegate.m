//
//  TTTAppDelegate.m
//  TableTennisMatchup
//
//  Created by Sheel Choksi on 5/18/13.
//  Copyright (c) 2013 Sheel's Code. All rights reserved.
//

#import "TTTAppDelegate.h"
#import "TTTPreferencesController.h"

@implementation TTTAppDelegate
{
    TTTPreferencesController* preferences;
    TTTRestClient* restClient;
    NSUserDefaults* userSettings;
}

- (void)applicationDidFinishLaunching:(NSNotification *)aNotification
{
    statusItem = [[NSStatusBar systemStatusBar] statusItemWithLength:NSVariableStatusItemLength];
    [statusItem setMenu:statusMenu];
    [statusItem setTitle:@"TTT"];
    [statusItem setHighlightMode:YES];
    
    userSettings = [[NSUserDefaults alloc] init];
    restClient = [[TTTRestClient alloc] initWithSettings: userSettings];
    preferences = [[TTTPreferencesController alloc] initWithRestClient: restClient];
    [preferences showIfNecessary];
}

- (IBAction)openPreferences:(id)sender
{
    [preferences showWindow:self];
}

- (IBAction)createMatch:(id)sender
{
}

- (void)applicationWillTerminate:(NSNotification *)aNotification
{
    [userSettings synchronize];
}

@end
