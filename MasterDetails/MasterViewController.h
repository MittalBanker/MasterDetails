//
//  MasterViewController.h
//  MasterDetails
//
//  Created by mittal on 7/9/13.
//  Copyright (c) 2013 digicorp. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <MapKit/MapKit.h>
#import <MapKit/MKAnnotation.h>
@class ProfileViewController;
@class HomeListingViewController;
@interface MasterViewController : UIViewController<UITableViewDelegate,UITableViewDataSource,MKMapViewDelegate,UIPopoverControllerDelegate>
{
    IBOutlet UIView *vw_master;
    IBOutlet UIView *vw_Listing;
    IBOutlet UINavigationController *nav_Listing;
    NSMutableArray *arrSearchTypes;
    UIPopoverController *_hiddenPopoverController;
    IBOutlet UIView *vw_main;
    UIPopoverController *popoverController;
    IBOutlet UIButton *btn_Vicinity;
    BOOL masterVisible;
    BOOL listingVisible;
    IBOutlet UITextField *txt_Currentlocation;
    IBOutlet UIImageView *img_NaviBar;
    IBOutlet UIView *vw_naviBar;
    IBOutlet UIButton *btn_filter;
    IBOutlet UIButton *btn_download;
    IBOutlet UIImageView *img_CurrentLocation;
    HomeListingViewController *home_View;
    
}
@property(nonatomic,retain)IBOutlet UIView *vw_master;
@property(nonatomic,retain)IBOutlet UIView *vw_main;
@property(nonatomic,retain)IBOutlet UIView *vw_Listing;
@property(nonatomic,retain)IBOutlet UINavigationController *nav_Listing;
@property(nonatomic,retain)NSMutableArray *arrSearchTypes;
@property(nonatomic,retain)UIPopoverController *popoverController;
@property(nonatomic,retain)HomeListingViewController *home_View;
@end
