//
//  AppDelegate.h
//  SampleSurvey
//
//  Created by Amin Tavassolian on 11-10-28.
//  Copyright University of Saskatchewan 2011. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Menu.h"

@class RootViewController;

@interface AppDelegate : NSObject <UIApplicationDelegate> {
	UIWindow			*window;
	RootViewController	*viewController;
}

@property (nonatomic, retain) UIWindow *window;

@end
