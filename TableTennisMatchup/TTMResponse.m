//
//  TTMResponse.m
//  TableTennisMatchup
//
//  Created by Sheel Choksi on 5/19/13.
//  Copyright (c) 2013 Sheel's Code. All rights reserved.
//

#import "TTMResponse.h"

@implementation TTMResponse
{
    NSData* _data;
    NSError* _error;
}

+ (TTMResponse*) initFromData:(NSData*) data error:(NSError*) error
{
    TTMResponse *response;
    if ((response = [TTMResponse alloc])) {
        response->_data = data;
        response->_error = error;
    }
    return response;
}

- (BOOL) success
{
    if(self->_error) {
        return false;
    }
    
    NSError* jsonParseErrors;
    id json;
    json = [NSJSONSerialization JSONObjectWithData:self->_data options:0 error:&jsonParseErrors];
    return !jsonParseErrors && [json isKindOfClass:[NSDictionary class]];
}

- (NSDictionary*) json
{
    NSError* jsonParseErrors;
    return ((NSDictionary*) [NSJSONSerialization JSONObjectWithData:self->_data options:0 error:&jsonParseErrors]);
}

@end
