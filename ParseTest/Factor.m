//
//  Factor.m
//  ParseTest
//
//  Created by Gavin Eadie on 11/24/11.
//  Copyright (c) 2011 __MyCompanyName__. All rights reserved.
//

#import "Factor.h"
#import "Expression.h"

@implementation Factor

@synthesize value;

- (id)initWithSyntaxTree:(CPSyntaxTree *)syntaxTree {
    self = [self init];
    
    if (nil != self) {
        NSLog(@"Factor:initWithSyntaxTree: %@", syntaxTree);
        
        NSArray *components = [syntaxTree children];
        if ([components count] == 1) {
            [self setValue:[[(CPNumberToken *)[components objectAtIndex:0] number] floatValue]];
        }
        else {
            [self setValue:[(Expression *)[components objectAtIndex:1] value]];
        }
    }
    
    return self;
}

- (NSString *) description {
    return [NSString stringWithFormat:@"F %f", value];
}

@end
