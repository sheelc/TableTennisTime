//
//  TTMPreferences.m
//  TableTennisMatchup
//
//  Created by Sheel Choksi on 5/19/13.
//  Copyright (c) 2013 Sheel's Code. All rights reserved.
//

#import "TTMPreferencesController.h"

typedef void(^ImageTogglerBlock)(BOOL);

@implementation TTMPreferencesController
{
    TTMRestClient* client;
    ImageTogglerBlock imageToggler;
}

- (TTMPreferencesController*) initWithRestClient:(TTMRestClient *)restClient
{
    if (self = [super initWithWindowNibName:@"TTMPreferencesController" owner:self])
    {
        client = restClient;
        imageToggler = ^(BOOL valid){
            if(valid){
                _status.image = [NSImage imageNamed: @"check.png"];
            } else {
                _status.image = [NSImage imageNamed: @"cross.png"];
            }
        };
    }
    
    return self;
}

- (void)showIfNecessary
{
    [client targetValid:^(BOOL valid){
        if(!valid) {
            [self showWindow:self];
        }
    }];
}

- (void) windowDidLoad
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
