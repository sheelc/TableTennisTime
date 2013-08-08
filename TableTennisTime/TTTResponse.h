//
//  TTTResponse.h
//  TableTennisMatchup
//
//  Created by Sheel Choksi on 5/19/13.
//  Copyright (c) 2013 Sheel's Code. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface TTTResponse : NSObject

- (id)initFromResponse:(NSURLResponse *)newResponse data:(NSData *)newData error:(NSError *)newError;
- (BOOL)success;
- (NSInteger)statusCode;
- (NSDictionary *)json;

@end
