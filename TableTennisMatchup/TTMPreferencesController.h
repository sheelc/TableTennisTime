//
//  TTMPreferences.h
//  TableTennisMatchup
//
//  Created by Sheel Choksi on 5/19/13.
//  Copyright (c) 2013 Sheel's Code. All rights reserved.
//

#import <Cocoa/Cocoa.h>
#import "TTMRestClient.h"

@interface TTMPreferencesController : NSWindowController

@property (weak) IBOutlet NSTextField *serverUrl;
@property (weak) IBOutlet NSImageView *status;

- (TTMPreferencesController*) initWithRestClient: (TTMRestClient*) client;
- (void)controlTextDidChange:(NSNotification *)notification;

@end
