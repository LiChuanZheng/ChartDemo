//
//  PCLineChartViewComponent.h
//  test11
//
//  Created by 李传政 on 14-12-1.
//  Copyright (c) 2014年 李传政. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface PCLineChartViewComponent : NSObject
{
    NSString *title;
    NSArray *points;
    UIColor *colour;
	BOOL shouldLabelValues;
    NSString *labelFormat;
}
@property (nonatomic, assign) BOOL shouldLabelValues;
@property (nonatomic, retain) NSArray *points;
@property (nonatomic, retain) UIColor *colour;
@property (nonatomic, retain) NSString *title, *labelFormat;
@end

#define PCColor1 [UIColor colorWithRed:74/255.0 green:147/255.0 blue:69/255.0 alpha:1.0]
#define PCColor2 [UIColor colorWithRed:178/255.0 green:209/255.0 blue:37/255.0 alpha:1.0]
#define PCColor3 [UIColor colorWithRed:253/255.0 green:210/255.0 blue:84/255.0 alpha:1.0]
#define PCColor4 [UIColor colorWithRed:253/255.0 green:170/255.0 blue:18/255.0 alpha:1.0]
#define PCColor5 [UIColor colorWithRed:253/255.0 green:88/255.0 blue:28/255.0 alpha:1.0]
#define PCColor6 [UIColor colorWithRed:17.f/255.0 green:141.f/255.0 blue:219.f/255.0 alpha:1.0]
#define PCColor7 [UIColor colorWithRed:35.f/255.0 green:99.f/255.0 blue:173.f/255.0 alpha:1.0]

@interface PCLineChartView : UIView {
    NSMutableArray *components;
	NSMutableArray *xLabels;
	UIFont *yLabelFont, *xLabelFont, *valueLabelFont, *legendFont;
    float interval;
	float minValue;
	float maxValue;
    
    // Use these to autoscale the y axis to 'nice' values.
    // If used, minValue is ignored (0) and interval computed internally
    BOOL autoscaleYAxis;
    NSUInteger numYIntervals;   // Use n*5 for best results
}

@property (nonatomic, assign) float interval;
@property (nonatomic, assign) float minValue;
@property (nonatomic, assign) float maxValue;
@property (nonatomic, retain) NSMutableArray *components, *xLabels;
@property (nonatomic, retain) UIFont *yLabelFont, *xLabelFont, *valueLabelFont, *legendFont;
@property (nonatomic, assign) BOOL autoscaleYAxis;
@property (nonatomic, assign) NSUInteger numYIntervals;
@property (nonatomic, assign) NSUInteger numXIntervals;

@end
