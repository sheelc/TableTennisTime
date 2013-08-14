//
//  TTTMatchFoundController.m
//  TableTennisTime
//
//  Created by Sheel Choksi on 6/29/13.
//  Copyright (c) 2013 Sheel's Code. All rights reserved.
//

#import "TTTMatchFoundController.h"
#import "TTTMatch.h"

static NSString *kMatchFoundKey = @"matchFound";
static NSString *kMatchConfirmationTimeRemainingKey = @"timeRemaining";

@implementation TTTMatchFoundController
{
    TTTMatch *match;
}

- (id)initWithMatch:(TTTMatch *)givenMatch
{
    self = [super initWithWindowNibName:@"TTTMatchFoundController"];
    if (self) {
        match = givenMatch;
        [match addObserver:self forKeyPath:kMatchFoundKey options:NSKeyValueObservingOptionNew context:NULL];
    }
    return self;
}

- (void)windowDidLoad {
    [super windowDidLoad];
    [self setWindowFields];
}

- (IBAction)acceptMatch:(id)sender
{
    self.acceptButton.hidden = YES;
    self.rejectButton.hidden = YES;
    [match acceptMatch];
}

- (IBAction)rejectMatch:(id)sender
{
    [match rejectMatch];
}

- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary *)change context:(void *)context
{
    [self setWindowFields];
    if ([keyPath isEqualToString:kMatchFoundKey]) {
        [[self window] setLevel: NSPopUpMenuWindowLevel];
        [self showWindow:self];

        [match addObserver:self forKeyPath:kMatchConfirmationTimeRemainingKey options:NSKeyValueObservingOptionNew context:NULL];
    }
}

- (void)setWindowFields
{
    [self.matchCreatedField setStringValue:[@"A match has been proposed at: " stringByAppendingString:match.assignedTable]];
    NSDictionary *team1 = match.teams[0];
    NSDictionary *team2 = match.teams[1];

    [self.team1Name setStringValue:team1[@"names"]];
    [self.team1StatusIcon setImage:[NSImage imageNamed:[@"confirmed_icon_" stringByAppendingString:team1[@"confirmed"]]]];
    [self.team2Name setStringValue:team2[@"names"]];
    [self.team2StatusIcon setImage:[NSImage imageNamed:[@"confirmed_icon_" stringByAppendingString:team2[@"confirmed"]]]];

    if(match.scheduled != 0) {
        self.acceptButton.hidden = YES;
        self.rejectButton.hidden = YES;
        self.closeButton.hidden = NO;

        if(match.scheduled < 0){
            [self.matchFeedbackMessage setStringValue:@"Sorry, the match was not accepted by both teams."];
        } else {
            [self.matchFeedbackMessage setStringValue:@"Your match is confirmed! Meet at the table now!"];
        }
    } else {
        [self.matchFeedbackMessage setStringValue:[[match.timeRemaining stringValue] stringByAppendingString: @" seconds remaining for both teams to accept"]];
    }
}

@end
