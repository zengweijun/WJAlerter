//
//  ViewController.m
//  WJAlerter
//
//  Created by ybf on 2019/4/15.
//  Copyright © 2019 nius. All rights reserved.
//

#import "ViewController.h"
#import "WJAlerter.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    int condition = 1;
    if (condition) {
        WJAlerter.create()
        .title(@"这是标题")
        .titleColor([UIColor blueColor])
        .addAction(^(WJAlerterAction *action){
            action.title(@"确定").color([UIColor greenColor]).handler(^{
                NSLog(@"点击了-->确定");
            });
        })
        .addAction(^(WJAlerterAction *action){
            action.title(@"取消").color([UIColor lightGrayColor]);
        })
        .show();
    } else {
        WJAlerter.create()
        .title(@"这是标题")
        .titleColor([UIColor blueColor])
        .addAction(^(WJAlerterAction *action){
            action.title(@"确定").color([UIColor lightGrayColor]).handler(^{
                NSLog(@"点击了-->确定");
            });
        })
        .addAction(^(WJAlerterAction *action){
            action.title(@"占位").color([UIColor redColor]).handler(^{
                NSLog(@"点击了-->占位");
            });
        })
        .addAction(^(WJAlerterAction *action){
            action.title(@"取消").color([UIColor greenColor]);
        })
        .show();
    }
    
}


@end
