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
    NSWindowController* preferences;
}

- (void)applicationDidFinishLaunching:(NSNotification *)aNotification
{
    statusItem = [[NSStatusBar systemStatusBar] statusItemWithLength:NSVariableStatusItemLength];
    [statusItem setMenu:statusMenu];
    [statusItem setTitle:@"TTM"];
    [statusItem setHighlightMode:YES];
    
    restClient = [[TTMRestClient alloc] init];
    preferences = [[TTMPreferencesController alloc] initWithRestClient: restClient];
    [preferences showWindow:self];
}

- (IBAction)openPreferences:(id)sender {
    [preferences showWindow:self];
}

- (IBAction)createMatch:(id)sender {
}

@end
