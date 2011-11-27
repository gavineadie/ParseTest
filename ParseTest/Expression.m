//
//  Expression.m
//  ParseTest
//
//  Created by Gavin Eadie on 11/24/11.
//  Copyright (c) 2011 Ramsay Consulting. All rights reserved.
//

#import "Expression.h"
#import "Term.h"

@implementation Expression

@synthesize value;

- (id)initWithSyntaxTree:(CPSyntaxTree *)syntaxTree {
    if (nil == (self = [self init])) return nil;
    
    NSLog(@"Expression:initWithSyntaxTree: %@", syntaxTree);

    NSArray *       components = [syntaxTree children];

    if ([components count] == 1) {
        [self setValue:[(Term *)[components objectAtIndex:0] value]];
    }
    else {
        if ([[components objectAtIndex:1] isEqualToString:@"+"]) {
            [self setValue:[(Expression *)[components objectAtIndex:0] value] + [(Term *)[components objectAtIndex:2] value]];
        }
        else {
            [self setValue:[(Expression *)[components objectAtIndex:0] value] - [(Term *)[components objectAtIndex:2] value]];
        }
    }

    return self;
}

- (NSString *) description {
    return [NSString stringWithFormat:@"<Expression: %3.1f>", value];
}

@end
