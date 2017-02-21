//
//  DataManager.m
//  ICreative
//
//  Created by Simrandeep Singh on 10/11/16.
//  Copyright © 2016 Simrandeep Singh. All rights reserved.
//

#import "WebServiceManager.h"
#import "VideosElement.h"
#import "Define.h"

#import "DataManager.h"

@interface DataManager ()

@property (nonatomic, strong) NSMutableArray* savedMediaList;

@end

@implementation DataManager

+ (instancetype)sharedInstance
{
    static dispatch_once_t once;
    static id sharedManager;
    dispatch_once(&once, ^{
        sharedManager = [[DataManager alloc] init];
    });
    return sharedManager;
}

- (id) init
{
    if (self = [super init])
    {
//		NSUserDefaults* standardUserDefaults = [NSUserDefaults standardUserDefaults];
//        NSData* userData = [standardUserDefaults objectForKey:@"USER_DATA"];
//        _user = [NSKeyedUnarchiver unarchiveObjectWithData:userData];
//		_allowWifiDownload = [[standardUserDefaults objectForKey:@"AllowWifiDownload"] boolValue];
    }
    return self;
}

#pragma mark


- (void)loadInitialVideos:(void(^)(NSMutableArray*))completionblock{
    
   
    NSURLRequest* request = [WebServiceManager getRequestWithService:kLoadInitialVideosUrl];
    
    [WebServiceManager sendRequest:request completion:^(WebServiceResponse* response){
        NSMutableArray* finalVideoList;
        NSDictionary* videojson  =[self dictFromJson:response.responseData];
        NSArray* receivedjsonArray = [videojson objectForKey:@"items"];
        finalVideoList = [[NSMutableArray alloc]init];
        for(NSDictionary* dict in receivedjsonArray)
        {
            [finalVideoList addObject:[VideosElement buildVideoElement:dict]];
        }
        completionblock(finalVideoList);
    }];

    
}



-(void)getSearchResults:(NSString*)searchText withCompletionHandler:(void(^)(NSMutableArray*))completionBlock;
{
    NSString* urlString = [kSearchvideoUrl stringByAppendingString:[NSString stringWithFormat:@"%@&part=snippet&maxResults=50&key=%@",searchText,kApiKey]];
    NSURLRequest* request = [WebServiceManager getRequestWithService:urlString];
    [WebServiceManager sendRequest:request completion:^(WebServiceResponse* response){
        NSMutableArray* finalVideoList;
        NSDictionary* videojson  =[self dictFromJson:response.responseData];
        NSArray* receivedjsonArray = [videojson objectForKey:@"items"];
        finalVideoList = [[NSMutableArray alloc]init];
        for(NSDictionary* dict in receivedjsonArray)
        {
            if([[dict objectForKey:@"snippet"]objectForKey:@"description"]!=nil)
            {
            [finalVideoList addObject:[VideosElement buildVideoElement:dict]];
            }
        }
        completionBlock(finalVideoList);
        
        
        
    }];
}

//- (void) getFeedListwithCallback:(void(^)(NSArray* feedList)) callback
//{
//    NSURLRequest* request = [WebServiceManager getAuthorizationRequestWithService:KFeedURL];
//    [WebServiceManager sendRequest:request completion:^(WebServiceResponse* response)
//    {
//        if (response.status)
//        {
//            NSDictionary* responseDict = [self dictFromJson:response.responseData];
//            MFLogPARSING(@"\n\n\nhere is my extracted response for feed list %@",responseDict);
//            NSDictionary* dict = [responseDict objectForKey:@"response"];
//            NSArray* dataArray = [dict objectForKey:@"data"];
//            NSMutableArray* feedList  = [[NSMutableArray alloc] init];
//            for (NSDictionary* data in dataArray)
//            {
//                [feedList addObject :
//                 [FeedElement buildFeedElementModelwithDictionary:data]];
//            }
//            
//            callback(feedList);
//        }
//        else
//        {
//            callback(nil);
//        }
//    }];
//}
//
//#pragma mark
//
//- (void) getCategoryListwithCallback:(void (^)(NSArray* categoryList))callback
//{
//    NSURLRequest* request = [WebServiceManager getAuthorizationRequestWithService:KCategoriesURL];
//    
//    [WebServiceManager sendRequest:request completion:^(WebServiceResponse* response)
//    {
//        if (response.status)
//        {
//            NSDictionary* responseDict = [self dictFromJson:response.responseData];
//            MFLogPARSING(@"\n\n\nhere is my extracted response for category list %@",responseDict);
//            NSDictionary* dict = [responseDict objectForKey:@"response"];
//            NSArray* dataArray = [dict objectForKey:@"data"];
//            NSMutableArray* categoryList  = [[NSMutableArray alloc] init];
//            for (NSDictionary* data in dataArray)
//            {
//                [categoryList addObject :
//                 [VideoCategory buildVideoCategoryModelWithDictionary:data]];
//            }
//            
//            _categoryList = categoryList;
//            callback(categoryList);
//        }
//        else
//        {
//            callback(nil);
//        }
//    }];
//}
//
//- (void) getVideoListforCategory:(NSString*)category withCallback:(void (^)(CategoryBasedData* categoryBasedData))callback
//{
//    NSURLRequest* request = [WebServiceManager getAuthorizationRequestWithService:[NSString stringWithFormat:@"%@/%@",KCategoryURL,category]];
//    [WebServiceManager sendRequest:request completion:^(WebServiceResponse* response)
//    {
//        if (response.status)
//        {
//            NSDictionary* dict = [self dictFromJson:response.responseData];
//            MFLogPARSING(@"\n\n\nhere is my extracted response for video list for categoryName %@ \n %@",category,dict);
//            CategoryBasedData* categoryBasedData = [CategoryBasedData buildCategoryBasedDataModelWithDictionary:dict];
//            callback(categoryBasedData);
//        }
//        else
//        {
//            callback(nil);
//        }
//    }];
//}
//
//#pragma mark
//
//- (void) sendSignUpRequestWithDetails:(SignUpForm*)signUpForm withCallback:(void (^)(WebServiceResponse *response))callback
//{
//    NSURLRequest* request = [WebServiceManager postRequestWithService:kSignUpURL withpostDict:[signUpForm dictionaryRepresentationofSignUpForm]];
//    
//    [WebServiceManager sendRequest:request completion:^(WebServiceResponse* response)
//    {
//        if (response.status)
//        {
//            NSDictionary* dict = [self dictFromJson:response.responseData];
//			MFLogPARSING(@"\n\n\nhere is my extracted response for Login IN \n %@ ",dict);
//			_user = [User buildUserModelwithDictionary:dict];
//			[self saveUserData];
//        }
//        callback(response);
//
//    }];
//}
//
//- (void) sendLogInRequestWithDetails:(NSDictionary*)dict withCallback:(void (^)(WebServiceResponse* response))callback
//{
//    NSURLRequest* request = [WebServiceManager postRequestWithService:kLogInURL  withpostDict:dict];
//    
//    [WebServiceManager sendRequest:request completion:^(WebServiceResponse* response)
//    {
//        if (response.status)
//        {
//            NSDictionary* dict = [self dictFromJson:response.responseData];
//            MFLogPARSING(@"\n\n\nhere is my extracted response for Login IN \n %@ ",dict);
//            _user = [User buildUserModelwithDictionary:dict];
//            [self saveUserData];
//        }
//        callback(response);
//    }];
//}

//- (void) saveUserData
//{
//	NSUserDefaults* standardUserDefaults = [NSUserDefaults standardUserDefaults];
//	if (_user.token)
//	{
//		NSData* data = [NSKeyedArchiver archivedDataWithRootObject:_user];
//		[standardUserDefaults setObject:data forKey:@"USER_DATA"];
//	}
//	else
//	{
//		[standardUserDefaults setObject:nil forKey:@"USER_DATA"];
//	}
//	[standardUserDefaults synchronize];
//}
//
//- (void) sendLogOutRequest:(void (^)(WebServiceResponse* response))callback
//{
//    NSURLRequest* request = [WebServiceManager getAuthorizationRequestWithService:KLogOutURL];
//	[UIUtils showLoadingView:YES];
//    [WebServiceManager sendRequest:request completion:^(WebServiceResponse* response)
//    {
//        if (response.status)
//        {
//            NSDictionary* dict = [self dictFromJson:response.responseData];
//            MFLogPARSING(@"\n\n\nhere is my extracted response for Logout API \n %@ ",dict);
//        }
//		_user = nil;
//		[self saveUserData];
//		[UIUtils showLoadingView:NO];
//        callback(response);
//    }];
//}
//
//- (void) sendRefreshRequestWithCallback:(void (^)(WebServiceResponse* response))callback
//{
//    NSURLRequest* request = [WebServiceManager getAuthorizationRequestWithService:KRefreshURL];
//    
//    [WebServiceManager sendRequest:request completion:^(WebServiceResponse* response)
//    {
//        if(response.status)
//        {
//			NSDictionary* dict = [self dictFromJson:response.responseData];
//			MFLogPARSING(@"\n\n\nhere is my extracted response for Refresh API \n %@ ",dict);
//
//			NSDictionary* responseDict = [dict objectForKey:@"response"];
//			_user.token = [responseDict objectForKey:@"token"];
//	        [self saveUserData];
//        }
//        callback(response);
//    }];
//}
//
//#pragma mark -
//
//- (void) readSavedMediaData
//{
//	NSData* mediaData = [[NSUserDefaults standardUserDefaults]
//						objectForKey:@"SAVED_MEDIA"];
//	self.savedMediaList = [NSKeyedUnarchiver unarchiveObjectWithData:mediaData];
//	if (self.savedMediaList == nil)
//	{
//		self.savedMediaList = [[NSMutableArray alloc] init];
//	}
//}
//
//- (void) addMediaToSavedList:(Media*)media
//{
//	if (media == nil)
//		return;
//	
//	if (self.savedMediaList == nil)
//		[self readSavedMediaData];
//
//	[self.savedMediaList addObject:media];
//	[self saveMediaData];
//}
//
//- (void) deleteMediafromSavedList:(Media*)media
//{
//	[self.savedMediaList removeObject:media];
//	[self saveMediaData];
//}
//
//- (NSArray*) getMediaList
//{
//	if (self.savedMediaList == nil)
//		[self readSavedMediaData];
//
//	return self.savedMediaList;
//}

- (void) saveMediaData
{
	NSUserDefaults* standardUserDefaults = [NSUserDefaults standardUserDefaults];
	NSData* data = [NSKeyedArchiver archivedDataWithRootObject:self.savedMediaList];
	[standardUserDefaults setObject:data forKey:@"SAVED_MEDIA"];
	[standardUserDefaults synchronize];
}

- (void) setAllowWifiDownload:(BOOL)allowWifiDownload
{
	_allowWifiDownload = allowWifiDownload;
	NSUserDefaults* standardUserDefaults = [NSUserDefaults standardUserDefaults];
	[standardUserDefaults setObject:[NSNumber numberWithBool:_allowWifiDownload] forKey:@"AllowWifiDownload"];
	[standardUserDefaults synchronize];
}

#pragma mark -

- (NSDictionary*) dictFromJson: (NSData*) responseData
{
    NSDictionary* dictJ=[NSJSONSerialization JSONObjectWithData:responseData options:kNilOptions error:nil];
    return dictJ;
}

@end
