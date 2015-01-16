//
//  ViewController.h
//  TestDataManager
//
//  Created by Dmytro Barsukov on 1/14/15.
//  Copyright (c) 2015 Dmytro Barsukov. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AIDDataManager.h"

@interface ViewController : UIViewController{
    AIDDataManager *dataManager;
}

@property ( nonatomic ) AIDDataManager *dataManager;
@property (weak, nonatomic) IBOutlet UITextView *textView;

@end

