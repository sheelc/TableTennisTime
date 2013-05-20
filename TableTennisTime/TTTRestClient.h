//
//  TTTRestClient.h
//  TableTennisMatchup
//
//  Created by Sheel Choksi on 5/18/13.
//  Copyright (c) 2013 Sheel's Code. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface TTTRestClient : NSObject

@property (strong) NSString *target;

- (TTTRestClient*)initWithSettings: (NSUserDefaults*) userSettings;
- (void)updateTarget:(NSString*)target;
- (void)targetValid:(void ( ^ )(BOOL))callback;
- (void)get:(NSString*)path callback:(void ( ^ )(id)) callback;

@end
