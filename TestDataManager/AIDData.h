//
//  AIDData.h
//  
//
//  Created by Dmytro Barsukov on 1/13/15.
//  Copyright (c) 2015 Dmytro Barsukov. All rights reserved.
//
////////////////////////////////////////////////////////////////////////////
//  AID Data classes (used only as data storage)
//

#ifndef testTest_AIDData_h
#define testTest_AIDData_h

#import <Foundation/Foundation.h>
#import <objc/objc-runtime.h>

#pragma mark Constants for internal key names in dictionary
FOUNDATION_EXTERN NSString* const KeyAIDDataID;
FOUNDATION_EXTERN NSString* const KeyAIDDataCreated;
FOUNDATION_EXTERN NSString* const KeyAIDDataUpdated;
FOUNDATION_EXTERN NSString* const KeyAIDDataTimeStamp;
FOUNDATION_EXTERN NSString* const KeyAIDDataName;
FOUNDATION_EXTERN NSString* const KeyAIDDataZIP;
FOUNDATION_EXTERN NSString* const KeyAIDDataPhone;
FOUNDATION_EXTERN NSString* const KeyAIDDataEmail;
FOUNDATION_EXTERN NSString* const KeyAIDDataActive;
FOUNDATION_EXTERN NSString* const KeyAIDDataAnchorId;
FOUNDATION_EXTERN NSString* const KeyAIDDataConsumerId;
FOUNDATION_EXTERN NSString* const KeyAIDDataUUID;
FOUNDATION_EXTERN NSString* const KeyAIDDataStatus;
FOUNDATION_EXTERN NSString* const KeyAIDDataOS;
FOUNDATION_EXTERN NSString* const KeyAIDDataEndpointArn;
FOUNDATION_EXTERN NSString* const KeyAIDDataRecordId;
FOUNDATION_EXTERN NSString* const KeyAIDDataClientAppId;
FOUNDATION_EXTERN NSString* const KeyAIDDataSecurityCode;

#pragma mark AIDData - base data storage class
@interface AIDData : NSObject < NSCopying >

@property ( nonatomic ) NSString    *cId;
@property ( nonatomic ) NSString    *created;
@property ( nonatomic ) NSString    *updated;
@property ( nonatomic ) NSString    *timestamp;

- ( instancetype )copyWithZone:(NSZone *)zone;
- ( NSDictionary* )dictionaryRepresentation;
- ( void )setDataWithDictionary: ( NSDictionary* )dictionary; // !!! method does not validate passed dictionary

@end

#pragma mark AIDDataConsumer
@interface AIDDataConsumer : AIDData

@property ( nonatomic ) NSString    *parentConsumerId; // Reserved for future usage
@property ( nonatomic ) NSString    *name;
@property ( nonatomic ) NSString    *zip;
@property ( nonatomic ) NSString    *phone;
@property ( nonatomic ) NSString    *email;

@end

#pragma mark AIDDataApplication
@interface AIDDataApplication : AIDData

@property ( nonatomic ) NSString    *name;
@property ( nonatomic ) NSString    *active;

@end

#pragma mark AIDDataDevice
@interface AIDDataDevice : AIDData

@property ( nonatomic ) NSString    *anchorId;
@property ( nonatomic ) NSString    *consumerId;
@property ( nonatomic ) NSString    *uuid;
@property ( nonatomic ) NSString    *status;
@property ( nonatomic ) NSString    *os;
@property ( nonatomic ) NSString    *endpointArn;

@end

#pragma mark AIDDataTransaction
@interface AIDDataTransaction : AIDData

@property ( nonatomic ) NSString    *recordId; // maybe record ID?
@property ( nonatomic ) NSString    *consumerId;
@property ( nonatomic ) NSString    *clientAppId;
@property ( nonatomic ) NSString    *status;
@property ( nonatomic ) NSString    *securityCode;

@end

#endif
