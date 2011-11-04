//
//  HelloWorldLayer.m
//  SampleSurvey
//
//  Created by Amin Tavassolian on 11-10-28.
//  Copyright University of Saskatchewan 2011. All rights reserved.
//


// Import the interfaces
#import "HelloWorldLayer.h"


// HelloWorldLayer implementation
@implementation HelloWorldLayer

@synthesize surveyState = _surveyState;
@synthesize isItActive = _isItActive;

+(CCScene *) scene
{
	// 'scene' is an autorelease object.
	CCScene *scene = [CCScene node];
	
	// 'layer' is an autorelease object.
	HelloWorldLayer *layer = [HelloWorldLayer node];
	
	// add layer as a child to scene
	[scene addChild: layer];
	
	// return the scene
	return scene;
}

// on "init" you need to initialize your instance
-(id) init
{
	// always call "super" init
	// Apple recommends to re-assign "self" with the "super" return value
	if( (self=[super init]))
    {	
		//set the state of the survey
        _isItActive = YES;
        
        // ask director the the window size
		CGSize size = [[CCDirector sharedDirector] winSize];
        
        //background sprite
        CCSprite* backgroundSprite = [CCSprite spriteWithFile:@"feedback_popup.png"];
        [backgroundSprite setPosition:ccp (size.width/2, size.height/2)];
        backgroundSprite.rotation = -90.0;

        //background sprite
        solidBackground = [CCSprite spriteWithFile:@"opaque_background.png"];
        [backgroundSprite setPosition:ccp (size.width/2, size.height/2)];
        backgroundSprite.rotation = -90.0;
        
        //adding background sprite to the layer
        [self addChild: backgroundSprite z:1];
        [self addChild: solidBackground z:0];
        
        //buttons
        firstAnswerBtn = [CCSprite spriteWithFile:@"answer_button.png"];
        secondAnswerBtn = [CCSprite spriteWithFile:@"answer_button.png"];
        thirdAnswerBtn = [CCSprite spriteWithFile:@"answer_button.png"];
        exitBtn = [CCSprite spriteWithFile:@"nothanks_button.png"];
        
        firstAnswerBtn.position =  ccp(272, 168);
        secondAnswerBtn.position =  ccp(309, 168);
        thirdAnswerBtn.position =  ccp(346, 168);
        exitBtn.position =  ccp(384, 232);
        
        firstAnswerBtn.rotation = -90.0;
        secondAnswerBtn.rotation = -90.0;
        thirdAnswerBtn.rotation = -90.0;
        exitBtn.rotation = -90.0;
        //backgroundSprite.rotation = ;
        
        [self addChild: firstAnswerBtn z:2];
        [self addChild: secondAnswerBtn z:2];
        [self addChild: thirdAnswerBtn z:2];
        [self addChild: exitBtn z:2];
        
        //question lableuestio
        questionLbl = [CCLabelTTF labelWithString:@"question" dimensions:CGSizeMake(210, 60) alignment:UITextAlignmentCenter lineBreakMode:UILineBreakModeWordWrap fontName: @"Marker Felt" fontSize:16];
        [questionLbl setColor:ccc3(0, 0, 0)];
        questionLbl.position = ccp(240, 168);
        questionLbl.rotation = -90;
        [self addChild:questionLbl z:3];
        
        //answer1label
        answer1Lbl = [CCLabelTTF labelWithString:@"a1" fontName:@"Marker Felt" fontSize:16];
        [answer1Lbl setColor:ccc3(0, 0, 0)];
        answer1Lbl.position = ccp(272, 168);
        answer1Lbl.rotation = -90;
        [self addChild:answer1Lbl z:3];
        
        //answer2label
        answer2Lbl = [CCLabelTTF labelWithString:@"a2" fontName:@"Marker Felt" fontSize:16];
        [answer2Lbl setColor:ccc3(0, 0, 0)];
        answer2Lbl.position = ccp(309, 168);
        answer2Lbl.rotation = -90;
        [self addChild:answer2Lbl z:3];
        
        //answer3label
        answer3Lbl = [CCLabelTTF labelWithString:@"a3" fontName:@"Marker Felt" fontSize:16];
        [answer3Lbl setColor:ccc3(0, 0, 0)];
        answer3Lbl.position = ccp(346, 168);
        answer3Lbl.rotation = -90;
        [self addChild:answer3Lbl z:3];
        
        //adding the state instance for the survey
        _surveyState = [[SurveyState alloc] init];
        _fileName = _surveyState.fileName;
        //NSArray* dataArray = [_surveyState ReadFromFile: _fileName];
        //NSArray* dataArray = [_surveyState loadData:@"QuestionDictionary.xml"];
        //[self ParserAndInitialize:dataArray ForQuestionNumber:2];
        [self InitializeUIWithArray:[_surveyState LoadSurvey:_fileName]]; 
        
        //enabiling touch
        self.isTouchEnabled = YES;
	}
	return self;
}

// on "dealloc" you need to release all your retained objects
- (void) dealloc
{
	free(firstAnswerBtn);
    free(secondAnswerBtn);
    free(thirdAnswerBtn);
    free(questionLbl);
    free(exitBtn);
    free(solidBackground);
    free(answer1Lbl);
    free(answer2Lbl);
    free(answer3Lbl);
    free(_surveyState);
    free(_fileName);
	// don't forget to call "super dealloc"
	[super dealloc];
}

//
//touch handler
//
-(void)ccTouchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    UITouch *touchesArray = [touches anyObject];
    CGPoint Location = [touchesArray locationInView: [touchesArray view]];
    Location = [[CCDirector sharedDirector] convertToGL: Location];
    if ([self isItActive])
    {
        //questionLbl.string = [NSString stringWithFormat:@"x=%f y=%f", Location.x, Location.y];
        int btnWidth = 20;
        int btnHeight = 160;
        //NSString* res = [[NSString alloc] initWithFormat:@"x = %f y = %f", Location.x, Location.y];
        //questionlBL.string = res;
    
        if (Location.x >= 270 && Location.x <= 270 + btnWidth
        && Location.y >= 100 && Location.y <= 260)
            {
                //_surveyState.isCompleted = YES; 
                [self Closing];
                [questionLbl setString:@"Thanks!"];
                [[self surveyState] UserAnsweredToQuestionNumber:[_surveyState questionNum] WithAnswer:1];
            }
        if (Location.x >= 310 && Location.x <= 310 + btnWidth
             && Location.y >= 100 && Location.y <= 260)
        {
            //_surveyState.isCompleted = YES;
            [self Closing];
            [questionLbl setString:@"Thanks!"];
            [[self surveyState] UserAnsweredToQuestionNumber:[_surveyState questionNum] WithAnswer:2];
        }
        else if (Location.x >= 340 && Location.x <= 340 + btnWidth
             && Location.y >= 100 && Location.y <= 260)
        {
            //_surveyState.isCompleted = YES;
            [self Closing];
            [questionLbl setString:@"Thanks!"];
            [[self surveyState] UserAnsweredToQuestionNumber:[_surveyState questionNum] WithAnswer:3];
        }
        else if (Location.x >= exitBtn.position.x && Location.x <= exitBtn.position.x + exitBtn.contentSize.width
             && Location.y >= exitBtn.position.y && Location.y <= exitBtn.position.y + exitBtn.contentSize.height)
        {
            //_surveyState.isCompleted = NO;
            [self Closing];
            [questionLbl setString:@"Thanks!"];
            [[self surveyState] UserDidNotAnswerToQuestionNumber:[_surveyState questionNum]];
        }
    }
    else
    {
        //terminate the program
    }
    
}
/*
-(BOOL) ccTouchBegan:(NSSet *)touch withEvent:(UIEvent *)event
{
    CCLOG(@"touched");
    questionlBL.string = @"touched";
    NSSet *touches = [event allTouches];
    if ( [touches count] == 1)
    {
        CGPoint touchLocation = [touch locationInView: [touch view]];		
        touchLocation = [[CCDirector sharedDirector] convertToGL: touchLocation];
        NSString* res = [[NSString alloc] initWithFormat:@"x = %f y = %f", touchLocation.x, touchLocation.y];
        questionlBL.string = res;
        if ( touchLocation.x >= firstAnswerbTN.position.x && touchLocation.x <= touchLocation.x + firstAnswerbTN.contentSize.width
            && touchLocation.y >= firstAnswerbTN.position.y && touchLocation.y <= touchLocation.y + firstAnswerbTN.contentSize.height)
        {
            questionlBL.string = @"first answer button is clicked";
        } 
    }
	return YES;
}
 */
//
//
//
-(void) ccTouchEnded:(UITouch *)touch withEvent:(UIEvent *)event
{
    CCLOG(@"touch ended!");
}
//
//
//
-(void) ccTouchMoved:(UITouch *)touch withEvent:(UIEvent *)event
{
    CCLOG(@"touch moved!");
}

//
//
//
-(void)UIInitializerWithquestion:(NSString*)question FirstAnswer:(NSString*)answer1 SecondAnswer:(NSString*)answer2 ThirdAnswer:(NSString*)answer3
{
    [questionLbl setString:question];
    [answer1Lbl setString:answer1];
    [answer2Lbl setString:answer2];
    [answer3Lbl setString:answer3];
}

//
//
//
-(bool)InitializeUIWithArray:(NSMutableArray*)dataArray
{
    [self UIInitializerWithquestion:[dataArray objectAtIndex:0] FirstAnswer:[dataArray objectAtIndex:1] SecondAnswer:[dataArray objectAtIndex:2] ThirdAnswer:[dataArray objectAtIndex:3]];
    return true;
}

//
//
//
-(void)Closing
{
    [self removeChild:answer1Lbl cleanup:YES];
    [self removeChild:answer2Lbl cleanup:YES];
    [self removeChild:answer3Lbl cleanup:YES];
    [self removeChild:firstAnswerBtn cleanup:YES];
    [self removeChild:secondAnswerBtn cleanup:YES];
    [self removeChild:thirdAnswerBtn cleanup:YES];
    [self removeChild:questionLbl cleanup:NO];
    [self removeChild:exitBtn cleanup:YES];
    questionLbl = [CCLabelTTF labelWithString:@"Thanks" fontName: @"Marker Felt" fontSize:32];
    [questionLbl setPosition:ccp(250, 168)];
    [questionLbl setColor:ccc3(0, 0, 0)];
    questionLbl.rotation = -90;
    [self addChild:questionLbl z:3];
}

@end
