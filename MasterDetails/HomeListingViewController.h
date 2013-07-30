//
//  HomeListingViewController.h
//  MasterDetails
//
//  Created by mittal on 7/12/13.
//  Copyright (c) 2013 digicorp. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface HomeListingViewController : UIViewController<UITableViewDataSource,UITableViewDelegate>
{
    IBOutlet UILabel *lbl_Results;
    IBOutlet UITableView *tbl_propertyList;
    AppDelegate *appDelegate;
    IBOutlet UIImageView *img_masterImage;
    
}
@property(strong,nonatomic)NSMutableArray *table_propertylist_array;
@property(strong,nonatomic)IBOutlet UITableView *tbl_propertyList;

@end
