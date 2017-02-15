//
//  ViewController.h
//  GoogleSignInDemo
//
//  Created by Amanpreet Singh on 14/02/17.
//  Copyright © 2017 Amanpreet Singh. All rights reserved.
//
#import <GoogleSignIn/GoogleSignIn.h>
#import <FBSDKLoginKit/FBSDKLoginKit.h>
#import <UIKit/UIKit.h>

@interface ViewController : UIViewController <GIDSignInDelegate,GIDSignInUIDelegate,FBSDKLoginButtonDelegate>

@property(weak, nonatomic) IBOutlet UILabel* userName;
@property(weak, nonatomic) IBOutlet UILabel* userEmail;
@property(weak, nonatomic) IBOutlet UILabel* googleSignIn;
@property(weak ,nonatomic) IBOutlet UIImageView* userImage;
@property(weak, nonatomic) IBOutlet GIDSignInButton* SignInBtn;
@property(weak, nonatomic) IBOutlet UIButton* logOutBtn;









@end

