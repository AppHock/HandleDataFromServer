//
//  NSObject+Safety.m
//  加法计算器
//
//  Created by Hock on 2020/5/9.
//  Copyright © 2020 Hock. All rights reserved.
//

#import "NSObject+Safety.h"
#import <objc/runtime.h>

static NSString *objKey     = @"obj";

@implementation NSObject (Safety)

- (void)setObj:(id)obj {
    objc_setAssociatedObject(self, &objKey, obj, OBJC_ASSOCIATION_COPY_NONATOMIC);
}


- (id)obj {
    id value = objc_getAssociatedObject(self, &valueKey);
    self.value = nil;
    return value;
    
}

- (NSObject *  _Nullable (^)(NSString * _Nullable))objForKey {
    return ^NSObject * _Nullable (NSString *key) {
        if (!key || !key.length) {
            return [NSObject new];
        }
        
        NSDictionary *dict = (NSDictionary *)self.obj;
        if (!dict) {
            dict = (NSDictionary *)self;
        }
        if ([dict isKindOfClass:[NSDictionary class]]) {
            if ([[dict objectForKey:key] isKindOfClass:[NSNull class]]) {
                return [NSObject new];
            }
            self.obj = [dict objectForKey:key];
            return self;
        }
        return [NSObject new];
    };
}

- (NSObject *  _Nullable (^)(NSInteger))objAtIndex {
    return ^NSObject * _Nullable (NSInteger index) {
        if (index < 0) {
            return [NSObject new];
        }
        
        NSArray *array = (NSArray *)self.obj;
        if (!array) {
            array = (NSArray *)self;
        }
        if ([array isKindOfClass:[NSArray class]]) {
            if (array.count < index + 1) {
                return [NSObject new];
            }
            
            if ([[array objectAtIndex:index] isKindOfClass:[NSNull class]]) {
                return [NSObject new];
            }
            self.obj = [array objectAtIndex:index];
            return self;
        }
        return [NSObject new];
    };
}





@end
