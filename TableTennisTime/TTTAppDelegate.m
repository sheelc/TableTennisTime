//
//  TTTAppDelegate.m
//  TableTennisMatchup
//
//  Created by Sheel Choksi on 5/18/13.
//  Copyright (c) 2013 Sheel's Code. All rights reserved.
//

#import "TTTAppDelegate.h"
#import "TTTPreferencesController.h"
#import "TTTMatchesController.h"

@implementation TTTAppDelegate
{
    TTTPreferencesController* preferences;
    TTTMatchesController* matches;
    TTTRestClient* restClient;
    NSUserDefaults* userSettings;
}

- (void)applicationDidFinishLaunching:(NSNotification *)aNotification
{
    statusItem = [[NSStatusBar systemStatusBar] statusItemWithLength:NSVariableStatusItemLength];
    userSettings = [[NSUserDefaults alloc] init];
    restClient = [[TTTRestClient alloc] initWithSettings: userSettings];
    
    [statusItem setMenu:statusMenu];
    [statusItem setTitle:@"TTT"];
    [statusItem setHighlightMode:YES];
    
    [restClient targetValid:^(BOOL valid){
        if(!valid) {
            [self openPreferences:self];
        }
    }];
}

- (IBAction)openPreferences:(id)sender
{
    if(!preferences) {
        preferences = [[TTTPreferencesController alloc] initWithRestClient: restClient];
        [[preferences window] setLevel: NSPopUpMenuWindowLevel];
        [preferences showWindow:self];
        [[NSNotificationCenter defaultCenter] addObserverForName:NSWindowWillCloseNotification
                                                          object:[preferences window]
                                                           queue:nil
                                                      usingBlock:^(NSNotification *notification) {
                                                          preferences = nil;
                                                      }];        
    }
}

- (IBAction)createMatch:(id)sender
{
    if(!matches) {
        matches = [[TTTMatchesController alloc] initWithWindowNibName:@"TTTMatchesController"];
        [[matches window] setLevel: NSPopUpMenuWindowLevel];
        [matches showWindow:self];
        [[NSNotificationCenter defaultCenter] addObserverForName:NSWindowWillCloseNotification
                                                          object:[matches window]
                                                           queue:nil
                                                      usingBlock:^(NSNotification *notification) {
                                                          matches = nil;
                                                      }];
    }
}

- (void)applicationWillTerminate:(NSNotification *)aNotification
{
    [userSettings synchronize];
}

@end
