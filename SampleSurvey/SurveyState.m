//
//  SurveyState.m
//  SampleSurvey
//
//  Created by Amin Tavassolian on 11-11-01.
//  Copyright (c) 2011 University of Saskatchewan. All rights reserved.
//

#import "SurveyState.h"
#import "cocos2d.h"
#import <Foundation/Foundation.h>
#import <Foundation/NSXMLParser.h>

#define NUMBER_OF_QUESTIONS 10

@implementation SurveyState
@synthesize dataArray = _dataArray;
@synthesize fileName = _fileName;
@synthesize nsDataArray = _nsDataArray;
@synthesize questionNum = _questionNum;


//
//implementing methods
//
//init mehtod with delegate
-(id)init
{
    self = [super init];
    if (self != nil)
    {
        self.dataArray = [[NSMutableArray alloc] initWithCapacity:NUMBER_OF_QUESTIONS];
        self.fileName = @"QuestionDictionary.xml";
        if (IsFileExist(@"QuestionDictionary.xml"))
        {
            NSLog(@"<<file exist!>>");
            //self.filePath = pathForFile(@"QuestionDictionary.xml");
        }
        else
        {
            [self AddToDataArray:_dataArray Dictionary:[self CreateDictionaryForQuestionNumber:1 Question:@"When I jump in Pop&Dodge, it’s because" QuestionStatus:0 WithAnswer1:@"I want to get more points" Answer2:@"It’s cool to jump" Answer3:@"I don’t jump, I only tap" AndFinalAnswer:@"null"]];
        
            [self AddToDataArray:_dataArray Dictionary:[self CreateDictionaryForQuestionNumber:2 Question:@"When I'm playing Pop&Dodge, I focus on" QuestionStatus:0 WithAnswer1:@"Getting a high score" Answer2:@"getting lots of coins" Answer3:@"lasting as long as possible" AndFinalAnswer:@"null"]];
        
            [self AddToDataArray:_dataArray Dictionary:[self CreateDictionaryForQuestionNumber:3 Question:@"I think the balls in Pop&Dodge" QuestionStatus:0 WithAnswer1:@"come too often" Answer2:@"come too fast" Answer3:@"are just right" AndFinalAnswer:@"null"]];
        
            [self AddToDataArray:_dataArray Dictionary:[self CreateDictionaryForQuestionNumber:4 Question:@"When I jump in Pop&Dodge, the penguin" QuestionStatus:0 WithAnswer1:@"sometimes doesn't move" Answer2:@"sometimes moves too much" Answer3:@"jumps just right" AndFinalAnswer:@"null"]];
        
            [self AddToDataArray:_dataArray Dictionary:[self CreateDictionaryForQuestionNumber:5 Question:@"If you could add something to the store, what would you add?" QuestionStatus:0 WithAnswer1:@"outfits for the penguin" Answer2:@"different backgrounds" Answer3:@"more powerups" AndFinalAnswer:@"null"]];
                
            [self AddToDataArray:_dataArray Dictionary:[self CreateDictionaryForQuestionNumber:6 Question:@"How old are you?" QuestionStatus:0 WithAnswer1:@"Under 10 years old" Answer2:@"11 - 15 years old" Answer3:@"Over 15 years old" AndFinalAnswer:@"null"]];
        
            [self AddToDataArray:_dataArray Dictionary:[self CreateDictionaryForQuestionNumber:7 Question:@"What is your gender?" QuestionStatus:0 WithAnswer1:@"male" Answer2:@"female" Answer3:@"" AndFinalAnswer:@"null"]];
        
            [self AddToDataArray:_dataArray Dictionary:[self CreateDictionaryForQuestionNumber:8 Question:@"Will you play Pop&Dodge again" QuestionStatus:0 WithAnswer1:@"Yes" Answer2:@"Maybe" Answer3:@"No" AndFinalAnswer:@"null"]];
        
            [self AddToDataArray:_dataArray Dictionary:[self CreateDictionaryForQuestionNumber:9 Question:@"Where did you hear about the game?" QuestionStatus:0 WithAnswer1:@"A friend" Answer2:@"The app store" Answer3:@"A website" AndFinalAnswer:@"null"]];
        
            [self AddToDataArray:_dataArray Dictionary:[self CreateDictionaryForQuestionNumber:10 Question:@"What would make you want to play Pop & Dodge more often?" QuestionStatus:0 WithAnswer1:@"Less jumping and moving" Answer2:@"More jumping and moving" Answer3:@"More powerups" AndFinalAnswer:@"null"]];
            [self AddToDataArray:_dataArray Dictionary:[self CreateDictionaryForSurveyStatusWithInitialQuestionNumber:0]];
            [self SaveToFile:@"QuestionDictionary.xml" Dictionary:_dataArray];
            NSLog(@"<<file is created successfully!>>");
        }
    }
    return self;
}

//
//The init function with delegate.
//We shoudln't call this function always use init function
//
-(id)initWithDelegate:(id)delegate
{
    self = [super init];
    if (self != nil)
    {
        
    }
    return self;
}

//
// on "dealloc" you need to release all your retained objects
//
- (void) dealloc
{
    self.dataArray = nil;
    self.nsDataArray = nil;
    self.fileName = nil;
    // don't forget to call "super dealloc"
	[super dealloc];
}

//
//when user answers to the review
//
-(void)UserAnsweredToQuestionNumber:(int)questionNum WithAnswer:(int)answerID
{
    NSString* question;
    NSString* answer1;
    NSString* answer2;
    NSString* answer3;
    NSMutableDictionary* resultDict;
    
    //NSArray* tempArray = [self ReadFromFile:[self filePath]];
    NSMutableArray* tempMutableArray = [NSMutableArray arrayWithArray:[self nsDataArray]];
    for (int i=0; i < [tempMutableArray count]; i++)
    {
        //modifying the answer
        if([[[tempMutableArray objectAtIndex:i] valueForKey:@"QuestionNumber"] intValue] == questionNum)
        {
            [tempMutableArray removeObjectAtIndex:i];
            question = [[[self nsDataArray] objectAtIndex:i] valueForKey:@"Question"];
            answer1  = [[[self nsDataArray] objectAtIndex:i] valueForKey:@"Answer1"];
            answer2  = [[[self nsDataArray] objectAtIndex:i] valueForKey:@"Answer2"];
            answer3  = [[[self nsDataArray] objectAtIndex:i] valueForKey:@"Answer3"];
            
            if (answerID == 1)
            {
                resultDict = [self CreateDictionaryForQuestionNumber:questionNum Question:question QuestionStatus:1 WithAnswer1:answer1 Answer2:answer2 Answer3:answer3 AndFinalAnswer:answer1];
                [self AddToDataArray:tempMutableArray Dictionary:resultDict];
            }
            else if (answerID == 2)
            {
                resultDict = [self CreateDictionaryForQuestionNumber:questionNum Question:question QuestionStatus:1 WithAnswer1:answer1 Answer2:answer2 Answer3:answer3 AndFinalAnswer:answer2];
                [self AddToDataArray:tempMutableArray Dictionary:resultDict];
            }
            else
            {
                resultDict = [self CreateDictionaryForQuestionNumber:questionNum Question:question QuestionStatus:1 WithAnswer1:answer1 Answer2:answer2 Answer3:answer3 AndFinalAnswer:answer3];
                [self AddToDataArray:tempMutableArray Dictionary:resultDict];
            }
        }
        //modifying the last question tag
        if ([[tempMutableArray objectAtIndex:i] valueForKey:@"LastQuestionNumber"] != nil)
        {
            [tempMutableArray removeObjectAtIndex:i];
            [self AddToDataArray:tempMutableArray Dictionary:[self CreateDictionaryForSurveyStatusWithInitialQuestionNumber:questionNum]];
        }
        
    }
    //sendgin results to server
    [self SendResultToFlurry:resultDict];
    //updating the survey status
    [self SaveToFile:@"QuestionDictionary.xml" Dictionary:tempMutableArray];

}


//when user leaves the review
-(void)UserDidNotAnswerToQuestionNumber:(int) questionNum
{
    CCLOG(@"USER DID NOT ANSWER!");    
}

//
-(bool)AddToDataArray: (NSMutableArray*) array Dictionary:(NSMutableDictionary*) dict
{
    [array addObject:dict];
    return true;//well I know it sounds meaningless!
}

//
-(bool)SaveToFile: (NSString*)fileName Dictionary:(NSMutableArray*)dictionaryArray
{
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *documentsDirectory = [[paths objectAtIndex:0] stringByAppendingPathComponent:fileName];
    //self.filePath =  documentsDirectory;//save the file path
    int count = [dictionaryArray count];
    bool result = [dictionaryArray writeToFile:documentsDirectory atomically:YES];
    if (!result ) 
    {
        NSLog(@"<<Save data failure!>>");
    } 
    else
    {
        NSLog(@"<<save successfully. Number of records= %d>>", [dictionaryArray count]);
    }
    //deallocating all the pbjects
    //[dictionaryArray removeAllObjects];
    return result;
}

//this function creates a new NSMutableDictionary with input values
-(NSMutableDictionary*)CreateDictionaryForQuestionNumber: (int)questionNum Question:(NSString*)question QuestionStatus:(int)questionStatus WithAnswer1:(NSString*) answer1 Answer2:(NSString*) answer2 Answer3:(NSString*)answer3 AndFinalAnswer:(NSString*) answer
{
    NSMutableDictionary* dict = [NSMutableDictionary dictionaryWithObjectsAndKeys:@"Survey", @"type", 
                                 [NSNumber numberWithInt:questionNum], @"QuestionNumber",
                                 [NSString stringWithString: question], @"Question",
                                 [NSNumber numberWithInt:questionStatus], @"QuestionStatus", 
                                 [NSString stringWithString:answer1], @"Answer1",
                                 [NSString stringWithString:answer2], @"Answer2",
                                 [NSString stringWithString:answer3], @"Answer3",
                                 [NSString stringWithString:answer], @"Answer",
                                 nil];
    return  dict;
}


//
-(NSMutableDictionary*)CreateDictionaryForSurveyStatusWithInitialQuestionNumber:(int) questionNumber
{
    NSMutableDictionary* dict = [NSMutableDictionary dictionaryWithObjectsAndKeys:@"SurveyStatus", @"type", 
                                 [NSNumber numberWithInt:questionNumber], @"LastQuestionNumber",
                                 nil];
    return  dict;
}


//
-(NSArray*)ReadFromFile: (NSString*) fileName
{   
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *documentsDirectory = [[paths objectAtIndex:0] stringByAppendingPathComponent:fileName];
    NSLog(@"<<start reading from file path: %@ >>", documentsDirectory);
    NSURL* url = [NSURL fileURLWithPath:documentsDirectory];
    NSArray *dataArray = [[[NSMutableArray alloc] initWithContentsOfURL:url] autorelease];
    NSLog(@"<<Reading is finished>>");
    //int count = [dataArray count];
    return dataArray;
}

NSString* pathForFile(NSString* filename)
{
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *documentsDirecotry = [paths objectAtIndex:0];
    
    return [documentsDirecotry stringByAppendingPathComponent:filename];
}

//
//
//
bool IsFileExist(NSString* fileName)
{
    NSString* filePath = pathForFile(fileName);
    if ([[NSFileManager defaultManager] fileExistsAtPath:filePath])
    {
        return true;//we have the file already
    }
    return false;//the file dosn't exist
}

//
//This function loads the survey
//first, load the file
//second, fetch the number of question that should be asked
//third, pars data of the question and return it
//
-(NSMutableArray*)LoadSurvey:(NSString*) filPath
{
    NSMutableArray* resultArray = [[NSMutableArray alloc] init];
    //loading the whole file
    self.nsDataArray = [self ReadFromFile:@"QuestionDictionary.xml"];
    //check the status of the survey
    int questionNum = [self WhichQuestionToLoad:[self nsDataArray]];
    self.questionNum = questionNum;
    if (questionNum == -1)
        return nil;
    //find the question and answers
    for (int i=0; i < [[self nsDataArray] count]; i++)
    {
        if ([[[self nsDataArray] objectAtIndex:i] valueForKey:@"QuestionNumber"] != nil)
        {
            if([[[[self nsDataArray] objectAtIndex:i] valueForKey:@"QuestionNumber"] intValue] == questionNum)
            {
                [resultArray addObject: [[[self nsDataArray] objectAtIndex:i] valueForKey:@"Question"]];
                [resultArray addObject: [[[self nsDataArray] objectAtIndex:i] valueForKey:@"Answer1"]];
                [resultArray addObject: [[[self nsDataArray] objectAtIndex:i] valueForKey:@"Answer2"]];
                [resultArray addObject: [[[self nsDataArray] objectAtIndex:i] valueForKey:@"Answer3"]];
            }
        }
    }
    return resultArray;
}

//
//This function fetches the number of last asked question and
//increases it by 1, to be referred to the current question that should be asked
//
-(int)WhichQuestionToLoad: (NSArray*)dataArray
{
    int questionNum;
    int questionStatus;
    NSString* log = [NSString stringWithFormat:@"<<The number of last question is found! %f>>", questionNum];
    for (int i=0; i < [dataArray count]; i++)
    {
        if([[dataArray objectAtIndex:i] valueForKey:@"LastQuestionNumber"] != nil)
        {
            questionNum = [[[dataArray objectAtIndex:i] valueForKey:@"LastQuestionNumber"] intValue];
            CCLOG(log);
            break;
        } 
    }
    for (int i=0; i < [dataArray count]; i++)
    {
        if ([[dataArray objectAtIndex:i] valueForKey:@"QuestionNumber"] != nil)
        {
            if([[[dataArray objectAtIndex:i] valueForKey:@"QuestionNumber"] intValue] == questionNum)
            {
                questionStatus = [[[dataArray objectAtIndex:i] valueForKey:@"QuestionStatus"] intValue];
                break;
            }
        }
    }
    if (questionStatus == 0 || questionNum < 10)
    {
        return ++questionNum;
    }
    else
    {
        //terminate the program
        //In this case the the progrma shouldn't commnece.
        return -1;
        
    }
}

//
//
//
-(bool)SendResultToFlurry:(NSDictionary*)dict
{
    [FlurryAnalytics logEvent:@"PopAndDogeFeedbakc" withParameters:dict];
}

//
//
//



//
//
//

@end