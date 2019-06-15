//
//  ViewController.m
//  leancode
//
//  Created by zsp on 2019/6/15.
//  Copyright © 2019 woop. All rights reserved.
//

#import "ViewController.h"
#import "SILeanManager.h"
#import "SILeanViewController.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self configUI];
}

- (void)configUI {
    UIBarButtonItem *leftItem = [[UIBarButtonItem alloc] initWithTitle:@"test" style:UIBarButtonItemStylePlain target:self action:@selector(addTestData)];
    self.navigationItem.leftBarButtonItem=leftItem;
    
    UIBarButtonItem *rightItem = [[UIBarButtonItem alloc] initWithTitle:@"request" style:UIBarButtonItemStylePlain target:self action:@selector(showRequestVC)];
    self.navigationItem.rightBarButtonItem=rightItem;
}

- (void)addTestData {
    [[SILeanManager shareInstance] saveTestData];
}

- (void)showRequestVC {
    [[SILeanManager shareInstance] showRequestVC];    
}

@end
