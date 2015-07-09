//
//  CodFisResponse.m
//  CodFis-Helper
//
//  Created by Giuseppe Nucifora on 09/07/15.
//  Copyright (c) 2015 Giuseppe Nucifora. All rights reserved.
//

#import "CodFisResponse.h"

@implementation CodFisResponse

- (instancetype) initWithResponse:(NSString*) response andError:(NSError*) responseError {
    self = [super init];
    if (self) {
        _responseError = responseError;
        _response = response;
    }
    return self;
}

@end
