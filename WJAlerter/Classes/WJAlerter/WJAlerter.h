//
//  WJAlerter.h
//  WJAlerter
//
//  Created by 曾维俊 on 2019/4/10.
//  Copyright © 2019年 Nius. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

typedef NS_ENUM(NSInteger, WJAlerterActionStyle) {
    WJAlerterActionStyleDefault = UIAlertActionStyleDefault,
    WJAlerterActionStyleCancel = UIAlertActionStyleCancel,
    WJAlerterActionStyleDestructive = UIAlertActionStyleDestructive
};

typedef NS_ENUM(NSInteger, WJAlerterStyle) {
    WJAlerterStyleActionSheet = UIAlertControllerStyleActionSheet,
    WJAlerterStyleAlert = UIAlertControllerStyleAlert
};

typedef void(^WJActionCb)(void);

@interface WJAlerterAction : NSObject

- (WJAlerterAction * (^)(UIImage *image))image;
- (WJAlerterAction * (^)(UIColor *color))color;
- (WJAlerterAction * (^)(NSString *title))title;
- (WJAlerterAction * (^)(NSTextAlignment alignment))alignment;
- (WJAlerterAction * (^)(WJAlerterActionStyle style))style;
- (WJAlerterAction * (^)(WJActionCb action))handler;

@end

/**
 可拆卸式AlertView
 使用addAction方法添加按钮
 */
@interface WJAlerter : NSObject

+ (WJAlerter * (^)(void))create;
- (WJAlerter * (^)(NSString *title))title;
- (WJAlerter * (^)(UIFont *font))titleFont;
- (WJAlerter * (^)(UIColor *color))titleColor;
- (WJAlerter * (^)(NSString *message))message;
- (WJAlerter * (^)(UIFont *font))messageFont;
- (WJAlerter * (^)(UIColor *color))messageColor;
- (WJAlerter * (^)(WJAlerterStyle style))style;
- (WJAlerter * (^)(UIAlertAction *alerterAction))addSysAction;
- (WJAlerter * (^)(void(^)(WJAlerterAction *alerterAction)))addAction;
- (void (^)(void))show;

@end

NS_ASSUME_NONNULL_END
