//
//  BBMatchGameViewController.m
//  Bonbon
//
//  Created by 周峰 on 2017/11/14.
//  Copyright © 2017年 word. All rights reserved.
//

#import "BBMatchGameViewController.h"
#import "BBDatabase.h"
#import "BBWord.h"
#import "BBTool.h"
#import "BBMatchCard.h"
#import "BBGameResult.h"
#import "BBMatchGame.h"


@interface BBMatchGameViewController ()

@property (strong, nonatomic) BBGameResult *gameResult;

@property (strong, nonatomic) UIDynamicAnimator *pileAnimator;
@property (strong, nonatomic) NSMutableArray *cardViews;
@property (weak, nonatomic) IBOutlet UIView *gridView;


@end

@implementation BBMatchGameViewController

-(NSInteger)numberOfStartingCards
{
    return _numberOfMatchWords * 2;
}

- (NSMutableArray *)cardViews
{
    if (!_cardViews) _cardViews = [[NSMutableArray alloc] init];
    return _cardViews;
}

- (BBGameResult *)gameResult
{
    if (!_gameResult) _gameResult = [[BBGameResult alloc] init];
    _gameResult.gameType = self.gameType;
    return _gameResult;
}

- (BBMatchGame *)game
{
    if (!_game) {
        _game = [[BBMatchGame alloc] initWithWordCount:self.numberOfMatchWords];
        _game.matchBonus = 4;
        _game.mismatchPenalty = 1;
        _game.flipCost = 1;
    }
    return _game;
}


- (void)viewDidLoad {
    [super viewDidLoad];
    //[self.navigationController setNavigationBarHidden:YES animated:YES];
    self.title = @"Match";
    self.tabBarController.tabBar.hidden = YES;
    self.numberOfMatchWords = 8;
}

-(void)restartTheGame
{
    self.game = nil;
    self.gameResult = nil;
    for (UIView *subView in self.cardViews) {
        [subView removeFromSuperview];
    }
    self.cardViews = nil;
    self.pileAnimator = nil;
    [self updateUI];
}

- (IBAction)touchDealBtn:(id)sender
{
    [self restartTheGame];
}

-(void)viewWillAppear:(BOOL)animated
{
    [self updateUI];
}

- (void)touchCard:(UITapGestureRecognizer *)gesture
{
    if (gesture.state == UIGestureRecognizerStateEnded) {
        BBMatchCard *card = [self.game cardAtIndex:gesture.view.tag];
        if (!card.matched && !self.pileAnimator) {
            [UIView transitionWithView:gesture.view
                              duration:0
                               options:UIViewAnimationOptionTransitionNone animations:^{
                                   card.chosen = !card.chosen;
                               } completion:^(BOOL finished) {
                                   card.chosen = !card.chosen;
                                   [self.game chooseCardAtIndex:gesture.view.tag];
                                   [self updateUI];
                                   
                               }];
            
        } else if (self.pileAnimator) {
            self.pileAnimator = nil;
            [self updateUI];
        }
    }
}

-(void)showGameResult
{
    NSString* message = [NSString stringWithFormat:@"最终得分：%ld", self.game.score];
    UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"" message:message preferredStyle:UIAlertControllerStyleAlert];
    UIAlertAction *okAction = [UIAlertAction actionWithTitle:@"再来一局" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        [self restartTheGame];
    }];
    [alertController addAction:okAction];
    [self presentViewController:alertController animated:YES completion:nil];
}

-(BOOL)allCardMatched
{
    for (NSUInteger cardIndex = 0;
         cardIndex < self.game.numberOfDealtCards - 1;
         cardIndex++) {
        BBMatchCard *card = [self.game cardAtIndex:cardIndex];
        if(!card.matched) return NO;
    }
    return YES;
}

- (UIView *)createViewForCard:(BBMatchCard *)card
{
    UIView *view = [[UIView alloc] init];
    [view addSubview:card];
    return view;
}

- (void)updateView:(UIView *)view forCard:(BBMatchCard *)card
{
    view.backgroundColor = [UIColor blueColor];
}
#define CELL_WIDTH self.gameGrip.frame.size.width / 4
#define CELL_HEIGHT self.gameGrip.frame.size.height / 4
-(void)updateUI
{
    for (NSUInteger cardIndex = 0;
         cardIndex < self.game.numberOfDealtCards;
         cardIndex++) {
        BBMatchCard *card = [self.game cardAtIndex:cardIndex];
        
        NSUInteger viewIndex = [self.cardViews indexOfObjectPassingTest:^BOOL(id obj, NSUInteger idx, BOOL *stop) {
            if ([obj isKindOfClass:[UIView class]]) {
                if (((UIView *)obj).tag == cardIndex) return YES;
            }
            return NO;
        }];

        UIView *cardView;
        if (viewIndex == NSNotFound) {
            if (!card.matched) {
                cardView = [self createViewForCard:card];
                cardView.tag = cardIndex;
                CGRect rect;
                CGFloat x = (cardIndex % 4)*80;
                CGFloat y = 124 + (NSInteger)(cardIndex / 4)*80;
                rect = CGRectMake(x, y, 80, 80);
                cardView.frame = rect;
                UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self
                                                                                      action:@selector(touchCard:)];
                [cardView addGestureRecognizer:tap];
                
                [self.cardViews addObject:cardView];
                viewIndex = [self.cardViews indexOfObject:cardView];
                [self.view addSubview:cardView];
            }
        }
        else{
            cardView = self.cardViews[viewIndex];
            if (!card.matched) {
                card.layer.borderWidth = card.chosen?3:1;
                
            } else {
                if (self.removeMatchingCards) {
                    [self.cardViews removeObject:cardView];
                    [cardView removeFromSuperview];
                
                } else {
                    cardView.alpha = card.matched ? 0.0 : 1.0;
                }
            }
        }
    }
    
    self.scoreLabel.text = [NSString stringWithFormat:@"Score: %ld", (long)(self.game.score)];
    
    if([self allCardMatched]){
        
        [self showGameResult];
    }
}

- (BOOL)canBecomeFirstResponder
{
    return YES;
}

-(void)viewWillDisappear:(BOOL)animated
{
    self.tabBarController.tabBar.hidden = NO;
}

- (void)viewDidAppear:(BOOL)animated
{
    [self becomeFirstResponder];
}

- (void)motionEnded:(UIEventSubtype)motion withEvent:(UIEvent *)event
{
    if (motion == UIEventSubtypeMotionShake) {
        if (!self.pileAnimator) {
            self.pileAnimator = [[UIDynamicAnimator alloc] initWithReferenceView:self.gridView];
            UIGravityBehavior *gravity = [[UIGravityBehavior alloc] initWithItems:self.cardViews];
            [self.pileAnimator addBehavior:gravity];
            UICollisionBehavior *collision = [[UICollisionBehavior alloc] initWithItems:self.cardViews];
            collision.translatesReferenceBoundsIntoBoundary = YES;
            [self.pileAnimator addBehavior:collision];
            UIDynamicItemBehavior *item = [[UIDynamicItemBehavior alloc] initWithItems:self.cardViews];
            item.elasticity = 1.1;
            [self.pileAnimator addBehavior:item];
        } else {
            self.pileAnimator = nil;
            [self updateUI];
        }
    }
}

@end
