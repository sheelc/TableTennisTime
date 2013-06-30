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
#import "TTTMatchFoundController.h"
#import "TTTMatch.h"

@implementation TTTAppDelegate
{
    TTTPreferencesController* preferences;
    TTTMatchesController* matches;
    TTTMatchFoundController* matchScheduled;
    TTTRestClient* restClient;
    TTTMatch* match;
    NSUserDefaults* userSettings;
}

- (void)applicationDidFinishLaunching:(NSNotification *)aNotification
{
    statusItem = [[NSStatusBar systemStatusBar] statusItemWithLength:NSVariableStatusItemLength];
    userSettings = [[NSUserDefaults alloc] init];
    restClient = [[TTTRestClient alloc] initWithSettings: userSettings];
    match = [[TTTMatch alloc] initWithSettings:userSettings andRestClient:restClient];
    matchScheduled = [[TTTMatchFoundController alloc] initWithMatch: match];
    
    [match addObserver:self forKeyPath:@"guid" options:NSKeyValueObservingOptionNew context:NULL];

    [statusMenu setAutoenablesItems:NO];
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
        matches = [[TTTMatchesController alloc] initWithMatch: match];
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

- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary *)change context:(void *)context
{
    if([object isEqualTo: match] && [keyPath isEqualToString:@"guid"]) {
        NSMenuItem* item = [statusMenu itemWithTag:1];
        if(match.guid) {
            [item setTitle:@"Awaiting match..."];
            [item setEnabled:NO];
        } else {
            [item setTitle:@"Request Match!"];
            [item setEnabled:YES];
        }
    }
}

- (void)applicationWillTerminate:(NSNotification *)aNotification
{
    [userSettings synchronize];
}

@end
