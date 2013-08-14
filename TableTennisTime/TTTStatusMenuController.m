//
//  TTTStatusMenuController.m
//  TableTennisTime
//
//  Created by Sheel Choksi on 7/27/13.
//  Copyright (c) 2013 Sheel's Code. All rights reserved.
//

#import "TTTStatusMenuController.h"
#import "TTTMatchRequestController.h"
#import "TTTPreferencesController.h"
#import "TTTMatchFoundController.h"
#import "TTTMatchRequest.h"
#import "TTTMatch.h"
#import "TTTRestClient.h"
#import "TTTStatusMenuDelegate.h"

NSString* kRequestMatchTitle = @"Request a Match!";
int kRequestMatchTag = 1;
int kTimeRemainingTag = 2;

@implementation TTTStatusMenuController
{
    NSMenu *statusMenu;
    id<NSMenuDelegate> menuDelegate;
    NSStatusItem* statusItem;
    TTTRestClient* restClient;
    TTTMatchRequest* matchRequest;
    TTTMatch* match;

    TTTPreferencesController* preferencesController;
    TTTMatchRequestController* matchRequestController;
    TTTMatchFoundController* matchFoundController;
}

- (id) initWithUserSettings:(NSUserDefaults *)userSettings {
    self = [super init];
    if(self) {
        restClient = [[TTTRestClient alloc] initWithSettings: userSettings];
        match = [[TTTMatch alloc] initWithRestClient:restClient];
        matchRequest = [[TTTMatchRequest alloc] initWithSettings:userSettings andRestClient:restClient andMatch:match];

        matchFoundController = [[TTTMatchFoundController alloc] initWithMatch: match];
        
        statusMenu = self.createStatusMenu;
        statusItem = self.createStatusItem;
        
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

    NSMenuItem *menuItem;
    menuItem = [menu addItemWithTitle:@"Preferences" action:@selector(openPreferences:) keyEquivalent:@""];
    menuItem.target = self;
    
    menuItem = [menu addItemWithTitle:kRequestMatchTitle action:@selector(createMatch:) keyEquivalent:@""];
    menuItem.tag = kRequestMatchTag;
    menuItem.target = self;

    menuItem = [menu addItemWithTitle:@"" action:nil keyEquivalent:@""];
    menuItem.tag = kTimeRemainingTag;
    menuItem.enabled = NO;
    menuItem.indentationLevel = 1;
    menuItem.hidden = YES;

    [menu addItem:[NSMenuItem separatorItem]];
    
    menuItem = [menu addItemWithTitle:@"Quit" action:@selector(closeApplication:) keyEquivalent:@""];
    menuItem.target = self;

    menuDelegate = [[TTTStatusMenuDelegate alloc] initWithMatchRequest:matchRequest];
    menu.delegate = menuDelegate;

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
    if(!preferencesController) {
        preferencesController = [[TTTPreferencesController alloc] initWithRestClient: restClient];
        [[preferencesController window] setLevel: NSPopUpMenuWindowLevel];
        [preferencesController showWindow:self];
        [[NSNotificationCenter defaultCenter] addObserverForName:NSWindowWillCloseNotification
                                                          object:[preferencesController window]
                                                           queue:nil
                                                      usingBlock:^(NSNotification *notification) {
                                                          preferencesController = nil;
                                                      }];
    }
}

- (void)createMatch:(id)sender
{
    if(!matchRequestController) {
        matchRequestController = [[TTTMatchRequestController alloc] initWithMatchRequest: matchRequest];
        [[matchRequestController window] setLevel: NSPopUpMenuWindowLevel];
        [matchRequestController showWindow:self];
        [[NSNotificationCenter defaultCenter] addObserverForName:NSWindowWillCloseNotification
                                                          object:[matchRequestController window]
                                                           queue:nil
                                                      usingBlock:^(NSNotification *notification) {
                                                          matchRequestController = nil;
                                                      }];
    }
}

- (void)closeApplication:(id)sender {
    [NSApp terminate:self];
}

@end
