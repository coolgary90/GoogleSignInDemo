//
//  DataManager.h
//  ICreative
//
//  Created by Simrandeep Singh on 10/11/16.
//  Copyright © 2016 Simrandeep Singh. All rights reserved.
//

#import "WebServiceResponse.h"

@interface DataManager : NSObject

@property (nonatomic, strong) NSArray* categoryList;
@property (nonatomic, assign) BOOL allowWifiDownload;

+ (DataManager*) sharedInstance;


- (void)loadInitialVideos:(void(^)(NSMutableArray*))completionblock;

- (void)getSearchResults:(NSString*)searchText withCompletionHandler:(void(^)(NSMutableArray*))completionBlock;


@end

