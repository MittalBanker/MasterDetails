//
//  AppDelegate.h
//  MasterDetails
//
//  Created by mittal on 7/9/13.
//  Copyright (c) 2013 digicorp. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "DetailsViewController.h"
@interface AppDelegate : UIResponder <UIApplicationDelegate>
{
    BOOL firstTimeLoad;
}
@property (strong, nonatomic) UIWindow *window;
@property(assign)BOOL firstTimeLoad;
@property (strong) UINavigationController *navController;
@property(nonatomic,retain)DetailsViewController *details_View;
@end
