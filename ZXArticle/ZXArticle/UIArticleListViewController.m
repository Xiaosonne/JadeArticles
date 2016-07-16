//
//  UIArticleListViewController.m
//  ZXArticle
//
//  Created by MacHuicuitong on 16/7/14.
//  Copyright © 2016年 MacHuicuitong. All rights reserved.
//
#define PAGE_SIZE 10;
#import "UIArticleListViewController.h"
#import "ContentCell.h"
#import "UIArticleDetailViewController.h"
@interface UIArticleListViewController ()<UITableViewDelegate,UITableViewDataSource,UIScrollViewDelegate>
@property(nonatomic,strong) UITableView * tableView;
@property(nonatomic,strong) NSMutableArray* allContentModels;
@property(nonatomic) bool isLoadingData;
@property(nonatomic) int currentPage;
@end

@implementation UIArticleListViewController

- (void)viewDidLoad {
    [super viewDidLoad]; 
    self.tableView=[[UITableView alloc] init];
    self.tableView.backgroundColor=[UIColor whiteColor];
    self.tableView.frame=[[UIScreen mainScreen] bounds];
    [self.view addSubview:self.tableView];
    self.tableView.dataSource=self;
    self.tableView.delegate=self;
    self.allContentModels=[NSMutableArray array];
    self.currentPage=1;
    self.isLoadingData=true;
    NSString* where=[NSString stringWithFormat:@" order by UrlPic desc LIMIT %d,%d",(self.currentPage-1)*10,10];
    NSArray* arr= [ContentModel Select:GET_CONTENT_SELECT_SQL_WITH_WHEAR(where)];
    self.currentPage++;
    [self.allContentModels addObjectsFromArray:arr];
    self.isLoadingData=false;
    
}
#pragma mark tableview 每个分组内的数量
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.allContentModels.count;
}
#pragma mark tableview 每个cell长什么样
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    ContentCell * cell= [tableView dequeueReusableCellWithIdentifier:@"fuck"];
    ContentModel* cm=[self.allContentModels objectAtIndex:indexPath.row];
    if(cell==nil){
        cell=[[ContentCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"fuck"];
    }
    cell.Model=cm;
    return cell;
}
#pragma mark tableview每一行的行高
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return ((ContentModel *)[self.allContentModels objectAtIndex:indexPath.row]).heightForRow;
}
#pragma mark tableview 选择某一行的时候
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    ContentModel * cm=[self.allContentModels objectAtIndex:indexPath.row];
    [cm LoadSubParagraph];
    UIArticleDetailViewController * view=[[UIArticleDetailViewController alloc] init];
    view.pContentModels=cm.pContentModels;
    view.conModel=cm;
    [self.navigationController pushViewController:view animated:YES];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark 滚动时候加载更多数据
- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    float allheight=scrollView.contentSize.height;
    float currentoffset=scrollView.contentOffset.y;
    float visualheight=scrollView.frame.size.height;
    if(self.isLoadingData==false){
        if(allheight*0.9<=(currentoffset+visualheight)){
            self.isLoadingData=true;
            NSString* where=[NSString stringWithFormat:@" LIMIT %d,%d",(self.currentPage-1)*10,10];
            NSArray* arr= [ContentModel Select:GET_CONTENT_SELECT_SQL_WITH_WHEAR(where)];
            self.currentPage++;
            [self.allContentModels addObjectsFromArray:arr];
            self.isLoadingData=false;
            [self.tableView reloadData];
        }
    }
}

@end
