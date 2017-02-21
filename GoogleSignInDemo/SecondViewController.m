//
//  SecondViewController.m
//  GoogleSignInDemo
//
//  Created by Amanpreet Singh on 15/02/17.
//  Copyright © 2017 Amanpreet Singh. All rights reserved.
//
#import "NDCustomCell.h"
#import "SecondViewController.h"
#import "UIImageView+WebCache.h"
#import "DataManager.h"
#import "YTPlayerView.h"


@interface SecondViewController (){
    YTPlayerView* player;
    UIButton* cancelButton;
    DataManager* dataManagerObj;
    NSArray* videoSearched;
    UISwipeGestureRecognizer* gestureLeft;
    UISwipeGestureRecognizer* gestureDown;

    
}

@end

@implementation SecondViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self loadInitialData];
   
    
}

-(void)loadInitialData
{
    dataManagerObj = [DataManager sharedInstance];
    [dataManagerObj loadInitialVideos:^(NSArray* video){
        videoSearched = [NSArray arrayWithArray:video];
        [self.tableView reloadData];
        
    }];
    
    
}



-(void)searchBar:(UISearchBar *)searchBar textDidChange:(NSString *)searchText
{
    [dataManagerObj getSearchResults:searchText withCompletionHandler:^(NSMutableArray* video){
        videoSearched = [NSArray arrayWithArray:video];
        [self.tableView reloadData];
        
    }];
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 120;
}
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [videoSearched count];
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    NDCustomCell* cell  = (NDCustomCell*)[tableView dequeueReusableCellWithIdentifier:@"CELL"];
    if(cell == nil)
    {
        cell = [[[NSBundle mainBundle]loadNibNamed:@"NDCustomCell" owner:self options:nil] objectAtIndex:0];
    }
    VideosElement* currentVideoObj = [videoSearched objectAtIndex:indexPath.row];
    [cell loadCellData:currentVideoObj];
    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    VideosElement* obj = [videoSearched objectAtIndex:indexPath.row];
if(obj.videoId == nil)
   {
    // do nothing
   }
else
    {
    [self removeExistingPlayer];
    player  =[[YTPlayerView alloc]init];
    player.delegate = self;
    player.frame =CGRectMake(0, 0, self.view.frame.size.width, 200);
    self.tableView.frame = CGRectMake(self.tableView.frame.origin.x, player.frame.origin.y+player.frame.size.height, self.tableView.frame.size.width, self.tableView.frame.size.height-200);
    [self.view addSubview:player];
    gestureDown = [[UISwipeGestureRecognizer alloc]initWithTarget:self action:@selector(swipe:) ];
    gestureDown.direction = UISwipeGestureRecognizerDirectionDown;
    [player addGestureRecognizer:gestureDown];
    gestureLeft = [[UISwipeGestureRecognizer alloc]initWithTarget:self action:@selector(swipe:) ];
    gestureLeft.direction = UISwipeGestureRecognizerDirectionLeft;
    [player addGestureRecognizer:gestureLeft];
    [player loadWithVideoId:obj.videoId];
    }
    
}

 - (void)removeExistingPlayer
{
    for(UIView* subView in self.view.subviews)
    {
        if([subView isKindOfClass:[YTPlayerView class]])
        {
            [subView removeFromSuperview];
        }
    }
}
-(void)playerViewDidBecomeReady:(YTPlayerView *)playerView
{
    [player playVideo];
}

- (void)playerView:(nonnull YTPlayerView *)playerView didChangeToState:(YTPlayerState)state
{
    
   
   if(kYTPlayerStatePlaying)
    {
        player.frame =CGRectMake(0, 0, self.view.frame.size.width, 200);
        self.tableView.frame = CGRectMake(0, 200, self.view.frame.size.width, self.view.frame.size.height-200);

    }
}

-(void)swipe:(UISwipeGestureRecognizer*)gestureDirection
{
    dispatch_async(dispatch_get_main_queue(), ^{
        
        if(gestureDirection.direction==UISwipeGestureRecognizerDirectionLeft)
        {
            [UIView animateWithDuration:0.5 animations:^{
            [self removeExistingPlayer];
            self.tableView.frame= CGRectMake(self.tableView.frame.origin.x, 60, self.tableView.frame.size.width, self.view.frame.size.height-50);
            }];

        }
        else
        {
            [UIView animateWithDuration:0.5 animations:^{
                
            
                player.frame=CGRectMake(self.view.frame.size.width-200, self.view.frame.size.height-200, 200, 200);
                self.tableView.frame= CGRectMake(self.tableView.frame.origin.x, 60, self.tableView.frame.size.width, self.view.frame.size.height-50);
                }];
        }
        
    });
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
