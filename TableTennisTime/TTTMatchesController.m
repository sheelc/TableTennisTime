//
//  TTTMatchesController.m
//  TableTennisTime
//
//  Created by Sheel Choksi on 5/19/13.
//  Copyright (c) 2013 Sheel's Code. All rights reserved.
//

#import "TTTMatchesController.h"

@interface TTTMatchesController ()

@end

@implementation TTTMatchesController

- (id)initWithWindow:(NSWindow *)window
{
    self = [super initWithWindow:window];
    if (self) {
        // Initialization code here.
    }
    
    return self;
}

- (void)windowDidLoad
{
    [super windowDidLoad];
    
    // Implement this method to handle any initialization after your window controller's window has been loaded from its nib file.
}

- (IBAction)numPlayersChanged:(id)sender
{
    if([self.numPlayers selectedColumn] > 0) {
        [[self.matchType cellWithTag:1] setState: NSOffState];
        [[self.matchType cellWithTag:2] setState: NSOnState];
        [[self.matchType cellWithTag:1] setEnabled: NO];
    } else {
        [[self.matchType cellWithTag:1] setEnabled: YES];
    }
}
@end
