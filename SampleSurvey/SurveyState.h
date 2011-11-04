//
//  SurveyState.h
//  SampleSurvey
//
//  Created by Amin Tavassolian on 11-11-01.
//  Copyright (c) 2011 University of Saskatchewan. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "FlurryAnalytics.h"

//
//define a protocol for this class
//
/*
@protocol SurveyStateProtocol <NSObject>

//required methods
@required
-(void)UserAnswered;
-(void)UserDidNotAnswer;
@end
*/
@interface SurveyState : NSObject
{
    NSMutableArray* _dataArray;
    NSArray* _nsDataArray;
    NSString* _fileName;
    int _questionNum;
    //id<SurveyStateProtocol> _delegate;
}

//properties
@property (nonatomic, assign) int questionNum;
@property (nonatomic, retain) NSMutableArray* dataArray;
@property (nonatomic, retain) NSArray* nsDataArray;
@property (nonatomic, retain) NSString* fileName;
//@property (nonatomic, retain) id<SurveyStateProtocol> delegate;

//methods
-(void)UserAnsweredToQuestionNumber: (int)questionNum WithAnswer:(int)answerID;
-(void)UserDidNotAnswerToQuestionNumber:(int) questionNum;
-(id)initWithDelegate:(id)delegate;
-(bool)AddToDataArray: (NSMutableArray*) array Dictionary:(NSMutableDictionary*) dict;
-(NSArray*)ReadFromFile: (NSString*) fileName;
-(bool)SaveToFile: (NSString*)fileName Dictionary:(NSMutableArray*)dictionaryArray;
-(NSMutableDictionary*)CreateDictionaryForQuestionNumber: (int)questionNum Question:(NSString*)question QuestionStatus:(int)questionStatus WithAnswer1:(NSString*)answer1 Answer2:(NSString*)answer2 Answer3:(NSString*)answer3 AndFinalAnswer:(NSString*) answer;
-(NSMutableDictionary*)CreateDictionaryForSurveyStatusWithInitialQuestionNumber:(int) questionNumber;
void saveData(id theData, NSString* filename);
bool IsFileExist(NSString* fileName);
NSString* pathForFile(NSString* filename);
-(int)WhichQuestionToLoad: (NSArray*)dataArray;
-(NSMutableArray*)LoadSurvey:(NSString*) filPath;
-(bool)SendResultToFlurry:(NSDictionary*)dict;

@end

