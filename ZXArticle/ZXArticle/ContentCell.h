//
//  ContentCell.h
//  ZXArticle
//
//  Created by MacHuicuitong on 16/7/14.
//  Copyright © 2016年 MacHuicuitong. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ContentModel.h"
@interface ContentCell : UITableViewCell
@property(strong,nonatomic) ContentModel* Model;
@property(strong,nonatomic) UILabel* headLable;
@property(strong,nonatomic) UILabel* despLable;
@property(strong,nonatomic) UIImageView* cellImageView;
@end
