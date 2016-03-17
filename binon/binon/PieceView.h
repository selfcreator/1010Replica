//
//  PieceView.h
//  binon
//
//  Created by Mert Güneş on 18/10/14.
//  Copyright (c) 2014 Mert Güneş. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AppDelegate.h"

@interface PieceView : UIView

@property (nonatomic) int pieceType;

@property (nonatomic) CGPoint defaultCenter;

- (void)initialize;

@end
