//
//  WhiskeyViewController.m
//  Alcolator
//
//  Created by Joseph Blanco on 5/13/15.
//  Copyright (c) 2015 Blancode. All rights reserved.
//

#import "WhiskeyViewController.h"

@interface WhiskeyViewController ()

@end

@implementation WhiskeyViewController

int ouncesInOneBeer = 12;
float ouncesInOneWhiskeyShot = 1;
float alcoholPercentageOfWhiskey = 0.4;
NSString *beerTextAgain;
NSString *whiskeyText;
int numberOfBeers;
float alcoholPercentageOfBeer;
float ouncesOfAlcoholPerBeer;
float ouncesOfAlcoholTotal;
float ouncesOfAlcoholPerWhiskeyShot;
float numberOfWhiskeyShotsForEquivalentAlcoholAmount;

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = NSLocalizedString(@"Whiskey", @"whiskey");
}

- (void)sliderValueDidChange:(UISlider *)sender {
    NSLog(@"Slider value changed to %f", sender.value);
    [self.beerPercentTextField resignFirstResponder];
    numberOfBeers = self.beerCountSlider.value;
    alcoholPercentageOfBeer = [self.beerPercentTextField.text floatValue] / 100;
    ouncesOfAlcoholPerBeer = ouncesInOneBeer * alcoholPercentageOfBeer;
    ouncesOfAlcoholTotal = ouncesOfAlcoholPerBeer * numberOfBeers;
    ouncesOfAlcoholPerWhiskeyShot = ouncesInOneWhiskeyShot * alcoholPercentageOfWhiskey;
    numberOfWhiskeyShotsForEquivalentAlcoholAmount = ouncesOfAlcoholTotal / ouncesOfAlcoholPerWhiskeyShot;
    
    
    if (numberOfBeers == 1) {
        beerTextAgain = NSLocalizedString(@"beer", @"singular beer");
    } else {
        beerTextAgain = NSLocalizedString(@"beers", @"plural of beer");
    }
    
    if (numberOfWhiskeyShotsForEquivalentAlcoholAmount == 1) {
        whiskeyText = NSLocalizedString(@"shot", @"singular shot");
    } else {
        whiskeyText = NSLocalizedString(@"shots", @"plural of shot");
    }
    
    NSString *beerCountText = [NSString stringWithFormat:NSLocalizedString(@"%d %@", nil), numberOfBeers, beerTextAgain];
    self.sliderCountLabel.text = beerCountText;
    // added beer label ends here
    
    NSString *newTitle = [NSString stringWithFormat:NSLocalizedString(@"Whiskey (%.1f %@)", nil),numberOfWhiskeyShotsForEquivalentAlcoholAmount, whiskeyText];
    self.title = newTitle;
    
}

-(void)buttonPressed:(UIButton *)sender;
{
    
    NSString *resultText = [NSString stringWithFormat:NSLocalizedString(@"%d %@ contains as much alcohol as %.1f %@ of whiskey.", nil), numberOfBeers, beerTextAgain, numberOfWhiskeyShotsForEquivalentAlcoholAmount, whiskeyText];
    self.resultLabel.text = resultText;
}


@end
