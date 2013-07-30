//
//  DetailsViewController.h
//  MasterDetails
//
//  Created by mittal on 7/18/13.
//  Copyright (c) 2013 digicorp. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface DetailsViewController : UIViewController
{
    IBOutlet UILabel *lbl_property_Details;
    
}
-(IBAction)backAction:(id)sender;
@end