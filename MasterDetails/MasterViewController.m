//
//  MasterViewController.m
//  MasterDetails
//
//  Created by mittal on 7/9/13.
//  Copyright (c) 2013 digicorp. All rights reserved.
//

#import "MasterViewController.h"
#import "ProfileViewController.h"
#import "HomeListingViewController.h"
#define kMenuFullWidth_Portrait 768.0f
#define kMenuFullWidth_Landscape 1024.0f
#define kMenuSlideDuration .3f
#define kMenuOrigin -153
#define kMenuListingOriginForPortrait 768
#define kMenuListingOriginForLandscape 1024
#define kMenuListingWidth 278
#define kMenuVicinityOriginPortraitIfListing 278
#define kMenuVicinityOriginPortraitIfMaster 556
#define kMenuVicinityOriginLandscapeIfListing 428
#define kMenuVicinityOriginLandscapeIfMaster 278
#define kMenuVicinityY 56
#define kMenuVicinityY 56
#define kMenuListingHeightPortrait 1004
#define kMenuListingHeightLandscape 768

@interface MasterViewController ()

@end

@implementation MasterViewController

@synthesize vw_master,vw_Listing,vw_main,popoverController,arrSearchTypes,home_View,nav_Listing;
- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    arrSearchTypes = [[NSMutableArray alloc ] init];
    
    [arrSearchTypes addObject:[NSDictionary dictionaryWithObjectsAndKeys:@"aquarium",@"searchtype",@"icon_aquarium.png",@"imagename",nil]];
    [arrSearchTypes addObject:[NSDictionary dictionaryWithObjectsAndKeys:@"bank",@"searchtype",@"icon_bank.png",@"imagename",nil]];
    [arrSearchTypes addObject:[NSDictionary dictionaryWithObjectsAndKeys:@"book_store",@"searchtype",@"icon_books.png",@"imagename",nil]];
    [arrSearchTypes addObject:[NSDictionary dictionaryWithObjectsAndKeys:@"cafe",@"searchtype",@"icon_cafe.png",@"imagename",nil]];
    [arrSearchTypes addObject:[NSDictionary dictionaryWithObjectsAndKeys:@"church",@"searchtype",@"icon_church.png",@"imagename",nil]];
    [arrSearchTypes addObject:[NSDictionary dictionaryWithObjectsAndKeys:@"hospital",@"searchtype",@"icon_hospital.png",@"imagename",nil]];
    [arrSearchTypes addObject:[NSDictionary dictionaryWithObjectsAndKeys:@"school",@"searchtype",@"icon_school.png",@"imagename",nil]];
    [arrSearchTypes addObject:[NSDictionary dictionaryWithObjectsAndKeys:@"restaurant",@"searchtype",@"icon_restuarant.png",@"imagename",nil]];
    [arrSearchTypes addObject:[NSDictionary dictionaryWithObjectsAndKeys:@"gas_station",@"searchtype",@"gas.png",@"imagename",nil]];
    
    CGRect newFrame = CGRectOffset(self.vw_main.frame, +(self.vw_master.frame.size.width), 0.0);
    self.vw_main.frame = newFrame;
    
    txt_Currentlocation.font = [UIFont fontWithName:@"DroidSans" size:15];
    masterVisible = TRUE;
    [self getPropertyListing];
    [vw_master setBackgroundColor:[UIColor clearColor]];
    
}
-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [[UIDevice currentDevice] beginGeneratingDeviceOrientationNotifications];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(detectOrientation) name:UIDeviceOrientationDidChangeNotification object:nil];
  }
-(void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
    [[NSNotificationCenter defaultCenter]removeObserver:self name:UIDeviceOrientationDidChangeNotification object:nil];
}
-(IBAction)showListing:(id)sender{
    
    [self toggleListing];
    
    
}
-(IBAction)showMaster:(id)sender{

    [self toggleListing];
}
-(IBAction)showHome:(id)sender{
    
    
    [self toggleMenuMaster];
    
}

-(IBAction)toggleMenuMaster
{
    
    [UIView beginAnimations:@"Menu Slide" context:nil];
    [UIView setAnimationDuration:0.5];
    if([UIApplication sharedApplication].statusBarOrientation == UIInterfaceOrientationLandscapeLeft || [UIApplication sharedApplication].statusBarOrientation == UIInterfaceOrientationLandscapeRight){
        vw_Listing.frame = CGRectMake(kMenuListingOriginForLandscape, 0, self.vw_Listing.frame.size.width, self.vw_Listing.frame.size.height);
    }
    else{
        vw_Listing.frame = CGRectMake(kMenuListingOriginForPortrait, 0, self.vw_Listing.frame.size.width, self.vw_Listing.frame.size.height);
        
    }
    if(self.vw_master.frame.origin.x == kMenuOrigin){
        self.vw_master.frame = CGRectMake(0, 0, self.vw_master.frame.size.width, self.vw_master.frame.size.height);
        
        CGRect newFrame = CGRectOffset(self.vw_main.frame, self.vw_master.frame.size.width, 0.0);
        self.vw_main.frame = newFrame;
        masterVisible = TRUE;
        listingVisible = FALSE;
            
    }
    else{
        self.vw_master.frame = CGRectMake(kMenuOrigin, 0, self.vw_master.frame.size.width, self.vw_master.frame.size.height);
        self.vw_main.frame = CGRectMake(0, 0, self.vw_main.frame.size.width, self.vw_main.frame.size.height);
        masterVisible = FALSE;
    }
    [self layoutSubviewsForInterfaceOrientation:[UIApplication sharedApplication].statusBarOrientation];
    [UIView commitAnimations];
    
}
-(void)getPropertyListing{
  
    home_View = [[HomeListingViewController alloc] initWithNibName:@"HomeListingViewController" bundle:nil];
    
    nav_Listing = [[UINavigationController alloc] initWithRootViewController:home_View];[self addChildViewController:nav_Listing];
    nav_Listing.view.frame = CGRectMake(kMenuListingOriginForPortrait, 0, kMenuListingWidth, kMenuListingHeightPortrait);
    
    
    self.vw_Listing = nav_Listing.view;
    nav_Listing.navigationBar.hidden = YES;
   
    if(self.interfaceOrientation==UIDeviceOrientationPortrait||self.interfaceOrientation==UIDeviceOrientationPortraitUpsideDown){
         nav_Listing.view.frame = CGRectMake(kMenuListingOriginForPortrait, 0, kMenuListingWidth, kMenuListingHeightPortrait);
    }
    else if(self.interfaceOrientation==UIDeviceOrientationLandscapeLeft||self.interfaceOrientation==UIDeviceOrientationLandscapeRight)
    {
         nav_Listing.view.frame = CGRectMake(kMenuListingOriginForLandscape, 0, kMenuListingWidth, kMenuListingHeightLandscape);
        
    }

    NSLog(@"%f %f %f %f",nav_Listing.view.frame.origin.x,nav_Listing.view.frame.origin.y,    nav_Listing.view.frame.size.height,    nav_Listing.view.frame.size.width );
   
    [self.view addSubview:nav_Listing.view];
    [nav_Listing didMoveToParentViewController:self];
}

-(IBAction)toggleListing
{
    
    [UIView beginAnimations:@"Menu Slide" context:nil];
    [UIView setAnimationDuration:0.5];
    
    if(self.vw_Listing.frame.origin.x == kMenuListingOriginForPortrait || self.vw_Listing.frame.origin.x == kMenuListingOriginForLandscape){
        CGRect newFrame = CGRectOffset(self.vw_Listing.frame, -(self.vw_Listing.frame.size.width), 0.0);
        self.vw_master.frame = CGRectMake(kMenuOrigin, 0, self.vw_master.frame.size.width, self.vw_master.frame.size.height);
        // CGRect newFrameMain = CGRectOffset(self.vw_main.frame, -(self.vw_Listing.frame.size.width), 0.0);
        self.vw_main.frame = CGRectMake(0, 0, self.vw_main.frame.size.width, self.vw_main.frame.size.height);;
        vw_Listing.frame = newFrame;
        listingVisible = TRUE;
        [self.view bringSubviewToFront:vw_Listing];
        masterVisible = FALSE;
        
    }
    else{
        
        CGRect newFrame = CGRectOffset(self.vw_main.frame, -(self.vw_Listing.frame.size.width), 0.0);
        self.vw_main.frame = newFrame;
        listingVisible = FALSE;
    }
    [self layoutSubviewsForInterfaceOrientation:[UIApplication sharedApplication].statusBarOrientation];
    [UIView commitAnimations];
}
//show the profile
-(IBAction)showProfile:(id)sender{
    ProfileViewController *profileController = [[ProfileViewController alloc] initWithNibName:@"ProfileViewController" bundle:nil];
    
    UINavigationController *navigationController = [[UINavigationController alloc]
                                                    initWithRootViewController:profileController];
    
    navigationController.modalPresentationStyle = UIModalPresentationFormSheet;
    navigationController.navigationBarHidden = TRUE;
    navigationController.modalTransitionStyle = UIModalTransitionStyleFlipHorizontal;
    [self presentViewController:navigationController animated:YES completion: nil];
    
}
//show the profile
-(IBAction)showSearch:(id)sender{
    HomeListingViewController *home_View = [[HomeListingViewController alloc] initWithNibName:@"ProfileViewController" bundle:nil];

    self.popoverController = [[UIPopoverController alloc]
                              initWithContentViewController:home_View];
    self.popoverController.delegate = self;

    [self.popoverController presentPopoverFromRect:btn_Vicinity.frame
                                            inView:self.view
                          permittedArrowDirections:UIPopoverArrowDirectionAny
                                          animated:YES];
    
    
}
-(void)reconfigureView{
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
//#pragma mark-tableView methods
//- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
//{
//    return 1;
//}
//
//- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
//{
//    return [arrSearchTypes count];
//}
//
//- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
//{
//    static NSString *CellIdentifier = @"Cell";
//    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
//    if (cell == nil) {
//        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
//        [cell setSelectionStyle:UITableViewCellSelectionStyleNone];
//    }
//
//
//    UILabel *lblText = [[UILabel alloc]initWithFrame:CGRectMake(70, cell.bounds.origin.y+5, 180, 30)];
//    lblText.font = [UIFont fontWithName:@"HelveticaNeue-Bold" size:18.0];
//    [lblText setTextColor:[UIColor darkGrayColor]];
//    lblText.text = [(NSString*)[[arrSearchTypes objectAtIndex:indexPath.row] objectForKey:@"searchtype"]capitalizedString];
//    [cell addSubview:lblText];
//
//
//    // Configure the cell...
//
//    return cell;
//}
//
#pragma mark - UITableViewDelegate Methods
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    return [self.arrSearchTypes count ];
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"Cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
        [cell setSelectionStyle:UITableViewCellSelectionStyleNone];
    }
    
    
    UILabel *lblText = [[UILabel alloc]initWithFrame:CGRectMake(70, cell.bounds.origin.y+5, 180, 30)];
    lblText.font = [UIFont fontWithName:@"HelveticaNeue-Bold" size:18.0];
    [lblText setTextColor:[UIColor darkGrayColor]];
    lblText.text = (NSString*)[[self.arrSearchTypes objectAtIndex:indexPath.row] objectForKey:@"searchtype"];
    [cell addSubview:lblText];
    
    
    // Configure the cell...
    
    return cell;
}

#pragma mark -orientation methods
- (void)didRotateFromInterfaceOrientation:(UIInterfaceOrientation)fromInterfaceOrientation
{
    
	//[self setControlAgain:fromInterfaceOrientation];
}
- (void)layoutSubviewsForInterfaceOrientation:(UIInterfaceOrientation)theOrientation
{
	
	if(theOrientation == UIInterfaceOrientationLandscapeLeft || theOrientation == UIInterfaceOrientationLandscapeRight){
        
        
        
        if(masterVisible==TRUE)
        {
            [btn_Vicinity setFrame:CGRectMake(self.view.frame.size.width-61, kMenuVicinityY, btn_Vicinity.frame.size.width, btn_Vicinity.frame.size.height)];
            
            
        }
        else{
            if(listingVisible==TRUE)
            {
                [btn_Vicinity setFrame:CGRectMake(self.view.frame.size.width-278-61, kMenuVicinityY, btn_Vicinity.frame.size.width, btn_Vicinity.frame.size.height)];
            }
            else{
                [btn_Vicinity setFrame:CGRectMake(self.view.frame.size.width-61, kMenuVicinityY, btn_Vicinity.frame.size.width, btn_Vicinity.frame.size.height)];
            }
            // [vw_master setFrame:CGRectMake(<#CGFloat x#>, <#CGFloat y#>, <#CGFloat width#>, <#CGFloat height#>)];
        }
        
        
    }
    else{
        if(masterVisible==TRUE)
        {
            [btn_Vicinity setFrame:CGRectMake(self.view.frame.size.width-61, kMenuVicinityY, btn_Vicinity.frame.size.width, btn_Vicinity.frame.size.height)];
        }
        else
        {
            if(listingVisible==TRUE)
            {
                [btn_Vicinity setFrame:CGRectMake(self.view.frame.size.width-278-61, kMenuVicinityY, btn_Vicinity.frame.size.width, btn_Vicinity.frame.size.height)];
            }
            else{
                [btn_Vicinity setFrame:CGRectMake(self.view.frame.size.width-61, kMenuVicinityY, btn_Vicinity.frame.size.width, btn_Vicinity.frame.size.height)];
            }
        }
        
    }
	
    
}
-(void)setControlAgain:(UIInterfaceOrientation )theOrientation{
    if(theOrientation == UIInterfaceOrientationLandscapeLeft || theOrientation == UIInterfaceOrientationLandscapeRight){
        
        
        
        if(masterVisible==TRUE)
        {
            [btn_Vicinity setFrame:CGRectMake(self.view.frame.size.width-61, kMenuVicinityY, btn_Vicinity.frame.size.width, btn_Vicinity.frame.size.height)];
            [self.vw_main setFrame:CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height)];
            [vw_master setFrame:CGRectMake(0, 0, vw_master.frame.size.width, self.view.frame.size.height-48)];
            CGRect newFrame = CGRectOffset(self.vw_main.frame, +(self.vw_master.frame.size.width), 0.0);
            [vw_Listing setFrame:CGRectMake(self.view.frame.size.width, 0, kMenuVicinityOriginPortraitIfListing, self.view.frame.size.height)];
            self.vw_main.frame = newFrame;
            
        }
        else{
            if(listingVisible==TRUE)
            {
                [btn_Vicinity setFrame:CGRectMake(self.view.frame.size.width-278-61, kMenuVicinityY, btn_Vicinity.frame.size.width, btn_Vicinity.frame.size.height)];
                CGRect newFrame = CGRectOffset(self.vw_Listing.frame, -(self.vw_Listing.frame.size.width), 0.0);
                self.vw_master.frame = CGRectMake(kMenuOrigin, 0, self.vw_master.frame.size.width, self.vw_master.frame.size.height);
                // CGRect newFrameMain = CGRectOffset(self.vw_main.frame, -(self.vw_Listing.frame.size.width), 0.0);
                self.vw_main.frame = CGRectMake(0, 0, self.vw_main.frame.size.width, self.vw_main.frame.size.height);;
                vw_Listing.frame = newFrame;
            }
            else{
                [btn_Vicinity setFrame:CGRectMake(self.view.frame.size.width-61, kMenuVicinityY, btn_Vicinity.frame.size.width, btn_Vicinity.frame.size.height)];
                [vw_Listing setFrame:CGRectMake(self.view.frame.size.width, 0, kMenuVicinityOriginLandscapeIfListing, self.view.frame.size.height)];
            }
            // [vw_master setFrame:CGRectMake(<#CGFloat x#>, <#CGFloat y#>, <#CGFloat width#>, <#CGFloat height#>)];
        }
        [img_NaviBar setImage:[UIImage imageNamed:@"navi_land_ipad.png"]];
        
    }
    else{
        if(masterVisible==TRUE)
        {
            [btn_Vicinity setFrame:CGRectMake(self.view.frame.size.width-61, kMenuVicinityY, btn_Vicinity.frame.size.width, btn_Vicinity.frame.size.height)];
            [self.vw_main setFrame:CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height)];
            [vw_master setFrame:CGRectMake(0, 0, vw_master.frame.size.width, self.view.frame.size.height-48)];
            CGRect newFrame = CGRectOffset(self.vw_main.frame, +(self.vw_master.frame.size.width), 0.0);
            [vw_Listing setFrame:CGRectMake(self.view.frame.size.width, 0, kMenuVicinityOriginPortraitIfListing, self.view.frame.size.height)];
            self.vw_main.frame = newFrame;
        }
        else
        {
            if(listingVisible==TRUE)
            {
                [btn_Vicinity setFrame:CGRectMake(self.view.frame.size.width-278-61, kMenuVicinityY, btn_Vicinity.frame.size.width, btn_Vicinity.frame.size.height)];
                CGRect newFrame = CGRectOffset(self.vw_Listing.frame, -(self.vw_Listing.frame.size.width), 0.0);
                self.vw_master.frame = CGRectMake(kMenuOrigin, 0, self.vw_master.frame.size.width, self.vw_master.frame.size.height);
                // CGRect newFrameMain = CGRectOffset(self.vw_main.frame, -(self.vw_Listing.frame.size.width), 0.0);
                self.vw_main.frame = CGRectMake(0, 0, self.vw_main.frame.size.width, self.vw_main.frame.size.height);;
                vw_Listing.frame = newFrame;
            }
            else{
                [btn_Vicinity setFrame:CGRectMake(self.view.frame.size.width-61, kMenuVicinityY, btn_Vicinity.frame.size.width, btn_Vicinity.frame.size.height)];
                [vw_Listing setFrame:CGRectMake(self.view.frame.size.width, 0, kMenuVicinityOriginPortraitIfListing, self.view.frame.size.height)];
            }
        }
        [img_NaviBar setImage:[UIImage imageNamed:@"navi_port_ipad"]];
        
    }
    [vw_naviBar setFrame:CGRectMake(0, 0, self.view.frame.size.width, 48)];
    
}


#pragma mark -
#pragma mark View management


- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    
    
    return YES;
}

- (NSUInteger) supportedInterfaceOrientations
{
    return UIInterfaceOrientationMaskAll;
}
- (BOOL)shouldAutorotate
{
    
    return YES;
}
- (CGSize)splitViewSizeForOrientation:(UIInterfaceOrientation)theOrientation
{
	UIScreen *screen = [UIScreen mainScreen];
	CGRect fullScreenRect = screen.bounds; // always implicitly in Portrait orientation.
	CGRect appFrame = screen.applicationFrame;
	
	// Find status bar height by checking which dimension of the applicationFrame is narrower than screen bounds.
	// Little bit ugly looking, but it'll still work even if they change the status bar height in future.
	float statusBarHeight = MAX((fullScreenRect.size.width - appFrame.size.width), (fullScreenRect.size.height - appFrame.size.height));
	
	// Initially assume portrait orientation.
	float width = fullScreenRect.size.width;
	float height = fullScreenRect.size.height;
	
	// Correct for orientation.
	if (UIInterfaceOrientationIsLandscape(theOrientation)) {
		width = height;
		height = fullScreenRect.size.width;
	}
	
	// Account for status bar, which always subtracts from the height (since it's always at the top of the screen).
	height -= statusBarHeight;
	
	return CGSizeMake(width, height);
}
#pragma mark dismiss modal view
- (void)didDismissModalView {
    
    // Dismiss the modal view controller
    [self dismissModalViewControllerAnimated:YES];
}
#pragma mark orientation method in ios 6.0
-(void) detectOrientation {
    NSLog(@"%d",[[UIDevice currentDevice] orientation]);
    if (([[UIDevice currentDevice] orientation] == UIDeviceOrientationPortrait) ||
        ([[UIDevice currentDevice] orientation] == UIDeviceOrientationPortraitUpsideDown)) {
        if(masterVisible==TRUE){
            [btn_Vicinity setFrame:CGRectMake(self.view.frame.size.width-61, kMenuVicinityY, btn_Vicinity.frame.size.width, btn_Vicinity.frame.size.height)];
            [self.vw_main setFrame:CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height)];
            [vw_master setFrame:CGRectMake(0, 0, vw_master.frame.size.width, self.view.frame.size.height-48)];
            CGRect newFrame = CGRectOffset(self.vw_main.frame, +(self.vw_master.frame.size.width), 0.0);
            [vw_Listing setFrame:CGRectMake(self.view.frame.size.width, 0, kMenuVicinityOriginPortraitIfListing, self.view.frame.size.height)];
            self.vw_main.frame = newFrame;
        }
        else{
            if(listingVisible==TRUE){
                [btn_Vicinity setFrame:CGRectMake(self.view.frame.size.width-278-61, kMenuVicinityY, btn_Vicinity.frame.size.width, btn_Vicinity.frame.size.height)];
                [vw_Listing setFrame:CGRectMake(self.view.frame.size.width, 0, kMenuVicinityOriginPortraitIfListing, self.view.frame.size.height)];
                CGRect newFrame = CGRectOffset(self.vw_Listing.frame, -(self.vw_Listing.frame.size.width), 0.0);
                self.vw_master.frame = CGRectMake(kMenuOrigin, 0, self.vw_master.frame.size.width, self.vw_master.frame.size.height);
                // CGRect newFrameMain = CGRectOffset(self.vw_main.frame, -(self.vw_Listing.frame.size.width), 0.0);
                self.vw_main.frame = CGRectMake(0, 0, self.vw_main.frame.size.width, self.vw_main.frame.size.height);;
                vw_Listing.frame = newFrame;
            }
            else{
                [btn_Vicinity setFrame:CGRectMake(self.view.frame.size.width-61, kMenuVicinityY, btn_Vicinity.frame.size.width, btn_Vicinity.frame.size.height)];
                [vw_Listing setFrame:CGRectMake(self.view.frame.size.width, 0, kMenuVicinityOriginPortraitIfListing, self.view.frame.size.height)];
            }
            
        }
        
        [img_NaviBar setImage:[UIImage imageNamed:@"navi_port_ipad"]];
        [img_CurrentLocation setImage:[UIImage imageNamed:@"location_search.png"]];
        [img_CurrentLocation setFrame:CGRectMake(98,7, 258, 31)];
        [txt_Currentlocation setFrame:CGRectMake(img_CurrentLocation.frame.origin.x+10, img_CurrentLocation.frame.origin.y+4, img_CurrentLocation.frame.size.width-19, txt_Currentlocation.frame.size.height)];
        [btn_filter setFrame:CGRectMake(img_CurrentLocation.frame.origin.x+img_CurrentLocation.frame.size.width+20, btn_filter.frame.origin.y, btn_filter.frame.size.width, btn_filter.frame.size.height)];
        [btn_download setFrame:CGRectMake(btn_filter.frame.origin.x+btn_filter.frame.size.width+20, btn_download.frame.origin.y, btn_download.frame.size.width, btn_download.frame.size.height)];
    }
    else if (([[UIDevice currentDevice] orientation] == UIDeviceOrientationLandscapeLeft) ||
             ([[UIDevice currentDevice] orientation] == UIDeviceOrientationLandscapeRight)) {
        if(masterVisible==TRUE){
            [btn_Vicinity setFrame:CGRectMake(self.view.frame.size.width-61, kMenuVicinityY, btn_Vicinity.frame.size.width, btn_Vicinity.frame.size.height)];
            [self.vw_main setFrame:CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height)];
            [vw_master setFrame:CGRectMake(0, 0, vw_master.frame.size.width, self.view.frame.size.height-48)];
            CGRect newFrame = CGRectOffset(self.vw_main.frame, +(self.vw_master.frame.size.width), 0.0);
            [vw_Listing setFrame:CGRectMake(self.view.frame.size.width, 0, kMenuVicinityOriginPortraitIfListing, self.view.frame.size.height)];
            self.vw_main.frame = newFrame;
            
        }
        else{
            if(listingVisible==TRUE){
                [btn_Vicinity setFrame:CGRectMake(self.view.frame.size.width-278-61, kMenuVicinityY, btn_Vicinity.frame.size.width, btn_Vicinity.frame.size.height)];
                [self.vw_Listing setFrame:CGRectMake(self.view.frame.size.width, 0, kMenuVicinityOriginPortraitIfListing, self.view.frame.size.height)];
                CGRect newFrame = CGRectOffset(self.vw_Listing.frame, -(self.vw_Listing.frame.size.width), 0.0);
                self.vw_master.frame = CGRectMake(kMenuOrigin, 0, self.vw_master.frame.size.width, self.vw_master.frame.size.height);
                // CGRect newFrameMain = CGRectOffset(self.vw_main.frame, -(self.vw_Listing.frame.size.width), 0.0);
                self.vw_main.frame = CGRectMake(0, 0, self.vw_main.frame.size.width, self.vw_main.frame.size.height);;
                self.vw_Listing.frame = newFrame;
            }
            else{
                [btn_Vicinity setFrame:CGRectMake(self.view.frame.size.width-61, kMenuVicinityY, btn_Vicinity.frame.size.width, btn_Vicinity.frame.size.height)];
                [vw_Listing setFrame:CGRectMake(self.view.frame.size.width, 0, kMenuVicinityOriginLandscapeIfListing, self.view.frame.size.height)];
            }
        }
        [img_NaviBar setImage:[UIImage imageNamed:@"navi_land_ipad.png"]];
        [img_CurrentLocation setImage:[UIImage imageNamed:@"search_land_ipad.png"]];
        [img_CurrentLocation setFrame:CGRectMake(img_CurrentLocation.frame.origin.x, img_CurrentLocation.frame.origin.y, 458, 31)];
        [txt_Currentlocation setFrame:CGRectMake(img_CurrentLocation.frame.origin.x+10, img_CurrentLocation.frame.origin.y+4, img_CurrentLocation.frame.size.width-19, txt_Currentlocation.frame.size.height)];
        [btn_filter setFrame:CGRectMake(img_CurrentLocation.frame.origin.x+img_CurrentLocation.frame.size.width+20, btn_filter.frame.origin.y, btn_filter.frame.size.width, btn_filter.frame.size.height)];
        [btn_download setFrame:CGRectMake(btn_filter.frame.origin.x+btn_filter.frame.size.width+20, btn_download.frame.origin.y, btn_download.frame.size.width, btn_download.frame.size.height)];
        
    }
    [vw_naviBar setFrame:CGRectMake(0, 0, self.view.frame.size.width, 48)];
    
}
@end
