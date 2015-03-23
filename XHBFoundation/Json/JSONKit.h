
@interface NSString (JSONKitDeserializing)
- (id)objectFromJSONString;

@end

@interface NSData (JSONKitDeserializing)
// The NSData MUST be UTF8 encoded JSON.
- (id)objectFromJSONData;

@end

////////////
#pragma mark Serializing methods
////////////

@interface NSString (JSONKitSerializing)

- (NSData *)JSONData;

- (NSString *)XHBJSONString;
@end

@interface NSArray (JSONKitSerializing)
- (NSData *)JSONData;

- (NSString *)XHBJSONString;

@end

@interface NSDictionary (JSONKitSerializing)

- (NSString *)XHBJSONString;

@end