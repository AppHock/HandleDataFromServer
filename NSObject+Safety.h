//
//  NSObject+Safety.h
//  加法计算器
//
//  Created by Hock on 2020/5/9.
//  Copyright © 2020 Hock. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface NSObject (Safety)

@property (nonatomic, strong) id obj;

- (NSObject * _Nullable (^)(NSString * _Nullable))objForKey;
- (NSObject * _Nullable (^)(NSInteger))objAtIndex;

@end

NS_ASSUME_NONNULL_END
