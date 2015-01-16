//
//  AIDDataManager.m
//  
//
//  Created by Dmytro Barsukov on 1/13/15.
//  Copyright (c) 2015 Dmytro Barsukov. All rights reserved.
//

#import "AIDDataManager.h"

#pragma mark Globals
NSString *const AIDKeyChainService = @"com.anchoridTest";

#pragma mark Errors
NSInteger const ErrorAIDDataManagerKeyChainEmptyCode   = 101;
NSString* const ErrorAIDDataManagerKeyChainEmpty        = @"Keychain are empty";

#pragma mark Constants for internal key names in Keychain store
NSString* const KeyAIDDataManagerConsumer                   = @"consumer";
NSString* const KeyAIDDataManagerApplications               = @"applications";
NSString* const KeyAIDDataManagerSerializedApplications     = @"serializedApplications";
NSString* const KeyAIDDataManagerDevice                     = @"device";
NSString* const KeyAIDDataManagerSerializedTransactions     = @"serializedTransactions";
NSString* const KeyAIDDataManagerTransactions               = @"transactions";

#pragma mark Private~
@interface AIDDataManager(){
    UICKeyChainStore    *keychainStore;
    NSMutableArray      *serializedApplications;    // array of dictionaries
    NSMutableArray      *serializedTransactions;    // array of dictionaries
}

@property ( nonatomic ) NSMutableArray *serializedApplications;
@property ( nonatomic ) NSMutableArray *serializedTransactions;

@end

#pragma mark AIDDataManager implementation
@implementation AIDDataManager
@synthesize consumer;
@synthesize applications;
@synthesize device;
@synthesize transactions;
@synthesize serializedApplications;
@synthesize serializedTransactions;

#pragma mark Init
+ ( id )sharedManager{
    static AIDDataManager   *sharedDataManager = nil;
    static dispatch_once_t  onceToken;
    
    dispatch_once( &onceToken, ^{ sharedDataManager = [ self new ]; } );
    return sharedDataManager;
}

- ( id )init{
    if( ( self = [ super init ] ) ){
        keychainStore               = [ UICKeyChainStore keyChainStoreWithService: AIDKeyChainService ];
        self.consumer               = [ AIDDataConsumer new ];
        self.applications           = [ NSMutableArray new ];
        self.device                 = [ AIDDataDevice new ];
        self.transactions           = [ NSMutableArray new ];
        self.serializedApplications = [ NSMutableArray new ];
        self.serializedTransactions = [ NSMutableArray new ];
    }
    return self;
}

#pragma mark Keychain save/load
#define IS_ARRAY( __k )     ( [ __k isEqual: KeyAIDDataManagerSerializedApplications ] || [ __k isEqual: KeyAIDDataManagerSerializedTransactions ] )
#define DATA_OBJECT( __k )  [ self valueForKey: __k ]

- ( AIDData* )getAIDDataObjectForKey: ( NSString* )key{
    //////////////////////////////////////////////////////////////////////////////////
    // for future use
    //
    AIDData *aData = [ key isEqual: KeyAIDDataManagerApplications ] ? [ AIDDataApplication new ] : [ AIDDataTransaction new ];
    return aData;
}

- ( void )fillArrayOfObjectsForKey: ( NSString* )key andData: ( NSArray* )data{
    //////////////////////////////////////////////////////////////////////////////////
    // key map from serialized array
    //
    key = [ key isEqual: KeyAIDDataManagerSerializedApplications ] ? KeyAIDDataManagerApplications : KeyAIDDataManagerTransactions;

    for( NSDictionary *d in data ){
        AIDData *aData = [ self getAIDDataObjectForKey: key ];
        
        [ aData dataWithDictionary: d ];
        [ DATA_OBJECT( key ) addObject: aData ];
    }
}

- ( NSError* )loadDataFromKeyChainStoreForKey: ( NSString* )key{
    NSData  *jsonData   = [ keychainStore dataForKey: key ];
    NSError *error      = nil;
    
    if( !jsonData )
        error = [ NSError errorWithDomain: NSMachErrorDomain
                                     code: ErrorAIDDataManagerKeyChainEmptyCode
                                 userInfo: @{ NSLocalizedDescriptionKey: NSLocalizedString( ErrorAIDDataManagerKeyChainEmpty, nil ) } ];
    else{
        id data = [ NSJSONSerialization JSONObjectWithData: jsonData options: NSJSONReadingMutableContainers error: &error ];

        if( error ) return error;
        if( IS_ARRAY( key ) ) [ self fillArrayOfObjectsForKey: key andData: data ];
        else [ DATA_OBJECT( key ) dataWithDictionary: data ];
    }
    return error;
}

- ( NSError* )saveDataToKeyChainStoreForKey: ( NSString* )key{
    id      data    = IS_ARRAY( key ) ? DATA_OBJECT( key ) : [ DATA_OBJECT( key ) dictionaryRepresentation ]; // Array or dictionary
    NSError *error  = nil;
    
    if( data ){
        NSData *jsonData = [ NSJSONSerialization dataWithJSONObject: data
                                                            options: NSJSONWritingPrettyPrinted
                                                              error: &error ];
        
        if( !error ){
            [ keychainStore setData: jsonData forKey: key ];
            [ keychainStore synchronize ];
        }
    }
    return error;
}

#pragma mark User data managment methods fetch
- ( NSError* )fetchConsumer{
    NSError *error = nil;
    
    error = [ self loadDataFromKeyChainStoreForKey: KeyAIDDataManagerConsumer ];
    return error;
}

- ( NSError* )fetchApplications{
    NSError *error = nil;
    
    if( self.applications.count ) [ self.applications removeAllObjects ];
    if( self.serializedApplications.count ) [ self.serializedApplications removeAllObjects ];
    error = [ self loadDataFromKeyChainStoreForKey: KeyAIDDataManagerSerializedApplications ];
    return error;
}

- ( NSError* )fetchDevice{
    NSError *error = nil;
    
    error = [ self loadDataFromKeyChainStoreForKey: KeyAIDDataManagerDevice ];
    return error;
}

- ( NSError* )fetchTransactions{
    NSError *error = nil;
    
    return error;
}

#pragma mark User data managment methods store
- ( NSError* )storeConsumer{
    NSError *error = nil;
    
    error = [ self saveDataToKeyChainStoreForKey: KeyAIDDataManagerConsumer ];
    return error;
}

- ( NSError* )storeApplications{
    NSError *error = nil;

    //////////////////////////////////////////////////////////////////////////////////
    // Converting to array of dictionaries
    //
    if( self.serializedApplications.count ) [ self.serializedApplications removeAllObjects ];
    for( id a in self.applications ) [ self.serializedApplications addObject: [ a dictionaryRepresentation ] ];
    error = [ self saveDataToKeyChainStoreForKey: KeyAIDDataManagerSerializedApplications ];
    return error;
}

- ( NSError* )storeDevice{
    NSError *error = nil;
    
    return [ self saveDataToKeyChainStoreForKey: KeyAIDDataManagerDevice ];
    return error;
}

- ( NSError* )storeTransactions{
    NSError *error = nil;
    
    return error;
}

@end
