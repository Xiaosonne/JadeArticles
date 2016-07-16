//
//  UIArticleDetailViewController.m
//  ZXArticle
//
//  Created by MacHuicuitong on 16/7/14.
//  Copyright © 2016年 MacHuicuitong. All rights reserved.
//

#import "UIArticleDetailViewController.h" 
@interface UIArticleDetailViewController ()<UITableViewDataSource,UITableViewDelegate>
@property(nonatomic,strong) UITableView * tableView;

@end

@implementation UIArticleDetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor=[UIColor whiteColor];
    self.tableView=[[UITableView alloc] initWithFrame:self.view.frame];
    self.tableView.delegate=self;
    self.tableView.dataSource=self;
    [self.view addSubview:self.tableView];
    self.navigationItem.title=self.conModel.Head;
    self.tableView.separatorStyle=UITableViewCellSeparatorStyleNone;
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark tableview 每个分组内的数量
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.pContentModels.count;
}
#pragma mark tableview 每个cell长什么样
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell  * cell= [tableView dequeueReusableCellWithIdentifier:@"fuck"];
    PcontentModel* cm=[self.pContentModels objectAtIndex:indexPath.row];
    if(cell==nil){
        cell=[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"fuck"];
    }
    cell.textLabel.text=@"1";
    cell.textLabel.numberOfLines=0;
    cell.textLabel.lineBreakMode=NSLineBreakByWordWrapping;
    cell.textLabel.frame=CGRectMake(10, 10, self.view.frame.size.width, cm.rowHeight);
    cell.textLabel.text=cm.Content;
    cell.textLabel.font=[UIFont systemFontOfSize:14];
    return cell;
}
#pragma mark tableview每一行的行高
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return ((PcontentModel*)[self.pContentModels objectAtIndex:indexPath.row]).rowHeight;
}

@end
