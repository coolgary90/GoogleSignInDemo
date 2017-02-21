//
//  NDCustomCell.m
//  NewsDemo
//
//  Created by Amanpreet singh on 06/02/17.
//  Copyright © 2017 Amanpreet Singh. All rights reserved.
//

#import "NDCustomCell.h"

@implementation NDCustomCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
    

    // Configure the view for the selected state
}

- (void)loadCellData:(VideosElement*)VideosElementObj
{
    self.videoTitle.text = VideosElementObj.videoTitle;
    self.videoChannel.text = [NSString stringWithFormat:@"Channel %@",VideosElementObj.videoChannel];
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_HIGH, 2), ^
    {
        NSData* data = [NSData dataWithContentsOfURL:[NSURL URLWithString:VideosElementObj.videoThumbnail]];
        dispatch_async(dispatch_get_main_queue(), ^
                       {
                           self.videoImage.image = [UIImage imageWithData:data];
                       });
        
        
                       
    });
    
    
}

@end
