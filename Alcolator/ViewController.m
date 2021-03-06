//
//  ViewController.m
//  Alcolator
//
//  Created by Joseph Blanco on 5/8/15.
//  Copyright (c) 2015 Blancode. All rights reserved.
//

#import "ViewController.h"
#import <QuartzCore/QuartzCore.h>

@interface ViewController () <UITextFieldDelegate>

@property (weak, nonatomic) UIButton *calculateButton;
@property (weak, nonatomic) UITapGestureRecognizer *hideKeyboardTapGestureRecognizer;

@end

@implementation ViewController

int beerCounter;
int ouncesInOneBeerGlass = 12;
float ouncesInOneWineGlass = 5;
float alcoholPercentageOfWine = 0.13;
float alcoholPercentageOfBeer;
float ouncesOfAlcoholPerBeer;
float ouncesOfAlcoholTotal;
float ouncesOfAlcoholPerWineGlass;
float numberOfWineGlassesForEquivalentAlcoholAmount;
NSString *beerText;
NSString *wineText;

- (instancetype) init {
    self = [super init];
    
    if (self) {
        self.title = NSLocalizedString(@"Wine", @"wine");
        [self.tabBarItem setTitlePositionAdjustment:UIOffsetMake(0, -18)];
    }
    
    return self;
}

- (void)loadView {
    self.view = [[UIView alloc] init];
    
    UITextField *textField = [[UITextField alloc] init];
    UISlider *slider = [[UISlider alloc] init];
    UILabel *label = [[UILabel alloc] init];
    UILabel *sliderLabel = [[UILabel alloc] init];
    UIButton *button = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] init];
    
    [self.view addSubview:textField];
    [self.view addSubview:slider];
    [self.view addSubview:label];
    [self.view addSubview:sliderLabel];
    [self.view addSubview:button];
    [self.view addGestureRecognizer:tap];
    
    self.beerPercentTextField = textField;
    self.beerCountSlider = slider;
    self.resultLabel = label;
    self.sliderCountLabel = sliderLabel;
    self.calculateButton = button;
    self.hideKeyboardTapGestureRecognizer = tap;
    
}


- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor colorWithRed:0.741 green:0.925 blue:0.714 alpha:1]; /*#bdecb6*/
    [[UILabel appearance] setFont:[UIFont fontWithName:@"TrebuchetMS" size:14]];
    [[UITextField appearance] setFont:[UIFont fontWithName:@"TrebuchetMS" size:14]];
    // colors go here
    self.beerPercentTextField.delegate = self;
    self.beerPercentTextField.placeholder = NSLocalizedString(@"% Alcohol Content Per Beer", @"Beer percent placeholder text");
    self.beerPercentTextField.textAlignment = NSTextAlignmentCenter;
    self.beerPercentTextField.backgroundColor = [UIColor whiteColor];
    self.beerPercentTextField.layer.cornerRadius = 5;
    self.beerPercentTextField.layer.borderColor=[[UIColor colorWithWhite:0.3f alpha:0.3f]CGColor];
    self.beerPercentTextField.layer.borderWidth=1.5;
    [self.beerCountSlider addTarget:self action:@selector(sliderValueDidChange:) forControlEvents:UIControlEventValueChanged];
    self.beerCountSlider.minimumValue = 1;
    self.beerCountSlider.maximumValue = 10;
    
    [self.calculateButton addTarget:self action:@selector(buttonPressed:) forControlEvents:UIControlEventTouchUpInside];
    [self.calculateButton setTitle:NSLocalizedString(@"Calculate!", @"Calculate command") forState:UIControlStateNormal];
    self.calculateButton.backgroundColor = [UIColor blueColor];
    [self.calculateButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [[self.calculateButton titleLabel] setFont:[UIFont fontWithName:@"TrebuchetMS-Bold" size:16]];
    self.calculateButton.layer.cornerRadius = 5;
    self.calculateButton.clipsToBounds = YES;
    
    [self.hideKeyboardTapGestureRecognizer addTarget:self action:@selector(tapGestureDidFire:)];
    self.resultLabel.numberOfLines = 0;
    self.resultLabel.textAlignment = NSTextAlignmentCenter;
    self.sliderCountLabel.text = @"How Many Beers?";
    self.sliderCountLabel.numberOfLines = 0;
    self.sliderCountLabel.textAlignment = NSTextAlignmentCenter;
    
    

}

-(void) viewWillLayoutSubviews {
    [super viewWillLayoutSubviews];
    
    CGRect screenRect = [[UIScreen mainScreen] bounds];
    CGFloat viewWidth = screenRect.size.width;
    CGFloat viewHeight = screenRect.size.height;
    CGFloat padding = 20;
    CGFloat itemWidth = viewWidth - padding - padding;
    CGFloat itemHeight = 34;
    self.beerPercentTextField.frame = CGRectMake(padding, viewHeight/6, itemWidth, itemHeight);
    CGFloat bottomOfTextField = CGRectGetMaxY(self.beerPercentTextField.frame);
    self.beerCountSlider.frame = CGRectMake(padding, bottomOfTextField + padding, itemWidth, itemHeight);
    CGFloat bottomOfSlider = CGRectGetMaxY(self.beerCountSlider.frame);
    self.sliderCountLabel.frame = CGRectMake(padding, bottomOfSlider, itemWidth, itemHeight);
    CGFloat bottomOfSliderLabel = CGRectGetMaxY(self.sliderCountLabel.frame);
    self.resultLabel.frame = CGRectMake(padding, bottomOfSliderLabel, itemWidth, itemHeight * 2);
    CGFloat bottomOfLabel = CGRectGetMaxY(self.resultLabel.frame);
    self.calculateButton.frame = CGRectMake(padding * 5, bottomOfLabel + padding, itemWidth - (padding *8), itemHeight+8);
    
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

- (void)textFieldDidChange:(UITextField *)sender {
    
    NSString *enteredText = sender.text;
    float enteredNumber = [enteredText floatValue];
    
    if (enteredNumber == 0) {
        sender.text = nil;
    }
}

- (void)sliderValueDidChange:(UISlider *)sender {
    NSLog(@"Slider value changed to %f", sender.value);
    [self.beerPercentTextField resignFirstResponder];
    [self.tabBarItem setBadgeValue:[NSString stringWithFormat:@"%d", (int) sender.value]];
    beerCounter = self.beerCountSlider.value;
    alcoholPercentageOfBeer = [self.beerPercentTextField.text floatValue] / 100;
    ouncesOfAlcoholPerBeer = ouncesInOneBeerGlass * alcoholPercentageOfBeer;
    ouncesOfAlcoholTotal = ouncesOfAlcoholPerBeer * beerCounter;
    ouncesOfAlcoholPerWineGlass = ouncesInOneWineGlass * alcoholPercentageOfWine;
    numberOfWineGlassesForEquivalentAlcoholAmount = ouncesOfAlcoholTotal / ouncesOfAlcoholPerWineGlass;

    if (beerCounter == 1) {
        beerText = NSLocalizedString(@"beer", @"singular beer");
    } else {
        beerText = NSLocalizedString(@"beers", @"plural of beer");
    }
   
    if (numberOfWineGlassesForEquivalentAlcoholAmount == 1) {
        wineText = NSLocalizedString(@"glass", @"singular glass");
    } else {
        wineText = NSLocalizedString(@"glasses", @"plural of glass");
    }
    
    NSString *beerCountText = [NSString stringWithFormat:NSLocalizedString(@"%d %@", nil), beerCounter, beerText];
    self.sliderCountLabel.text = beerCountText;
    
    NSString *newTitle = [NSString stringWithFormat:NSLocalizedString(@"Wine (%.1f %@)", nil),numberOfWineGlassesForEquivalentAlcoholAmount, wineText];
    self.title = newTitle;
    
}


- (void)buttonPressed:(UIButton *)sender {
    
    NSString *resultText = [NSString stringWithFormat:NSLocalizedString(@"%d %@ contains as much alcohol as %.1f %@ of wine.", nil), beerCounter, beerText, numberOfWineGlassesForEquivalentAlcoholAmount, wineText];
    self.resultLabel.text = resultText;
    
}


- (void)tapGestureDidFire:(UITapGestureRecognizer *)sender {
    
    [self.beerPercentTextField resignFirstResponder];
    
}


@end
