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
#import "PureLayout.h"

@interface AKTextViewController ()
@property (nonatomic, strong) AKTextView *textView;
@end

@implementation AKTextViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self comInit];
    [self styleInit];
}

- (void)comInit {
    _textView = [[AKTextView alloc] initWithFrame:CGRectMake(0, 100, CGRectGetWidth(self.view.bounds), 400)];
    [self.view addSubview:_textView];
    
    UIButton *speechBtn = [UIButton buttonWithType:UIButtonTypeSystem];
    [speechBtn setTitle:@"读取文字" forState:UIControlStateNormal];
    [speechBtn addTarget:self action:@selector(onSpeechClick) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:speechBtn];
    speechBtn.frame = CGRectMake(0, 500, 100, 30);

}

- (void)styleInit {
    self.view.backgroundColor = [UIColor whiteColor];
    _textView.backgroundColor = [UIColor yellowColor];
}


- (void)onSpeechClick {
    AKSpeechModel *item = [AKSpeechModel new];
    item.contentText = _textView.text;
    item.language = @"zh-CN";
    item.pitchMultiPlier = 1.0f;
    [[AKSpeechMgr shared] speechWithItem:item complete:^(AVSpeechSynthesizer *synthesizer, AVSpeechUtterance *utterance, NSRange characterRange, AKASpeechDelegateType type) {
        NSLog(@"type :%ld , speech noew content : %@",type,[utterance.speechString substringWithRange:characterRange]);
    }];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}


@end
