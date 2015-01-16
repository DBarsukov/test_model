//
//  AIDData.m
//  
//
//  Created by Dmytro Barsukov on 1/13/15.
//  Copyright (c) 2015 Dmytro Barsukov. All rights reserved.
//

#import "AIDData.h"

#define VALID_DATA( __data ) __data ? __data : @""

#pragma mark Internal key names for dictionary
NSString* const KeyAIDDataID            = @"cId";
NSString* const KeyAIDDataCreated       = @"created";
NSString* const KeyAIDDataUpdated       = @"updated";
NSString* const KeyAIDDataTimeStamp     = @"timestamp";
NSString* const KeyAIDDataName          = @"name";
NSString* const KeyAIDDataZIP           = @"zip";
NSString* const KeyAIDDataPhone         = @"phone";
NSString* const KeyAIDDataEmail         = @"email";
NSString* const KeyAIDDataActive        = @"active";
NSString* const KeyAIDDataAnchorId      = @"anchorId";
NSString* const KeyAIDDataConsumerId    = @"consumerId";
NSString* const KeyAIDDataUUID          = @"uuid";
NSString* const KeyAIDDataStatus        = @"status";
NSString* const KeyAIDDataOS            = @"os";
NSString* const KeyAIDDataEndpointArn   = @"endpointArn";
NSString* const KeyAIDDataRecordId      = @"recordId";
NSString* const KeyAIDDataClientAppId   = @"clientAppId";
NSString* const KeyAIDDataSecurityCode  = @"securityCode";

#pragma mark AIDData
@implementation AIDData

@synthesize cId;
@synthesize created;
@synthesize updated;
@synthesize timestamp;

- ( id )copyWithZone:(NSZone *)zone{
    AIDData *copyObj = [ [ [ self class ] allocWithZone: nil ] init ];
    
    copyObj.cId         = self.cId;
    copyObj.created     = self.created;
    copyObj.updated     = self.updated;
    copyObj.timestamp   = self.timestamp;
    return copyObj;
}

- ( NSDictionary* )dictionaryRepresentation{
    return @{ KeyAIDDataID:         VALID_DATA( self.cId ),
              KeyAIDDataCreated:    VALID_DATA( self.created ),
              KeyAIDDataUpdated:    VALID_DATA( self.updated ),
              KeyAIDDataTimeStamp:  VALID_DATA( self.timestamp ) };
}

- ( void )dataWithDictionary: ( NSDictionary* )dictionary{
    for( NSString *key in dictionary )
        [ self setValue: [ dictionary valueForKey: key ] forKey: key ];
}

@end

#pragma mark AIDDataConsumer
@implementation AIDDataConsumer

@synthesize parentConsumerId;
@synthesize name;
@synthesize zip;
@synthesize phone;
@synthesize email;

- ( id )copyWithZone:(NSZone *)zone{
    AIDDataConsumer *copyObj = [ super copyWithZone: zone ];
    
    copyObj.name    = self.name;
    copyObj.zip     = self.zip;
    copyObj.phone   = self.phone;
    copyObj.email   = self.email;
    return copyObj;
}

- ( NSDictionary* )dictionaryRepresentation{
    NSMutableDictionary *dictionary = [ [ NSMutableDictionary alloc ] initWithDictionary: [ super dictionaryRepresentation ] ];
    
    [ dictionary addEntriesFromDictionary: @{ KeyAIDDataName:   VALID_DATA( self.name ),
                                              KeyAIDDataZIP:    VALID_DATA( self.zip ),
                                              KeyAIDDataPhone:  VALID_DATA( self.phone ),
                                              KeyAIDDataEmail:  VALID_DATA( self.email ) } ];
    return dictionary;
}

@end

#pragma mark AIDDataApplication
@implementation AIDDataApplication

@synthesize name;
@synthesize active;

- ( id )copyWithZone:(NSZone *)zone{
    AIDDataApplication *copyObj = [ super copyWithZone: zone ];
    
    copyObj.name    = self.name;
    copyObj.active  = self.active;
    return copyObj;
}

- ( NSDictionary* )dictionaryRepresentation{
    NSMutableDictionary *dictionary = [ [ NSMutableDictionary alloc ] initWithDictionary: [ super dictionaryRepresentation ] ];
    
    [ dictionary addEntriesFromDictionary: @{ KeyAIDDataName:   VALID_DATA( self.name ),
                                              KeyAIDDataActive: VALID_DATA( self.active ) } ];
    return dictionary;
}

@end

#pragma mark AIDDataDevice
@implementation AIDDataDevice

@synthesize anchorId;
@synthesize consumerId;
@synthesize uuid;
@synthesize status;
@synthesize os;
@synthesize endpointArn;

- ( id )copyWithZone:(NSZone *)zone{
    AIDDataDevice *copyObj = [ super copyWithZone: zone ];
    
    copyObj.anchorId    = self.anchorId;
    copyObj.consumerId  = self.consumerId;
    copyObj.uuid        = self.uuid;
    copyObj.status      = self.status;
    copyObj.os          = self.os;
    copyObj.endpointArn = self.endpointArn;
    return copyObj;
}

- ( NSDictionary* )dictionaryRepresentation{
    NSMutableDictionary *dictionary = [ [ NSMutableDictionary alloc ] initWithDictionary: [ super dictionaryRepresentation ] ];
    
    [ dictionary addEntriesFromDictionary: @{ KeyAIDDataAnchorId:   VALID_DATA( self.anchorId ),
                                              KeyAIDDataConsumerId: VALID_DATA( self.consumerId ),
                                              KeyAIDDataUUID:       VALID_DATA( self.uuid ),
                                              KeyAIDDataStatus:     VALID_DATA( self.status ),
                                              KeyAIDDataOS:         VALID_DATA( self.os ),
                                              KeyAIDDataEndpointArn:VALID_DATA( self.endpointArn ) } ];
    return dictionary;
}

@end

#pragma mark AIDDataTransaction
@implementation AIDDataTransaction

@synthesize recordId;
@synthesize consumerId;
@synthesize clientAppId;
@synthesize status;
@synthesize securityCode;

- ( id )copyWithZone:(NSZone *)zone{
    AIDDataTransaction *copyObj = [ super copyWithZone: zone ];
    
    copyObj.recordId    = self.recordId;
    copyObj.consumerId  = self.consumerId;
    copyObj.clientAppId = self.clientAppId;
    copyObj.status      = self.status;
    copyObj.securityCode= self.securityCode;
    return copyObj;
}

- ( NSDictionary* )dictionaryRepresentation{
    NSMutableDictionary *dictionary = [ [ NSMutableDictionary alloc ] initWithDictionary: [ super dictionaryRepresentation ] ];
    
    [ dictionary addEntriesFromDictionary: @{ KeyAIDDataRecordId:       VALID_DATA( self.recordId ),
                                              KeyAIDDataConsumerId:     VALID_DATA( self.consumerId ),
                                              KeyAIDDataClientAppId:    VALID_DATA( self.clientAppId ),
                                              KeyAIDDataStatus:         VALID_DATA( self.status ),
                                              KeyAIDDataSecurityCode:   VALID_DATA( self.securityCode ) } ];
    return dictionary;
}

@end

