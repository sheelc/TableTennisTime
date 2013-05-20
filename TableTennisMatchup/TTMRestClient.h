//
//  TTMRestClient.h
//  TableTennisMatchup
//
//  Created by Sheel Choksi on 5/18/13.
//  Copyright (c) 2013 Sheel's Code. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface TTMRestClient : NSObject

@property (strong) NSString *target;

- (void)updateTarget:(NSString*)target;
- (void)updateTarget:(NSString*)target callback:(void ( ^ )(BOOL)) callback;
- (void)targetValid:(void ( ^ )(BOOL))callback;
- (void)get:(NSString*)path callback:(void ( ^ )(id)) callback;

@end
