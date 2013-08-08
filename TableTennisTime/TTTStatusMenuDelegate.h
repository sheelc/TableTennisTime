//
//  TTTStatusMenuDelegate.h
//  TableTennisTime
//
//  Created by Sheel Choksi on 8/7/13.
//  Copyright (c) 2013 Sheel's Code. All rights reserved.
//

#import <Foundation/Foundation.h>

@class TTTMatch;

@interface TTTStatusMenuDelegate : NSObject<NSMenuDelegate>

- (id)initWithMatch:(TTTMatch *)match;

@end
