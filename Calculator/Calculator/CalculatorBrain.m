//
//  CalculatorBrain.m
//  Calculator
//
//  Created by Oleksandr Kulakov on 4/12/13.
//  Copyright (c) 2013 Oleksandr Kulakov. All rights reserved.
//

#import "CalculatorBrain.h"

@interface CalculatorBrain ()

@property (strong, nonatomic) NSMutableArray *operandStack;

@end

@implementation CalculatorBrain
@synthesize operandStack = _operandStack;

- (NSMutableArray *) operandStack
{
    if (!_operandStack)
    {
        _operandStack = [[NSMutableArray alloc]init];
    }
    return _operandStack;
}

- (void) pushOperand: (double) operand
{
    NSNumber *operandObject = [NSNumber numberWithDouble:operand];
    [self.operandStack addObject:operandObject];
}

- (double) popOperand
{
    NSNumber *operandObject = [self.operandStack lastObject];
    if (operandObject)
    {
        [self.operandStack removeLastObject];
    }
    return [operandObject doubleValue];
}


- (double) performOperetion: (NSString*) operation
{
    double result = 0;
    
    if ([operation isEqualToString:@"+"])
    {
        result = [self popOperand]+[self popOperand];
    }
    else if ([operation isEqualToString:@"*"])
    {
        result = [self popOperand]*[self popOperand];
    }
    else if ([operation isEqualToString:@"/"])
    {
        double divisor = [self popOperand];
        if (divisor)
        {
            result = [self popOperand]/divisor;
        }
        
    }
    else if ([operation isEqualToString:@"-"])
    {
        double subtrahend = [self popOperand];
        result = [self popOperand]-subtrahend;
    }
    
    [self pushOperand:result];
    return result;
}


- (double) performFunction: (NSString*) function
{
    double result = 0;
    
    if ([function isEqualToString:@"sin"])
    {
        result = (double) sin([self popOperand]);
    }
    else if ([function isEqualToString:@"cos"])
    {
        result = (double) cos([self popOperand]);
    }
    else if ([function isEqualToString:@"sqrt"])
    {
        if ([self.operandStack lastObject] >= 0)
        {
            result = (double) sqrt([self popOperand]);
        }
        
    }

    
 [self pushOperand:result];
 return result;
}



@end
