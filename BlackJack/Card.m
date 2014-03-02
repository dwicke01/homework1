//
//  Card.m
//  BlackJack
//
//  Created by Daniel Wickes on 2/25/14.
//  Copyright (c) 2014 Daniel Wickes. All rights reserved.
//

#import "Card.h"

@implementation Card

- (id)init :(int)value :(int)suit
{
    self = [super init];
    if (self) {
        self.suit = suit;
        self.value = value;
    }
    return self;
}

-(int)calcValue
{
    if (self.value < 10)
        return self.value;
    else if (self.value == 14)
        return 11;
    else
        return 10;
}

-(NSString*)toString
{
    NSString *cardString;
    if (self.value <= 10)
        cardString = [NSString stringWithFormat:@"%d", self.value];
    else if (self.value == 11)
        cardString = @"J";
    else if (self.value == 12)
        cardString = @"Q";
    else if (self.value == 13)
        cardString = @"K";
    else
        cardString = @"A";
        
    return cardString;
}

@end
