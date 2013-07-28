//
//  TTTStatusMenuController.h
//  TableTennisTime
//
//  Created by Sheel Choksi on 7/27/13.
//  Copyright (c) 2013 Sheel's Code. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface TTTStatusMenuController : NSObject

- (id) initWithUserSettings:(NSUserDefaults *)userSettings;
- (void)openPreferences:(id)sender;
- (void)createMatch:(id)sender;

@end
