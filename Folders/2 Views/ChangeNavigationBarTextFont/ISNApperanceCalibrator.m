//
//  ISNApperanceCalibrator.m
//  iOSNotes
//
//  Created by 杨冬凌 on 16/4/11.
//  Copyright © 2016年 yangdongling. All rights reserved.
//

#import "ISNApperanceCalibrator.h"
static ISNApperanceCalibrator* instanceCalibrator = nil;

static NSString* APP_FONTNAME_TITLE = @"DIN-Light";

@implementation ISNApperanceCalibrator
+ (instancetype)sharedCalibrator {
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        instanceCalibrator = [ISNApperanceCalibrator new];
    });
    return instanceCalibrator;
}

- (void)adjustNavigationBar:(UINavigationBar*)bar {
    [bar setTitleTextAttributes:@{ NSFontAttributeName : [UIFont fontWithName:APP_FONTNAME_TITLE size:20], NSForegroundColorAttributeName : [UIColor redColor] }];
}
- (void)adjustNavigationBarButton {
    [[UIBarButtonItem appearance] setTitleTextAttributes:@{ NSFontAttributeName : [UIFont fontWithName:APP_FONTNAME_TITLE size:20],
                                                            NSForegroundColorAttributeName : [UIColor redColor] }
                                                forState:UIControlStateNormal];
}

- (NSString*)adjustHtmlFont:(NSString*)html {
    return [NSString stringWithFormat:@"<span style=\"font-family:DIN-Regular\">%@</span>", html];
}

@end
