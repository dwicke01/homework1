//
//  StrategyCalculator.m
//  BlackJack
//
//  Created by Daniel Wickes on 3/2/14.
//  Copyright (c) 2014 Daniel Wickes. All rights reserved.
//

#import "StrategyCalculator.h"

@implementation StrategyCalculator

- (id)init
{
    self = [super init];
    if (self) {
        NSMutableArray *allHit = [[NSMutableArray alloc]init];
        for (int i = 0; i < 10; i++) {
            [allHit addObject:@"Hit"];
        }
        
        NSMutableArray *hardRow4 = [[NSMutableArray alloc]init];
        for (int i = 0; i < 10; i++) {
            [hardRow4 addObject:@"Hit"];
        }
        [hardRow4 setObject:@"Double Down or Hit" atIndexedSubscript:3];
        [hardRow4 setObject:@"Double Down or Hit" atIndexedSubscript:4];

        NSMutableArray *hardRow5 = [[NSMutableArray alloc]init];
        for (int i = 0; i < 5; i++) {
            [hardRow5 addObject:@"Double Down or Hit"];
        }
        for (int i = 0; i < 5; i++) {
            [hardRow5 addObject:@"Hit"];
        }
        
        NSMutableArray *hardRow6 = [[NSMutableArray alloc]init];
        for (int i = 0; i < 8; i++) {
            [hardRow6 addObject:@"Double Down or Hit"];
        }
        for (int i = 0; i < 2; i++) {
            [hardRow6 addObject:@"Hit"];
        }

        
        NSMutableArray *hardRow7 = [[NSMutableArray alloc]init];
        for (int i = 0; i < 10; i++) {
            [hardRow7 addObject:@"Double Down or Hit"];
        }

        NSMutableArray *hardRow8 = [[NSMutableArray alloc]init];
        for (int i = 0; i < 10; i++) {
            [hardRow8 addObject:@"Hit"];
        }
        [hardRow8 setObject:@"Stay" atIndexedSubscript:2];
        [hardRow8 setObject:@"Stay" atIndexedSubscript:3];
        [hardRow8 setObject:@"Stay" atIndexedSubscript:4];
        
        
        
        NSMutableArray *halfStayHalfHit = [[NSMutableArray alloc]init];
        for (int i = 0; i < 5; i++) {
            [halfStayHalfHit addObject:@"Stay"];
        }
        for (int i = 0; i < 5; i++) {
            [halfStayHalfHit addObject:@"Hit"];
        }

        NSMutableArray *allStay = [[NSMutableArray alloc]init];
        for (int i = 0; i < 10; i++) {
            [allStay addObject:@"Stay"];
        }
        
        self.hardCalc = [[NSArray alloc]initWithObjects:allHit, allHit, allHit, hardRow4, hardRow5, hardRow6, hardRow7, halfStayHalfHit, halfStayHalfHit, halfStayHalfHit, halfStayHalfHit, allStay, allStay, allStay, allStay, allStay, nil];
        
        NSMutableArray *softRow1to4 = [[NSMutableArray alloc]init];
        for (int i = 0; i < 10; i++) {
            [softRow1to4 addObject:@"Hit"];
        }
        [softRow1to4 setObject:@"Double Down or Hit" atIndexedSubscript:2];
        [softRow1to4 setObject:@"Double Down or Hit" atIndexedSubscript:3];
        [softRow1to4 setObject:@"Double Down or Hit" atIndexedSubscript:4];
        
        NSMutableArray *softRow6 = [[NSMutableArray alloc]init];
        for (int i = 0; i < 10; i++) {
            [softRow6 addObject:@"Stay"];
        }
        [softRow6 setObject:@"Double Down or Hit" atIndexedSubscript:1];
        [softRow6 setObject:@"Double Down or Hit" atIndexedSubscript:2];
        [softRow6 setObject:@"Double Down or Hit" atIndexedSubscript:3];
        [softRow6 setObject:@"Double Down or Hit" atIndexedSubscript:4];
        [softRow6 setObject:@"Hit" atIndexedSubscript:7];
        [softRow6 setObject:@"Hit" atIndexedSubscript:8];

        NSMutableArray *softRow7 = [[NSMutableArray alloc]init];
        for (int i = 0; i < 10; i++) {
            [softRow7 addObject:@"Stay"];
        }
        [softRow7 setObject:@"Double Down or Hit" atIndexedSubscript:4];

        self.softCalc = [[NSArray alloc]initWithObjects:softRow1to4,softRow1to4,softRow1to4,softRow1to4, hardRow5, softRow6, softRow7, allStay, allStay, nil];
        
        NSMutableArray *pairRow1and5 = [[NSMutableArray alloc]init];
        for (int i = 0; i < 6; i++)
        {
            [pairRow1and5 addObject:@"Split"];
        }
        for (int i = 0; i < 4; i++)
        {
            [pairRow1and5 addObject:@"Hit"];
        }

        NSMutableArray *pairRow2 = [[NSMutableArray alloc]init];
        for (int i = 0; i < 7; i++)
        {
            [pairRow2 addObject:@"Split"];
        }
        for (int i = 0; i < 3; i++)
        {
            [pairRow2 addObject:@"Hit"];
        }
        
        NSMutableArray *pairRow3 = [[NSMutableArray alloc]init];
        for (int i = 0; i < 2; i++)
        {
            [pairRow3 addObject:@"Hit"];
        }
        for (int i = 0; i < 3; i++)
        {
            [pairRow3 addObject:@"Split"];
        }
        for (int i = 0; i < 5; i++)
        {
            [pairRow3 addObject:@"Hit"];
        }

        NSMutableArray *pairRow4 = [[NSMutableArray alloc]init];
        for (int i = 0; i < 8; i++)
        {
            [pairRow4 addObject:@"Double down or Hit"];
        }
        for (int i = 0; i < 2; i++)
        {
            [pairRow4 addObject:@"Hit"];
        }

        NSMutableArray *pairRow6 = [[NSMutableArray alloc]init];
        for (int i = 0; i < 7; i++)
        {
            [pairRow6 addObject:@"Split"];
        }
        for (int i = 0; i < 3; i++)
        {
            [pairRow6 addObject:@"Hit"];
        }
        [pairRow6 setObject:@"Stay" atIndexedSubscript:8];
        
        NSMutableArray *allSplit = [[NSMutableArray alloc]init];
        for (int i = 0; i < 10; i++)
        {
            [allSplit addObject:@"Split"];
        }
        
        NSMutableArray *pairRow8 = [[NSMutableArray alloc]init];
        for (int i = 0; i < 10; i++)
        {
            [pairRow8 addObject:@"Split"];
        }
        [pairRow8 setObject:@"Stay" atIndexedSubscript:5];
        [pairRow8 setObject:@"Stay" atIndexedSubscript:8];
        [pairRow8 setObject:@"Stay" atIndexedSubscript:9];

        self.pairCalc = [[NSArray alloc]initWithObjects:pairRow1and5, pairRow2, pairRow3, pairRow4, pairRow1and5, pairRow6, allSplit, pairRow8, allStay, allSplit, nil];
    }
    return self;
}

-(NSString*) getHardStrategy :(int) score :(int) dealerCard
{
    NSLog(@"Hard");
    return [[self.hardCalc objectAtIndex:(score-5)]objectAtIndex:dealerCard-2];
}

-(NSString*) getSoftStrategy :(int) score :(int) dealerCard
{
    NSLog(@"Soft");
    return [[self.softCalc objectAtIndex:(score-13)]objectAtIndex:dealerCard-2];
}

-(NSString*) getPairStrategy :(int) score :(int) dealerCard
{
    NSLog(@"Pair");
    return [[self.pairCalc objectAtIndex:((score/2)-2)]objectAtIndex:dealerCard-2];
}

-(NSString*) getStrategy :(int) score :(int) dealerCard :(BOOL) soft :(BOOL) pair
{
    if (pair)
        return [self getPairStrategy:score :dealerCard];
    else if (soft)
        return [self getSoftStrategy:score :dealerCard];
    return [self getHardStrategy:score :dealerCard];
}

@end
