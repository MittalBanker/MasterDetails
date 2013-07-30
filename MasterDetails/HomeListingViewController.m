//
//  HomeListingViewController.m
//  MasterDetails
//
//  Created by mittal on 7/12/13.
//  Copyright (c) 2013 digicorp. All rights reserved.
//

#import "HomeListingViewController.h"
#import "DetailsViewController.h"
#define LABEL_PROPERTY -999
#define kMenuFullWidth_Portrait 768.0f
#define kMenuListingHeightPortrait 1004.0
#define kMenuListingWidth 278
#define kMenuListingHeightLandscape 768

@interface HomeListingViewController ()

@end

@implementation HomeListingViewController

@synthesize table_propertylist_array,tbl_propertyList;
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
    self.table_propertylist_array = [[NSMutableArray alloc ] init];
    
    [self.table_propertylist_array addObject:[NSDictionary dictionaryWithObjectsAndKeys:@"aquarium",@"shortaddress",@"1000",@"price",nil]];
    [self.table_propertylist_array addObject:[NSDictionary dictionaryWithObjectsAndKeys:@"bank",@"shortaddress",@"1000",@"price",nil]];
    [self.table_propertylist_array addObject:[NSDictionary dictionaryWithObjectsAndKeys:@"book_store",@"shortaddress",@"1000",@"price",nil]];
    lbl_Results.font = [UIFont fontWithName:@"DroidSans" size:15];
    lbl_Results.text = [NSString stringWithFormat:@"%d RESULTS",[self.table_propertylist_array count]];
    appDelegate = (AppDelegate*)[[UIApplication sharedApplication] delegate];
    
}
-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [tbl_propertyList reloadData];
    [[UIDevice currentDevice] beginGeneratingDeviceOrientationNotifications];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(detectOrientation) name:UIDeviceOrientationDidChangeNotification object:nil];
}

-(void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
    [[NSNotificationCenter defaultCenter]removeObserver:self name:UIDeviceOrientationDidChangeNotification object:nil];
}
#pragma mark - UITableViewDelegate Methods
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    return [self.table_propertylist_array count ];
}
//- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
//{
//    static NSString *CellIdentifier = @"Cell";
//    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
//    UILabel *lblText;
//    if (cell == nil) {
//        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
//        [cell setSelectionStyle:UITableViewCellSelectionStyleNone];
//        lblText = [[UILabel alloc]initWithFrame:CGRectMake(0, cell.bounds.origin.y+5, 260, 30)];
//        lblText.font = [UIFont fontWithName:@"HelveticaNeue-Bold" size:18.0];
//        [lblText setTextColor:[UIColor darkGrayColor]];
////[lblText setCenter:CGPointMake(cell.bounds.size.width/2, lblText.center.y)];
//        [lblText setBackgroundColor:[UIColor clearColor]];
//        lblText.text = (NSString*)[[self.table_propertylist_array objectAtIndex:indexPath.row] objectForKey:@"searchtype"];
//        lblText.tag = LABEL_PROPERTY;
//        [cell addSubview:lblText];
//    }
//   // [cell setBackgroundColor:[UIColor grayColor]];
//    lblText = (UILabel*)[cell viewWithTag:LABEL_PROPERTY];
//    lblText.font = [UIFont fontWithName:@"HelveticaNeue-Bold" size:18.0];
//    [lblText setTextColor:[UIColor darkGrayColor]];
//    //[lblText setCenter:CGPointMake(cell.bounds.size.width/2, lblText.center.y)];
//    [lblText setBackgroundColor:[UIColor grayColor]];
//    lblText.text = (NSString*)[[self.table_propertylist_array objectAtIndex:indexPath.row] objectForKey:@"searchtype"];
//    lblText.tag = LABEL_PROPERTY;
//
//
//
//
//
//
//    // Configure the cell...
//
//    return cell;
//}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    appDelegate.details_View = [[DetailsViewController alloc] initWithNibName:@"DetailsViewController" bundle:nil];
    [self.navigationController pushViewController:appDelegate.details_View animated:YES];
    
}
- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

//#pragma mark - UITableViewDelegate Methods
//- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
//{
//    return 1;
//}
//- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
//
//    return [self.table_propertylist_array count ];
//}
//- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
//{
//    static NSString *CellIdentifier = @"Cell";
//    UITableViewCell *cell = [self.tbl_propertyList dequeueReusableCellWithIdentifier:CellIdentifier];
//    if (cell == nil) {
//        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
//        [cell setSelectionStyle:UITableViewCellSelectionStyleNone];
//    }
//
//
//    UILabel *lblText = [[UILabel alloc]initWithFrame:CGRectMake(70, cell.bounds.origin.y+5, 180, 30)];
//    lblText.font = [UIFont fontWithName:@"HelveticaNeue-Bold" size:18.0];
//    [lblText setTextColor:[UIColor darkGrayColor]];
//    lblText.text = (NSString*)[[self.table_propertylist_array objectAtIndex:indexPath.row] objectForKey:@"price"];
//    [cell addSubview:lblText];
//
//
//    // Configure the cell...
//
//    return cell;
//}

// Customize the appearance of table view cells.
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
	static NSString *cellIdentifier = @"propertylist";
    UITableViewCell *cell = [tbl_propertyList dequeueReusableCellWithIdentifier:cellIdentifier];
    
    if (cell == nil) {
        cell = [[[NSBundle mainBundle] loadNibNamed:@"CCell-iPad" owner:self options:nil] objectAtIndex:0];
        [cell setSelectionStyle:UITableViewCellSelectionStyleNone];
    }
    NSString *flierPrice = (NSString*)[[self.table_propertylist_array objectAtIndex:indexPath.row] objectForKey:@"price"];
    flierPrice = [NSString stringWithFormat:@"%@ %@",@"Price: ",flierPrice];
    UILabel *flierPrice_label = (UILabel*)[cell viewWithTag:TAG_PROPERTLISTYPRICE];
    [flierPrice_label setText:flierPrice];
    NSString *flierMls ;
    UILabel *flierMls_label = (UILabel*)[cell viewWithTag:TAG_PROPERTYLISTFEATURE];
    //flierMls = [NSString stringWithFormat:@"%@ %@",@"MLS#: ",flierMls];
    
    
    NSMutableArray * arr_Features ;
    arr_Features = [[self.table_propertylist_array objectAtIndex:indexPath.row]  objectForKey:@"features"];
    
    NSString *strBed = @"" ;
    NSString *strBath = @"";
    
    for (int i = 0; i < [arr_Features count]; i++)
    {
        
        if([[[arr_Features objectAtIndex:i] objectForKey:@"key"] isEqualToString:@"Bedrooms"]){
            
            strBed = [[arr_Features objectAtIndex:i] objectForKey:@"value"];
        }
        if([[[arr_Features objectAtIndex:i] objectForKey:@"key"] isEqualToString:@"Bathrooms"])
        {
            strBath = [[arr_Features objectAtIndex:i] objectForKey:@"value"];
        }
        
        
    }
    if([strBed isEqualToString:@""])
    {
        strBed = @"- ";
    }
    if([strBath isEqualToString:@""])
    {
        strBath = @"- ";
    }
    if([strBed isEqualToString:@""] && [strBath isEqualToString:@""])
    {
        // [flierMls_label setHidden:TRUE];
    }
    else{
        [flierMls_label setHidden:FALSE];
    }
    
    flierMls =  [[NSString stringWithFormat:@"%@ %@",@"Bed:",strBed] stringByAppendingString:[NSString stringWithFormat:@"%@ %@",@"  Bath:",strBath] ];
    [flierMls_label setText:flierMls];
    NSString *flierMiles = (NSString*)[[self.table_propertylist_array objectAtIndex:indexPath.row] objectForKey:@"flyerarea"];
    if([flierMiles isEqualToString:@""])
    {
        flierMiles = @"-";
    }
    UILabel *flierMiles_label = (UILabel*)[cell viewWithTag:TAG_PROPERTYLISTFEATURE];
    [flierMiles_label setText:flierMiles];
    
    UILabel *flierarea_label_lot = (UILabel*)[cell viewWithTag:TAG_PROPERTYLISTLOT];
    
    if([flierMiles isEqualToString:@""]){
        //[flierMiles_label setHidden:TRUE];
        [flierarea_label_lot setHidden:TRUE];
        
    }
    else{
        [flierMiles_label setHidden:FALSE];
        [flierarea_label_lot setHidden:FALSE];
    }
    
    UIImageView *tag_Image = (UIImageView*)[cell viewWithTag:TAG_PROPERTYLISTSTATUSIMAGE];
    NSString *flierpurpose = (NSString*)[[self.table_propertylist_array objectAtIndex:indexPath.row] objectForKey:@"flyerpurpose"];
    
    
    // UILabel *flier_label_LeaseOrSale = (UILabel*)[cell viewWithTag:TAG_PROPERTSALEORLEASE];
    
    
    
    if ([flierpurpose isEqualToString:@"For Sale"]) {
        
        flierpurpose = @"Sale - ";
        
    }
    else if ([flierpurpose isEqualToString:@"For Rent"]){
        
        flierpurpose = @"Rent - ";
    }
    else{
        
        flierpurpose = @"Lease - ";
    }
    
    NSString *fliername = (NSString*)[[self.table_propertylist_array objectAtIndex:indexPath.row] objectForKey:@"shortaddress"];
    UILabel *fliername_label = (UILabel*)[cell viewWithTag:TAG_PROPERTYLISTADDRESS];
    [fliername_label setText:[flierpurpose stringByAppendingString:fliername]];
    
    
    NSString *flierStatus = (NSString*)[[self.table_propertylist_array objectAtIndex:indexPath.row] objectForKey:@"flyerstatus"];
    
    if ([flierStatus isEqualToString:@"Created"]){
        [tag_Image setImage:[UIImage imageNamed:@"active.png"]];
        
    }
    else if ([flierStatus isEqualToString:@"Pending"]){
        [tag_Image setImage:[UIImage imageNamed:@"pending.png"]];
        
    }
    else if ([flierStatus isEqualToString:@"Active"]){
        [tag_Image setImage:[UIImage imageNamed:@"active.png"]];
        
    }
    else
    {
        [tag_Image setImage:[UIImage imageNamed:@"sold.png"]];
    }
    NSString *flierlot = (NSString*)[[self.table_propertylist_array objectAtIndex:indexPath.row] objectForKey:@"flyerlotsize"];
    
    UILabel *flier_label_lot = (UILabel*)[cell viewWithTag:TAG_PROPERTYLISTLOT];
    UILabel *flierlist_label_lot = (UILabel*)[cell viewWithTag:TAG_PROPERTYLISTLOT];
    [flier_label_lot setText:flierlot];
    
    if([flierlot isEqualToString:@""])
    {
        flierlot = @"-";
    }
    
    //    HJManagedImageV *_image_view = (HJManagedImageV*)[cell viewWithTag:TAG_PROPERTYIMAGE];
    //
    //    if([[[self.table_propertylist_array objectAtIndex:indexPath.row] objectForKey:@"images"] count]>0)
    //    {
    //        NSString *strImage =  (NSString*)[[[[self.table_propertylist_array objectAtIndex:indexPath.row] objectForKey:@"images"]objectAtIndex:0 ]objectForKey:@"imageurl"];
    //        strImage =  [strImage stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    //        UIColor* border_color = [UIColor colorWithRed:171/256.0 green:171/256.0 blue:171/256.0 alpha:1.0];
    //        _image_view.layer.borderColor = border_color.CGColor;
    //        _image_view.layer.borderWidth = 1.0;
    //        [_image_view setBackgroundColor:[UIColor colorWithRed:222.0/255.0 green:222.0/255.0 blue:222.0/255.0 alpha:1]];
    //        [_image_view clear];
    //        [_image_view showLoadingWheel];
    //        _image_view.url = [NSURL URLWithString:strImage];
    //        [[APP_DELEGATE globalHJObj] manage:_image_view];
    //
    //    }
    //    else{
    //        UIColor* border_color = [UIColor colorWithRed:171/256.0 green:171/256.0 blue:171/256.0 alpha:1.0];
    //        _image_view.layer.borderColor = border_color.CGColor;
    //        _image_view.layer.borderWidth = 1.0;
    //        [_image_view setBackgroundColor:[UIColor colorWithRed:222.0/255.0 green:222.0/255.0 blue:222.0/255.0 alpha:1]];
    //        [_image_view clear];
    //
    //    }
    
    
    
    //    if ((indexPath.row + 1) ==[self.table_propertylist_array count] && !is_requst_is_loading)
    //    {
    //        [self loadNextPageData];
    //    }
    
    return cell;
}


//- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
//
//
//
//
//
//}
//// sets the height for a row based on indexPath
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    //    // set the height to a larger number for iPhone 5 rows
    return  103.0f; // this sets a height of 50 for iPhone 5 rows, and 44 for all other iPhones
    
}
#pragma mark orientation method in ios 6.0
-(void) detectOrientation {
  
}

@end
