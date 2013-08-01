//
//  TTTMatchFoundControllerWindowController.m
//  TableTennisTime
//
//  Created by Sheel Choksi on 6/29/13.
//  Copyright (c) 2013 Sheel's Code. All rights reserved.
//

#import "TTTMatchFoundController.h"

static NSString *kMatchFoundKey = @"scheduledMatchData";

@implementation TTTMatchFoundController
{
    TTTMatch* match;
}

- (id)initWithMatch:(TTTMatch*)selectedMatch
{
    self = [super initWithWindowNibName:@"TTTMatchFoundController"];
    if (self) {
        match = selectedMatch;
        [match addObserver:self forKeyPath:kMatchFoundKey options:NSKeyValueObservingOptionNew context:NULL];
    }
    return self;
}

- (void) windowDidLoad
{
    [super windowDidLoad];

    NSDictionary *attributes = @{NSForegroundColorAttributeName: [NSColor blueColor]};
    NSMutableAttributedString *matchCreated = [[NSMutableAttributedString alloc] initWithString:@"Your match is scheduled! Go to the "];
    [matchCreated appendAttributedString:[[NSAttributedString alloc] initWithString:match.assignedTable attributes:attributes]];
    [matchCreated appendAttributedString:[[NSAttributedString alloc] initWithString:@" now. You are playing: "]];
    [matchCreated appendAttributedString:[[NSAttributedString alloc] initWithString:match.opponentNames attributes:attributes]];

    [self.matchCreatedField setAttributedStringValue:matchCreated];
}

- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary *)change context:(void *)context
{
    if ([object isEqualTo:match] && [keyPath isEqualToString:kMatchFoundKey]) {
        if ([change objectForKey:@"new"] != (id)[NSNull null]) {
            [[self window] setLevel: NSPopUpMenuWindowLevel];
            [self showWindow:self];
        }
    }
}

@end
