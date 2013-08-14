//
//  TTTRestClient.h
//  TableTennisTime
//
//  Created by Sheel Choksi on 5/18/13.
//  Copyright (c) 2013 Sheel's Code. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface TTTRestClient : NSObject

@property (strong) NSString *target;

- (id)initWithSettings:(NSUserDefaults *)userSettings;
- (void)updateTarget:(NSString *)target;
- (void)targetValid:(void ( ^ )(BOOL))callback;
- (void)get:(NSString *)path callback:(void ( ^ )(id)) callback;
- (void)put:(NSString *)path options:(NSDictionary*)body callback:(void ( ^ )(id)) callback;
- (void)post:(NSString *)path options:(NSDictionary*)body callback:(void ( ^ )(id)) callback;

@end
