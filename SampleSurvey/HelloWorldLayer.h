//
//  HelloWorldLayer.h
//  SampleSurvey
//
//  Created by Amin Tavassolian on 11-10-28.
//  Copyright University of Saskatchewan 2011. All rights reserved.
//


// When you import this file, you import all the cocos2d classes
#import "cocos2d.h"
#import "SurveyState.h"

// HelloWorldLayer
@interface HelloWorldLayer : CCLayer
{
    CCSprite* solidBackground;
    CCSprite* firstAnswerBtn;
    CCSprite* secondAnswerBtn;
    CCSprite* thirdAnswerBtn;
    CCSprite* exitBtn;
    CCLabelTTF* questionLbl;
    CCLabelTTF* answer1Lbl;
    CCLabelTTF* answer2Lbl;
    CCLabelTTF* answer3Lbl;
    BOOL _isItActive;
    
    SurveyState* _surveyState;
    NSString* _fileName;
    //id<SurveyStateProtocol> _serveyProtocol;
}

//properties
//@property (nonatomic, retain) id<SurveyStateProtocol> serveyProtocol;
@property (nonatomic, retain) SurveyState* surveyState;
@property (nonatomic, assign)BOOL isItActive;
//class mathods

// returns a CCScene that contains the HelloWorldLayer as the only child
+(CCScene *) scene;

//instance methods
-(void)UIInitializerWithquestion:(NSString*)question FirstAnswer:(NSString*)answer1 SecondAnswer:(NSString*)answer2 ThirdAnswer:(NSString*)answer3;
//-(bool)ParserAndInitialize:(NSArray*)dataArray ForQuestionNumber:(int)questionNum;
-(bool)InitializeUIWithArray:(NSMutableArray*)dataArray;
-(void)Closing;

@end
