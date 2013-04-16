//
//  ViewController.m
//  Calculator
//
//  Created by Oleksandr Kulakov on 4/12/13.
//  Copyright (c) 2013 Oleksandr Kulakov. All rights reserved.
//

#include <math.h>
#import "ViewController.h"
#import "CalculatorBrain.h"

@interface ViewController ()

@property (nonatomic) BOOL userIsInTheMiddleOfEnteringANumber;
@property (nonatomic, strong) CalculatorBrain *brain;
@property (nonatomic) BOOL topOfTheLine;

@end

@implementation ViewController
@synthesize display;
@synthesize secondDisplay;
@synthesize userIsInTheMiddleOfEnteringANumber;
@synthesize topOfTheLine;
@synthesize brain = _brain;

- (CalculatorBrain *) brain
{
    if (!_brain)
    {
        _brain = [[CalculatorBrain alloc]init];
    }
    return _brain;
}

- (IBAction)digitPressed:(UIButton *)sender
{
    NSString *digit = [sender currentTitle];
    NSLog(@"User touched %@", digit);
//    UILabel *myDisplay = self.display; //[self display]
//    NSString *currentDisplayText = self.display.text;
//    NSString *newDisplayText = [currentDisplayText stringByAppendingString:digit];
    if (topOfTheLine)
    {
        self.secondDisplay.text = [self.secondDisplay.text stringByAppendingString:digit];
        
    }
    else
    {
        self.secondDisplay.text= digit;
        topOfTheLine = YES;
    }
    if (self.userIsInTheMiddleOfEnteringANumber)
    {
       self.display.Text = [self.display.text stringByAppendingString:digit];
       
    }
    else
    {
        self.display.text = digit;
        self.userIsInTheMiddleOfEnteringANumber = YES;
    }
}
- (IBAction)enterPressed
{
    [self.brain pushOperand:[self.display.text doubleValue]];
    self.userIsInTheMiddleOfEnteringANumber = NO;
    self.secondDisplay.Text = [self.secondDisplay.text stringByAppendingString:@" "];

}


- (IBAction)operationPressed:(UIButton *)sender
{
    if (self.userIsInTheMiddleOfEnteringANumber)
    {
        [self enterPressed];
    }
    NSString *operation = [sender currentTitle];
    double result = [self.brain performOperetion:operation];
    self.display.text = [NSString stringWithFormat:@"%g", result];
    self.secondDisplay.Text = [self.secondDisplay.text stringByAppendingString:[sender currentTitle]];
}


- (IBAction)pointPressed:(UIButton *)sender
{
    NSString *point = [sender currentTitle];
    NSRange range = [self.display.text rangeOfString:point];
    if (range.length == 0)
    {
        self.display.text = [self.display.text stringByAppendingString:point];
        self.userIsInTheMiddleOfEnteringANumber = YES;
   
    }

    self.secondDisplay.text = [self.secondDisplay.text stringByAppendingString:[sender currentTitle]];
}


- (IBAction)cPressed
{
    self.brain = nil;
    self.display.text = [NSString stringWithFormat:@"0"];
    self.secondDisplay.text = [NSString stringWithFormat:@""];
    self.userIsInTheMiddleOfEnteringANumber = NO;
    self.topOfTheLine = NO;
}

- (IBAction)functionPressed:(UIButton *)sender
{
    if (self.userIsInTheMiddleOfEnteringANumber)
    {
        [self enterPressed];
        
    }

    NSString *function = [sender currentTitle];
    double result = [self.brain performFunction:function];
    self.display.text = [NSString stringWithFormat:@"%g", result];
    self.secondDisplay.Text = [self.secondDisplay.text stringByAppendingString:[sender currentTitle]];
    topOfTheLine = YES;
}

- (IBAction)backspacePressed
{
    if (self.display.text.length)
    {
        self.display.text = [self.display.text substringToIndex:[self.display.text length]-1];
    }
    if (self.secondDisplay.text.length)
    {
        self.secondDisplay.text = [self.secondDisplay.text substringToIndex:[self.secondDisplay.text length]-1];
    }

    
    
}

- (IBAction)plusMinusPressed:(UIButton *)sender
{
    if (self.userIsInTheMiddleOfEnteringANumber)
    {
        [self enterPressed];
    }
    NSString *operation = [sender currentTitle];
    double lenght = [self.brain lastValueLengh];
    self.secondDisplay.text = [self.secondDisplay.text substringToIndex:[self.secondDisplay.text length]-(++lenght)];
    self.secondDisplay.Text = [self.secondDisplay.text stringByAppendingString:@"(-"];
    self.secondDisplay.Text = [self.secondDisplay.text stringByAppendingString:[self.brain lastObject]];
    self.secondDisplay.Text = [self.secondDisplay.text stringByAppendingString:@")"];
    NSLog(@"%g", lenght);
    double result = [self.brain performOperetion:operation];
    self.display.text = [NSString stringWithFormat:@"%g", result];}


@end
