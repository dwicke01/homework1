//
//  Deck.m
//  BlackJack
//
//  Created by Daniel Wickes on 2/26/14.
//  Copyright (c) 2014 Daniel Wickes. All rights reserved.
//

#import "Deck.h"


@implementation Deck

- (id)init
{
    self = [super init];
    if (self) {
        self.cards = [NSMutableArray arrayWithCapacity:52];
        for (int i = 0; i < 4; i++) {
            for (int j = 2; j < 15; j++)
                [self.cards addObject:[[Card alloc] init :j :i]];
        }
    }
    return self;
}

- (void)shuffle
{
    NSUInteger count = [self.cards count];
    for (NSUInteger i = 0; i < count; ++i) {
        // Select a random element between i and end of array to swap with.
        NSInteger nElements = count - i;
        NSInteger n = arc4random_uniform(nElements) + i;
        [self.cards exchangeObjectAtIndex:i withObjectAtIndex:n];
    }
}

- (Card *)deal
{
    Card *top = [self.cards objectAtIndex:0];
    [self.cards removeObjectAtIndex:0];
    return top;
}

@end
