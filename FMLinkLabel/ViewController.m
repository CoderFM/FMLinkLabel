//
//  ViewController.m
//  FMLinkLabel
//
//  Created by 周发明 on 16/9/29.
//  Copyright © 2016年 周发明. All rights reserved.
//

#import "ViewController.h"
#import "FMLinkLabel.h"

@interface ViewController ()


@property (weak, nonatomic) IBOutlet FMLinkLabel *label;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
}

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    
}
- (void)viewDidAppear:(BOOL)animated{
    [super viewDidAppear:animated];
    
    NSString *str = @"呵呵哒 :呵呵呵呵呵呵呵呵额哈哈哈呵呵呵呵呵 这里可以点击 呵呵呵额哈哈哈呵呵呵呵呵呵呵呵额哈哈哈呵呵呵呵呵呵呵呵额哈哈哈呵呵呵";
    
    self.label.text = str;
    
    self.label.font = [UIFont systemFontOfSize:20];
    
    [self.label addClickText:@"呵呵哒 :" attributeds:@{NSForegroundColorAttributeName : [UIColor orangeColor]} transmitBody:(id)@"呵呵哒 被点击了" clickItemBlock:^(id transmitBody) {
        [[[UIAlertView alloc] initWithTitle:@"提示" message:[NSString stringWithFormat:@"%@", transmitBody] delegate:self cancelButtonTitle:@"取消" otherButtonTitles: nil] show];
    }];
    
    [self.label addClickText:@"这里可以点击" attributeds:@{NSForegroundColorAttributeName : [UIColor greenColor]} transmitBody:(id)@"确实可以点击" clickItemBlock:^(id transmitBody) {
        [[[UIAlertView alloc] initWithTitle:@"提示" message:[NSString stringWithFormat:@"%@", transmitBody] delegate:self cancelButtonTitle:@"取消" otherButtonTitles: nil] show];
    }];

}


- (void)viewWillLayoutSubviews{
    [super viewWillLayoutSubviews];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
