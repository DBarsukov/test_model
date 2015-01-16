//
//  AIDDataManager.h
//  
//
//  Created by Dmytro Barsukov on 1/13/15.
//  Copyright (c) 2015 Dmytro Barsukov. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UICKeyChainStore.h>
#import "AIDData.h"

#pragma mark Errors
FOUNDATION_EXTERN NSInteger const ErrorAIDDataManagerKeyChainEmptyCode;
FOUNDATION_EXTERN NSString* const ErrorAIDDataManagerKeyChainEmpty;

@interface AIDDataManager : NSObject{
    AIDDataConsumer     *consumer;
    NSMutableArray      *applications;
    AIDDataDevice       *device;
    NSMutableArray      *transactions;
}

@property ( nonatomic ) AIDDataConsumer     *consumer;
@property ( nonatomic ) NSMutableArray      *applications;
@property ( nonatomic ) AIDDataDevice       *device;
@property ( nonatomic ) NSMutableArray      *transactions;

+ ( id )sharedManager;
- ( NSError* )fetchConsumer;
- ( NSError* )fetchApplications;
- ( NSError* )fetchDevice;
- ( NSError* )fetchTransactions;
- ( NSError* )storeConsumer;
- ( NSError* )storeApplications;
- ( NSError* )storeDevice;
- ( NSError* )storeTransactions;

@end
