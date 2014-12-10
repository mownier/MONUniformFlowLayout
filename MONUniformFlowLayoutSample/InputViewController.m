//
//  InputViewController.m
//  CollectionSample
//
//  Created by mownier on 12/10/14.
//  Copyright (c) 2014 mownier. All rights reserved.
//

#import "InputViewController.h"
#import "ViewController.h"

@interface InputViewController ()

@property (strong, nonatomic) UITextView *textView;

- (void)tapRightBarButtonItem;
- (void)tapLeftBarButtonItem;

- (NSString *)getDefaultJSONString;

@end

@implementation InputViewController

#pragma mark -
#pragma mark - View Cycle

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor lightGrayColor];
    [self.textView becomeFirstResponder];
    [self.view addSubview:self.textView];
    NSDictionary *views = @{ @"textView": self.textView };
    [self.view addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:|[textView]|" options:0 metrics:0 views:views]];
    [self.view addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:|[textView]|" options:0 metrics:0 views:views]];
    
    UIBarButtonItem *rightBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"Go" style:UIBarButtonItemStylePlain target:self action:@selector(tapRightBarButtonItem)];
    UIBarButtonItem *leftBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"Default" style:UIBarButtonItemStylePlain target:self action:@selector(tapLeftBarButtonItem)];
    self.navigationItem.rightBarButtonItem = rightBarButtonItem;
    self.navigationItem.leftBarButtonItem = leftBarButtonItem;
}

#pragma mark -
#pragma mark - Actions

- (void)tapRightBarButtonItem {
    NSError *error;
    NSDictionary *inputInfo = [NSJSONSerialization JSONObjectWithData:[self.textView.text dataUsingEncoding:NSUTF8StringEncoding] options:0 error:&error];
    if (error) {
        UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"Malformed JSON format" message:error.localizedDescription delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil];
        [alertView show];
        return;
    }
    ViewController *vc = [ViewController new];
    vc.inputInfo = inputInfo;
    [self.navigationController pushViewController:vc animated:YES];
}

- (void)tapLeftBarButtonItem {
    self.textView.text = [self getDefaultJSONString];
}

#pragma mark -
#pragma mark - Text View

- (UITextView *)textView {
    if (!_textView) {
        _textView = [[UITextView alloc] initWithFrame:CGRectZero];
        _textView.backgroundColor = [UIColor clearColor];
        _textView.translatesAutoresizingMaskIntoConstraints = NO;
        _textView.contentInset = UIEdgeInsetsMake(0, 0, 260.0f, 0);
        _textView.scrollIndicatorInsets = UIEdgeInsetsMake(0, 0, 260.0f, 0);
        _textView.text = [self getDefaultJSONString];
    }
    return _textView;
}

#pragma mark -
#pragma mark - Default JSON String

- (NSString *)getDefaultJSONString {
    NSBundle *bundle = [NSBundle mainBundle];
    return [NSString stringWithContentsOfFile:[bundle pathForResource:@"default" ofType:@"json"] encoding:NSUTF8StringEncoding error:nil];
}

@end
