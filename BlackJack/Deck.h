//
//  Deck.h
//  BlackJack
//
//  Created by Daniel Wickes on 2/26/14.
//  Copyright (c) 2014 Daniel Wickes. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Card.h"

@interface Deck : NSObject

@property NSMutableArray *cards;

- (id)init;

- (void)shuffle;
- (Card *)deal;

@end
