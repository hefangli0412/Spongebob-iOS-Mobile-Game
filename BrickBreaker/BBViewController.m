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
@property (nonatomic) MPMoviePlayerController * moviePlayer;
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
    
    [self playVideo];
    
    // Present the scene.
    [skView presentScene:scene];
}

-(void)playVideo
{
    // play video file
    NSURL *urlString = [NSURL fileURLWithPath:[[NSBundle mainBundle] pathForResource:@"introvideo" ofType:@"mp4"]];
    _moviePlayer = [[MPMoviePlayerController alloc] initWithContentURL:urlString];
    [[_moviePlayer view] setFrame:[self.view bounds]];
    
    [self.view addSubview:_moviePlayer.view];
    
    _moviePlayer.fullscreen = YES;
    _moviePlayer.allowsAirPlay = YES;
    _moviePlayer.scalingMode = MPMovieScalingModeAspectFit;
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(moviePlayStateDidChange:)
                                                 name:MPMoviePlayerPlaybackStateDidChangeNotification
                                               object:_moviePlayer];
    
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(moviePlayBackDidFinish:)
                                                 name:MPMoviePlayerPlaybackDidFinishNotification
                                               object:nil];
    
    [_moviePlayer play];
}

- (void)moviePlayBackDidFinish : (NSNotification *) notification
{
    MPMoviePlayerController * player = notification.object;
    [player stop];
}

-(void)moviePlayStateDidChange : (NSNotification *) notification
{
    MPMoviePlayerController * player = notification.object;
    switch (player.playbackState) {
        case MPMoviePlaybackStatePlaying:
            NSLog(@"playing");
            break;
            
        case MPMoviePlaybackStatePaused:
            {NSLog(@"paused");
            UIAlertView * alert =[[UIAlertView alloc ] initWithTitle:@"Exit playing?"
                                                             message:nil
                                                            delegate:self
                                                   cancelButtonTitle:@"NO"
                                                   otherButtonTitles: nil];
            [alert addButtonWithTitle:@"YES"];
            [alert show];}
        default:
            break;
    }
}

- (void)alertView:(UIAlertView *)alertView didDismissWithButtonIndex:(NSInteger)buttonIndex
{
    NSLog(@"Button Index =%ld",(long)buttonIndex);
    if (buttonIndex == 0)
    {
        NSLog(@"You have clicked NO");
    }
    else if(buttonIndex == 1)
    {
        NSLog(@"You have clicked YES");
        [_moviePlayer stop];
    }
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
