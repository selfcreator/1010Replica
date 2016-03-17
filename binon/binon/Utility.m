//
//  Utility.m
//  binon
//
//  Created by Mert Güneş on 19/10/14.
//  Copyright (c) 2014 Mert Güneş. All rights reserved.
//

#import "Utility.h"

static NSMutableArray* randomPieceArray;

@implementation Utility

+ (UIColor *)colorOfType:(int)_type
{
    if(_type == pTypeSingleDot)
    {
        return tileColorType1;
    }
    else if(_type == pTypeDoubleLineH || _type == pTypeDoubleLineV)
    {
        return tileColorType2;
    }
    else if(_type == pTypeTripleLineH || _type == pTypeTripleLineV)
    {
        return tileColorType3;
    }
    else if(_type == pTypeDoubleSquare)
    {
        return tileColorType4;
    }
    else if(_type == pTypeDoubleL0 || _type == pTypeDoubleL1 || _type == pTypeDoubleL2 || _type == pTypeDoubleL3)
    {
        return tileColorType5;
    }
    else if(_type == pTypeTripleSquare)
    {
        return tileColorType6;
    }
    else if(_type == pTypeTripleL0 || _type == pTypeTripleL1 || _type == pTypeTripleL2 || _type == pTypeTripleL3)
    {
        return tileColorType7;
    }
    else if(_type == pTypeQuadLineH || _type == pTypeQuadLineV)
    {
        return tileColorType8;
    }
    else if(_type == pTypePentaH || _type == pTypePentaV)
    {
        return tileColorType9;
    }
    
    return tileColorDefault;
}

+ (NSInteger)randomNumberBetween:(NSInteger)min maxNumber:(NSInteger)max
{
    return min + arc4random_uniform((u_int32_t)(max - min + 1));
}

+ (NSDictionary*)getShapeDictWithType:(int)_type
{
    NSMutableDictionary* shapeDict = [[NSMutableDictionary alloc] init];
    
    if(_type == pTypeSingleDot)
    {
        [shapeDict setObject:[NSNumber numberWithInt:1] forKey:@"width"];
        [shapeDict setObject:[NSNumber numberWithInt:1] forKey:@"height"];
        [shapeDict setObject:[NSNumber numberWithInt:1] forKey:@"weight"];
        [shapeDict setObject:@"1" forKey:@"pattern"];
    }
    else if(_type == pTypeDoubleLineV)
    {
        [shapeDict setObject:[NSNumber numberWithInt:1] forKey:@"width"];
        [shapeDict setObject:[NSNumber numberWithInt:2] forKey:@"height"];
        [shapeDict setObject:[NSNumber numberWithInt:2] forKey:@"weight"];
        [shapeDict setObject:@"11" forKey:@"pattern"];
    }
    else if(_type == pTypeDoubleLineH)
    {
        [shapeDict setObject:[NSNumber numberWithInt:2] forKey:@"width"];
        [shapeDict setObject:[NSNumber numberWithInt:1] forKey:@"height"];
        [shapeDict setObject:[NSNumber numberWithInt:2] forKey:@"weight"];
        [shapeDict setObject:@"11" forKey:@"pattern"];
    }
    else if(_type == pTypeDoubleL0)
    {
        [shapeDict setObject:[NSNumber numberWithInt:2] forKey:@"width"];
        [shapeDict setObject:[NSNumber numberWithInt:2] forKey:@"height"];
        [shapeDict setObject:[NSNumber numberWithInt:3] forKey:@"weight"];
        [shapeDict setObject:@"1110" forKey:@"pattern"];
    }
    else if(_type == pTypeDoubleL1)
    {
        [shapeDict setObject:[NSNumber numberWithInt:2] forKey:@"width"];
        [shapeDict setObject:[NSNumber numberWithInt:2] forKey:@"height"];
        [shapeDict setObject:[NSNumber numberWithInt:3] forKey:@"weight"];
        [shapeDict setObject:@"1101" forKey:@"pattern"];
    }
    else if(_type == pTypeDoubleL2)
    {
        [shapeDict setObject:[NSNumber numberWithInt:2] forKey:@"width"];
        [shapeDict setObject:[NSNumber numberWithInt:2] forKey:@"height"];
        [shapeDict setObject:[NSNumber numberWithInt:3] forKey:@"weight"];
        [shapeDict setObject:@"1011" forKey:@"pattern"];
    }
    else if(_type == pTypeDoubleL3)
    {
        [shapeDict setObject:[NSNumber numberWithInt:2] forKey:@"width"];
        [shapeDict setObject:[NSNumber numberWithInt:2] forKey:@"height"];
        [shapeDict setObject:[NSNumber numberWithInt:3] forKey:@"weight"];
        [shapeDict setObject:@"0111" forKey:@"pattern"];
    }
    else if(_type == pTypeDoubleSquare)
    {
        [shapeDict setObject:[NSNumber numberWithInt:2] forKey:@"width"];
        [shapeDict setObject:[NSNumber numberWithInt:2] forKey:@"height"];
        [shapeDict setObject:[NSNumber numberWithInt:4] forKey:@"weight"];
        [shapeDict setObject:@"1111" forKey:@"pattern"];
    }
    else if(_type == pTypeTripleLineV)
    {
        [shapeDict setObject:[NSNumber numberWithInt:1] forKey:@"width"];
        [shapeDict setObject:[NSNumber numberWithInt:3] forKey:@"height"];
        [shapeDict setObject:[NSNumber numberWithInt:3] forKey:@"weight"];
        [shapeDict setObject:@"111" forKey:@"pattern"];
    }
    else if(_type == pTypeTripleLineH)
    {
        [shapeDict setObject:[NSNumber numberWithInt:3] forKey:@"width"];
        [shapeDict setObject:[NSNumber numberWithInt:1] forKey:@"height"];
        [shapeDict setObject:[NSNumber numberWithInt:3] forKey:@"weight"];
        [shapeDict setObject:@"111" forKey:@"pattern"];
    }
    else if(_type == pTypeTripleL0)
    {
        [shapeDict setObject:[NSNumber numberWithInt:3] forKey:@"width"];
        [shapeDict setObject:[NSNumber numberWithInt:3] forKey:@"height"];
        [shapeDict setObject:[NSNumber numberWithInt:5] forKey:@"weight"];
        [shapeDict setObject:@"111100100" forKey:@"pattern"];
    }
    else if(_type == pTypeTripleL1)
    {
        [shapeDict setObject:[NSNumber numberWithInt:3] forKey:@"width"];
        [shapeDict setObject:[NSNumber numberWithInt:3] forKey:@"height"];
        [shapeDict setObject:[NSNumber numberWithInt:5] forKey:@"weight"];
        [shapeDict setObject:@"111001001" forKey:@"pattern"];
    }
    else if(_type == pTypeTripleL2)
    {
        [shapeDict setObject:[NSNumber numberWithInt:3] forKey:@"width"];
        [shapeDict setObject:[NSNumber numberWithInt:3] forKey:@"height"];
        [shapeDict setObject:[NSNumber numberWithInt:5] forKey:@"weight"];
        [shapeDict setObject:@"100100111" forKey:@"pattern"];
    }
    else if(_type == pTypeTripleL3)
    {
        [shapeDict setObject:[NSNumber numberWithInt:3] forKey:@"width"];
        [shapeDict setObject:[NSNumber numberWithInt:3] forKey:@"height"];
        [shapeDict setObject:[NSNumber numberWithInt:5] forKey:@"weight"];
        [shapeDict setObject:@"001001111" forKey:@"pattern"];
    }
    else if(_type == pTypeTripleSquare)
    {
        [shapeDict setObject:[NSNumber numberWithInt:3] forKey:@"width"];
        [shapeDict setObject:[NSNumber numberWithInt:3] forKey:@"height"];
        [shapeDict setObject:[NSNumber numberWithInt:9] forKey:@"weight"];
        [shapeDict setObject:@"111111111" forKey:@"pattern"];
    }
    else if(_type == pTypeQuadLineV)
    {
        [shapeDict setObject:[NSNumber numberWithInt:1] forKey:@"width"];
        [shapeDict setObject:[NSNumber numberWithInt:4] forKey:@"height"];
        [shapeDict setObject:[NSNumber numberWithInt:4] forKey:@"weight"];
        [shapeDict setObject:@"1111" forKey:@"pattern"];
    }
    else if(_type == pTypeQuadLineH)
    {
        [shapeDict setObject:[NSNumber numberWithInt:4] forKey:@"width"];
        [shapeDict setObject:[NSNumber numberWithInt:1] forKey:@"height"];
        [shapeDict setObject:[NSNumber numberWithInt:4] forKey:@"weight"];
        [shapeDict setObject:@"1111" forKey:@"pattern"];
    }
    else if(_type == pTypePentaV)
    {
        [shapeDict setObject:[NSNumber numberWithInt:1] forKey:@"width"];
        [shapeDict setObject:[NSNumber numberWithInt:5] forKey:@"height"];
        [shapeDict setObject:[NSNumber numberWithInt:5] forKey:@"weight"];
        [shapeDict setObject:@"11111" forKey:@"pattern"];
    }
    else if(_type == pTypePentaH)
    {
        [shapeDict setObject:[NSNumber numberWithInt:5] forKey:@"width"];
        [shapeDict setObject:[NSNumber numberWithInt:1] forKey:@"height"];
        [shapeDict setObject:[NSNumber numberWithInt:5] forKey:@"weight"];
        [shapeDict setObject:@"11111" forKey:@"pattern"];
    }
    
    return (NSDictionary*)shapeDict;
}

+ (int)getARandomPieceType
{
    if(randomPieceArray == nil)
    {
        randomPieceArray = [[NSMutableArray alloc] init];
        
        for(int i = 0; i < 4; i++)
        {
            [randomPieceArray addObject:[NSNumber numberWithInt:pTypeSingleDot]];
            [randomPieceArray addObject:[NSNumber numberWithInt:pTypeDoubleSquare]];
            [randomPieceArray addObject:[NSNumber numberWithInt:pTypeTripleSquare]];
            
            if(i < 2)
            {
                [randomPieceArray addObject:[NSNumber numberWithInt:pTypeDoubleLineH]];
                [randomPieceArray addObject:[NSNumber numberWithInt:pTypeDoubleLineV]];
                
                [randomPieceArray addObject:[NSNumber numberWithInt:pTypeTripleLineH]];
                [randomPieceArray addObject:[NSNumber numberWithInt:pTypeTripleLineV]];
                
                [randomPieceArray addObject:[NSNumber numberWithInt:pTypeQuadLineH]];
                [randomPieceArray addObject:[NSNumber numberWithInt:pTypeQuadLineV]];
                
                [randomPieceArray addObject:[NSNumber numberWithInt:pTypePentaH]];
                [randomPieceArray addObject:[NSNumber numberWithInt:pTypePentaV]];
            }
            
            if(i < 1)
            {
                [randomPieceArray addObject:[NSNumber numberWithInt:pTypeDoubleL0]];
                [randomPieceArray addObject:[NSNumber numberWithInt:pTypeDoubleL1]];
                [randomPieceArray addObject:[NSNumber numberWithInt:pTypeDoubleL2]];
                [randomPieceArray addObject:[NSNumber numberWithInt:pTypeDoubleL3]];

                [randomPieceArray addObject:[NSNumber numberWithInt:pTypeTripleL0]];
                [randomPieceArray addObject:[NSNumber numberWithInt:pTypeTripleL1]];
                [randomPieceArray addObject:[NSNumber numberWithInt:pTypeTripleL2]];
                [randomPieceArray addObject:[NSNumber numberWithInt:pTypeTripleL3]];
            }
        }
    }
    
    NSUInteger count = [randomPieceArray count];
    for (NSUInteger i = 0; i < count; ++i)
    {
        NSInteger remainingCount = count - i;
        NSInteger exchangeIndex = i + arc4random_uniform((u_int32_t)remainingCount);
        [randomPieceArray exchangeObjectAtIndex:i withObjectAtIndex:exchangeIndex];
    }
    
    return [[randomPieceArray objectAtIndex:[self randomNumberBetween:0 maxNumber:([randomPieceArray count] - 1)]] intValue];
}

+ (BOOL)isThisPoint:(CGPoint)_point insideThisRect:(CGRect)_rect
{
    if((_point.x >= _rect.origin.x) && (_point.x <= (_rect.origin.x + _rect.size.width)) &&
       (_point.y >= _rect.origin.y) && (_point.y <= (_rect.origin.y + _rect.size.height)))
    {
        return YES;
    }
    
    return NO;
}

+ (void)showAlertWithMessage:(NSString*)message
{
    UIAlertView* alert = [[UIAlertView alloc] initWithTitle:@"Veleloooy" message:message delegate:nil cancelButtonTitle:@"Tamam" otherButtonTitles: nil];
    [alert show];
}

@end
