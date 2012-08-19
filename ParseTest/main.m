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
        
        TokeniserDelegate *tDelegate = [[TokeniserDelegate alloc] init];
        [tokeniser setDelegate:tDelegate];

        CPTokenStream *tokenStream = [tokeniser tokenise:@"5 + (2.0 / 5.0 + 9) * 8"];
        NSLog(@"tokenStream: %@", tokenStream);

        NSString *expressionGrammar = @"Expression ::= term@<Term>   | expr@<Expression> op@<AddOp> term@<Term>;\n"
                                      @"Term       ::= fact@<Factor> | fact@<Factor>     op@<MulOp> term@<Term>;\n"
                                      @"Factor     ::= num@'Number'  | '(' expr@<Expression> ')';"
                                      @"AddOp      ::= '+' | '-';\n"
                                      @"MulOp      ::= '*' | '/';\n";
        
        NSError *err = nil;
        CPGrammar *g = [CPGrammar grammarWithStart:@"Expression"
                                    backusNaurForm:expressionGrammar
                                             error:&err];
        if (nil == g)
        {
            NSLog(@"Error creating grammar:");
            NSLog(@"%@", err);
            return 0;
        }
        CPParser *parser = [CPLALR1Parser parserWithGrammar:g];
        
        ParserDelegate *pDelegate = [[ParserDelegate alloc] init];
        [parser setDelegate:pDelegate];
        
        NSLog(@"ANSWER %3.1f", [(Expression *)[parser parse:tokenStream] value]);
    }
    
    return 0;
}