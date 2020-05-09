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

@interface NSObject ()

@end

@implementation NSObject (Safety)

- (void)setObj:(id)obj {
    objc_setAssociatedObject(self, &objKey, obj, OBJC_ASSOCIATION_COPY_NONATOMIC);
}


- (id)obj {
    return objc_getAssociatedObject(self, &objKey);
}

- (NSObject *  _Nullable (^)(NSString * _Nullable))objForKey {
    return ^NSObject * _Nullable (NSString *key) {
        if (!key || !key.length) {
            return [NSObject new];
        }
        
        NSDictionary *dict = (NSDictionary *)self;
        if (self.obj) {
            dict = (NSDictionary *)self.obj;
        }
        if ([dict isKindOfClass:[NSDictionary class]]) {
            self.obj = [dict objectForKey:key];
            if ([self.obj isKindOfClass:[NSNull class]]) {
                return [NSObject new];
            }
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
        
        NSArray *array = (NSArray *)self;
        if (self.obj) {
            array = (NSArray *)self.obj;
        }
        if ([array isKindOfClass:[NSArray class]]) {
            if (array.count < index + 1) {
                return [NSObject new];
            }
            
            self.obj = [array objectAtIndex:index];
            if ([self.obj isKindOfClass:[NSNull class]]) {
                return [NSObject new];
            }
            return self;
        }
        return [NSObject new];
    };
}





@end
