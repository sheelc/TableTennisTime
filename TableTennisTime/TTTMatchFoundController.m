//
//  TTTMatchFoundControllerWindowController.m
//  TableTennisTime
//
//  Created by Sheel Choksi on 6/29/13.
//  Copyright (c) 2013 Sheel's Code. All rights reserved.
//

#import "TTTMatchFoundController.h"

@implementation TTTMatchFoundController
{
    TTTMatch* match;
}

- (id)initWithMatch:(TTTMatch*)selectedMatch
{
    self = [super initWithWindowNibName:@"TTTMatchFoundController"];
    if (self) {
        match = selectedMatch;
        [match addObserver:self forKeyPath:@"opponentNames" options:NSKeyValueObservingOptionNew context:NULL];
    }
    return self;
}

- (void) windowDidLoad
{
    [super windowDidLoad];
    [self.displayedOpponentNames setStringValue:match.opponentNames];
}

- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary *)change context:(void *)context
{
    if ([object isEqualTo:match] && [keyPath isEqualToString:@"opponentNames"]) {
        if ([change objectForKey:@"new"] != (id)[NSNull null]) {
            [[self window] setLevel: NSPopUpMenuWindowLevel];
            [self showWindow:self];
        }
    }
}

@end
