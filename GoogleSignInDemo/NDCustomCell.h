//
//  NDCustomCell.h
//  NewsDemo
//
//  Created by Amanpreet singh on 06/02/17.
//  Copyright © 2017 Amanpreet Singh. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "VideosElement.h"

@interface NDCustomCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UILabel* videoTitle;
@property (weak, nonatomic) IBOutlet UIImageView* videoImage;
@property (weak, nonatomic) IBOutlet UILabel* videoChannel;



- (void)loadCellData:(VideosElement*)VideosElementObj;

@end
