//
//  ViewController.h
//  CheatSomething
//
//  Created by Bischoff Tobias on 25.03.12.
//  Copyright (c) 2012 Tobias Bischoff. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <iAd/iAd.h>

@interface ViewController : UIViewController <ADBannerViewDelegate> {
    NSArray * wordlist;
    NSMutableArray * solution3;
    NSMutableArray * solution4; 
    NSMutableArray * solution5; 
    NSMutableArray * solution6;
}

@property (weak, nonatomic) IBOutlet UIActivityIndicatorView *activity;
@property (weak, nonatomic) IBOutlet UITextField *queryField;
@property (weak, nonatomic) IBOutlet UIButton *findButton;
@property (weak, nonatomic) IBOutlet UITextView *solutionField;
- (IBAction)findButton:(id)sender;
- (void)bruteforce;
- (void)updategui;
- (IBAction)backgroundtapped:(id)sender;
@property (weak, nonatomic) IBOutlet ADBannerView *AdView;


@end
