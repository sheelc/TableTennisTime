//
//  TTTMatchFoundControllerWindowController.h
//  TableTennisTime
//
//  Created by Sheel Choksi on 6/29/13.
//  Copyright (c) 2013 Sheel's Code. All rights reserved.
//

#import <Cocoa/Cocoa.h>
#import "TTTMatch.h"

@interface TTTMatchFoundController : NSWindowController

@property (weak) IBOutlet NSTextField *displayedOpponentNames;

- (id)initWithMatch:(TTTMatch*)match;

@end
