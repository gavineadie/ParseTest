//
//  TokeniserDelegate.m
//  ParseTest
//
//  Created by Gavin Eadie on 11/24/11.
//  Copyright (c) 2011 Ramsay Consulting. All rights reserved.
//

#import "TokeniserDelegate.h"

@implementation TokeniserDelegate

- (BOOL)tokeniser:(CPTokeniser *)tokeniser shouldConsumeToken:(CPToken *)token {
    return YES;
}

- (NSArray *)tokeniser:(CPTokeniser *)tokeniser willProduceToken:(CPToken *)token {
    if ([token isKindOfClass:[CPWhiteSpaceToken class]] || [[token name] isEqualToString:@"Comment"]) {
        return [NSArray array];
    }
    return [NSArray arrayWithObject:token];
}

@end
