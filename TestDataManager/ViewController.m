//
//  ViewController.m
//  TestDataManager
//
//  Created by Dmytro Barsukov on 1/14/15.
//  Copyright (c) 2015 Dmytro Barsukov. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@end

@implementation ViewController
@synthesize dataManager;
@synthesize textView;

- (void)viewDidLoad {
    [super viewDidLoad];
    self.dataManager = [ AIDDataManager sharedManager ];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)buttonSaveTap:(id)sender {
    AIDDataApplication *a1 = [ AIDDataApplication new ];
    AIDDataApplication *a2 = [ AIDDataApplication new ];

    [ a1 setDataWithDictionary: @{ KeyAIDDataID: @"1", KeyAIDDataName: @"app1", KeyAIDDataActive: @"active" } ];
    [ a2 setDataWithDictionary: @{ KeyAIDDataName: @"app2", KeyAIDDataActive: @"non active" } ];
    [ self.dataManager.applications addObject: a1 ];
    [ self.dataManager.applications addObject: a2 ];
//    NSLog( @"%@", self.dataManager.applications );
    [ self.dataManager storeApplications ];
/*    NSDictionary *dict = @{ KeyAIDDataID:       @"1",
                            KeyAIDDataName:     @"name",
                            KeyAIDDataZIP:      @"12345",
                            KeyAIDDataPhone:    @"555-555-555",
                            KeyAIDDataEmail:    @"asd@mail.com",
                            KeyAIDDataCreated:  @"1.1.15",
                            KeyAIDDataTimeStamp:@"1234567890" };
    
    [ self.dataManager.consumer dataWithDictionary: dict ];
    if( [ self.dataManager storeConsumer ] ) NSLog( @"ERROR: can't store data" );*/
}

- (IBAction)buttonLoadTap:(id)sender {
/*    if( ![ self.dataManager fetchConsumer ] )
        self.textView.text = [ NSString stringWithFormat: @"Consumer: %@", [ self.dataManager.consumer dictionaryRepresentation ] ];*/
/*    [ self.dataManager fetchApplications ];
    self.textView.text = [ NSString stringWithFormat: @"%@", [ [ self.dataManager.applications objectAtIndex: 0 ] dictionaryRepresentation ] ];*///@"Applications:\n";
    //self.textView.text = [ NSString stringWithFormat: @"a%@", [ [ self.dataManager.applications objectAtIndex: 0 ] dictionaryRepresentation ] ];
    NSString *text = [ NSString new ];   
    
    if( ![ self.dataManager fetchApplications ] )
        for( int i = 0; i < self.dataManager.applications.count; i++ )
            text = [ text stringByAppendingPathComponent: [ NSString stringWithFormat: @"%@", [ [ self.dataManager.applications objectAtIndex: i ] dictionaryRepresentation ] ] ];
    self.textView.text = text;
    //NSLog( @"View: %@", /*[ [ self.dataManager.applications objectAtIndex: 0 ] dictionaryRepresentation ]*/text );
}

@end
