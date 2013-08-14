//
//  TTTMatch.m
//  TableTennisTime
//
//  Created by Sheel Choksi on 8/11/13.
//  Copyright (c) 2013 Sheel's Code. All rights reserved.
//

#import "TTTMatch.h"
#import "TTTMatchRequest.h"
#import "TTTRestClient.h"
#import "TTTResponse.h"

#define POLLING_INTERVAL 1.0

@implementation TTTMatch
{
    TTTRestClient* client;
    NSString *confirmationPollingGuid;
    NSTimer *timer;
}

- (id)initWithRestClient:(TTTRestClient *)restClient
{
    self = [super init];
    if(self) {
        client = restClient;
    }

    return self;
}

- (void)beginPollingForConfirmationWithJSON:(NSDictionary *)json
{
    confirmationPollingGuid = [json objectForKey:@"scheduledMatchGuid"];
    timer = [NSTimer scheduledTimerWithTimeInterval:POLLING_INTERVAL target:self selector:@selector(pollForConfirmation) userInfo:NULL repeats:YES];
    [timer fire];
}

- (void)pollForConfirmation {
    [client get:[self matchPath] callback:^(TTTResponse *resp) {
        NSDictionary *json = [resp json];
        self.scheduled = [json[@"scheduled"] integerValue];

        if([resp statusCode] == 404) {
            self.scheduled = -1;
            self.timeRemaining = 0;
        }

        if(self.scheduled != 0) {
            [timer invalidate];
        }


        NSArray *responseKeys = @[@"assignedTable", @"teams", @"timeRemaining"];
        for (NSString *key in responseKeys) {
            if(json[key]) {
                [self setValue:json[key] forKey:key];
            }
        }

        if(!self.matchFound) {
            self.matchFound = YES;
        }
    }];
}

- (void)acceptMatch {
    [client put:[self matchPath] options:@{@"accepted" : @YES, @"matchRequestGuid" : self.matchRequestGuid} callback:^(id resp){}];
}

- (void)rejectMatch {
    [client put:[self matchPath] options:@{@"accepted" : @NO, @"matchRequestGuid" : self.matchRequestGuid} callback:^(id resp){}];
}

- (NSString *)matchPath {
    return [@"/matches/" stringByAppendingString:confirmationPollingGuid];
}


@end
