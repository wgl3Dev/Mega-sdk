//
//  SettingsViewController.m
//  Demo
//
//  Created by Javier Navarro on 29/10/14.
//  Copyright (c) 2014 MEGA. All rights reserved.
//

#import "SettingsViewController.h"

@interface SettingsViewController ()

@property (weak, nonatomic) IBOutlet UILabel *userEmail;
@property (weak, nonatomic) IBOutlet UIImageView *userAvatar;

@end

@implementation SettingsViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.userEmail.text = [[MEGASdkManager sharedMEGASdk] myEmail];
    [self setUserAvatar];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Private Methods

- (void)setUserAvatar {
    
    MEGAUser *user = [[MEGASdkManager sharedMEGASdk] contactWithEmail:self.userEmail.text];
    NSString *destinationPath = [NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES) objectAtIndex:0];
    NSString *fileName = [self.userEmail.text stringByAppendingString:@".jpg"];
    NSString *destinationFilePath = [destinationPath stringByAppendingPathComponent:@"thumbs"];
    destinationFilePath = [destinationFilePath stringByAppendingPathComponent:fileName];
    BOOL fileExists = [[NSFileManager defaultManager] fileExistsAtPath:destinationFilePath];
    
    if (!fileExists) {
        [[MEGASdkManager sharedMEGASdk] getAvatarWithUser:user destinationFilePath:destinationFilePath delegate:self];
    } else {
        [self.userAvatar setImage:[UIImage imageNamed:destinationFilePath]];
        
        self.userAvatar.layer.cornerRadius = self.userAvatar.frame.size.width/2;
        self.userAvatar.layer.masksToBounds = YES;
    }
}

#pragma mark - MEGARequestDelegate

- (void)onRequestStart:(MEGASdk *)api request:(MEGARequest *)request {
}

- (void)onRequestFinish:(MEGASdk *)api request:(MEGARequest *)request error:(MEGAError *)error {
    if ([error type]) {
    }
    
    switch ([request type]) {
        case MEGARequestTypeAccountDetails: {
            break;
        }
            
        case MEGARequestTypeGetAttrUser: {
            [self setUserAvatar];
        }
            
        default:
            break;
    }
}

- (void)onRequestUpdate:(MEGASdk *)api request:(MEGARequest *)request {
}

- (void)onRequestTemporaryError:(MEGASdk *)api request:(MEGARequest *)request error:(MEGAError *)error {
}

@end