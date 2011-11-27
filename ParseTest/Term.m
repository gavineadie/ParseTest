//
//  Term.m
//  ParseTest
//
//  Created by Gavin Eadie on 11/24/11.
//  Copyright (c) 2011 Ramsay Consulting. All rights reserved.
//

#import "Term.h"
#import "Factor.h"

@implementation Term

@synthesize value;

- (id)initWithSyntaxTree:(CPSyntaxTree *)syntaxTree {
    self = [self init];
    
    if (nil != self) {
        NSLog(@"Term:initWithSyntaxTree: %@", syntaxTree);

        NSArray *components = [syntaxTree children];
        if ([components count] == 1) {
            [self setValue:[(Term *)[components objectAtIndex:0] value]];
        }
        else {
            NSString *op = [components objectAtIndex:1];
            if ([op isEqualToString:@"*"]) {
                [self setValue:[(Term *)[components objectAtIndex:0] value] * [(Factor *)[components objectAtIndex:2] value]];
            }
            else {
                [self setValue:[(Term *)[components objectAtIndex:0] value] / [(Factor *)[components objectAtIndex:2] value]];
            }
        }
    }
    
    return self;
}

- (NSString *) description {
    return [NSString stringWithFormat:@"<Term: %3.1f>", value];
}

@end
