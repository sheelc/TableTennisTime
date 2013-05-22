//
//  TTTMatchesController.m
//  TableTennisTime
//
//  Created by Sheel Choksi on 5/19/13.
//  Copyright (c) 2013 Sheel's Code. All rights reserved.
//

#import "TTTMatchesController.h"

@implementation TTTMatchesController
{
    TTTMatch* match;
}

- (void)windowDidLoad
{
    [super windowDidLoad];
    
    // Implement this method to handle any initialization after your window controller's window has been loaded from its nib file.
}

- (TTTMatchesController*)initWithMatch:(TTTMatch*)selectedMatch
{
    self = [super initWithWindowNibName:@"TTTMatchesController"];
    match = selectedMatch;
    return self;
}

- (IBAction)numPlayersChanged:(id)sender
{
    if([self.numPlayers selectedColumn] > 0) {
        [[self.matchType cellWithTag:1] setState: NSOffState];
        [[self.matchType cellWithTag:2] setState: NSOnState];
        [[self.matchType cellWithTag:1] setEnabled: NO];
        [self.matchType selectCellAtRow:0 column:1];
    } else {
        [self.matchType selectCellAtRow:0 column:0];
        [[self.matchType cellWithTag:1] setEnabled: YES];
    }
}

- (IBAction)createMatch:(id)sender
{
    if(![[self.playerNames stringValue] length]) {
        [self.playerNames setBackgroundColor:[NSColor redColor]];
        [self.playerNames setTextColor:[NSColor whiteColor]];
        NSString* placeholder = [[self.playerNames cell] placeholderString];
        [[self.playerNames cell] setPlaceholderAttributedString:[[NSAttributedString alloc] initWithString:placeholder attributes:@{NSForegroundColorAttributeName: [NSColor whiteColor]}]];
        return;
    }
    
    NSMutableDictionary *options = [[NSMutableDictionary alloc] init];
    [options setValue:[self.playerNames stringValue] forKey:@"names"];
    
    int playerCount = (int) [self.numPlayers selectedColumn] + 1;
    [options setValue:[NSNumber numberWithInt: playerCount] forKey:@"numPlayers"];
    
    [options setValue:[[[self.matchType selectedCell] title] lowercaseString] forKey:@"matchType"];
    
    [match createMatchFromOptions:options];
    [[self window] close];
}

@end
