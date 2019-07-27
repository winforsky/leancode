//
//  ViewController.m
//  structdemo
//
//  Created by zsp on 2019/7/5.
//  Copyright © 2019 woop. All rights reserved.
//

#import "ViewController.h"
#import "SDTool.h"

@interface ViewController ()

@property (weak, nonatomic) IBOutlet UITextField *textField;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (IBAction)checkEmail:(id)sender {
   BOOL result = [SDTool checkEmailFormatFor:self.textField.text];
    if (result) {
        NSLog(@"OK");
    }else{
        NSLog(@"Error");
    }
}

- (IBAction)checkNonChinaPhone:(id)sender {
    BOOL result = [SDTool checkNonChineseMobileFormatFor:self.textField.text];
    if (result) {
        NSLog(@"OK");
    }else{
        NSLog(@"Error");
    }
}

- (IBAction)checkChinaPhone:(id)sender {
    BOOL result = [SDTool checkChineseMobileFormatFor:self.textField.text];
    if (result) {
        NSLog(@"OK");
    }else{
        NSLog(@"Error");
    }
}

@end
