//
//  Card.h
//  BlackJack
//
//  Created by Daniel Wickes on 2/25/14.
//  Copyright (c) 2014 Daniel Wickes. All rights reserved.
//

#import <Foundation/Foundation.h>

enum Suit {
    diamonds = 0,
    clubs = 1,
    hearts = 2,
    spades = 3
    };

@interface Card : NSObject

@property enum Suit suit;
@property int value;

- (id)init :(int)value :(int)suit;
- (int)calcValue;
- (NSString*) toString;

@end
