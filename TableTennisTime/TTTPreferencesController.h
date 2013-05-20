//
//  TTTPreferences.h
//  TableTennisMatchup
//
//  Created by Sheel Choksi on 5/19/13.
//  Copyright (c) 2013 Sheel's Code. All rights reserved.
//

#import <Cocoa/Cocoa.h>
#import "TTTRestClient.h"

@interface TTTPreferencesController : NSWindowController

@property (weak) IBOutlet NSTextField *serverUrl;
@property (weak) IBOutlet NSImageView *status;

- (TTTPreferencesController*) initWithRestClient: (TTTRestClient*) client;
- (void)controlTextDidChange:(NSNotification *)notification;

@end
