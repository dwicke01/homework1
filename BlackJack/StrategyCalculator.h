//
//  StrategyCalculator.h
//  BlackJack
//
//  Created by Daniel Wickes on 3/2/14.
//  Copyright (c) 2014 Daniel Wickes. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface StrategyCalculator : NSObject

@property NSMutableArray *hardCalc;
@property NSMutableArray *softCalc;
@property NSMutableArray *pairCalc;

-(NSString*) getStrategy :(int) score :(int) dealerCard :(BOOL) soft :(BOOL) pair;
-(NSString*) getHardStrategy :(int) score :(int) dealerCard;
-(NSString*) getSoftStrategy :(int) score :(int) dealerCard;
-(NSString*) getPairStrategy :(int) score :(int) dealerCard;

@end
