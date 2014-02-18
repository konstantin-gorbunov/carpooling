//
//  CPViewController.m
//  Carpooling
//
//  Created by Konstantin Gorbunov on 18/02/14.
//  Copyright (c) 2014 Konstantin Gorbunov. All rights reserved.
//

#import "CPViewController.h"
#import "CPTableController.h"
#import "CPDataManager.h"

@interface CPViewController () {
    CPTableController *tableController;
}

@property (strong, atomic) IBOutlet UITableView *cityTableView;
@property (strong, atomic) IBOutlet UITextField *countryNumberTextField;

-(IBAction)updateCityList:(id)sender;

@end

@implementation CPViewController

- (id)initWithCoder:(NSCoder *)aDecoder {
    self = [super initWithCoder:aDecoder];
    if (self) {
        [self setup];
    }
    return self;
}

- (void) setup {
    tableController = [[CPTableController alloc] init];
    
    self.cityTableView.dataSource = tableController;
    self.cityTableView.delegate = tableController;
    
    self.countryNumberTextField.delegate = self;
    
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(useNotificationWithString:)
                                                 name:kNotificationName object:nil];
}

- (void)viewDidLoad {
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(IBAction)updateCityList:(id)sender {
    if (self.countryNumberTextField.text.length > 0) {
        [[CPDataManager sharedManager] loadData:[self.countryNumberTextField.text intValue]];
    }
    else {
        [[CPDataManager sharedManager] loadData];
    }
}

#pragma mark - UITextFieldDelegate

- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string {
    if (textField.text.length >= 2) {
        return NO;
    }
    else {
        return YES;
    }
}

#pragma mark - Notifications
- (void)useNotificationWithString:(NSNotification*)notification {
    NSLog(@"123");
}

@end
