//
//  AKTextViewController.m
//  AKAudioNoteBook
//
//  Created by Aka on 2017/9/7.
//  Copyright © 2017年 Aka. All rights reserved.
//

#import "AKTextViewController.h"
#import "AKTextView.h"
#import "AKSpeechMgr.h"
#import "AKSpeechModel.h"
#import "MSLog.h"

@interface AKTextViewController ()

@property (nonatomic, strong) AKTextView *textView;
@property (nonatomic, strong) UITextField *titletextField;

@property (nonatomic, strong) UIButton *readBtn;
@property (nonatomic, strong) UIButton *saveBtn;

@end

@implementation AKTextViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self comInit];
    [self styleInit];
    [self textInit];
}

- (void)textInit {
    self.title = @"文字的标题";
}

- (void)comInit {
    
    self.automaticallyAdjustsScrollViewInsets = NO;
    _textView = [AKTextView newAutoLayoutView];
    [self.view addSubview:_textView];
    [_textView autoPinEdgesToSuperviewEdgesWithInsets:UIEdgeInsetsMake(40.f, 0.f, 40.f, 0.f)];
    
    UIButton *speechBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    speechBtn.translatesAutoresizingMaskIntoConstraints = NO;
    [speechBtn setTitle:@"读取文字" forState:UIControlStateNormal];
    [speechBtn addTarget:self action:@selector(onSpeechClick) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:speechBtn];
    _readBtn = speechBtn;
    [speechBtn autoPinEdge:ALEdgeLeft toEdge:ALEdgeLeft ofView:speechBtn.superview];
    [speechBtn autoPinEdge:ALEdgeBottom toEdge:ALEdgeBottom ofView:speechBtn.superview];
    
    _titletextField = [UITextField new];
    _titletextField.frame = CGRectMake(0, 64, CGRectGetWidth([UIScreen mainScreen].bounds), 36);
    [self.view addSubview:_titletextField];
    _titletextField.backgroundColor = [UIColor redColor];
    
    UIButton *saveBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [saveBtn setTitle:@"保存文件" forState:UIControlStateNormal];
    [saveBtn addTarget:self action:@selector(onSaveClick:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:saveBtn];
    _saveBtn = saveBtn;
    [saveBtn autoPinEdge:ALEdgeRight toEdge:ALEdgeRight ofView:saveBtn.superview];
    [saveBtn autoPinEdge:ALEdgeBottom toEdge:ALEdgeBottom ofView:saveBtn.superview];
    
}

- (void)styleInit {
    self.view.backgroundColor = [UIColor whiteColor];
    _textView.backgroundColor = [UIColor yellowColor];
    [_readBtn setTitleColor:[UIColor yellowColor] forState:UIControlStateNormal];
    _readBtn.backgroundColor = [UIColor redColor];
    [_saveBtn setTitleColor:[UIColor yellowColor] forState:UIControlStateNormal];
    _saveBtn.backgroundColor = [UIColor redColor];
}

#pragma mark -- click custom methods

- (void)onSpeechClick {
    MSLogD(@"读取文件");
    if (_textView.text.length <= 0) {
        return;
    }
    AKSpeechModel *item = [AKSpeechModel new];
    item.contentText = _textView.text;
    item.language = @"zh-CN";
    item.pitchMultiPlier = 1.0f;
    [[AKSpeechMgr shared] speechWithItem:item complete:^(AVSpeechSynthesizer *synthesizer, AVSpeechUtterance *utterance, NSRange characterRange, AKASpeechDelegateType type) {
        NSLog(@"type :%ld , speech noew content : %@",type,[utterance.speechString substringWithRange:characterRange]);
    }];
}

- (void)onSaveClick:(UIButton *)sender {
    MSLogD(@"保存文件");
//    存储在数据库里面；
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}


@end
