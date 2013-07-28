//
//  TTTStatusMenuController.m
//  TableTennisTime
//
//  Created by Sheel Choksi on 7/27/13.
//  Copyright (c) 2013 Sheel's Code. All rights reserved.
//

#import "TTTStatusMenuController.h"
#import "TTTMatchesController.h"
#import "TTTPreferencesController.h"
#import "TTTMatchFoundController.h"
#import "TTTMatch.h"
#import "TTTRestClient.h"

static NSString* kRequestMatchTitle = @"Request a Match!";
static int kRequestMatchTag = 1;

@implementation TTTStatusMenuController
{
    NSMenu *statusMenu;
    NSStatusItem* statusItem;
    TTTRestClient* restClient;
    TTTMatch* match;

    TTTPreferencesController* preferences;
    TTTMatchesController* matches;
    TTTMatchFoundController* matchScheduled;
}

- (id) initWithUserSettings:(NSUserDefaults *)userSettings {
    self = [super init];
    if(self) {
        restClient = [[TTTRestClient alloc] initWithSettings: userSettings];
        match = [[TTTMatch alloc] initWithSettings:userSettings andRestClient:restClient];

        matchScheduled = [[TTTMatchFoundController alloc] initWithMatch: match];
        
        statusMenu = self.createStatusMenu;
        statusItem = self.createStatusItem;
        
        [match addObserver:self forKeyPath:@"pollingGuid" options:NSKeyValueObservingOptionNew context:NULL];
        
        [restClient targetValid:^(BOOL valid){
            if(!valid) {
                [self openPreferences:self];
            }
        }];
    }
    
    return self;
}

- (NSMenu *)createStatusMenu {
    NSMenu* menu = [[NSMenu alloc] init];
    menu.autoenablesItems = NO;

    NSMenuItem* menuItem;
    menuItem = [menu addItemWithTitle:@"Preferences" action:@selector(openPreferences:) keyEquivalent:@""];
    menuItem.target = self;
    
    menuItem = [menu addItemWithTitle:kRequestMatchTitle action:@selector(createMatch:) keyEquivalent:@""];
    menuItem.tag = kRequestMatchTag;
    menuItem.target = self;
    
    [menu addItem:[NSMenuItem separatorItem]];
    
    menuItem = [menu addItemWithTitle:@"Quit" action:@selector(closeApplication:) keyEquivalent:@""];
    menuItem.target = self;
    
    return menu;
}

- (NSStatusItem *)createStatusItem {
    NSStatusItem* item = [[NSStatusBar systemStatusBar] statusItemWithLength:NSVariableStatusItemLength];
    
    [item setMenu:statusMenu];
    [item setTitle:@"TTT"];
    [item setHighlightMode:YES];

    return item;
}

- (void)openPreferences:(id)sender
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

- (void)createMatch:(id)sender
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

- (void)closeApplication:(id)sender {
    [NSApp terminate:self];
}

- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary *)change context:(void *)context
{
    if([object isEqualTo: match] && [keyPath isEqualToString:@"pollingGuid"]) {
        NSMenuItem* item = [statusMenu itemWithTag:kRequestMatchTag];
        if(match.pollingGuid) {
            [item setTitle:@"Awaiting match..."];
            [item setEnabled:NO];
        } else {
            [item setTitle:kRequestMatchTitle];
            [item setEnabled:YES];
        }
    }
}

@end
