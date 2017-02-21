//
//  VideosElement.h
//  GoogleSignInDemo
//
//  Created by Amanpreet Singh on 20/02/17.
//  Copyright © 2017 Amanpreet Singh. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface VideosElement : NSObject

+(instancetype)buildVideoElement:(NSDictionary*)videosjson;

@property(strong, nonatomic) NSString* videoTitle;
@property(strong, nonatomic) NSString* videoThumbnail;
@property(strong, nonatomic) NSString* videoId;
@property(strong, nonatomic) NSString* videoChannel;





@end
