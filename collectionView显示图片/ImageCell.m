//
//  ImageCell.m
//  collectionView显示图片
//
//  Created by 罗金明 on 15/9/8.
//  Copyright (c) 2015年 ming. All rights reserved.
//

#import "ImageCell.h"
#import "UIImageView+WebCache.h"
@interface ImageCell()
@property (weak, nonatomic) IBOutlet UIImageView *imgView;

@end
@implementation ImageCell

- (void)awakeFromNib {
    // Initialization code
    self.backgroundColor=[UIColor whiteColor];
}

-(void)setImgName:(NSString *)imgName{
    self.imgView.contentMode=UIViewContentModeScaleAspectFit;
//    NSLog(@"%@",imgName);

    [self.imgView sd_setImageWithURL:[NSURL URLWithString:imgName] placeholderImage:[UIImage imageNamed:@"me@2x.png"] options:SDWebImageLowPriority | SDWebImageRetryFailed|SDWebImageProgressiveDownload|SDWebImageDelayPlaceholder];
    
    

}
@end
