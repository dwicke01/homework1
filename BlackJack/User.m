//
//  User.m
//  BlackJack
//
//  Created by Daniel Wickes on 2/26/14.
//  Copyright (c) 2014 Daniel Wickes. All rights reserved.
//

#import "User.h"

@implementation User

- (id)init
{
    self = [super init];
    if (self) {
        self.money = 100;
        self.splitHand = [[NSMutableArray alloc]init];
    }
    return self;
}

-(void)increaseSplitScore :(int) v
{
    if (v == 11)
    {
        if (self.splitScore < 11)
        {
            self.splitScore += 11;
            self.splitSoft = YES;
        }
        else
            self.splitScore += 1;
    }
    else
        self.splitScore += v;
    if (self.splitScore > 21 && self.splitSoft)
    {
        self.splitScore -= 10;
        self.splitSoft = NO;
    }
}


-(void)hitSplitHand :(Card*)card
{
    [self.splitHand addObject:card];
    [self increaseSplitScore:[card calcValue]];
}

-(void)dealSplitHand :(Card*)card
{
    self.splitScore = 0;
    [self.splitHand removeAllObjects];
    
    Card *cardFromPair = [self.hand lastObject];
    [self.hand removeObjectAtIndex:([self.hand count]-1)];
    self.score -= [cardFromPair calcValue];
    
    [self hitSplitHand:cardFromPair];
    [self hitSplitHand:card];
}

-(NSString*)splitHandToString
{
    NSString *handString;
    handString = [[NSString alloc]init];
    handString = @"";
    
    for (Card *card in self.splitHand) {
        NSString *s = [card toString];
        handString = [handString stringByAppendingString:s];
        handString = [handString stringByAppendingString:@" "];
    }
    
    return handString;

}

@end
