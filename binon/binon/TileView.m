//
//  TileView.m
//  binon
//
//  Created by Mert Güneş on 18/10/14.
//  Copyright (c) 2014 Mert Güneş. All rights reserved.
//

#import "TileView.h"
#import "Utility.h"

@implementation TileView

@synthesize isAvailable;

- (void)initialize
{
    self.isAvailable = YES;
    
    [self setBackgroundColor:tileColorDefault];

    [self.layer setCornerRadius:cornerRadius];
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
