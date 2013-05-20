//
//  TTMAppDelegate.h
//  TableTennisMatchup
//
//  Created by Sheel Choksi on 5/18/13.
//  Copyright (c) 2013 Sheel's Code. All rights reserved.
//

#import <Cocoa/Cocoa.h>
#import "TTMRestClient.h"

@interface TTMAppDelegate : NSObject <NSApplicationDelegate>
{
    IBOutlet NSMenu* statusMenu;
    NSStatusItem* statusItem;
    TTMRestClient* restClient;
}

@property (weak) IBOutlet NSMenuItem *createMatch;

- (IBAction)openPreferences:(id)sender;
- (IBAction)createMatch:(id)sender;

@end
