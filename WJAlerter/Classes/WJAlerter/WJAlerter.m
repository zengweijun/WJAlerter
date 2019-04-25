//
//  Alerter.m
//  Alerter
//
//  Created by 曾维俊 on 2019/4/10.
//  Copyright © 2019年 Nius. All rights reserved.
//

#import "WJAlerter.h"

@interface UIAlertAction (WJAlerter)
@property (assign, nonatomic) NSTextAlignment wjTitleTextAlignment;
@property (strong, nonatomic) UIColor *wjTitleColor;
@property (strong, nonatomic) UIImage *wjImage;
@end

@implementation UIAlertAction (WJAlerter)
- (void)setWjTitleTextAlignment:(NSTextAlignment)wjTitleTextAlignment {
    [self setValue:[NSNumber numberWithInteger:wjTitleTextAlignment] forKey:@"titleTextAlignment"];
}
- (NSTextAlignment)wjTitleTextAlignment {
    return [[self valueForKey:@"titleTextAlignment"] integerValue];
}
- (void)setWjImage:(UIImage *)wjImage {
    [self setValue:[wjImage imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal] forKey:@"image"];
}
- (UIImage *)wjImage {
    return [self valueForKey:@"image"];
}
- (void)setWjTitleColor:(UIColor *)wjTitleColor {
    [self setValue:wjTitleColor forKey:@"titleTextColor"];
}
- (UIColor *)wjTitleColor {
    return [self valueForKey:@"titleTextColor"];
}
@end

@interface UIAlertController (WJAlerter)
@property (copy, nonatomic) NSAttributedString *wjAttributedTitle;
@property (copy, nonatomic) NSAttributedString *wjAttributedMessage;
@end

@implementation UIAlertController (WJAlerter)
- (void)setWjAttributedTitle:(NSAttributedString *)wjAttributedTitle {
    [self setValue:wjAttributedTitle forKey:@"attributedTitle"];
}
- (NSAttributedString *)wjAttributedTitle {
    return [self valueForKey:@"attributedTitle"];
}
- (void)setWjAttributedMessage:(NSAttributedString *)wjAttributedMessage {
    [self setValue:wjAttributedMessage forKey:@"attributedMessage"];
}
- (NSAttributedString *)wjAttributedMessage {
    return [self valueForKey:@"attributedMessage"];
}
@end

static WJAlerter *alert;
@interface WJAlertController : UIAlertController
@end
@implementation WJAlertController
- (void)dealloc {
    alert = nil;
}
@end

@implementation WJAlerterAction {
@public
    UIColor *_color;
    UIImage *_image;
    NSTextAlignment _alignment;
    WJActionCb _action;
    WJAlerterActionStyle _style;
    NSString *_title;
}

- (instancetype)init {
    self = [super init];
    if (self) {
        _alignment = NSTextAlignmentCenter;
    }
    return self;
}

- (WJAlerterAction * (^)(UIImage *image))image {
    return ^(UIImage *image) {
        self->_image = image;
        return self;
    };
}

- (WJAlerterAction * (^)(UIColor *color))color {
    return ^(UIColor *color) {
        self->_color = color;
        return self;
    };
}

- (WJAlerterAction * (^)(NSString *title))title {
    return ^(NSString *title) {
        self->_title = title;
        return self;
    };
}

- (WJAlerterAction * (^)(NSTextAlignment alignment))alignment {
    return ^(NSTextAlignment alignment) {
        self->_alignment = alignment;
        return self;
    };
}

- (WJAlerterAction * (^)(WJAlerterActionStyle style))style {
    return ^(WJAlerterActionStyle style) {
        self->_style = style;
        return self;
    };
}

- (WJAlerterAction * (^)(WJActionCb action))handler {
    return ^(WJActionCb action) {
        self->_action = action;
        return self;
    };
}

@end

@implementation WJAlerter {
    NSString *_title;
    UIFont   *_titleFont;
    UIColor  *_titleColor;
    NSString *_message;
    UIFont   *_messageFont;
    UIColor  *_messageColor;
    WJAlerterStyle _style;
    NSMutableArray *_actions;
}

+ (WJAlerter * (^)(void))create {
    return ^{
        if (!alert) {
            alert = [WJAlerter new];
        }
        return alert;
    };
}

- (instancetype)init {
    if (self = [super init]) {
        _actions = @[].mutableCopy;
        _style = WJAlerterStyleAlert;
    }
    return self;
}

- (WJAlerter * (^)(NSString *title))title {
    return ^(NSString *title) {
        self->_title = title;
        return self;
    };
}

- (WJAlerter * (^)(NSString *message))message {
    return ^(NSString *message) {
        self->_message = message;
        return self;
    };
}

- (WJAlerter * (^)(WJAlerterStyle style))style {
    return ^(WJAlerterStyle style) {
        self->_style = style;
        return self;
    };
}

- (WJAlerter * (^)(UIColor *color))titleColor {
    return ^(UIColor *color) {
        self->_titleColor = color;
        return self;
    };
}

- (WJAlerter * (^)(UIFont *font))titleFont {
    return ^(UIFont *font) {
        self->_titleFont = font;
        return self;
    };
}

- (WJAlerter * (^)(UIFont *font))messageFont {
    return ^(UIFont *font) {
        self->_messageFont = font;
        return self;
    };
}

- (WJAlerter * (^)(UIColor *color))messageColor {
    return ^(UIColor *color) {
        self->_messageColor = color;
        return self;
    };
}

- (WJAlerter * (^)(UIAlertAction *alerterAction))addSysAction; {
    return ^(UIAlertAction *alerterAction) {
        [self->_actions addObject:alerterAction];
        return self;
    };
}

- (WJAlerter * (^)(void(^)(WJAlerterAction *)))addAction {
    return ^(void(^configAction)(WJAlerterAction *alerterAction)) {
        WJAlerterAction *alerterAction = [WJAlerterAction new];
        configAction(alerterAction);
        [self->_actions addObject:alerterAction];
        return self;
    };
}

- (void (^)(void))show {
    return ^{
        [self _show];
    };
}

- (void)_show {
    // Config Alert VC
    WJAlertController *alertVc = [WJAlertController alertControllerWithTitle:self->_title
                                                                     message:self->_message
                                                              preferredStyle:(UIAlertControllerStyle)self->_style];
    
    
    NSMutableAttributedString * (^configStr)(NSString *text, UIFont *font, UIColor *color) =
    ^(NSString *text, UIFont *font, UIColor *color) {
        
        NSMutableAttributedString *titleAttrStr = nil;
        if (!text) return titleAttrStr;
        
        NSMutableDictionary *attrs = @{}.mutableCopy;
        [attrs setValue:font  forKey:NSFontAttributeName];
        [attrs setValue:color forKey:NSForegroundColorAttributeName];
        titleAttrStr = [[NSMutableAttributedString alloc] initWithString:text
                                                              attributes:attrs];
        return titleAttrStr;
    };
    
    alertVc.wjAttributedTitle = configStr(self->_title, self->_titleFont, self->_titleColor);
    alertVc.wjAttributedMessage = configStr(self->_message, self->_messageFont, self->_messageColor);
    
    for (WJAlerterAction *alertAction in self->_actions) {
        UIAlertAction *UIAlertItem;
        if ([alertAction isMemberOfClass:UIAlertAction.class]) {
            UIAlertItem = (UIAlertAction *)alertAction;
        } else {
            UIAlertItem = [UIAlertAction actionWithTitle:alertAction->_title
                                                   style:(UIAlertActionStyle)alertAction->_style
                                                 handler:^(UIAlertAction * _Nonnull action) {
                alertAction->_action?alertAction->_action():nil;
                alert = nil;
            }];
            UIAlertItem.wjImage = alertAction->_image;
            UIAlertItem.wjTitleColor = alertAction->_color;
            UIAlertItem.wjTitleTextAlignment = alertAction->_alignment;
        }
        [alertVc addAction:UIAlertItem];
    }
    
    [self.getCurrentVC presentViewController:alertVc animated:YES completion:NULL];
}

- (void)dealloc {
    for (WJAlerterAction *alertAction in self->_actions) {
        if (![alertAction isMemberOfClass:[UIAlertAction class]]) {
            alertAction->_action = nil;
        }
    }
    [self->_actions removeAllObjects];
}

//获取当前屏幕显示的viewcontroller
- (UIViewController *)getCurrentVC {
    UIViewController *rootViewController = [UIApplication sharedApplication].keyWindow.rootViewController;
    UIViewController *currentVC = [self getCurrentVCFrom:rootViewController];
    return currentVC;
}

- (UIViewController *)getCurrentVCFrom:(UIViewController *)rootVC {
    UIViewController *currentVC;
    if ([rootVC presentedViewController]) {
        // 视图是被presented出来的
        rootVC = [rootVC presentedViewController];
    }
    
    if ([rootVC isKindOfClass:[UITabBarController class]]) {
        // 根视图为UITabBarController
        currentVC = [self getCurrentVCFrom:[(UITabBarController *)rootVC selectedViewController]];
    } else if ([rootVC isKindOfClass:[UINavigationController class]]){
        // 根视图为UINavigationController
        currentVC = [self getCurrentVCFrom:[(UINavigationController *)rootVC visibleViewController]];
    } else {
        // 根视图为非导航类
        currentVC = rootVC;
    }
    
    return currentVC;
}


@end
