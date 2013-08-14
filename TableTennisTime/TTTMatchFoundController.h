//
//  TTTMatchFoundController.h
//  TableTennisTime
//
//  Created by Sheel Choksi on 6/29/13.
//  Copyright (c) 2013 Sheel's Code. All rights reserved.
//

#import <Cocoa/Cocoa.h>

@class TTTMatch;

@interface TTTMatchFoundController : NSWindowController

@property (weak) IBOutlet NSTextField *matchCreatedField;

@property (weak) IBOutlet NSTextField *team1Name;
@property (weak) IBOutlet NSImageView *team1StatusIcon;
@property (weak) IBOutlet NSTextField *team2Name;
@property (weak) IBOutlet NSImageView *team2StatusIcon;
@property (weak) IBOutlet NSTextField *matchFeedbackMessage;

@property (strong) IBOutlet NSButton *acceptButton;
@property (strong) IBOutlet NSButton *rejectButton;
@property (strong) IBOutlet NSButton *closeButton;

- (IBAction)acceptMatch:(id)sender;
- (IBAction)rejectMatch:(id)sender;


- (id)initWithMatch:(TTTMatch *)givenMatch;

@end
