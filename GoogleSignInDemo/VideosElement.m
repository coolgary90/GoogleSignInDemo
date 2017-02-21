//
//  VideosElement.m
//  GoogleSignInDemo
//
//  Created by Amanpreet Singh on 20/02/17.
//  Copyright © 2017 Amanpreet Singh. All rights reserved.
//

#import "VideosElement.h"

@implementation VideosElement

+(instancetype)buildVideoElement:(NSDictionary*)videosjson{
    
    VideosElement* obj = [[VideosElement alloc]initWithArray:videosjson];
    return obj;
}

-(instancetype)initWithArray:(NSDictionary*)dict
{
    if(self = [super init])
{
    
    self.videoTitle = [[dict objectForKey:@"snippet"]objectForKey:@"title"];
    self.videoThumbnail = [[[[dict objectForKey:@"snippet"]objectForKey:@"thumbnails"] objectForKey:@"high"]objectForKey:@"url"];
    self.videoId = [[dict objectForKey:@"id"]objectForKey:@"videoId"];
    self.videoChannel = [[dict objectForKey:@"snippet"]objectForKey:@"channelTitle"];

    
}
    return self;

    
}

@end
