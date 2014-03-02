//
//  User.h
//  BlackJack
//
//  Created by Daniel Wickes on 2/26/14.
//  Copyright (c) 2014 Daniel Wickes. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Player.h"

@interface User : Player

@property int money;
@property NSMutableArray *splitHand;
@property int splitScore;
@property BOOL splitSoft;

-(void)hitSplitHand :(Card*)card;
-(void)dealSplitHand :(Card*)card;
-(NSString*)splitHandToString;
@end
