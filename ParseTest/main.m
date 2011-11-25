//
//  main.m
//  ParseTest
//
//  Created by Gavin Eadie on 11/24/11.
//  Copyright (c) 2011 Ramsay Consulting. All rights reserved.
//

#import "TokeniserDelegate.h"
#import "ParserDelegate.h"
#import "Expression.h"

int main (int argc, const char * argv[]) {

    @autoreleasepool {
        
        CPTokeniser *tokeniser = [[CPTokeniser alloc] init];
        [tokeniser addTokenRecogniser:[CPNumberRecogniser numberRecogniser]];
        [tokeniser addTokenRecogniser:[CPWhiteSpaceRecogniser whiteSpaceRecogniser]];
        [tokeniser addTokenRecogniser:[CPQuotedRecogniser quotedRecogniserWithStartQuote:@"/*" 
                                                                                endQuote:@"*/" 
                                                                                    name:@"Comment"]];
        [tokeniser addTokenRecogniser:[CPKeywordRecogniser recogniserForKeyword:@"+"]];
        [tokeniser addTokenRecogniser:[CPKeywordRecogniser recogniserForKeyword:@"-"]];
        [tokeniser addTokenRecogniser:[CPKeywordRecogniser recogniserForKeyword:@"*"]];
        [tokeniser addTokenRecogniser:[CPKeywordRecogniser recogniserForKeyword:@"/"]];
        [tokeniser addTokenRecogniser:[CPKeywordRecogniser recogniserForKeyword:@"("]];
        [tokeniser addTokenRecogniser:[CPKeywordRecogniser recogniserForKeyword:@")"]];
        
        TokeniserDelegate * tDelegate = [[TokeniserDelegate alloc] init];
        tokeniser.delegate = tDelegate;

        CPTokenStream *     tokenStream = [tokeniser tokenise:@"5 + (2.0 / 5.0 + 9) * 8"];
        
        
        NSLog(@"tokenStream: %@", tokenStream);
    

        NSString *  expressionGrammar = @"Expression ::= <Term>     | <Expression> <AddOp> <Term>;"
                                        @"Term       ::= <Factor>   | <Term>       <MulOp> <Factor>;"
                                        @"Factor     ::= \"Number\" | \"(\" <Expression> \")\";"
                                        @"AddOp      ::= \"+\"      | \"-\";"
                                        @"MulOp      ::= \"*\"      | \"/\";";

        CPParser *          parser = [CPLALR1Parser parserWithGrammar:[CPGrammar grammarWithStart:@"Expression" 
                                                                                   backusNaurForm:expressionGrammar]];
        ParserDelegate * pDelegate = [[ParserDelegate alloc] init];
        parser.delegate = pDelegate;
        
        NSLog(@"ANSWER %f", [(Expression *)[parser parse:tokenStream] value]);
    }
    
    return 0;
}