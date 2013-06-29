//
//  TTTResponse.h
//  TableTennisMatchup
//
//  Created by Sheel Choksi on 5/19/13.
//  Copyright (c) 2013 Sheel's Code. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface TTTResponse : NSObject

- (id) initFromData:(NSData*) data error:(NSError*) error;
- (BOOL) success;
- (NSDictionary*) json;

@end
