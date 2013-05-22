//
//  TTTMatch.h
//  TableTennisTime
//
//  Created by Sheel Choksi on 5/20/13.
//  Copyright (c) 2013 Sheel's Code. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "TTTRestClient.h"

@interface TTTMatch : NSObject

- (TTTMatch*)initWithSettings:(NSUserDefaults*)settings andRestClient:(TTTRestClient*)client;
- (void)createMatchFromOptions:(NSDictionary*)options;
@end
