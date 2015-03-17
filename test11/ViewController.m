//
//  ViewController.m
//  test11
//
//  Created by 李传政 on 14-12-1.
//  Copyright (c) 2014年 李传政. All rights reserved.
//

#import "ViewController.h"
#import "PCPieChart.h"
#import "PCLineChartView.h"

#define PCColorOrange [UIColor colorWithRed:1.0 green:153/255.0 blue:51/255.0 alpha:1.0]

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    
    NSMutableArray *components = [NSMutableArray array];

    
    PCLineChartView *lineChartView = [[PCLineChartView alloc] initWithFrame:CGRectMake(10,80,300,400)];
    [lineChartView setAutoresizingMask:UIViewAutoresizingFlexibleWidth|UIViewAutoresizingFlexibleHeight];
    lineChartView.minValue = 0;
    lineChartView.interval = 5;
    lineChartView.maxValue = 50;
    [self.view addSubview:lineChartView];
    
    NSMutableArray * XLabels = [NSMutableArray arrayWithObjects:@"1",@"22",@"14",@"16",@"2",@"21",@"15",@"15",@"15",@"15", nil];
    
    [lineChartView setXLabels:XLabels];

    NSMutableArray * pointArr = [NSMutableArray arrayWithObjects:@"5",@"45",@"10",@"7",@"12",@"",@"49",@"15",@"15",@"15", nil];

    
    PCLineChartViewComponent *component = [[PCLineChartViewComponent alloc] init];
    [component setTitle:@""];
    [component setPoints:pointArr];
    [component setShouldLabelValues:YES];
    
    [component setColour:PCColor6];
    
    [components addObject:component];
    
    
    [lineChartView setComponents:components];
    
	// Do any additional setup after loading the view, typically from a nib.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
