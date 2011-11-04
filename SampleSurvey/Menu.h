//
//  Menu.h
//  SampleSurvey
//
//  Created by Amin Tavassolian on 11-11-04.
//  Copyright (c) 2011 University of Saskatchewan. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "cocos2d.h"
#import "SurveyState.h"
#import "HelloWorldLayer.h"

@interface Menu : CCLayer
{
    CCSprite* _menuBackgroundSprite;
    CCSprite* _feedbackBtnSprite;
    SurveyState* _surveyState;
}

//class mthods
+(CCScene *) scene;

//instance methods
    
@end
