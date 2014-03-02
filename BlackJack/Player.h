//
//  Player.h
//  BlackJack
//
//  Created by Daniel Wickes on 2/26/14.
//  Copyright (c) 2014 Daniel Wickes. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Card.h"

@interface Player : NSObject

@property NSMutableArray *hand;
@property int score;
@property BOOL soft;

-(void)hit :(Card*)card;
-(void)deal :(Card*)card1 :(Card*)card2;
-(NSString*)handToString;


@end
