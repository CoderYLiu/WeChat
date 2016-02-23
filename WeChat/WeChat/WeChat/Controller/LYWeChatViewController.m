//
//  LYWeChatViewController.m
//  WeChat
//
//  Created by Y Liu on 16/2/23.
//  Copyright © 2016年 CoderYLiu. All rights reserved.
//

#import "LYWeChatViewController.h"

#import "LYConversationCell.h"
#import "LYConversation.h"

static NSString * const ID = @"WeChatCell";

@interface LYWeChatViewController () <UISearchBarDelegate>

/** 消息列表数据 */
@property (nonatomic, strong) NSMutableArray *data;

@property (nonatomic, strong) UISearchController *searchController;

@property (nonatomic, strong) UIBarButtonItem *navRightButton;

@end

@implementation LYWeChatViewController

#pragma mark - LifeCycle

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // 设置导航条
    [self setUpNavBar];
    
    // 设置TableView
    [self setUpTableView];
    
    // data
    [self loadNewData];
}

/**
 *  设置TableView
 */
- (void)setUpTableView {
    
    self.tableView.tableFooterView = [[UIView alloc] init];
    
    [self.tableView registerNib:[UINib nibWithNibName:NSStringFromClass([LYConversationCell class]) bundle:nil] forCellReuseIdentifier:ID];
    
    self.tableView.rowHeight = 63;
}

/**
 *  设置导航条
 */
- (void)setUpNavBar {
    // title
    self.navigationItem.title = @"微信";
    
}

#pragma mark - load Data
- (void) loadNewData {
    // 测试数据
    NSMutableArray *models = [[NSMutableArray alloc] initWithCapacity:10];
    LYConversation *item1 = [[LYConversation alloc] init];
    item1.from = [NSString stringWithFormat:@"项少羽"];
    item1.message = @"晨哥，天明又闯祸了！！";
    item1.avatarURL = [NSURL URLWithString:@"xsy.jpg"];
    item1.messageCount = 0;
    item1.date = [NSDate date];
    [models addObject:item1];
    self.data = models;
}


#pragma mark - <UITableViewDataSource>
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.data.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    LYConversationCell *cell = [tableView dequeueReusableCellWithIdentifier:ID];
    
    LYConversation *conversation = self.data[indexPath.row];
    
    cell.conversation = conversation;
    cell.topLineStyle = LYCellLineStyleNone;
    
    if (indexPath.row == self.data.count - 1) {
        cell.bottomLineStyle = LYCellLineStyleFill;
    } else {
        cell.bottomLineStyle = LYCellLineStyleDefault;
    }
    
    return cell;
}

- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    return YES;
}

- (NSString *)tableView:(UITableView *)tableView titleForDeleteConfirmationButtonForRowAtIndexPath:(NSIndexPath *)indexPath {
    return @"删除";
}

- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        [self.data removeObjectAtIndex:indexPath.row];
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationAutomatic];
    }
}

#pragma mark - <UITableViewDelegate>

#pragma mark - Event Response
- (void)navRightButtonDown {
    NSLog(@"%s", __func__);
}

#pragma mark - <UISearchBarDelegate>
- (void)searchBar:(UISearchBar *)searchBar textDidChange:(NSString *)searchText {
    self.tabBarController.tabBar.hidden = YES;
}

- (void)searchBarCancelButtonClicked:(UISearchBar *)searchBar {
    self.tabBarController.tabBar.hidden = NO;
}

#pragma mark - Getter and Setter
- (UIBarButtonItem *)navRightButton {
    if (!_navRightButton) {
        _navRightButton = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"barbuttonicon_add"] style:UIBarButtonItemStylePlain target:self action:@selector(navRightButtonDown)];
    }
    return _navRightButton;
}




@end
