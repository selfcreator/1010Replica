//
//  Utility.h
//  binon
//
//  Created by Mert Güneş on 19/10/14.
//  Copyright (c) 2014 Mert Güneş. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

enum {
    pTypeDefault        = -1,
    pTypeSingleDot      = 0,
    pTypeDoubleLineV    = 1,
    pTypeDoubleLineH    = 2,
    pTypeDoubleL0       = 3,
    pTypeDoubleL1       = 4,
    pTypeDoubleL2       = 5,
    pTypeDoubleL3       = 6,
    pTypeDoubleSquare   = 7,
    pTypeTripleLineV    = 8,
    pTypeTripleLineH    = 9,
    pTypeTripleL0       = 10,
    pTypeTripleL1       = 11,
    pTypeTripleL2       = 12,
    pTypeTripleL3       = 13,
    pTypeTripleSquare   = 14,
    pTypeQuadLineV      = 15,
    pTypeQuadLineH      = 16,
    pTypePentaV         = 17,
    pTypePentaH         = 18
};

#define tileSize 24 // iPhone:24 iPad:48
#define space 2 // 2 iPhone:2 iPad:4
#define numberOfTiles 10
#define pixelsPerSec  1000.0

#define cornerRadius 2.0 // iPhone:2 iPad:6


#define tileColorDefault [UIColor colorWithRed:235.0/255.0 green:235.0/255.0 blue:235.0/255.0 alpha:1.0] // Gray

#define tileColorType1   [UIColor colorWithRed:126.0/255.0 green:142.0/255.0 blue:212.0/255.0 alpha:1.0] // Purple

#define tileColorType2   [UIColor colorWithRed:255.0/255.0 green:198.0/255.0 blue:61.0/255.0 alpha:1.0]  // Yellow

#define tileColorType3   [UIColor colorWithRed:239.0/255.0 green:149.0/255.0 blue:74.0/255.0 alpha:1.0]  // Orange

#define tileColorType4   [UIColor colorWithRed:151.0/255.0 green:219.0/255.0 blue:85.0/255.0 alpha:1.0]  // Green

#define tileColorType5   [UIColor colorWithRed:89.0/255.0 green:203.0/255.0 blue:134.0/255.0 alpha:1.0]  // Green

#define tileColorType6   [UIColor colorWithRed:77.0/255.0 green:213.0/255.0 blue:176.0/255.0 alpha:1.0]  // Green

#define tileColorType7   [UIColor colorWithRed:92.0/255.0 green:189.0/255.0 blue:228.0/255.0 alpha:1.0]  // Blue

#define tileColorType8   [UIColor colorWithRed:231.0/255.0 green:106.0/255.0 blue:130.0/255.0 alpha:1.0] // Pink

#define tileColorType9   [UIColor colorWithRed:220.0/255.0 green:101.0/255.0 blue:85.0/255.0 alpha:1.0]  // Red

#define clearColor       [UIColor clearColor]

@interface Utility : NSObject

+ (UIColor*)colorOfType:(int)_type;

+ (NSInteger)randomNumberBetween:(NSInteger)min maxNumber:(NSInteger)max;

+ (NSDictionary*)getShapeDictWithType:(int)_type;

+ (int)getARandomPieceType;

+ (BOOL)isThisPoint:(CGPoint)_point insideThisRect:(CGRect)_rect;

+ (void)showAlertWithMessage:(NSString*)message;

@end
