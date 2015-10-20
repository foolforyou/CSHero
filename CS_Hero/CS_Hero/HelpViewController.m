//
//  HelpViewController.m
//  CS_Hero
//
//  Created by qianfeng on 15/10/11.
//  Copyright © 2015年 陈思. All rights reserved.
//

#import "HelpViewController.h"
#import "UIView+Common.h"

@interface HelpViewController () {
    UIView *_bgView;
    
    UIImageView *_firstImageView;
    UIImageView *_secondImageView;
    
    UIImageView *_gileImageView;
    UIImageView *_lineImageView;
    UIView *_lineView;
    
    UIImageView *_pointerImageView;
    
    NSTimer *_timer;
    
    UIButton *_actionButton;
    
    UIImageView *_handDownImageView;
}

@end

@implementation HelpViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.view.backgroundColor = [UIColor blackColor];
    [self createView];
    
}



- (void)walkGile {
    NSMutableArray *animationsArray = [NSMutableArray array];
    for (int i = 1; i <= 3; i++) {
        NSString *imageName = [NSString stringWithFormat:@"player_right_%d.png",i];
        [animationsArray addObject:[UIImage imageNamed:imageName]];
    }
    _gileImageView.animationImages = animationsArray;
}

- (void)createView {
    
    _bgView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, width(self.view.frame), height(self.view.frame)-300)];
    _bgView.backgroundColor = [UIColor whiteColor];
    _bgView.center = self.view.center;
    [self.view addSubview:_bgView];
    
    _firstImageView = [[UIImageView alloc] initWithFrame:CGRectMake((width(self.view.frame)-140-100)/2, height(_bgView.frame)-100, 70, 100)];
    _firstImageView.backgroundColor = [UIColor blackColor];
    [_bgView addSubview:_firstImageView];
    
    _gileImageView = [[UIImageView alloc] initWithFrame:CGRectMake(maxX(_firstImageView)-20, minY(_firstImageView)-20, 20, 20)];
    _gileImageView.image = [UIImage imageNamed:@"player_right_1"];
    [_bgView addSubview:_gileImageView];
    [self walkGile];
    
    _secondImageView = [[UIImageView alloc] initWithFrame:CGRectMake(maxX(_firstImageView)+100, minY(_firstImageView), 70, 100)];
    _secondImageView.backgroundColor = [UIColor blackColor];
    [_bgView addSubview:_secondImageView];
    
    _lineView = [[UIView alloc] initWithFrame:CGRectMake(maxX(_firstImageView)-5, minY(_firstImageView)-95, 10, 200)];
    [_bgView addSubview:_lineView];
    
    _lineImageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 100, 5, 0)];
    _lineImageView.backgroundColor = [UIColor blackColor];
    [_lineView addSubview:_lineImageView];
    
    _timer = [NSTimer scheduledTimerWithTimeInterval:0.03 target:self selector:@selector(changeLin:) userInfo:nil repeats:YES];
    
    [_timer setFireDate:[NSDate distantFuture]];
    
    
    UILabel *titleLabel = [[UILabel alloc] initWithFrame:CGRectMake((width(self.view.frame)-200)/2, 50, 200, 50)];
    titleLabel.text = @"怎么玩?";
    titleLabel.textAlignment = NSTextAlignmentCenter;
    titleLabel.textColor = [UIColor whiteColor];
    titleLabel.font = [UIFont boldSystemFontOfSize:35];
    [self.view addSubview:titleLabel];
    
    
    _actionButton = [UIButton buttonWithType:UIButtonTypeCustom];
    _actionButton.frame = CGRectMake((width(self.view.frame)-100)/2, height(self.view.frame)-100, 100, 40);
    _actionButton.layer.cornerRadius = 5.0;
    [_actionButton addTarget:self action:@selector(actionButtonClick:) forControlEvents:UIControlEventTouchUpInside];
    _actionButton.backgroundColor = [UIColor redColor];
    [_actionButton setTitle:@"开始" forState:UIControlStateNormal];
    [_actionButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [_actionButton setTitleColor:[UIColor purpleColor] forState:UIControlStateHighlighted];
    [self.view addSubview:_actionButton];
    
    
    UIImageView *hand = [[UIImageView alloc] initWithFrame:CGRectMake((width(self.view.frame)-40)/2, height(_bgView.frame)-60, 40, 40)];
    hand.image = [UIImage imageNamed:@"pointer"];
    [_bgView addSubview:hand];
    
    _handDownImageView = [[UIImageView alloc] initWithFrame:CGRectMake(minX(hand), minY(hand)-20, 30, 30)];
    _handDownImageView.image = [UIImage imageNamed:@"sound"];
    _handDownImageView.hidden = YES;
    [_bgView addSubview:_handDownImageView];
                                    
}

- (void)actionButtonClick:(UIButton *)button {
    
    _actionButton.hidden = YES;
    
    if ([button.titleLabel.text isEqualToString:@"演示结束"]) {
        [self dismissViewControllerAnimated:YES completion:^{
            
        }];
    }
    _handDownImageView.hidden = NO;
    [_timer setFireDate:[NSDate distantPast]];
    [button setTitle:@"演示结束" forState:UIControlStateNormal];
}

- (void)changeLin:(NSTimer *)timer {
    
    CGRect rect = _lineImageView.frame;
    
    if (rect.size.height > _lineView.frame.size.height/2) {
        _handDownImageView.hidden = YES;
        [_timer setFireDate:[NSDate distantFuture]];
        [self gileWalk];
        return;
    }
    
    [UIView animateWithDuration:0.03 animations:^{
        _lineImageView.frame = CGRectMake(rect.origin.x, rect.origin.y-3, rect.size.width, rect.size.height+3);
    }];
}

- (void)gileWalk {
    [UIView animateWithDuration:0.5 animations:^{
        _lineView.transform = CGAffineTransformMakeRotation(M_PI_2);
    } completion:^(BOOL finished) {
        [_gileImageView startAnimating];
        [UIView animateWithDuration:2 animations:^{
            _gileImageView.frame = CGRectMake(maxX(_secondImageView)-20, minY(_gileImageView), width(_gileImageView.frame), height(_gileImageView.frame));
        } completion:^(BOOL finished) {
            [_gileImageView stopAnimating];
            _actionButton.hidden = NO;
        }];
    }];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
