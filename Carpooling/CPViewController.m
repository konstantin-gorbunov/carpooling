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
}

- (void)viewWillAppear:(BOOL)animated {    
    [super viewWillAppear:animated];
    
    self.cityTableView.dataSource = tableController;
    self.cityTableView.delegate = tableController;
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(useNotificationWithString:)
                                                 name:kNotificationName object:nil];
}

- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    [[NSNotificationCenter defaultCenter] removeObserver:self];
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
    [self.countryNumberTextField resignFirstResponder];
}

#pragma mark - UITextFieldDelegate

- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string {
    if (textField.text.length < 2 || string.length == 0) {
        return YES;
    }
    else {
        return NO;
    }
}

#pragma mark - Notifications
- (void)useNotificationWithString:(NSNotification*)notification {
    [self.cityTableView reloadData];
}

@end
