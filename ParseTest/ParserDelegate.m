//
//  ParserDelegate.m
//  ParseTest
//
//  Created by Gavin Eadie on 11/24/11.
//  Copyright (c) 2011 Ramsay Consulting. All rights reserved.
//

#import "ParserDelegate.h"

@implementation ParserDelegate

- (id)parser:(CPParser *)parser didProduceSyntaxTree:(CPSyntaxTree *)syntaxTree {
    NSLog(@"ParserDelegate:didProduceSyntaxTree: %@", syntaxTree);
    NSLog(@"                  [SyntaxTree rule]: %@", [syntaxTree rule]);
    NSLog(@"              [SyntaxTree children]: %@", [syntaxTree children]);
    
    
    NSLog(@"              [SyntaxTree child[0]]: %@", [[syntaxTree children] objectAtIndex:0]);
    
    
    return [(CPKeywordToken *)[[syntaxTree children] objectAtIndex:0] keyword];
}

@end
