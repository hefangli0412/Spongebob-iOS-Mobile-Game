//
//  BBViewController.m
//  BrickBreaker
//
//  Created by J Hastwell on 16/04/2014.
//  Copyright (c) 2014 J Hastwell. All rights reserved.
//

#import "BBViewController.h"
#import "BBMyScene.h"
#import <MediaPlayer/MediaPlayer.h>

@interface BBViewController()
@property (nonatomic) MPMoviePlayerViewController * moviePlayer;
@end

@implementation BBViewController

- (void)viewDidLoad
{
    [super viewDidLoad];

    // Configure the view.
    SKView * skView = (SKView *)self.view;
    skView.showsFPS = YES;
    skView.showsNodeCount = YES;
    
    // Create and configure the scene.
    SKScene * scene = [BBMyScene sceneWithSize:skView.bounds.size];
    scene.scaleMode = SKSceneScaleModeAspectFill;
    
//    [self playVideo];
    
    // Present the scene.
    [skView presentScene:scene];
}

-(void)playVideo
{
    // play video file
    NSURL *urlString = [NSURL fileURLWithPath:[[NSBundle mainBundle] pathForResource:@"introvideo" ofType:@"mp4"]];
    _moviePlayer = [[MPMoviePlayerViewController alloc] initWithContentURL:urlString];
    
    [self.view addSubview:_moviePlayer.view];

//    [self presentViewController:_moviePlayer animated:NO completion:nil];
}


-(BOOL)prefersStatusBarHidden
{
    return YES;
}


- (BOOL)shouldAutorotate
{
    return YES;
}

- (NSUInteger)supportedInterfaceOrientations
{
    if ([[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPhone) {
        return UIInterfaceOrientationMaskAllButUpsideDown;
    } else {
        return UIInterfaceOrientationMaskAll;
    }
}


@end
