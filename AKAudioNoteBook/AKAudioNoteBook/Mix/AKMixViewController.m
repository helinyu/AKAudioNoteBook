//
//  AKMixViewController.m
//  AKAudioNoteBook
//
//  Created by Aka on 2017/9/7.
//  Copyright © 2017年 Aka. All rights reserved.
//

#import "AKMixViewController.h"
#import "AKMainCategory.h"
#import "AKTextViewController.h"

@interface AKMixViewController ()<UITableViewDataSource,UITableViewDelegate>

@property (nonatomic, strong) UITableView *tableView;

@property (nonatomic, strong) NSArray *dataSources;

@end

static NSString *const reuseMixTableViewCellIdentifier = @"reuse.mix.table.cell.identifier";

@implementation AKMixViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    [self comInit];
    [self textInit];
}

- (void)comInit {
    _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 64, CGRectGetWidth([UIScreen mainScreen].bounds), CGRectGetHeight([UIScreen mainScreen].bounds)-64) style:UITableViewStylePlain];
    [self.view addSubview:_tableView];
    [_tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:reuseMixTableViewCellIdentifier];
    _tableView.dataSource  = self;
    _tableView.delegate = self;
    
    if (@available(iOS 11.0, *)) {
        self.tableView.contentInsetAdjustmentBehavior =UIScrollViewContentInsetAdjustmentNever;
    } else {
        // Fallback on earlier versions
        self.automaticallyAdjustsScrollViewInsets = NO;
    }

    UIBarButtonItem *rightBarBtn = [[UIBarButtonItem alloc] initWithTitle:@"创建文件" style:UIBarButtonItemStylePlain target:self action:@selector(onCreateFileClick)];
    self.navigationController.navigationBar.topItem.rightBarButtonItem = rightBarBtn;
}

- (void)textInit {
    self.title = @"文件(夹)混合";
    _dataSources = @[@"创建文件"];
}

#pragma mark -- custom  click methods

- (void)onCreateFileClick {
    
}

#pragma mark -- tableView datasource

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return _dataSources.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:reuseMixTableViewCellIdentifier forIndexPath:indexPath];
    cell.textLabel.text = _dataSources[indexPath.row];
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 80.f;
}

#pragma mark --table delegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.row == 0) {
        [self.navigationController pushViewController:[AKTextViewController new] animated:YES];
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

@end
