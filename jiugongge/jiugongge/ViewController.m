//
//  ViewController.m
//  jiugongge
//
//  Created by 陈少斌 on 14-2-19.
//  Copyright (c) 2014年 ibokan. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()<UIAlertViewDelegate,UIScrollViewDelegate>
{
    NSMutableArray * buttonArr;
}
@end

@implementation ViewController



- (void)viewDidLoad
{
    [super viewDidLoad];
    self.oArray=[[NSMutableArray alloc]init];
    self.xArray=[[NSMutableArray alloc]init];
    buttonArr=[[NSMutableArray alloc]init];
	for (int i=0; i<3; i++) {
        //创建三行三列按钮
        for (int j=0; j<3; j++) {
            UIButton*but=[UIButton buttonWithType:UIButtonTypeRoundedRect];
            but.backgroundColor=[UIColor whiteColor];
            but.layer.cornerRadius=5.0;
            but.frame=CGRectMake(85+55*i, 100+55*j, 50, 50);
            [but addTarget:self action:@selector(dianji:) forControlEvents:UIControlEventTouchUpInside];
            
            /*  为按钮添加tag值
             *  106  107  102
             *  101  105  109
             *  108  103  104
             *  这样设置后相邻三个tag值加起来都为315
             *  用于后面判断胜利者
             */
            switch (i*3+j+1) {
                case 1:
                    but.tag=106;
                    break;
                case 2:
                    but.tag=107;
                    break;
                case 3:
                    but.tag=102;
                    break;
                case 4:
                    but.tag=101;
                    break;
                case 5:
                    but.tag=105;
                    break;
                case 6:
                    but.tag=109;
                    break;
                case 7:
                    but.tag=108;
                    break;
                case 8:
                    but.tag=103;
                    break;
                case 9:
                    but.tag=104;
                    break;
                default:
                    break;
            }
            [buttonArr addObject:but];
            [self.view addSubview:but];
        }
    } 
}


int flag=0;
//按钮点击事件
-(void)dianji:(UIButton*)sender{
    if (flag==0) {
        flag=1;
        [sender setTitle:@"O" forState:UIControlStateNormal];
        [self.oArray addObject:sender];
        //如果有三个以上O，就进行胜负判断
        if (self.oArray.count>=3) {
            //从self.oArray取出任意三个对象
            for (int i = 0; i < self.oArray.count - 2; i++ ){
                for (int j = i + 1; j < self.oArray.count - 1; j++ ){
                    for (int k = j + 1; k < self.oArray.count; k++ ){
                        //将三个对象的tag值加起来
                        int sum =((UIButton*)self.oArray[i]).tag + ((UIButton*)self.oArray[j]).tag + ((UIButton*)self.oArray[k]).tag;
                        //当tag值和为315，则游戏结束
                        if (sum==315) {
                            UIAlertView * alertView=[[UIAlertView alloc]initWithTitle:@"O胜利" message:@"再来一次" delegate:self cancelButtonTitle:nil otherButtonTitles:@"退出",@"确定", nil];
                            [alertView show];
                            return ;
                        }
                        else if(_xArray.count+_oArray.count==9){
                            UIAlertView * alertView=[[UIAlertView alloc]initWithTitle:@"平局" message:@"再来一次" delegate:self cancelButtonTitle:nil otherButtonTitles:@"退出",@"确定", nil];
                            [alertView show];
                            return ;
                        }
                    }
                }
            }
        }
        
        
    }
    else{
        flag=0;
        [sender setTitle:@"X" forState:UIControlStateNormal];
        [self.xArray addObject:sender];
        if (self.xArray.count>=3) {
            for (int i = 0; i < self.xArray.count - 2; i++ ){
                for (int j = i + 1; j < self.xArray.count - 1; j++ ){
                    for (int k = j + 1; k < self.xArray.count; k++ ){
                        int sum =((UIButton*)self.xArray[i]).tag + ((UIButton*)self.xArray[j]).tag + ((UIButton*)self.xArray[k]).tag;
                        if (sum==315) {
                            UIAlertView * alertView=[[UIAlertView alloc]initWithTitle:@"X胜利" message:@"再来一次" delegate:self cancelButtonTitle:nil otherButtonTitles:@"退出",@"确定", nil];
                            [alertView show];
                            return ;
                        }
                        else if(_xArray.count+_oArray.count==9){
                            UIAlertView * alertView=[[UIAlertView alloc]initWithTitle:@"平局" message:@"再来一次" delegate:self cancelButtonTitle:nil otherButtonTitles:@"退出",@"确定", nil];
                            [alertView show];
                            return ;
                        }
                    }
                }
            }
        }
        
    }
    //点击后的按钮取消过用户响应
    sender.userInteractionEnabled=NO;
    

    
}


-(void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex{
    
    if (buttonIndex==0) {
        exit(0);
    }
    
    else{
    
        [self.oArray removeAllObjects];
        [self.xArray removeAllObjects];
        for (UIButton * but in buttonArr) {
            
            [but setTitle:@"" forState:UIControlStateNormal];
            but.userInteractionEnabled=YES;

        }

    }

}


//弃用方法
/*-(void)dianji:(UIButton*)sender{
 
 if (flag==0) {
 flag=1;
 [sender setTitle:@"O" forState:UIControlStateNormal];
 [self.oArray addObject:sender];
 for (UIButton*btn in self.oArray) {
 int flagTag=btn.tag-sender.tag;
 if (flagTag!=0) {
 UIButton*flagBut=(UIButton*)[self.view viewWithTag:(btn.tag+flagTag)];
 
 if (sender.tag==102||sender.tag==201||sender.tag==203||sender.tag==302) {
 UIButton*flagBut=(UIButton*)[self.view viewWithTag:(btn.tag+flagTag)];
 }
 else if ([self.oArray containsObject:flagBut]) {
 NSLog(@"O方胜利");
 }
 }
 }
 }
 else{
 flag=0;
 [sender setTitle:@"X" forState:UIControlStateNormal];
 [self.xArray addObject:sender];
 for (UIButton*btn in self.xArray) {
 int flagTag=btn.tag-sender.tag;
 if (flagTag!=0) {
 UIButton*flagBut=(UIButton*)[self.view viewWithTag:(btn.tag+flagTag)];
 if ([self.xArray containsObject:flagBut]) {
 NSLog(@"X方胜利");
 }
 }
 }
 }
 sender.userInteractionEnabled=NO;
 }*/
- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
