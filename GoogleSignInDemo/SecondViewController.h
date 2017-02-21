//
//  SecondViewController.h
//  GoogleSignInDemo
//
//  Created by Amanpreet Singh on 15/02/17.
//  Copyright © 2017 Amanpreet Singh. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "YTPlayerView.h"

@interface SecondViewController : UIViewController < UITableViewDelegate , UITableViewDataSource ,YTPlayerViewDelegate,UISearchBarDelegate>

@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (weak, nonatomic) IBOutlet UISearchBar *seacrhbar;
//@property (weak, nonatomic) IBOutlet NSLayoutConstraint *playerwidth;
//@property (weak, nonatomic) IBOutlet NSLayoutConstraint *playerHeight;


@end
