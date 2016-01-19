//
//  ViewController.m
//  crystalexpress-lite
//
//  Created by roylo on 2015/10/20.
//  Copyright © 2015年 intowow. All rights reserved.
//

#import "ViewController.h"
#import "CENativeAd.h"

@interface ViewController () <CENativeAdDelegate>
@property (nonatomic, strong) CENativeAd *nativeAd;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // Setup native AD view customized UI layout for storyboard components
    _adUIView.layer.cornerRadius = 5.0f;
    _callToActionWrapper.layer.borderColor = [UIColor whiteColor].CGColor;
    _callToActionWrapper.layer.borderWidth = 1.0f;
    _callToActionWrapper.backgroundColor = [UIColor clearColor];
    [_callToActionBtn.titleLabel setFont:[UIFont systemFontOfSize:9]];
    [_adTitle setFont:[UIFont systemFontOfSize:13]];
    [_adBody setFont:[UIFont systemFontOfSize:11]];
}

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    
    // start ad play while viewcontroller appear
    // this will start video ad and track for impression
    if (_adMediaCoverView) {
        [_adMediaCoverView play];
    }
}

- (void)viewDidDisappear:(BOOL)animated
{
    [super viewDidDisappear:animated];
    
    // stop ad play while viewcontroller disappear
    if (_adMediaCoverView) {
        [_adMediaCoverView stop];
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

// button action from storyboard
- (IBAction)loadNativeAd:(id)sender {
    
    // load native AD with AD placement
    CENativeAd *nativeAd = [[CENativeAd alloc] initWithPlacement:@"NATIVE_AD"];
    
    // set the native ad delegate to self to receive relative events
    nativeAd.delegate = self;
    
    // start load a native ad component
    [nativeAd loadAd];
}

// button action from storyboard
- (IBAction)startNativeAd:(id)sender {
    if (self.adMediaCoverView) {
        [self.adMediaCoverView play];
    }
}

// button action from storyboard
- (IBAction)stopNativeAd:(id)sender {
    if (self.adMediaCoverView) {
        [self.adMediaCoverView stop];
    }
}

#pragma mark - CENativeAdDelegate
- (void)nativeAdDidLoad:(CENativeAd *)nativeAd
{
    // leave a log on storyboard UI
    NSString *log = @"Native ad was loaded\n";
    _eventLog.text = log;
    NSLog(@"%@", log);
    
    _nativeAd = nativeAd;
    
    // load icon image asset asynchournously
    __weak typeof(self) weakSelf = self;
    [self.nativeAd.icon loadImageAsyncWithBlock:^(UIImage *image) {
        __strong typeof(self) strongSelf = weakSelf;
        strongSelf.adIconImageView.image = image;
    }];

    // set native ad instance for CEMediaView to setup ad media view
    [self.adMediaCoverView setNativeAd:nativeAd];

    // set native ad component string
    self.adTitle.text = nativeAd.title;
    self.adBody.text = nativeAd.body;
    [self.callToActionBtn setTitle:nativeAd.callToAction forState:UIControlStateNormal];
    
    [nativeAd registerViewForInteraction:self.callToActionBtn
                      withViewController:self];
  
  
//    You can replace to use the following method to specify the clicable area
//    
//    NSArray *clickableViews = @[
//                                self.callToActionBtn,
//                                self.adBody,
//                                ];
//    [nativeAd registerViewForInteraction:self.adUIView
//                      withViewController:self
//                      withClickableViews:clickableViews];

}

- (void)nativeAd:(CENativeAd *)nativeAd didFailWithError:(NSError *)error
{
    NSString *log = [NSString stringWithFormat:@"load native ad fail: %@", error];
    _eventLog.text = log;
    NSLog(@"%@", log);
}

- (void)nativeAdDidClick:(CENativeAd *)nativeAd
{
    NSString *log = @"Native ad was clicked.\n";
    _eventLog.text = [_eventLog.text stringByAppendingString:log];
    NSLog(@"%@", log);
}

- (void)nativeAdDidFinishHandlingClick:(CENativeAd *)nativeAd
{
    NSString *log = @"Native ad did finish click handling.\n";
    _eventLog.text = [_eventLog.text stringByAppendingString:log];
    [self.adMediaCoverView mute];
    NSLog(@"%@", log);
}

- (void)nativeAdWillTrackImpression:(CENativeAd *)nativeAd
{
    NSString *log = @"Native ad impression is being captured.\n";
    _eventLog.text = [_eventLog.text stringByAppendingString:log];
    NSLog(@"%@", log);
}

@end
