#import <Foundation/Foundation.h>
@interface JastorRuntimeHelper : NSObject {
	
}
+ (BOOL)isPropertyExist:(Class)klass propertyName:(NSString*)propertyName;
+ (BOOL)isPropertyReadOnly:(Class)klass propertyName:(NSString*)propertyName;
+ (Class)propertyClassForPropertyName:(NSString *)propertyName ofClass:(Class)klass;
+ (NSArray *)propertyNames:(Class)klass;

@end
