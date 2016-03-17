//
//  ViewController.m
//  binon
//
//  Created by Mert Güneş on 18/10/14.
//  Copyright (c) 2014 Mert Güneş. All rights reserved.
//

#import "ViewController.h"
#import "TileView.h"
#import "PieceView.h"
#import <QuartzCore/QuartzCore.h>

#define tile(i, j) (TileView*)[[tiles objectAtIndex:i] objectAtIndex:j]

@interface ViewController ()
{
    UIView* boardView;
    
    CGRect bounds;
    
    NSMutableArray* tiles;
    
    NSMutableArray* activeAreas;
    
    NSArray* pieces;
    
    CGPoint piece0CenterDefault;
    CGPoint piece1CenterDefault;
    CGPoint piece2CenterDefault;
    
    PieceView* piece0;
    PieceView* piece1;
    PieceView* piece2;
    
    UIView* highlightView;
    
    CGPoint lastPoint;
    
    int activePieceIndex;
    
    UIButton* restartButton;
}

@end

@implementation ViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    bounds = [[UIScreen mainScreen] bounds];
    
    restartButton = [[UIButton alloc] initWithFrame:CGRectMake(100, 80, bounds.size.width - 200, 40)];
    [restartButton setBackgroundColor:[UIColor redColor]];
    [restartButton setEnabled:NO];
    [restartButton setTitle:@"Restart" forState:UIControlStateNormal];
    [restartButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [restartButton addTarget:self action:@selector(buttonTapped:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:restartButton];
    
    CGRect boardFrame;
    boardFrame.size.width = (tileSize * numberOfTiles) + (space * (numberOfTiles + 1));
    boardFrame.size.height = (tileSize * numberOfTiles) + (space * (numberOfTiles + 1));
    boardFrame.origin.x = (bounds.size.width - boardFrame.size.width) / 2;
    boardFrame.origin.y = (bounds.size.height - boardFrame.size.height) / 2;
    
    boardView = [[UIView alloc] initWithFrame:boardFrame];
    [boardView setBackgroundColor:clearColor];
//    [self setAnchorPoint:CGPointMake(0, 0.5) forView:boardView];
//    UIView *myView = boardView;
//    CALayer *layer = myView.layer;
//    
//    CATransform3D transform = CATransform3DIdentity;
//    transform.m34 = 1.0 / -2000;
//    
//    CATransform3D rotationAndPerspectiveTransform = CATransform3DIdentity;
//    rotationAndPerspectiveTransform.m34 = 1.0 / -500;
//    rotationAndPerspectiveTransform = CATransform3DRotate(rotationAndPerspectiveTransform, 90.0f * M_PI / 180.0f, 0.0f, 1.0f, 0.0f);
//    layer.transform = rotationAndPerspectiveTransform;
    [self.view addSubview:boardView];
    
    [self generateBoard];
    
    [self generatePieces];

    [self resetHighlightView];
}

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    
    [UIView animateWithDuration:1.0 animations:^{
        UIView *myView = boardView;
        CALayer *layer = myView.layer;
        
        CATransform3D transform = CATransform3DIdentity;
        transform.m34 = 1.0 / -2000;
        
        CATransform3D rotationAndPerspectiveTransform = CATransform3DIdentity;
        rotationAndPerspectiveTransform.m34 = 1.0 / -500;
        rotationAndPerspectiveTransform = CATransform3DRotate(rotationAndPerspectiveTransform, 0.0f * M_PI / 180.0f, 0.0f, 1.0f, 0.0f);
        layer.transform = rotationAndPerspectiveTransform;
    }];
}

-(void)setAnchorPoint:(CGPoint)anchorPoint forView:(UIView *)view
{
    CGPoint newPoint = CGPointMake(view.bounds.size.width * anchorPoint.x,
                                   view.bounds.size.height * anchorPoint.y);
    CGPoint oldPoint = CGPointMake(view.bounds.size.width * view.layer.anchorPoint.x,
                                   view.bounds.size.height * view.layer.anchorPoint.y);
    
    newPoint = CGPointApplyAffineTransform(newPoint, view.transform);
    oldPoint = CGPointApplyAffineTransform(oldPoint, view.transform);
    
    CGPoint position = view.layer.position;
    
    position.x -= oldPoint.x;
    position.x += newPoint.x;
    
    position.y -= oldPoint.y;
    position.y += newPoint.y;
    
    view.layer.position = position;
    view.layer.anchorPoint = anchorPoint;
}

- (void)buttonTapped:(UIButton*)button
{
    [self generateBoard];
    
    [self generatePieces];
    
    [self resetHighlightView];
    
    [restartButton setEnabled:NO];
}

#pragma mark - Generation

- (void)generateBoard
{
    if(tiles == nil && activeAreas == nil)
    {
        tiles = [[NSMutableArray alloc] init];
        
        activeAreas = [[NSMutableArray alloc] init];
        
        for(int i = 0; i < numberOfTiles; i++)
        {
            NSMutableArray* tilesRow = [[NSMutableArray alloc] init];
            
            NSMutableArray* activeAreasRow = [[NSMutableArray alloc] init];
            
            for(int j = 0; j < numberOfTiles; j++)
            {
                CGRect tileFrame;
                tileFrame.origin.x = ((i + 1) * space) + (i * tileSize);
                tileFrame.origin.y = ((j + 1) * space) + (j * tileSize);
                tileFrame.size.width = tileSize;
                tileFrame.size.height = tileSize;
                
                TileView* tile = [[TileView alloc] initWithFrame:tileFrame];
                [tile initialize];
                [boardView addSubview:tile];
                
                [tilesRow addObject:tile];
                
                CGRect activeAreaFrame;
                activeAreaFrame.origin.x = i * (space + tileSize) + boardView.frame.origin.x;
                activeAreaFrame.origin.y = j * (space + tileSize) + boardView.frame.origin.y;
                activeAreaFrame.size.width = (space + tileSize) / 2;
                activeAreaFrame.size.height = (space + tileSize) / 2;
                
                [activeAreasRow addObject:[NSValue valueWithCGRect:activeAreaFrame]];
                
                // CGRect someRect = [[array objectAtIndex:0] CGRectValue];
            }
            
            [tiles addObject:tilesRow];
            
            [activeAreas addObject:activeAreasRow];
        }
    }
    else
    {
        for(int i = 0; i < numberOfTiles; i++)
        {
            for(int j = 0; j < numberOfTiles; j++)
            {
                [tile(i, j) initialize];
            }
        }
    }
}

- (void)generatePieces
{
    if(piece0 == nil && piece1 == nil && piece2 == nil)
    {
        int pieceY = (boardView.frame.origin.y + boardView.frame.size.height) + ((bounds.size.height - boardView.frame.origin.y - boardView.frame.size.height) / 2);
        
        int pieceSize = (tileSize * 5) + (space * (5 + 1));
        
        piece0 = [[PieceView alloc] initWithFrame:CGRectMake(0, 0, pieceSize, pieceSize)];
        [piece0 setBackgroundColor:clearColor];
        [piece0 setPieceType:[Utility getARandomPieceType]];
        [piece0 setCenter:CGPointMake((bounds.size.width / 2) - pieceSize - ((bounds.size.width - (pieceSize * 3)) / 4), pieceY)];
        [piece0 initialize];
        [self.view addSubview:piece0];
        
        piece1 = [[PieceView alloc] initWithFrame:CGRectMake(0, 0, pieceSize, pieceSize)];
        [piece1 setBackgroundColor:clearColor];
        [piece1 setPieceType:[Utility getARandomPieceType]];
        [piece1 setCenter:CGPointMake(bounds.size.width / 2, pieceY)];
        [piece1 initialize];
        [self.view addSubview:piece1];
        
        piece2 = [[PieceView alloc] initWithFrame:CGRectMake(0, 0, pieceSize, pieceSize)];
        [piece2 setBackgroundColor:clearColor];
        [piece2 setPieceType:[Utility getARandomPieceType]];
        [piece2 setCenter:CGPointMake((bounds.size.width / 2) + pieceSize + ((bounds.size.width - (pieceSize * 3)) / 4), pieceY)];
        [piece2 initialize];
        [self.view addSubview:piece2];
        
        pieces = [[NSArray alloc] initWithObjects:piece0, piece1, piece2, nil];
    }
    else
    {
        for(PieceView* piece in pieces)
        {
            [piece setPieceType:[Utility getARandomPieceType]];
            [piece initialize];
            [piece setHidden:NO];
        }
    }
}

- (void)resetHighlightView
{
    if(highlightView == nil)
    {
        highlightView = [[UIView alloc] initWithFrame:CGRectZero];
        [highlightView setBackgroundColor:clearColor];
        [highlightView setHidden:YES];
        [self.view addSubview:highlightView];
    }
    else
    {
        highlightView.layer.sublayers = nil;
        [highlightView setHidden:YES];
        [highlightView setFrame:CGRectZero];
    }
}

#pragma mark - Drawing

- (void)drawActiveShapeToHighlightViewOfPiece:(PieceView*)_piece fromPoint:(CGPoint)_point
{
    [self resetHighlightView];
    
    int highlightTileSize = tileSize - 2;
    int highlightTileSpace = 4; // iPhone:4 iPad:6
    
    NSDictionary* shapeDict = [Utility getShapeDictWithType:_piece.pieceType];
    
    int width = [[shapeDict objectForKey:@"width"] intValue];
    int height = [[shapeDict objectForKey:@"height"] intValue];
    
    NSString* pattern = [shapeDict objectForKey:@"pattern"];
    
    CGRect highlightFrame;
    highlightFrame.size.width = (width * highlightTileSize) + ((width - 1) * highlightTileSpace);
    highlightFrame.size.height = (height * highlightTileSize) + ((height - 1) * highlightTileSpace);
    highlightFrame.origin.x = (_point.x - (highlightFrame.size.width / 2));
    highlightFrame.origin.y = (_point.y - highlightFrame.size.height - 10);
    
    for(int i = 0; i < width; i++)
    {
        for(int j = 0; j < height; j++)
        {
            int charIndex = (i * height) + j;
            
            if([pattern characterAtIndex:charIndex] == '1')
            {
                CGRect tileFrame;
                tileFrame.size.width = highlightTileSize;
                tileFrame.size.height = highlightTileSize;
                tileFrame.origin.x = (i * (highlightTileSize + highlightTileSpace));
                tileFrame.origin.y = (j * (highlightTileSize + highlightTileSpace));
                
                CALayer * roundRect = [CALayer layer];
                [roundRect setFrame:tileFrame];
                [roundRect setCornerRadius:cornerRadius];
                [roundRect setMasksToBounds:YES];
                [roundRect setBackgroundColor:[[Utility colorOfType:_piece.pieceType] CGColor]];
                
                [[highlightView layer] insertSublayer:roundRect atIndex:0];
            }
        }
    }
    
    [highlightView setFrame:highlightFrame];
    
    [highlightView setHidden:NO];
}

#pragma mark - Touch Delegates & Methods

- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    UITouch *touch = [touches anyObject];
    
    int pieceIndex = [self isTouchOnAPiece:touch];
    
    if(pieceIndex != -1)
    {
        activePieceIndex = pieceIndex;
        
        PieceView* piece = (PieceView*)[pieces objectAtIndex:pieceIndex];
        
        [piece setHidden:YES];
        
        lastPoint = [touch locationInView:self.view];
        
        [self drawActiveShapeToHighlightViewOfPiece:piece fromPoint:lastPoint];
    }
}

- (void)touchesMoved:(NSSet *)touches withEvent:(UIEvent *)event
{
    UITouch *touch = [touches anyObject];
    
    if(!highlightView.isHidden)
    {
        float diffX = lastPoint.x - [touch locationInView:self.view].x;
        
        float diffY = lastPoint.y - [touch locationInView:self.view].y;
        
        CGRect frame = highlightView.frame;
        frame.origin.x -= diffX;
        frame.origin.y -= diffY;
        
        [highlightView setFrame:frame];
        
        lastPoint = [touch locationInView:self.view];
    }
}

- (void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event
{
    if(activePieceIndex == -1)
    {
        return;
    }
    
    UITouch *touch = [touches anyObject];
    
    lastPoint = [touch locationInView:self.view];
    
    if([self shouldPlacePieceOnBoard])
    {
        [self clearLinesIfPossible];
        
        if([self numberOfActivePieces] == 0)
        {
            [self generatePieces];
        }
        else
        {
            if(![self isAtLeastOnePieceCanBePlacedOnBoard])
            {
                [Utility showAlertWithMessage:@"End of game!"];
                
                NSLog(@"End of game");
                
                [restartButton setEnabled:YES];
            }
        }
    }
    else
    {
        [self putActivePieceBack];
    }
}

- (BOOL)isAtLeastOnePieceCanBePlacedOnBoard
{
    // Bug var
    
    for(PieceView* piece in pieces)
    {
        if(piece.isHidden)
        {
            continue;
        }
        
        NSDictionary* shapeDict = [Utility getShapeDictWithType:piece.pieceType];
        
        int width = [[shapeDict objectForKey:@"width"] intValue];
        int height = [[shapeDict objectForKey:@"height"] intValue];
        
        NSString* pattern = [shapeDict objectForKey:@"pattern"];
        
        for(int i = 0; i <= (numberOfTiles - width); i++)
        {
            for(int j = 0; j <= (numberOfTiles - height); j++)
            {
                int count = 0;
                
                for(int m = 0; m < width; m++)
                {
                    for(int n = 0; n < height; n++)
                    {
                        int charIndex = (m * height) + n;
                        
                        if([pattern characterAtIndex:charIndex] == '1')
                        {
                            TileView* pieceTile = tile(i + m, n + j);
                            
                            if([pieceTile isAvailable])
                            {
                                count++;
                            }
                        }
                    }
                }
                
                if(count == [[shapeDict objectForKey:@"weight"] intValue])
                {
                    return YES;
                }
            }
        }
    }
    
    return NO;
}

- (int)numberOfActivePieces
{
    int count = 0;
    
    for(PieceView* piece in pieces)
    {
        if(!piece.isHidden)
        {
            count++;
        }
    }
    
    return count;
}

- (void)clearLinesIfPossible
{
    for(int i = 0; i < numberOfTiles; i++)
    {
        int availableRowCount = 0;
        
        int availableColumnCount = 0;
        
        NSMutableArray* rowArray = [[NSMutableArray alloc] init];
        
        NSMutableArray* columnArray = [[NSMutableArray alloc] init];
        
        for(int j = 0; j < numberOfTiles; j++)
        {
            TileView* tileRow = tile(i, j);
            
            if(tileRow.isAvailable)
            {
                availableRowCount++;
            }
            
            [rowArray addObject:tileRow];
            
            TileView* tileColumn = tile(j, i);
            
            if(tileColumn.isAvailable)
            {
                availableColumnCount++;
            }
            
            [columnArray addObject:tileColumn];
        }
        
        if(availableRowCount == 0)
        {
            for(TileView* tile in rowArray)
            {
                [tile initialize];
            }
        }
        
        if(availableColumnCount == 0)
        {
            for(TileView* tile in columnArray)
            {
                [tile initialize];
            }
        }
    }
}

- (BOOL)shouldPlacePieceOnBoard
{
    int column = -1;
    
    int row = -1;
    
    for(int i = 0; i < numberOfTiles; i++)
    {
        for(int j = 0; j < numberOfTiles; j++)
        {
            CGRect rect = [[[activeAreas objectAtIndex:i] objectAtIndex:j] CGRectValue];
            
            if([Utility isThisPoint:CGPointMake(highlightView.frame.origin.x, highlightView.frame.origin.y) insideThisRect:rect])
            {
                column = i;
                
                row = j;
                
                goto endLoop;
            }
        }
    }
    
    endLoop:
    
    if(column == -1 && row == -1)
    {
        return NO;
    }
    
    PieceView* activePiece = (PieceView*)[pieces objectAtIndex:activePieceIndex];
    
    NSDictionary* shapeDict = [Utility getShapeDictWithType:activePiece.pieceType];
    
    if(((row + [[shapeDict objectForKey:@"height"] intValue]) <= numberOfTiles) && ((column + [[shapeDict objectForKey:@"width"] intValue]) <= numberOfTiles))
    {
        int width = [[shapeDict objectForKey:@"width"] intValue];
        int height = [[shapeDict objectForKey:@"height"] intValue];
        
        NSString* pattern = [shapeDict objectForKey:@"pattern"];
        
        NSMutableArray* placeTiles = [[NSMutableArray alloc] init];
        
        for(int i = 0; i < width; i++)
        {
            for(int j = 0; j < height; j++)
            {
                int charIndex = (i * height) + j;
                
                if([pattern characterAtIndex:charIndex] == '1')
                {
                    TileView* tile = tile(column + i, row + j);
                    
                    if(![tile isAvailable])
                    {
                        return NO;
                    }
                    else
                    {
                        [placeTiles addObject:tile];
                    }
                }
            }
        }
        
        UIColor* pieceColor = [Utility colorOfType:activePiece.pieceType];
        
        for(int k = 0; k < [placeTiles count]; k++)
        {
            TileView* tile = (TileView*)[placeTiles objectAtIndex:k];
            
            [tile setBackgroundColor:pieceColor];
            
            [tile setIsAvailable:NO];
        }
        
        activePieceIndex = -1;
        
        [self resetHighlightView];
        
        return YES;
    }
    else
    {
        return NO;
    }
    
    return NO;
}

- (void)putActivePieceBack
{
    PieceView* activePiece = (PieceView*)[pieces objectAtIndex:activePieceIndex];
    
    [UIView animateWithDuration:[self calculateAnimationSpeedFromPoint:highlightView.center toPoint:activePiece.center] animations:^{
        [highlightView setCenter:[activePiece defaultCenter]];
    } completion:^(BOOL finished) {
        [UIView animateWithDuration:0.5 animations:^{
            [self resetHighlightView];
            [(PieceView*)[pieces objectAtIndex:activePieceIndex] setHidden:NO];
        } completion:^(BOOL finished) {
            
        }];
    }];
}

- (float)calculateAnimationSpeedFromPoint:(CGPoint)_from toPoint:(CGPoint)_to
{
    float distanceX = (_from.x - _to.x);
    
    float distanceY = (_from.y - _to.y);
    
    float distance = sqrtf((distanceX * distanceX) + (distanceY * distanceY));
    
    return distance / pixelsPerSec;
}

- (int)isTouchOnAPiece:(UITouch*)_touch
{
    for(int i = 0; i < [pieces count]; i++)
    {
        PieceView* piece = (PieceView*)[pieces objectAtIndex:i];
        
        if(!piece.isHidden)
        {
            if([Utility isThisPoint:[_touch locationInView:self.view] insideThisRect:piece.frame])
            {
                return i;
            }
        }
    }
    
    return -1;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
