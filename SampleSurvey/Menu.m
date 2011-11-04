//
//  Menu.m
//  SampleSurvey
//
//  Created by Amin Tavassolian on 11-11-04.
//  Copyright (c) 2011 University of Saskatchewan. All rights reserved.
//

#import "Menu.h"

@implementation Menu

//
//scene function to create a scene and add the current layer to it
//
+(CCScene *) scene
{
	// 'scene' is an autorelease object.
	CCScene *menuScene = [CCScene node];
	
	// 'layer' is an autorelease object.
	Menu *menuLayer = [Menu node];
	
	// add layer as a child to scene
	[menuScene addChild: menuLayer];
	
	// return the scene
	return menuScene;
}

//
//
//
-(void)dealloc
{
    [_surveyState release];
    [super dealloc];
}


//
//
//
-(id)init
{
    if( (self=[super init]))
    {
        // ask director the the window size
		CGSize size = [[CCDirector sharedDirector] winSize];
        
        //background
        _menuBackgroundSprite = [CCSprite spriteWithFile:@"opaque_background.png"];
        [self addChild:_menuBackgroundSprite z:0];
        
        //feedback button
        _feedbackBtnSprite = [CCSprite spriteWithFile:@"Icon-72.png"];
        [_feedbackBtnSprite setPosition:ccp((int)(size.width/2), (int)(size.height/2))];
        [self addChild:_feedbackBtnSprite z:1];
        
        //SurveyState instance
        _surveyState = [[SurveyState alloc] init];
        
        //enabling the touch
        self.isTouchEnabled = YES;
    }
    return self;
}

//
//touch event handler
//
-(void)ccTouchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    UITouch *touchesArray = [touches anyObject];
    CGPoint location = [touchesArray locationInView: [touchesArray view]];
    location = [[CCDirector sharedDirector] convertToGL: location];
    if (location.x >= _feedbackBtnSprite.position.x - (int)(_feedbackBtnSprite.contentSize.width/2) && location.x <= _feedbackBtnSprite.position.x + (int)(_feedbackBtnSprite.contentSize.width/2) && location.y >= _feedbackBtnSprite.position.y - (int)(_feedbackBtnSprite.contentSize.height/2) && location.y <= _feedbackBtnSprite.position.y + (int)(_feedbackBtnSprite.contentSize.height/2))
    {
        if ([_surveyState LoadSurvey:_surveyState.fileName] != nil)
        {
            //start the feedback scene
            [[CCDirector sharedDirector] pushScene:[HelloWorldLayer scene]];
        }
        else
        {
            //DO NOTHING!
        }
    }
}

@end
