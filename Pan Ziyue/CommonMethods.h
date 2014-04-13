//
//  CommonMethods.h
//  Pan Ziyue
//
//  Common methods used in this app packed in a single NSObject
//
//  Created by Pan Ziyue on 10/4/14.
//  Copyright (c) 2014 StatiX Industries. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <StoreKit/StoreKit.h>

@interface CommonMethods : NSObject

+(void)labelAnimateEaseIn:(UILabel *)label delegate:(id)delegate timeTaken:(NSTimeInterval)duration completion:(SEL)selector;
+(void)labelAnimateEaseIn:(UILabel *)label delegate:(id)delegate timeTaken:(NSTimeInterval)duration completionBlock:(void (^)(BOOL))block;
+(UIInterpolatingMotionEffect *)getInterpolatingMotionEffect:(NSString *)type minMaxValues:(NSInteger)minMaxValues;
+(void)openAppStoreWithIdentifier:(NSInteger)appStoreIdent withDelegate:(id)delegate;
//+(void);

@end
