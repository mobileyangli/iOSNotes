//
//  ISNApperanceCalibrator.h
//  iOSNotes
//
//  使用第三方字体，经常需要更改UINavigationBar导航条等Font字体样式，以及返回HTML内容的字体样式
//
//  Created by 杨冬凌 on 16/4/11.
//  Copyright © 2016年 yangdongling. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface ISNApperanceCalibrator : NSObject
+ (instancetype)sharedCalibrator;
- (void)adjustNavigationBar:(UINavigationBar *)bar;
- (void)adjustNavigationBarButton;
- (NSString *)adjustHtmlFont:(NSString *)html;

@end
