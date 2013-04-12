//
//  ViewController.m
//  Calculator
//
//  Created by Oleksandr Kulakov on 4/12/13.
//  Copyright (c) 2013 Oleksandr Kulakov. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@property (nonatomic) BOOL userIsInTheMiddleOfEnteringANumber;

@end

@implementation ViewController
@synthesize display;
@synthesize userIsInTheMiddleOfEnteringANumber;

- (IBAction)digitPressed:(UIButton *)sender
{
    NSString *digit = [sender currentTitle];
    NSLog(@"User touched %@", digit);
//    UILabel *myDisplay = self.display; //[self display]
//    NSString *currentDisplayText = self.display.text;
//    NSString *newDisplayText = [currentDisplayText stringByAppendingString:digit];
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

- (IBAction)enterPressed:(id)sender
{
    
}



- (IBAction)operessionPressed:(UIButton *)sender
{
    
}

@end
