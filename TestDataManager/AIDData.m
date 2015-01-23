//
//  AIDData.m
//  
//
//  Created by Dmytro Barsukov on 1/13/15.
//  Copyright (c) 2015 Dmytro Barsukov. All rights reserved.
//

#import "AIDData.h"

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
NSString* const BaseClassName = @"AIDData";

@implementation AIDData

@synthesize cId;
@synthesize created;
@synthesize updated;
@synthesize timestamp;

- ( instancetype )init{
    self = [ super init ];
    if( self ){
        self.cId        = @"";
        self.created    = @"";
        self.updated    = @"";
        self.timestamp  = @"";
    }
    return self;
}

- ( instancetype )copyWithZone:(NSZone *)zone{
    AIDData *copyObj = [ [ [ self class ] allocWithZone: nil ] init ];
    
    copyObj.cId         = self.cId;
    copyObj.created     = self.created;
    copyObj.updated     = self.updated;
    copyObj.timestamp   = self.timestamp;
    return copyObj;
}

- ( NSDictionary* )getDictionary: ( NSString* )className{
    const char          *pszClassName   = [ className cStringUsingEncoding: [ NSString defaultCStringEncoding ] ];
    u_int               uCount          = 0;
    objc_property_t     *properties     = class_copyPropertyList( objc_getClass( pszClassName ), &uCount );
    NSMutableDictionary *dictionary     = [ [ NSMutableDictionary alloc ] initWithCapacity: uCount ];
    
    for( u_int i = 0; i < uCount; i++ ){
        NSString *key   = [ NSString stringWithUTF8String: property_getName( properties[ i ] ) ];
        NSString *value = [ self valueForKey: key ];
        
        if( value ) [ dictionary setObject: value forKey: key ];
    }
    free( properties );
    return dictionary;
}

- ( NSDictionary* )dictionaryRepresentation{
    NSString            *className  = NSStringFromClass( [ self class ] );
    NSMutableDictionary *dictionary = [ [ NSMutableDictionary alloc ] initWithDictionary: [ self getDictionary: className ] copyItems: YES ];
    
    if( ![ className isEqualToString: BaseClassName ] ) [ dictionary addEntriesFromDictionary: [ self getDictionary: BaseClassName ] ];
    return dictionary;

}

- ( void )setDataWithDictionary: ( NSDictionary* )dictionary{
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

- ( instancetype )init{
    self = [ super init ];
    if( self ){
        self.parentConsumerId   = @"";
        self.name               = @"";
        self.zip                = @"";
        self.phone              = @"";
        self.email              = @"";
    }
    return self;
}

- ( instancetype )copyWithZone:(NSZone *)zone{
    AIDDataConsumer *copyObj = [ super copyWithZone: zone ];
    
    copyObj.name    = self.name;
    copyObj.zip     = self.zip;
    copyObj.phone   = self.phone;
    copyObj.email   = self.email;
    return copyObj;
}

@end

#pragma mark AIDDataApplication
@implementation AIDDataApplication

@synthesize name;
@synthesize active;

- ( instancetype )init{
    self = [ super init ];
    if( self ){
        self.name   = @"";
        self.active = @"";
    }
    return self;
}


- ( instancetype )copyWithZone:(NSZone *)zone{
    AIDDataApplication *copyObj = [ super copyWithZone: zone ];
    
    copyObj.name    = self.name;
    copyObj.active  = self.active;
    return copyObj;
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


- ( instancetype )init{
    self = [ super init ];
    if( self ){
        self.anchorId   = @"";
        self.consumerId = @"";
        self.uuid       = @"";
        self.status     = @"";
        self.os         = @"";
        self.endpointArn= @"";
    }
    return self;
}

- ( instancetype )copyWithZone:(NSZone *)zone{
    AIDDataDevice *copyObj = [ super copyWithZone: zone ];
    
    copyObj.anchorId    = self.anchorId;
    copyObj.consumerId  = self.consumerId;
    copyObj.uuid        = self.uuid;
    copyObj.status      = self.status;
    copyObj.os          = self.os;
    copyObj.endpointArn = self.endpointArn;
    return copyObj;
}

@end

#pragma mark AIDDataTransaction
@implementation AIDDataTransaction

@synthesize recordId;
@synthesize consumerId;
@synthesize clientAppId;
@synthesize status;
@synthesize securityCode;


- ( instancetype )init{
    self = [ super init ];
    if( self ){
        self.recordId       = @"";
        self.consumerId     = @"";
        self.clientAppId    = @"";
        self.status         = @"";
        self.securityCode   = @"";
    }
    return self;
}

- ( instancetype )copyWithZone:(NSZone *)zone{
    AIDDataTransaction *copyObj = [ super copyWithZone: zone ];
    
    copyObj.recordId    = self.recordId;
    copyObj.consumerId  = self.consumerId;
    copyObj.clientAppId = self.clientAppId;
    copyObj.status      = self.status;
    copyObj.securityCode= self.securityCode;
    return copyObj;
}

@end

