//
//  PieceView.m
//  binon
//
//  Created by Mert Güneş on 18/10/14.
//  Copyright (c) 2014 Mert Güneş. All rights reserved.
//

#import "PieceView.h"
#import "Utility.h"

@interface PieceView()
{
    UIView* shapeView;
}

@end

@implementation PieceView

@synthesize pieceType, defaultCenter;

- (void)initialize
{
    self.defaultCenter = self.center;
    
    [self constructShape];
}

- (void)constructShape
{
    int pieceTileSize = tileSize - 4; // iPhone:4 iPad:8
    int pieceTileSpace = 1;
    
    NSDictionary* shapeDict = [Utility getShapeDictWithType:pieceType];
    
    int width = [[shapeDict objectForKey:@"width"] intValue];
    int height = [[shapeDict objectForKey:@"height"] intValue];
    
    NSString* pattern = [shapeDict objectForKey:@"pattern"];
    
    CGRect shapeFrame;
    shapeFrame.size.width = (width * pieceTileSize) + ((width + 1) * pieceTileSpace);
    shapeFrame.size.height = (height * pieceTileSize) + ((height + 1) * pieceTileSpace);
    shapeFrame.origin.x = (self.frame.size.width - shapeFrame.size.width) / 2;
    shapeFrame.origin.y = (self.frame.size.height - shapeFrame.size.height) / 2;
    
    if(shapeView == nil)
    {
        shapeView = [[UIView alloc] initWithFrame:shapeFrame];
    }
    else
    {
        shapeView.layer.sublayers = nil;
        
        [shapeView setFrame:shapeFrame];
    }
    
    for(int i = 0; i < width; i++)
    {
        for(int j = 0; j < height; j++)
        {
            int charIndex = (i * height) + j;
            
            if([pattern characterAtIndex:charIndex] == '1')
            {
                CGRect tileFrame;
                tileFrame.size.width = pieceTileSize;
                tileFrame.size.height = pieceTileSize;
                tileFrame.origin.x = ((i + 1) * pieceTileSpace) + (i * pieceTileSize);
                tileFrame.origin.y = ((j + 1) * pieceTileSpace) + (j * pieceTileSize);
                
                CALayer * roundRect = [CALayer layer];
                [roundRect setFrame:tileFrame];
                [roundRect setCornerRadius:cornerRadius];
                [roundRect setMasksToBounds:YES];
                [roundRect setBackgroundColor:[[Utility colorOfType:pieceType] CGColor]];
                
                //add the rounded rect layer underneath all other layers of the view
                [[shapeView layer] insertSublayer:roundRect atIndex:0];
            }
        }
    }
    
    [self addSubview:shapeView];
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
