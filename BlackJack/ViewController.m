//
//  ViewController.m
//  BlackJack
//
//  Created by Daniel Wickes on 2/25/14.
//  Copyright (c) 2014 Daniel Wickes. All rights reserved.
//

#import "ViewController.h"
#import "User.h"
#import "Card.h"
#import "Deck.h"
#import "Dealer.h"

@interface ViewController ()

@property (weak, nonatomic) IBOutlet UILabel *playersMoney;
@property (weak, nonatomic) IBOutlet UILabel *playersHand;
@property (weak, nonatomic) IBOutlet UILabel *dealersHand;
@property (weak, nonatomic) IBOutlet UILabel *dealersScore;
@property (weak, nonatomic) IBOutlet UILabel *playersScore;
@property (weak, nonatomic) IBOutlet UIButton *dealButton;
@property (weak, nonatomic) IBOutlet UIButton *hitButton;
@property (weak, nonatomic) IBOutlet UIButton *stayButton;
@property (weak, nonatomic) IBOutlet UIButton *doubleDownButton;
@property (weak, nonatomic) IBOutlet UIButton *splitButton;
@property (weak, nonatomic) IBOutlet UIButton *surrenderButton;
@property (weak, nonatomic) IBOutlet UILabel *playersSecondHand;
@property (weak, nonatomic) IBOutlet UILabel *playersSecondScore;
@property (weak, nonatomic) IBOutlet UILabel *insuranceLabel;
@property (weak, nonatomic) IBOutlet UIButton *insuranceYesButton;
@property (weak, nonatomic) IBOutlet UIButton *insuranceNoButton;

@property User *user;
@property Dealer *dealer;
@property Deck *deck;
@property NSMutableArray *trash; // holds cards after hands, between shuffles
@property int pot; // holds main bet
@property int splitPot; // holds bet if user splits
@property int counter; // counter to shuffle every 5 games
@property BOOL split; // YES if split
@property BOOL handleSplit; // YES if player is using second hand

@end

@implementation ViewController
- (IBAction)InsuranceYesButton:(id)sender {
}
- (IBAction)InsuranceNoButton:(id)sender {
}

- (IBAction)SurrenderButton:(id)sender {
    self.user.money += 5;
    [self.dealButton setHidden:NO];
    [self.hitButton setHidden:YES];
    [self.stayButton setHidden:YES];
    [self.surrenderButton setHidden:YES];
    [self.doubleDownButton setHidden:YES];
    [self.splitButton setHidden:YES];
}

- (IBAction)DoubleDownButton:(id)sender {
    self.user.money -= 10;
    self.pot += 10;
    
    Card *hold1;
    hold1 = [self.deck deal];
    [self.user hit:hold1];
    [self.playersHand setText:[self.user handToString]];
    [self.playersScore setText:[NSString stringWithFormat:@"%d",[self.user score]]];

    
    Card *hold;
    while (self.dealer.score < 17)
    {
        hold = [self.deck deal];
        [self.dealer hit:hold];
    }
    
    [self.dealersHand setText:[self.dealer handToString]];
    [self.dealersScore setText:[NSString stringWithFormat:@"%d",[self.dealer score]]];
    
    if (self.dealer.score > 21 || self.dealer.score < self.user.score)
    {
        self.user.money += self.pot*2;
    }
    else if (self.dealer.score == self.user.score)
    {
        self.user.money += self.pot;
    }
    
    NSString *s;
    s = @"$";
    s = [s stringByAppendingString:[NSString stringWithFormat:@"%d",[self.user money]]];
    [self.playersMoney setText:s];
    
    [self.dealButton setHidden:NO];
    [self.hitButton setHidden:YES];
    [self.stayButton setHidden:YES];
    [self.surrenderButton setHidden:YES];
    [self.doubleDownButton setHidden:YES];
    [self.splitButton setHidden:YES];
}

- (IBAction)SplitButton:(id)sender {
    [self.playersSecondHand setHidden:NO];
    [self.splitButton setHidden:YES];
    [self.surrenderButton setHidden:YES];
    [self.doubleDownButton setHidden:YES];
    [self.playersHand setHighlighted:YES];
    self.user.money -= 10;
    self.splitPot += 10;
    NSString *s;
    s = @"$";
    s = [s stringByAppendingString:[NSString stringWithFormat:@"%d",[self.user money]]];
    [self.playersMoney setText:s];
    
    [self.user dealSplitHand: [self.deck deal]];
    [self.user hit :[self.deck deal]];
    [self.playersHand setText:[self.user handToString]];
    [self.playersScore setText:[NSString stringWithFormat:@"%d",[self.user score]]];
    
    [self.playersSecondHand setText:[self.user splitHandToString]];
    self.split = YES;
    [self.playersSecondScore setHidden:NO];
    [self.playersSecondScore setText:[NSString stringWithFormat:@"%d", [self.user splitScore]]];
}

- (IBAction)HitButton:(id)sender {
    Card *hold;
    hold = [self.deck deal];
    if (!self.handleSplit)
    {
        [self.user hit:hold];
        [self.playersHand setText:[self.user handToString]];
        [self.playersScore setText:[NSString stringWithFormat:@"%d",[self.user score]]];
        if ([self.user score] > 21)
        {
            if (!self.split)
            {
                [self.dealButton setHidden:NO];
                [self.hitButton setHidden:YES];
                [self.stayButton setHidden:YES];
                [self.playersHand setHighlighted:NO];
                [self.playersSecondHand setHighlighted:YES];
            }
            else
            {
                self.handleSplit = YES;
                [self.playersHand setHighlighted:NO];
                [self.playersSecondHand setHighlighted:YES];
            }
        }
        [self.surrenderButton setHidden:YES];
        [self.doubleDownButton setHidden:YES];
        [self.splitButton setHidden:YES];
    }
    else
    {
        [self.user hitSplitHand:hold];
        [self.playersSecondHand setText:[self.user splitHandToString]];
        [self.playersSecondScore setText:[NSString stringWithFormat:@"%d",[self.user splitScore]]];
        if ([self.user splitScore] > 21)
        {
            [self.dealButton setHidden:NO];
            [self.hitButton setHidden:YES];
            [self.stayButton setHidden:YES];
            
            if (self.dealer.score > 21 || self.dealer.score < self.user.score)
            {
                self.user.money += self.pot*2;
            }
            else if (self.dealer.score == self.user.score)
            {
                self.user.money += self.pot;
            }
        }
    }
}

- (IBAction)DealButton:(id)sender {
    [self.trash addObjectsFromArray:self.user.hand];
    [self.trash addObjectsFromArray:self.dealer.hand];
    if (self.split)
        [self.trash addObjectsFromArray:self.user.splitHand];
    self.split = NO;
    self.handleSplit = NO;
    self.splitPot = 0;
    [self.playersSecondHand setHighlighted:NO];
    [self.playersSecondScore setHidden:YES];
    [self.insuranceLabel setHidden:YES];
    [self.insuranceYesButton setHidden:YES];
    [self.insuranceNoButton setHidden:YES];
    
    if (self.counter == 5)
    {
        self.counter = 0;
        [self.deck.cards addObjectsFromArray:self.trash];
        [self.trash removeAllObjects];
        [self.deck shuffle];
    }
    
    Card *hold1;
    Card *hold2;
    hold1 = [self.deck deal];
    hold2 = [self.deck deal];
    [self.user deal:hold1 :hold2];
    [self.playersHand setText:[self.user handToString]];
    [self.playersScore setText:[NSString stringWithFormat:@"%d",[self.user score]]];
    
    Card *hold3;
    Card *hold4;
    hold3 = [self.deck deal];
    hold4 = [self.deck deal];
    [self.dealer deal:hold3 :hold4];
    NSString *dealersHandString = [self.dealer handToString];
    if ([hold4 value] != 10)
        dealersHandString = [dealersHandString substringToIndex:([dealersHandString length]-2)];
    else
        dealersHandString = [dealersHandString substringToIndex:([dealersHandString length]-3)];
    dealersHandString = [dealersHandString stringByAppendingString:@"*"];
    [self.dealersHand setText:dealersHandString];
    int v = [hold3 value];
    if (v == 14)
        v = 11;
    else if (v > 10)
        v=10;
    [self.dealersScore setText:[NSString stringWithFormat:@"%d", v]];
    
    [self.dealButton setHidden:YES];
    [self.playersSecondHand setHidden:YES];
    [self.hitButton setHidden:NO];
    [self.stayButton setHidden:NO];
    [self.surrenderButton setHidden:NO];
    [self.doubleDownButton setHidden:NO];
    
    if ([hold1 calcValue] == [hold2 calcValue])
        [self.splitButton setHidden:NO];
    
    self.user.money = self.user.money - 10;
    self.pot = 10;
    NSString *s;
    s = @"$";
    s = [s stringByAppendingString:[NSString stringWithFormat:@"%d",[self.user money]]];
    [self.playersMoney setText:s];

    // if the dealer has blackjack without an ace showing
    if (v == 10 && [hold4 value] == 14)
    {
        [self.dealersHand setText:[self.dealer handToString]];
        if (self.user.score == 21)
            self.user.money += 10;
        [self.dealButton setHidden:NO];
        [self.hitButton setHidden:YES];
        [self.stayButton setHidden:YES];
        [self.surrenderButton setHidden:YES];
        [self.doubleDownButton setHidden:YES];
        [self.splitButton setHidden:YES];
        
        [self.dealersScore setText:[NSString stringWithFormat:@"%d",[self.dealer score]]];
        
        NSString *s;
        s = @"$";
        s = [s stringByAppendingString:[NSString stringWithFormat:@"%d",[self.user money]]];
        [self.playersMoney setText:s];
    }
    
    // if the player has blackjack
    if (self.user.score == 21)
    {
        if (self.dealer.score != 21)
            self.user.money += 15;
        else
            self.user.money += self.pot;
        [self.dealersHand setText:[self.dealer handToString]];
        [self.dealButton setHidden:NO];
        [self.hitButton setHidden:YES];
        [self.stayButton setHidden:YES];
        [self.surrenderButton setHidden:YES];
        [self.doubleDownButton setHidden:YES];
        [self.splitButton setHidden:YES];
        
        NSString *s;
        s = @"$";
        s = [s stringByAppendingString:[NSString stringWithFormat:@"%d",[self.user money]]];
        [self.playersMoney setText:s];
    }
    else if ([hold3 value]==14) // if the dealer has an ace showing
    {
        [self.dealButton setHidden:YES];
        [self.hitButton setHidden:YES];
        [self.stayButton setHidden:YES];
        [self.surrenderButton setHidden:YES];
        [self.doubleDownButton setHidden:YES];
        [self.splitButton setHidden:YES];
        [self.insuranceLabel setHidden:NO];
        [self.insuranceYesButton setHidden:NO];
        [self.insuranceNoButton setHidden:NO];
    }
    
    self.counter++;
}

- (IBAction)StayButton:(id)sender
{
    if (!self.split)
    {
        Card *hold;
        while (self.dealer.score < 17)
        {
            hold = [self.deck deal];
            [self.dealer hit:hold];
        }
    
        [self.dealersHand setText:[self.dealer handToString]];
        [self.dealersScore setText:[NSString stringWithFormat:@"%d",[self.dealer score]]];
    
        if (self.dealer.score > 21 || self.dealer.score < self.user.score)
        {
            self.user.money += self.pot*2;
        }
        else if (self.dealer.score == self.user.score)
        {
            self.user.money += self.pot;
        }
        
        if (self.handleSplit)
        {
            if (self.dealer.score > 21 || self.dealer.score < self.user.splitScore)
            {
                self.user.money += self.splitPot*2;
            }
            else if (self.dealer.score == self.user.splitScore)
            {
                self.user.money += self.splitPot;
            }

        }
    
        NSString *s;
        s = @"$";
        s = [s stringByAppendingString:[NSString stringWithFormat:@"%d",[self.user money]]];
        [self.playersMoney setText:s];
    
        [self.dealButton setHidden:NO];
        [self.hitButton setHidden:YES];
        [self.stayButton setHidden:YES];
    }
    else
    {
        self.split = NO;
        self.handleSplit = YES;
        [self.playersHand setHighlighted:NO];
        [self.playersSecondHand setHighlighted:YES];
    }
    [self.surrenderButton setHidden:YES];
    [self.doubleDownButton setHidden:YES];
    [self.splitButton setHidden:YES];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
    self.deck = [[Deck alloc] init];
    [self.deck shuffle];
    self.user = [[User alloc] init];
    self.dealer = [[Dealer alloc] init];
    [self.hitButton setHidden:YES];
    [self.stayButton setHidden:YES];
    [self.surrenderButton setHidden:YES];
    [self.doubleDownButton setHidden:YES];
    [self.splitButton setHidden:YES];
    [self.playersSecondHand setHidden:YES];
    [self.playersSecondScore setHidden:YES];
    [self.insuranceLabel setHidden:YES];
    [self.insuranceYesButton setHidden:YES];
    [self.insuranceNoButton setHidden:YES];
    NSString *s;
    s = @"$";
    s = [s stringByAppendingString:[NSString stringWithFormat:@"%d",[self.user money]]];
    self.counter = 0;
    self.split = NO;
    self.handleSplit = NO;
    self.trash = [[NSMutableArray alloc]init];
    
    [self.playersMoney setText:s];
    [self.playersHand setHighlightedTextColor:[UIColor greenColor]];
    [self.playersSecondHand setHighlightedTextColor:[UIColor greenColor]];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
