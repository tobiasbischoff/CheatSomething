//
//  ViewController.m
//  CheatSomething
//
//  Created by Bischoff Tobias on 25.03.12.
//  Copyright (c) 2012 Tobias Bischoff. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@end

@implementation ViewController
@synthesize AdView;
@synthesize activity;
@synthesize queryField;
@synthesize findButton;
@synthesize solutionField;



- (void)viewDidLoad
{
    [super viewDidLoad];
    
    solution3 = [[NSMutableArray alloc] init];
    solution4 = [[NSMutableArray alloc] init];
    solution5 = [[NSMutableArray alloc] init];
    solution6 = [[NSMutableArray alloc] init];
    
    [AdView setDelegate:self];
    
    //read the wordlist.csv file into an array
    NSString *title = @"wordlist";
    NSString *type = @"csv";
    NSString *seperation = @"\n";
    wordlist = [[NSArray alloc] initWithArray:[[NSString stringWithContentsOfFile:[[NSBundle mainBundle] 
                                                                                                    pathForResource:title ofType:type] 
                                                                                          encoding:NSMacOSRomanStringEncoding error:NULL] componentsSeparatedByString:seperation]];
    //log one item to see if seperation is made correct
    NSLog(@"array inhalt: %@ ", [wordlist objectAtIndex:0] );
}

- (void)viewDidUnload
{
    [self setQueryField:nil];
    [self setFindButton:nil];
    [self setSolutionField:nil];
    [self setActivity:nil];
    [self setAdView:nil];
    [super viewDidUnload];
    // Release any retained subviews of the main view.
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return (interfaceOrientation != UIInterfaceOrientationPortraitUpsideDown);
}

- (void)bruteforce
{
    //clear the solution arrays
    [solution3 removeAllObjects];
    [solution4 removeAllObjects];
    [solution5 removeAllObjects];
    [solution6 removeAllObjects];
    
    
    //build a character set from the contents of the query field
    NSCharacterSet * set = [NSCharacterSet characterSetWithCharactersInString:[queryField text]];
    
    //brute force the wordlist array
    for (id currentWord in wordlist) {
        
        int c = 0;
        
        //get the a range from the actual word
        NSRange range = {0, [currentWord length]-5};
        //make a working copy without the garbage at the end..
        NSString * working = [currentWord substringWithRange:range];
        NSLog(@"working %@", working);
        
        //go thru the word by char
        for(int i = 0; i < [working length]; ++i) {
            //see if the char is in our query, if so raise the counter
            unichar character = [working characterAtIndex:i];
            if ([set characterIsMember:character]) c++;
        }
        
        //if all chars are in the query field, we have a match    
        if (c == [working length]) {
            
            if ([working length] == 3) [solution3 addObject:working];
            if ([working length] == 4) [solution4 addObject:working];
            if ([working length] == 5) [solution5 addObject:working];
            if ([working length] > 5) [solution6 addObject:working];
            
        }
        
    }
    [self performSelectorOnMainThread:@selector(updategui) withObject:nil waitUntilDone:NO];
    
}

-(void)updategui
{
    solutionField.text = [NSString stringWithFormat:@"Found %d possible solutions:\n", [solution3 count]+[solution4 count]+[solution5 count]+[solution6 count]];
    solutionField.text = [NSString stringWithFormat:@"%@\n\n 3 char Words: \n", solutionField.text]; 
    
    for (id word in solution3) {
        solutionField.text = [NSString stringWithFormat:@"%@\n %@",solutionField.text , word];
    }
    
    solutionField.text = [NSString stringWithFormat:@"%@\n\n 4 char Words: \n", solutionField.text]; 
    
    for (id word in solution4) {
        solutionField.text = [NSString stringWithFormat:@"%@\n %@",solutionField.text , word];
    }
    
    solutionField.text = [NSString stringWithFormat:@"%@\n\n 5 Char Words: \n", solutionField.text]; 
    
    for (id word in solution5) {
        solutionField.text = [NSString stringWithFormat:@"%@\n %@",solutionField.text , word];
    }
    
    solutionField.text = [NSString stringWithFormat:@"%@\n\n 6+ Char Words: \n", solutionField.text]; 
    
    for (id word in solution6) {
        solutionField.text = [NSString stringWithFormat:@"%@\n %@",solutionField.text , word];
    }
    [activity stopAnimating];
    [findButton setEnabled:TRUE];

}

- (IBAction)findButton:(id)sender {
    
    [queryField resignFirstResponder];
    [activity startAnimating];
    [sender setEnabled:FALSE];
    [self performSelectorInBackground:@selector(bruteforce) withObject:nil];
     
    }

- (IBAction)backgroundtapped:(id)sender {
    
    [queryField resignFirstResponder];
    
}

- (void)bannerView:(ADBannerView *)banner didFailToReceiveAdWithError:(NSError *)error {
    
    [banner setHidden:TRUE];
}

- (void)bannerViewDidLoadAd:(ADBannerView *)banner {
    
    [banner setHidden:FALSE];
}

@end
