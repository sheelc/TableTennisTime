//
//  TTMAppDelegate.m
//  TableTennisMatchup
//
//  Created by Sheel Choksi on 5/18/13.
//  Copyright (c) 2013 Sheel's Code. All rights reserved.
//

#import "TTMAppDelegate.h"
#import "TTMPreferencesController.h"

@implementation TTMAppDelegate
{
    TTMPreferencesController* preferences;
    TTMRestClient* restClient;
    NSUserDefaults* userSettings;
}

- (void)applicationDidFinishLaunching:(NSNotification *)aNotification
{
    statusItem = [[NSStatusBar systemStatusBar] statusItemWithLength:NSVariableStatusItemLength];
    [statusItem setMenu:statusMenu];
    [statusItem setTitle:@"TTM"];
    [statusItem setHighlightMode:YES];
    
    userSettings = [[NSUserDefaults alloc] init];
    restClient = [[TTMRestClient alloc] initWithSettings: userSettings];
    preferences = [[TTMPreferencesController alloc] initWithRestClient: restClient];
    [preferences showIfNecessary];
}

- (IBAction)openPreferences:(id)sender {
    [preferences showWindow:self];
}

- (IBAction)createMatch:(id)sender {
}

@end
