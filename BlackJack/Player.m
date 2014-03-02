//
//  Player.m
//  BlackJack
//
//  Created by Daniel Wickes on 2/26/14.
//  Copyright (c) 2014 Daniel Wickes. All rights reserved.
//

#import "Player.h"

@implementation Player

- (id)init
{
    self = [super init];
    if (self) {
        self.hand = [[NSMutableArray alloc] init];
        self.soft = NO;
    }
    return self;
}

-(void)increaseScore :(int) v
{
    if (v == 11)
    {
        if (self.score < 11)
        {
            self.score += 11;
            if (!self.soft)
                self.soft = YES;
        }
        else
            self.score += 1;
    }
    else
        self.score += v;
    if (self.score > 21 && self.soft)
    {
        self.score -= 10;
        self.soft = NO;
    }
}


-(void)deal :(Card*)card1 :(Card*)card2
{
    self.score = 0;
    self.soft = NO;
    [self.hand removeAllObjects];
    
    [self.hand addObject:card1];
    [self.hand addObject:card2];
    
    int v1 = [card1 calcValue];
    int v2 = [card2 calcValue];
    
    [self increaseScore:v1];
    [self increaseScore:v2];
}


-(void)hit:(Card*)card
{
    [self.hand addObject:card];
    [self increaseScore:[card calcValue]];
}

-(NSString*)handToString
{
    NSString *handString;
    handString = [[NSString alloc]init];
    handString = @"";
    
    for (Card *card in self.hand) {
        NSString *s = [card toString];
        handString = [handString stringByAppendingString:s];
        handString = [handString stringByAppendingString:@" "];
    }
    
    return handString;
}

@end
