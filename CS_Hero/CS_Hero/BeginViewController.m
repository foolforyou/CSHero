//
//  BeginViewController.m
//  CS_Hero
//
//  Created by qianfeng on 15/10/8.
//  Copyright © 2015年 陈思. All rights reserved.
//

#import "BeginViewController.h"
#import <AVFoundation/AVFoundation.h>
#import "UIView+Common.h"
#import "PlayViewController.h"
#import "HelpViewController.h"

@interface BeginViewController () {
    UIButton *_button;
    NSTimer *_timer;
    int _pading;
    UIImageView *_gileImageView;
    BOOL _open;
    AVAudioPlayer *_audioPlayer;
}

@end

@implementation BeginViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    _open = YES;
    [self createView];
    [self walkGile];
    [self createMp3];
}

- (void)createMp3 {
    
    NSString *filePath = [[NSBundle mainBundle] pathForResource:@"卡农(清脆醒神的音乐)" ofType:@"mp3"];
    
    NSURL *fileUrl = [NSURL fileURLWithPath:filePath];
    
    _audioPlayer = [[AVAudioPlayer alloc] initWithContentsOfURL:fileUrl error:nil];
    
    _audioPlayer.numberOfLoops = -1;
    
    [_audioPlayer play];
}

- (void)walkGile {
    NSMutableArray *animationsArray = [NSMutableArray array];
    for (int i = 1; i <= 3; i++) {
        NSString *imageName = [NSString stringWithFormat:@"player_right_%d.png",i];
        [animationsArray addObject:[UIImage imageNamed:imageName]];
    }
    _gileImageView.animationImages = animationsArray;
    _gileImageView.animationDuration = 1.5;
    [_gileImageView startAnimating];
    
}

- (void)createView {
    UIImageView *imageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, width(self.view.frame), height(self.view.frame))];
    
    imageView.userInteractionEnabled = YES;
    
    NSString *imagePath = [[NSBundle mainBundle] pathForResource:@"32fcf66ca7366583d96c3b98fc007c84" ofType:@"jpeg"];
    imageView.image = [UIImage imageWithContentsOfFile:imagePath];
    
    
    UILabel *titleLabel = [[UILabel alloc] initWithFrame:CGRectMake((width(imageView.frame)-200)/2, 50, 200, 150)];
    titleLabel.text = @"HERO";
    titleLabel.numberOfLines = 0;
    titleLabel.textAlignment = NSTextAlignmentCenter;
    titleLabel.font = [UIFont boldSystemFontOfSize:30];
    [imageView addSubview:titleLabel];
    
    _button = [UIButton buttonWithType:UIButtonTypeCustom];
    _button.frame = CGRectMake(0, 0, 120, 120);
    _button.center = self.view.center;
    _button.backgroundColor = [UIColor grayColor];
    [_button setTitle:@"开始" forState:UIControlStateNormal];
    [_button setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    _button.titleLabel.font = [UIFont boldSystemFontOfSize:30];
    _button.layer.cornerRadius = 60.0;
    [imageView addSubview:_button];
    
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    button.frame = CGRectMake(minX(_button), minY(_button)-10, 120, 140);
    [button addTarget:self action:@selector(buttonAction:) forControlEvents:UIControlEventTouchUpInside];
    [imageView addSubview:button];
    
    UIImageView *ZZImageView = [[UIImageView alloc] initWithFrame:CGRectMake((width(self.view.frame)-100)/2, height(self.view.frame)-150, 100, 150)];
    ZZImageView.image = [UIImage imageNamed:@"bg"];
    [imageView addSubview:ZZImageView];
    
    UIButton *helpButton = [[UIButton alloc] initWithFrame:CGRectMake(50, midY(ZZImageView), 30, 30)];
    helpButton.backgroundColor = [UIColor colorWithRed:0 green:0 blue:0 alpha:0.3];
    [helpButton setImage:[UIImage imageNamed:@"help"] forState:UIControlStateNormal];
    [helpButton addTarget:self action:@selector(helpButtonClick:) forControlEvents:UIControlEventTouchUpInside];
    helpButton.layer.cornerRadius = 15;
    [imageView addSubview:helpButton];
    
    UIButton *musicButton = [[UIButton alloc] initWithFrame:CGRectMake(50, midY(ZZImageView)-45, 30, 30)];
    musicButton.backgroundColor = [UIColor colorWithRed:0 green:0 blue:0 alpha:0.3];
    [musicButton setImage:[UIImage imageNamed:@"sound-alt"] forState:UIControlStateNormal];
    [musicButton addTarget:self action:@selector(musicButtonClick:) forControlEvents:UIControlEventTouchUpInside];
    musicButton.layer.cornerRadius = 15;
    [imageView addSubview:musicButton];
    
    
    _gileImageView = [[UIImageView alloc] initWithFrame:CGRectMake(midX(ZZImageView)-10, minY(ZZImageView)-20, 20, 20)];
    _gileImageView.image = [UIImage imageNamed:@"player_right_1"];
    [imageView addSubview:_gileImageView];
    
    [self.view addSubview:imageView];
    
    _pading = 20;
    _timer = [NSTimer scheduledTimerWithTimeInterval:2 target:self selector:@selector(timerAction) userInfo:nil repeats:YES];
    [_timer setFireDate:[NSDate distantPast]];
    
}

- (void)helpButtonClick:(UIButton *)button {
    HelpViewController *helpView = [HelpViewController new];
    helpView.modalTransitionStyle = UIModalPresentationFormSheet;
    [self presentViewController:helpView animated:YES completion:^{
        
    }];
}

- (void)musicButtonClick:(UIButton *)button {
    if (_open) {
        [button setImage:[UIImage imageNamed:@"soundoff"] forState:UIControlStateNormal];
        
        if (_audioPlayer.isPlaying) {
            [_audioPlayer pause];
        }
        
    } else {
        [button setImage:[UIImage imageNamed:@"sound-alt"] forState:UIControlStateNormal];
        
        if (!_audioPlayer.isPlaying) {
            [_audioPlayer play];
        }
        
    }
    _open = !_open;
}



- (void)timerAction {
    _pading = _pading*(-1);
    [UIView animateWithDuration:2 animations:^{
        _button.transform = CGAffineTransformTranslate(_button.transform, 0, _pading);
    }];
}

- (void)buttonAction:(UIButton *)button {
    PlayViewController *playView = [PlayViewController new];
    playView.modalTransitionStyle = UIModalPresentationFormSheet;
    [self presentViewController:playView animated:YES completion:^{
        
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
