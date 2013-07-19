//
//  TTTResponse.m
//  TableTennisMatchup
//
//  Created by Sheel Choksi on 5/19/13.
//  Copyright (c) 2013 Sheel's Code. All rights reserved.
//

#import "TTTResponse.h"

@implementation TTTResponse
{
    NSHTTPURLResponse* response;
    NSData* data;
    NSError* error;
}

- (id) initFromResponse:(NSURLResponse*)newResponse data:(NSData *)newData error:(NSError*) newError
{
    self = [super init];
    if (self) {
        response = (NSHTTPURLResponse *)newResponse;
        data = newData;
        error = newError;
    }
    return self;
}

- (BOOL) success
{
    if(error) {
        return false;
    }
    
    NSError* jsonParseErrors;
    id json;
    json = [NSJSONSerialization JSONObjectWithData:data options:0 error:&jsonParseErrors];
    return !jsonParseErrors && [json isKindOfClass:[NSDictionary class]];
}

- (NSInteger) statusCode
{
    return [response statusCode];
}

- (NSDictionary*) json
{
    NSError* jsonParseErrors;
    return ((NSDictionary*) [NSJSONSerialization JSONObjectWithData:data options:0 error:&jsonParseErrors]);
}

@end
