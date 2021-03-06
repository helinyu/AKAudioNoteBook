//
//  ViewController.m/Users/felix/AKAudioNoteBook/AKAudioNoteBook/AKAudioNoteBook/Catalog
//  AKAudioNoteBook
//
//  Created by Aka on 2017/9/6.
//  Copyright © 2017年 Aka. All rights reserved.
//

#import "ViewController.h"
#import "AKMainCategory.h"
#import "AKMixViewController.h"

@interface ViewController ()<UITableViewDelegate,UITableViewDataSource>

@property (nonatomic, strong) UITableView *tableView;

@property (nonatomic, strong) NSArray<AKMainCategory *> *datasources;

@end

// cell 最好是自己去自定义的
static NSString *const reuseTableViewCellIdentifier = @"reuse.table.cell.identifier";

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self comInit];
}

- (void)comInit {
    
    _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, CGRectGetWidth([UIScreen mainScreen].bounds), CGRectGetHeight([UIScreen mainScreen].bounds)) style:UITableViewStylePlain];
    [self.view addSubview:_tableView];
    [_tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:reuseTableViewCellIdentifier];
    _tableView.dataSource  = self;
    _tableView.delegate = self;
    
    if (@available(iOS 11.0, *)) {
        self.tableView.contentInsetAdjustmentBehavior =UIScrollViewContentInsetAdjustmentNever;
    } else {
        // Fallback on earlier versions
        self.automaticallyAdjustsScrollViewInsets = NO;
    }
    
    UIBarButtonItem *rightBarBtn = [[UIBarButtonItem alloc] initWithTitle:@"创建文件夹" style:UIBarButtonItemStylePlain target:self action:@selector(onCreateFolderClick)];
    self.navigationController.navigationBar.topItem.rightBarButtonItem = rightBarBtn;
    
    
}

#pragma mark -- click
- (void)onCreateFolderClick {
//    test
    [self.navigationController pushViewController:[AKMixViewController new] animated:YES];
}


#pragma mark -- tableView datasource

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return _datasources.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:reuseTableViewCellIdentifier forIndexPath:indexPath];
    AKMainCategory *category = _datasources[indexPath.row];
//    cell.selectionStyle = UITableViewCellStyleDefault;
    cell.textLabel.text = category.title;
    cell.detailTextLabel.text = category.description;
    cell.image = category.firstImg;
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 80.f;
}

#pragma mark --table delegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    NSLog(@"选择对应的内容：%@",indexPath);
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}


@end
