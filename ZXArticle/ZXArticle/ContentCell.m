//
//  ContentCell.m
//  ZXArticle
//
//  Created by MacHuicuitong on 16/7/14.
//  Copyright © 2016年 MacHuicuitong. All rights reserved.
//

#import "ContentCell.h"
#import "ContentModel.h"

@implementation ContentCell

- (void)awakeFromNib {
    // Initialization code
}
-(void) setModel:(ContentModel*) model
{
    self.headLable.text=model.Head;
    self.despLable.text=model.Description;
    self.headLable.frame=CGRectMake(model.headRect.origin.x, model.headRect.origin.y, model.headRect.size.width, model.headRect.size.height);
    self.cellImageView.frame=CGRectMake(model.imgRect.origin.x, model.imgRect.origin.y, model.imgRect.size.width, model.imgRect.size.height);
    self.despLable.frame=CGRectMake(model.despRect.origin.x, model.despRect.origin.y, model.despRect.size.width, model.despRect.size.height);
    if (model.loadImgCompleted==YES) {
        
        self.cellImageView.image=[[UIImage alloc] initWithData:model.imgRowData];
    }
    //[name measureTextWithFont:fontWithSize(fsize) inSize:size(w, MAXFLOAT)]
}
-(instancetype) initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    if(self=[super initWithStyle:style reuseIdentifier:reuseIdentifier])
    {
        self.cellImageView=[[UIImageView alloc] initWithFrame:CGRectMake(10, 10, 100, 100)];
        self.headLable=[[UILabel alloc] initWithFrame:CGRectMake(10, 10, 200, 50)];
        self.headLable.numberOfLines=0;
        self.headLable.lineBreakMode=NSLineBreakByWordWrapping;
        self.headLable.font=[UIFont systemFontOfSize:20];
        self.despLable=[[UILabel alloc] initWithFrame:CGRectMake(10, 70, 200, 200)];
        self.despLable.numberOfLines=0;
        self.despLable.lineBreakMode=NSLineBreakByWordWrapping;
        self.despLable.font=[UIFont systemFontOfSize:15];
        [self addSubview:self.headLable];
        [self addSubview:self.despLable];
        [self addSubview:self.cellImageView];
    }
    return self;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
