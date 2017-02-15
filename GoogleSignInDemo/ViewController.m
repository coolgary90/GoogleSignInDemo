//
//  ViewController.m
//  GoogleSignInDemo
//
//  Created by Amanpreet Singh on 14/02/17.
//  Copyright © 2017 Amanpreet Singh. All rights reserved.
//
#import "UIImageView+WebCache.h"
#import "ViewController.h"
#import <FBSDKCoreKit/FBSDKCoreKit.h>
#import <FBSDKLoginKit/FBSDKLoginKit.h>

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [GIDSignIn sharedInstance].uiDelegate = self;
    [GIDSignIn sharedInstance].delegate =self;
    [GIDSignIn sharedInstance].shouldFetchBasicProfile=TRUE;
    self.SignInBtn.hidden = NO;
    self.logOutBtn.hidden=YES;
    FBSDKLoginButton* button = [[FBSDKLoginButton alloc]init];
    button.delegate = self;
    button.translatesAutoresizingMaskIntoConstraints = YES;
    button.frame = CGRectMake(self.SignInBtn.frame.origin.x, self.SignInBtn.frame.origin.y+self.SignInBtn.frame.size.height+20, self.SignInBtn.frame.size.width+35, self.SignInBtn.frame.size.height);
    button.readPermissions=@[@"public_profile", @"email"];
    [self.view addSubview:button];
    

    if([GIDSignIn sharedInstance].hasAuthInKeychain)
    {
        [[GIDSignIn sharedInstance]signInSilently];

        NSLog(@"Already Login");
        self.SignInBtn.hidden = YES;
        
    }
    else
    {
        self.SignInBtn.hidden = NO;
        
    }
    
    self.userName.hidden=YES;
    self.userEmail.hidden=YES;

    // Do any additional setup after loading the view, typically from a nib.
}


 - (void)viewWillAppear:(BOOL)animated
{
    }

- (void)signInWillDispatch:(GIDSignIn *)signIn error:(NSError *)error {
    
    if(signIn.currentUser)
    {
        NSLog(@"Already signed In");
    }
   
}

 -(void)signIn:(GIDSignIn *)signIn didSignInForUser:(GIDGoogleUser *)user withError:(NSError *)error
{
    NSString* userEmail = user.profile.email;
    NSString* userName  = user.profile.name;
    NSLog(@"User Email- %@ and User name - %@",userEmail,userName);
    self.userName.hidden=NO;
    self.userEmail.hidden=NO;
    self.googleSignIn.hidden=YES;
    self.userEmail.text = [NSString stringWithFormat:@"Email - %@",userEmail];
    self.userName.text = [NSString stringWithFormat:@"Name - %@",userName];
    
    if(user.profile.hasImage)
    {
        NSURL* url =[user.profile imageURLWithDimension:100];
        [self.userImage sd_setImageWithURL:url placeholderImage:nil];
        self.userImage.layer.cornerRadius = self.userImage.frame.size.height/2;
        self.userImage.clipsToBounds=YES;

        
        
    }
    self.SignInBtn.hidden = YES;
    self.logOutBtn.hidden=NO;



}


- (void)signIn:(GIDSignIn *)signIn
didDisconnectWithUser:(GIDGoogleUser *)user
     withError:(NSError *)error {
    // Perform any operations when the user disconnects from app here.
    // ...
}

- (IBAction)logOutClicked:(id)sender
{
    [[GIDSignIn sharedInstance] signOut];
    
    self.SignInBtn.hidden = NO;
    self.googleSignIn.hidden = NO;
    self.userName.hidden = YES;
    self.userEmail.hidden = YES;
    self.logOutBtn.hidden = YES;
}



- (void)  loginButton:(FBSDKLoginButton *)loginButton
didCompleteWithResult:(FBSDKLoginManagerLoginResult *)result
                error:(NSError *)error
{
    
    
    if([FBSDKAccessToken currentAccessToken])
    {
        [[[FBSDKGraphRequest alloc] initWithGraphPath:@"me" parameters:@{@"fields": @"email,name,first_name"}]
         startWithCompletionHandler:^(FBSDKGraphRequestConnection *connection, id result, NSError *error) {
             if (!error) {
                 
                 NSString *userImageURL = [NSString stringWithFormat:@"https://graph.facebook.com/%@/picture?type=small", [FBSDKAccessToken currentAccessToken].userID];

                 NSLog(@"fetched user:%@", result);
                 NSLog(@"%@",result[@"email"]);
                 self.userName.hidden=NO;
                 self.userEmail.hidden=NO;
                 self.googleSignIn.hidden=YES;
                 self.userEmail.text = [NSString stringWithFormat:@"Email - %@",result[@"email"]];
                 self.userName.text = [NSString stringWithFormat:@"Name - %@",result[@"name"]];
                 [self.userImage sd_setImageWithURL:[NSURL URLWithString:userImageURL] placeholderImage:nil];
                 self.SignInBtn.hidden=YES;

                 
             }
         }];
    }

}


-(void)loginButtonDidLogOut:(FBSDKLoginButton *)loginButton
{
    self.userName.hidden=YES;
    self.userEmail.hidden=YES;
    self.SignInBtn.hidden=NO;
    
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
