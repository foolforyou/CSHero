//
//  ViewController.m
//  CS_Hero
//
//  Created by qianfeng on 15/10/5.
//  Copyright © 2015年 陈思. All rights reserved.
//

#import "PlayViewController.h" 
#import "UIView+Common.h"
#import "UMSocial.h"

#define NAME1 @"26c76d9f7e90597119eb50dd9cd167be"

#define NAME2 @"fff988115a6a2732e5e009b5df797b95"

@interface PlayViewController () {
    NSTimer *_timer;
    UIImageView *_aLabel;
    UIView *_bgView;
    UIImageView *_backgroundImageView;
    UIImageView *_bigBackgroundImageView;
    UIImageView *_firstLabel;
    UIImageView *_secondLabel;
    UIView *_reloadView;
    
    UILabel *_twoLabel;
    UILabel *_fourLabel;
    
    UILabel *_numberLabel;
    UILabel *_titleLabel;
    
    UILabel *_overTitleLabel;
    
    UIImageView *_walkGile;
    
    BOOL _isYES;
    BOOL _isDown;
    
    NSString *_bigNumber;
    
    NSString *_appPath;
    NSString *_imagePath;
    
    UILabel *_oneRedLabel;
    UILabel *_twoRedLabel;
    
    UILabel *_popLabel;
    UILabel *_popAddLabel;
}

@end

@implementation PlayViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    _isYES = YES;
    _isDown = NO;
    [self createData];
    [self createTimer];
    [self createView];
    [self walkGile];
    [self createReloadView];
}

- (void)createData {
    _appPath = [NSHomeDirectory() stringByAppendingString:@"/data.txt"];
    
    
    NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
    _bigNumber = @"0";
    
    NSString *str = [NSString stringWithFormat:@"%@",[userDefaults valueForKey:@"bigNumber"]];
    
    if (![str isEqualToString:@"(null)"]) {
        NSLog(@"--(%@)",str);
        _bigNumber = str;
    } else {
        
    }
    
}

- (void)createView {
    
    _bigBackgroundImageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, width(self.view.frame), height(self.view.frame))];
    _imagePath = NAME1;
    NSString *imagePath = [[NSBundle mainBundle] pathForResource:_imagePath ofType:@"jpeg"];
    _bigBackgroundImageView.image = [UIImage imageWithContentsOfFile:imagePath];
    _bigBackgroundImageView.backgroundColor = [UIColor blueColor];
    [self.view addSubview:_bigBackgroundImageView];
    
    _numberLabel = [[UILabel alloc] initWithFrame:CGRectMake((width(self.view.frame)-80)/2, 50, 80, 40)];
    _numberLabel.backgroundColor = [UIColor grayColor];
    _numberLabel.text = @"0";
    _numberLabel.layer.cornerRadius = 5.0;
    _numberLabel.clipsToBounds = YES;
    _numberLabel.textAlignment = NSTextAlignmentCenter;
    _numberLabel.font = [UIFont boldSystemFontOfSize:30];
    _numberLabel.textColor = [UIColor whiteColor];
    [self.view addSubview:_numberLabel];
    
    _titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(minX(_numberLabel)-10, maxY(_numberLabel)+10, width(_numberLabel.frame)+20, 40)];
    _titleLabel.text = @"将手放到屏幕使杆变长";
    _titleLabel.numberOfLines = 0;
    _titleLabel.textAlignment = NSTextAlignmentCenter;
    _titleLabel.font = [UIFont boldSystemFontOfSize:15];
    [self.view addSubview:_titleLabel];
    
    _popLabel = [[UILabel alloc] initWithFrame:CGRectMake(minX(_titleLabel), maxY(_titleLabel)+30, width(_titleLabel.frame), height(_titleLabel.frame))];
    _popLabel.textAlignment = NSTextAlignmentCenter;
    _popLabel.textColor = [UIColor redColor];
    _popLabel.alpha = 0;
    [self.view addSubview:_popLabel];
    
    _popAddLabel = [[UILabel alloc] init];
    _popAddLabel.textAlignment = NSTextAlignmentCenter;
    _popAddLabel.textColor = [UIColor redColor];
    _popAddLabel.alpha = 0;
    [self.view addSubview:_popAddLabel];
    
    _backgroundImageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 100, width(self.view.frame), height(self.view.frame)-300)];
    
    _bgView = [[UIView alloc] initWithFrame:CGRectMake(50, 100, 10, 2*height(_backgroundImageView.frame))];
    [self.view addSubview:_bgView];
    
    _aLabel = [[UIImageView alloc] initWithFrame:CGRectMake(0, height(_bgView.frame)/2, 5, 0)];
//    _aLabel.backgroundColor = [UIColor blackColor];
    _aLabel.image = [UIImage imageNamed:@"bg"];
    [_bgView addSubview:_aLabel];
    
    _firstLabel = [[UIImageView alloc] initWithFrame:CGRectMake(20, maxY(_backgroundImageView), 36, height(self.view.frame)-maxY(_backgroundImageView))];
//    _firstLabel.backgroundColor = [UIColor blackColor];
    _firstLabel.image = [UIImage imageNamed:@"bg"];
    _firstLabel.layer.cornerRadius = 1.0;
    _firstLabel.clipsToBounds = YES;
    [self.view addSubview:_firstLabel];
    
    
    _secondLabel = [[UIImageView alloc] initWithFrame:CGRectMake(76+arc4random_uniform(200), maxY(_backgroundImageView), arc4random_uniform(100)+20, height(self.view.frame)-maxY(_backgroundImageView))];
//    _secondLabel.backgroundColor = [UIColor blackColor];
    _secondLabel.image = [UIImage imageNamed:@"bg"];
    _secondLabel.layer.cornerRadius = 5.0;
    _secondLabel.clipsToBounds = YES;
    [self.view addSubview:_secondLabel];
    
    _oneRedLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 5, 5)];
    _oneRedLabel.backgroundColor = [UIColor redColor];
    [_secondLabel addSubview:_oneRedLabel];
    
    _twoRedLabel = [[UILabel alloc] initWithFrame:CGRectMake(width(_secondLabel.frame)-5, 0, 5, 5)];
    _twoRedLabel.backgroundColor = [UIColor redColor];
    [_secondLabel addSubview:_twoRedLabel];
    
    
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    button.frame = CGRectMake(0, 0, width(self.view.frame), height(self.view.frame));
    [button addTarget:self action:@selector(buttonTouch:) forControlEvents:UIControlEventTouchDown];
    [button addTarget:self action:@selector(buttonUp:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:button];
    
    _walkGile = [[UIImageView alloc] initWithFrame:CGRectMake(30, minY(_firstLabel)-20, 20, 20)];
    _walkGile.image = [UIImage imageNamed:@"player_right_1"];
    [self.view addSubview:_walkGile];
    
}

- (void)createTimer {
    _timer = [NSTimer scheduledTimerWithTimeInterval:0.01 target:self selector:@selector(timeAction:) userInfo:nil repeats:YES];
    [_timer setFireDate:[NSDate distantFuture]];
}

- (void)timeAction:(NSTimer *)timer {
    CGRect rect = _aLabel.frame;
    
    if (rect.size.height > _backgroundImageView.frame.size.height) {
        return;
    }
    
    [UIView animateWithDuration:0.01 animations:^{
        _aLabel.frame = CGRectMake(rect.origin.x, rect.origin.y-3, rect.size.width, rect.size.height+3);
    }];
}

- (void)buttonTouch:(UIButton *)button {
    if (_isYES) {
        [_timer setFireDate:[NSDate distantPast]];
        _isDown = YES;
    }
}

- (void)buttonUp:(UIButton *)button {
    if (_isDown) {
        _isYES = NO;
        _isDown = NO;
        [_timer setFireDate:[NSDate distantFuture]];
        [self changeLabel];
    }
}

- (void)walkGile {
    NSMutableArray *animationsArray = [NSMutableArray array];
    for (int i = 1; i <= 3; i++) {
        NSString *imageName = [NSString stringWithFormat:@"player_right_%d.png",i];
        [animationsArray addObject:[UIImage imageNamed:imageName]];
    }
    _walkGile.animationImages = animationsArray;
}

- (void)changeLabel {
    [UIView animateWithDuration:0.5 animations:^{
        _bgView.transform = CGAffineTransformMakeRotation(M_PI_2);
    } completion:^(BOOL finished) {
        CGFloat aLabelHeight = height(_aLabel.frame);
        CGFloat precipiceWidth = minX(_secondLabel)-maxX(_firstLabel);
        CGFloat otherPrecipiceWidth = maxX(_secondLabel)-maxX(_firstLabel);
        if (aLabelHeight >= precipiceWidth && aLabelHeight <= otherPrecipiceWidth) {
            NSLog(@"%f,%f",aLabelHeight-precipiceWidth,otherPrecipiceWidth - aLabelHeight);
            if ((aLabelHeight-precipiceWidth <= 5) || (otherPrecipiceWidth - aLabelHeight) <= 5){
                [self showPopLabel];
            }
        }
        [self gileWalk];
    }];
    
}

- (void)gileWalk {
        
    CGFloat aLabelHeight = height(_aLabel.frame);
    CGFloat precipiceWidth = minX(_secondLabel)-maxX(_firstLabel);
    CGFloat otherPrecipiceWidth = maxX(_secondLabel)-maxX(_firstLabel);
    
    if ((aLabelHeight < precipiceWidth) || (aLabelHeight > otherPrecipiceWidth) ) {
        [self goDie];
    } else {
        [self gileWalkToSecond];
        _numberLabel.text = [NSString stringWithFormat:@"%ld",[_numberLabel.text integerValue]+1];
    }
    
}

- (void)showPopLabel {
    _popLabel.text = @"惊心动魄";
    _popLabel.alpha = 1;
    
    _popAddLabel.frame = CGRectMake(minX(_secondLabel), minY(_secondLabel)-50, width(_secondLabel.frame), 30);
    _popAddLabel.text = @"+5";
    _numberLabel.text = [NSString stringWithFormat:@"%ld",[_numberLabel.text integerValue]+5];
    _popAddLabel.alpha = 1;
    
    [UIView animateWithDuration:1 animations:^{
        _popLabel.transform = CGAffineTransformMakeTranslation(0, -10);
        _popLabel.alpha = 0;
        
        _popAddLabel.transform = CGAffineTransformMakeTranslation(0, -10);
        _popAddLabel.alpha = 0;
    } completion:^(BOOL finished) {
        _popLabel.transform = CGAffineTransformMakeTranslation(0, 0);
        _popAddLabel.transform = CGAffineTransformMakeTranslation(0, 0);
    }];
}

- (void)goDie {
    [_walkGile startAnimating];
    [UIView animateWithDuration:1 animations:^{
        _walkGile.frame = CGRectMake(50+height(_aLabel.frame), minY(_walkGile), 20, 20);
    } completion:^(BOOL finished) {
        [_walkGile stopAnimating];
        [UIView animateWithDuration:0.5 animations:^{
            _walkGile.frame = CGRectMake(minX(_walkGile), height(self.view.frame), 20, 20);
        } completion:^(BOOL finished) {
            [UIView animateWithDuration:0.04 animations:^{
                self.view.frame = CGRectMake(minX(self.view), minY(self.view)+10, width(self.view.frame), height(self.view.frame));
            } completion:^(BOOL finished) {
                [UIView animateWithDuration:0.05 animations:^{
                    self.view.frame = CGRectMake(minX(self.view), minY(self.view)-16, width(self.view.frame), height(self.view.frame));
                } completion:^(BOOL finished) {
                    [UIView animateWithDuration:0.02 animations:^{
                        self.view.frame = CGRectMake(minX(self.view), minY(self.view)+6, width(self.view.frame), height(self.view.frame));
                    } completion:^(BOOL finished) {
                        [self showReloadView];
                    }];
                }];
            }];
        }];
    }];
}

- (void)createReloadView {
    _reloadView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, width(self.view.frame), height(self.view.frame))];
    _reloadView.hidden = YES;
    [self.view addSubview:_reloadView];
    
    UILabel *bgLabel = [[UILabel alloc] initWithFrame:_reloadView.frame];
    bgLabel.backgroundColor = [UIColor blackColor];
    bgLabel.alpha = 0.5;
    [_reloadView addSubview:bgLabel];
    
    _overTitleLabel = [[UILabel alloc] initWithFrame:CGRectMake((width(self.view.frame)-250)/2, 50, 250, 100)];
    _overTitleLabel.text = @"游戏结束!";
    _overTitleLabel.textColor = [UIColor whiteColor];
    _overTitleLabel.textAlignment = NSTextAlignmentCenter;
    _overTitleLabel.font = [UIFont boldSystemFontOfSize:40];
    [_reloadView addSubview:_overTitleLabel];
    
    UIView *littleView = [[UIView alloc] initWithFrame:CGRectMake(minX(_overTitleLabel), maxY(_overTitleLabel)+10, width(_overTitleLabel.frame), 160)];
    littleView.backgroundColor = [UIColor whiteColor];
    littleView.layer.cornerRadius = 10;
    littleView.clipsToBounds = YES;
    [_reloadView addSubview:littleView];
    
    UILabel *oneLabel = [[UILabel alloc] initWithFrame:CGRectMake((width(littleView.frame)-100)/2, 5, 100, 20)];
    oneLabel.text = @"分数";
    oneLabel.textAlignment = NSTextAlignmentCenter;
    oneLabel.font = [UIFont systemFontOfSize:16];
    [littleView addSubview:oneLabel];
    
    _twoLabel = [[UILabel alloc] initWithFrame:CGRectMake(minX(oneLabel), maxY(oneLabel)+5, width(oneLabel.frame), 50)];
    _twoLabel.textAlignment = NSTextAlignmentCenter;
    _twoLabel.font = [UIFont boldSystemFontOfSize:32];
    [littleView addSubview:_twoLabel];
    
    UILabel *threeLabel = [[UILabel alloc] initWithFrame:CGRectMake(minX(oneLabel), maxY(_twoLabel)+5, width(oneLabel.frame), 20)];
    threeLabel.text = @"最佳";
    threeLabel.textAlignment = NSTextAlignmentCenter;
    threeLabel.font = [UIFont systemFontOfSize:16];
    [littleView addSubview:threeLabel];
    
    _fourLabel = [[UILabel alloc] initWithFrame:CGRectMake(minX(oneLabel), maxY(threeLabel)+5, width(oneLabel.frame), 50)];
    _fourLabel.textAlignment = NSTextAlignmentCenter;
    _fourLabel.font = [UIFont boldSystemFontOfSize:32];
    [littleView addSubview:_fourLabel];
    [self createButton];
}

- (void)createButton {
    
    NSArray *array = @[@"home",@"star",@"ccw"];
    
    CGFloat btnWidth = (width(self.view.frame)-10*2-180)/3;
    
    for (int i = 0; i < array.count; i++) {
        UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
        button.frame = CGRectMake(90+(btnWidth+10)*i, height(self.view.frame)-200, btnWidth, btnWidth);
        [button setImage:[UIImage imageNamed:array[i]] forState:UIControlStateNormal];
        button.backgroundColor = [UIColor grayColor];
        button.layer.cornerRadius = 5.0;
        button.tag = 100+i;
        [button addTarget:self action:@selector(buttonClick:) forControlEvents:UIControlEventTouchUpInside];
        [_reloadView addSubview:button];
    }
}

- (void)buttonClick:(UIButton *)button {
    NSInteger btnTag = button.tag-100;
    switch (btnTag) {
        case 0:
            [self dismissViewControllerAnimated:YES completion:^{
                
            }];
            break;
//        case 1:
//        {
//            UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"提示" message:@"暂无此项功能" delegate:self cancelButtonTitle:nil otherButtonTitles:@"OK", nil];
//            [alertView show];
//        }
//            break;
        case 1:
        {
            [UMSocialSnsService presentSnsIconSheetView:self appKey:@"56162ee3e0f55ae812003943" shareText:@"你要分享的文字" shareImage:[UIImage imageNamed:@"UMS_nav_button_refresh"] shareToSnsNames:[NSArray arrayWithObjects:UMShareToSina,UMShareToTwitter,UMShareToEmail,UMShareToSms,nil] delegate:self];
        }
            break;
        case 2:
        {
            if ([_imagePath isEqualToString:NAME1]) {
                _imagePath = NAME2;
            } else {
                _imagePath = NAME1;
            }
            _reloadView.hidden = YES;
            _walkGile.alpha = 0;
            [UIView animateWithDuration:0.5 animations:^{
                _bigBackgroundImageView.alpha = 0;
                _firstLabel.alpha = 0;
                _secondLabel.alpha = 0;
                _aLabel.alpha = 0;
                _numberLabel.alpha = 0;
                [self gileWalkToSecond];
            } completion:^(BOOL finished) {
                NSString *imagePath = [[NSBundle mainBundle] pathForResource:_imagePath ofType:@"jpeg"];
                _bigBackgroundImageView.image = [UIImage imageWithContentsOfFile:imagePath];
                [UIView animateWithDuration:1.5 animations:^{
                    _firstLabel.alpha = 1;
                    _secondLabel.alpha = 1;
                    _aLabel.alpha = 1;
                    _bigBackgroundImageView.alpha = 1;
                    _numberLabel.text = @"0";
                    _numberLabel.alpha = 1;
                    _walkGile.alpha = 1;
                } completion:^(BOOL finished) {
                }];
            }];
        }
            break;
            
        default:
            break;
    }
}

- (void)showReloadView {
    _reloadView.hidden = NO;
    _twoLabel.text = _numberLabel.text;
    
    NSInteger two = [_twoLabel.text integerValue];
    
    NSLog(@"%@",_bigNumber);
    
    NSInteger bigNumber = [_bigNumber integerValue];
    
    _overTitleLabel.text = @"游戏结束!";
    _overTitleLabel.textColor = [UIColor whiteColor];
    
    if (bigNumber < two) {
        
        NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
        
        _overTitleLabel.text = @"刷新最佳纪录";
        _overTitleLabel.textColor = [UIColor redColor];
        
        [userDefaults setInteger:two forKey:@"bigNumber"];
        
        [userDefaults synchronize];
        
        _bigNumber = _twoLabel.text;
    }
    
    _fourLabel.text = _bigNumber;
}

- (void)gileWalkToSecond {
    [_walkGile startAnimating];
    [UIView animateWithDuration:1 animations:^{
        _walkGile.frame = CGRectMake(maxX(_secondLabel)-20, minY(_secondLabel)-20, 20, 20);
    } completion:^(BOOL finished) {
        [_walkGile stopAnimating];
        _bgView.transform = CGAffineTransformMakeRotation(M_PI*2);
        _aLabel.frame = CGRectMake(0, height(_bgView.frame)/2, 5, 0);
        [UIView animateWithDuration:0.5 animations:^{
            _firstLabel.frame = CGRectMake(minX(_firstLabel), height(self.view.frame), width(_firstLabel.frame), height(_firstLabel.frame));
            _walkGile.frame = CGRectMake(30, minY(_secondLabel)-20, 20, 20);
            _secondLabel.frame = CGRectMake(56-width(_secondLabel.frame), minY(_secondLabel), width(_secondLabel.frame), height(_secondLabel.frame));
        } completion:^(BOOL finished) {
            _firstLabel.frame = _secondLabel.frame;
            
            _secondLabel.frame = CGRectMake(76+arc4random_uniform(200), -height(_firstLabel.frame), arc4random_uniform(100)+20, height(self.view.frame)-maxY(_backgroundImageView));
            
            _twoRedLabel.frame = CGRectMake(width(_secondLabel.frame)-5, 0, 5, 5);
            
            [UIView animateWithDuration:0.5 animations:^{
                _secondLabel.frame = CGRectMake(76+arc4random_uniform(200), maxY(_backgroundImageView), width(_secondLabel.frame), height(_secondLabel.frame));
            } completion:^(BOOL finished) {
                _isYES = YES;
            }];
        }];
    }];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
