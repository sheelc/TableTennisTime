//
//  TTTPreferences.m
//  TableTennisTime
//
//  Created by Sheel Choksi on 5/19/13.
//  Copyright (c) 2013 Sheel's Code. All rights reserved.
//

#import "TTTPreferencesController.h"

typedef void(^ImageTogglerBlock)(BOOL);

@implementation TTTPreferencesController
{
    TTTRestClient *client;
    ImageTogglerBlock imageToggler;
}

- (id)initWithRestClient:(TTTRestClient *)restClient
{
    self = [super initWithWindowNibName:@"TTTPreferencesController" owner:self];
    if (self){
        client = restClient;
        
        imageToggler = ^(BOOL valid){
            if(valid){
                self.status.image = [NSImage imageNamed: @"check.png"];
            } else {
                self.status.image = [NSImage imageNamed: @"cross.png"];
            }
        };
    }
    
    return self;
}

- (void)windowDidLoad
{
    [super windowDidLoad];
    if(client.target){
        [_serverUrl setStringValue: client.target];
    }
    [client targetValid: imageToggler];
}

- (void)controlTextDidChange:(NSNotification *)notification
{
    NSString* enteredUrl = [_serverUrl stringValue];
    [client updateTarget:enteredUrl];
    [client targetValid: imageToggler];
}

@end
