//
//  ViewController.h
//  Alcolator
//
//  Created by Joseph Blanco on 5/8/15.
//  Copyright (c) 2015 Blancode. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ViewController : UIViewController

@property (weak, nonatomic) UILabel *titleLogo;
@property (weak, nonatomic) UITextField *beerPercentTextField;
@property (weak, nonatomic) UILabel *resultLabel;
@property (weak, nonatomic) UISlider *beerCountSlider;
@property (weak, nonatomic) UILabel *sliderCountLabel;

- (void)buttonPressed:(UIButton *)sender;


@end

