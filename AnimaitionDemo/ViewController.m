//
//  ViewController.m
//  AnimaitionDemo
//
//  Created by Brain on 2019/3/29.
//  Copyright © 2019 Brain. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()
@property (nonatomic,strong) UIScrollView * scroll;
@property (nonatomic,strong) UIView * pollView;/** 滚动view */
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self createScroll];
    [self createPollView];
    [self createLabel];
    [self animation];
}
-(void)createPollView{
    _pollView=[[UIView alloc]initWithFrame:CGRectMake(0, 0, _scroll.frame.size.width, _scroll.frame.size.height)];
    _pollView.backgroundColor=[UIColor whiteColor];
    [_scroll addSubview:_pollView];
    _pollView.userInteractionEnabled=YES;

}
-(void)createLabel{
    CGFloat x=0;
    CGFloat y=0;
    CGFloat w=100;
    CGFloat h=44;
    for (int i = 0 ; i<10; i++) {
        UILabel *label=[[UILabel alloc]init];
        label.frame=CGRectMake(x, y, w, h);
        label.backgroundColor=[UIColor clearColor];
        label.text=[NSString stringWithFormat:@"%i",i];
        label.textAlignment=NSTextAlignmentCenter;
        label.numberOfLines=0;
        label.textColor=[UIColor blackColor];
        label.font=[UIFont systemFontOfSize:16];
        label.tag=0;
        [_pollView addSubview:label];
        label.userInteractionEnabled=YES;
        UITapGestureRecognizer *tap=[[UITapGestureRecognizer alloc]init];
        [tap addTarget:self action:@selector(tap:)];
        [label addGestureRecognizer:tap];
        x+=w;
    }
    CGRect frame=_pollView.frame;
    frame.size.width=x;
    _pollView.frame=frame;
}
-(void)createScroll{
    _scroll=[[UIScrollView alloc]init];
    _scroll.backgroundColor=[UIColor grayColor];
    _scroll.frame=CGRectMake(0, 100, self.view.frame.size.width, 44);
    [self.view addSubview:_scroll];
    _scroll.userInteractionEnabled=YES;
    _scroll.contentSize=CGSizeMake(1000, 44);
}
-(void)tap:(UITapGestureRecognizer *)sender {
    UILabel *lab=(UILabel *)sender.view;
    NSLog(@"%@ lab tap",lab.text);
}
-(void)animation{
    __weak typeof(self) ws = self;
    CGFloat x=_pollView.frame.origin.x-100;
    //UIViewAnimationOptionAllowUserInteraction 允许在动画时进行交互
    [UIView animateWithDuration:0.5 delay:0 options:(UIViewAnimationOptionAllowUserInteraction|UIViewAnimationOptionCurveLinear) animations:^{
        ws.pollView.frame=CGRectMake(x, 0, ws.pollView.frame.size.width, ws.scroll.frame.size.height);
    } completion:^(BOOL finished) {
        if (x<=-ws.pollView.frame.size.width) {
            ws.pollView.frame=CGRectMake(0, 0, ws.pollView.frame.size.width, ws.scroll.frame.size.height);
        }
        [ws performSelector:@selector(animation) withObject:nil afterDelay:0.01];//相当于主动制造0.01s的停顿，用于获取到点击事件
    }];

}
@end
