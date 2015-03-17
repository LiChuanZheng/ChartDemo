//
//  Created by 李传政 on 14-7-18.
//  Copyright (c) 2014年 李传政. All rights reserved.
//


#import "PCPieChart.h"

@implementation PCPieComponent
@synthesize value, title, colour, startDeg, endDeg;

- (id)initWithTitle:(NSString*)_title value:(float)_value
{
    self = [super init];
    if (self)
    {
        self.title = _title;
        self.value = _value;
        self.colour = PCColorDefault;
    }
    return self;
}

+ (id)pieComponentWithTitle:(NSString*)_title value:(float)_value
{
    return [[[super alloc] initWithTitle:_title value:_value] autorelease];
}

- (NSString*)description
{
    NSMutableString *text = [NSMutableString string];
    [text appendFormat:@"title: %@\n", self.title];
    [text appendFormat:@"value: %f\n", self.value];
    return text;
}

- (void)dealloc
{
    [colour release];
    [title release];
    [super dealloc];
}

@end

@implementation PCPieChart
@synthesize  components;
@synthesize diameter;
@synthesize titleFont, percentageFont;
@synthesize showArrow, sameColorLabel;

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
        [self setBackgroundColor:[UIColor clearColor]];
		
		self.titleFont = [UIFont fontWithName:@"GeezaPro" size:10];//[UIFont boldSystemFontOfSize:20];
		self.percentageFont = [UIFont fontWithName:@"HiraKakuProN-W6" size:20];//[UIFont boldSystemFontOfSize:14];
		self.showArrow = YES;
		self.sameColorLabel = NO;
		
	}
    return self;
}

#define LABEL_TOP_MARGIN 15
#define ARROW_HEAD_LENGTH 6
#define ARROW_HEAD_WIDTH 4

- (void)drawRect:(CGRect)rect
{
    // Drawing code
    
    float margin = 15;
    if (self.diameter==0)
    {
        diameter = MIN(rect.size.width, rect.size.height) - 2*margin;
    }
    float x = (rect.size.width - diameter)/2;
    float y = (rect.size.height - diameter)/2;
    float gap = 2;
    float inner_radius = diameter/2;
    float origin_x = x + diameter/2;
    float origin_y = y + diameter/2;
    
    
    if ([components count]>0)
    {
        
        float total = 0;
        for (PCPieComponent *component in components)
        {
            total += component.value;
        }
        
        CGContextRef ctx = UIGraphicsGetCurrentContext();
		UIGraphicsPushContext(ctx);
		CGContextSetRGBFillColor(ctx, 1.0f, 1.0f, 1.0f, 1.0f);  // white color
		CGContextSetShadow(ctx, CGSizeMake(0.0f, 0.0f), margin);
		CGContextFillEllipseInRect(ctx, CGRectMake(x, y, diameter, diameter));  // a white filled circle with a diameter of 100 pixels, centered in (60, 60)
		UIGraphicsPopContext();
		CGContextSetShadow(ctx, CGSizeMake(0.0f, 0.0f), 0);
		
		float nextStartDeg = 0;
		float endDeg = 0;
		NSMutableArray *tmpComponents = [NSMutableArray array];
		int last_insert = -1;
		for (int i=0; i<[components count]; i++)
		{
			PCPieComponent *component  = [components objectAtIndex:i];
			float perc = [component value]/total;
			endDeg = nextStartDeg+perc*360;
			
			CGContextSetFillColorWithColor(ctx, [component.colour CGColor]);
			CGContextMoveToPoint(ctx, origin_x, origin_y);
			CGContextAddArc(ctx, origin_x, origin_y, inner_radius, (nextStartDeg-90)*M_PI/180.0, (endDeg-90)*M_PI/180.0, 0);
			CGContextClosePath(ctx);
			CGContextFillPath(ctx);
			
			CGContextSetRGBStrokeColor(ctx, 1, 1, 1, 1);
			CGContextSetLineWidth(ctx, gap);
			CGContextMoveToPoint(ctx, origin_x, origin_y);
			CGContextAddArc(ctx, origin_x, origin_y, inner_radius, (nextStartDeg-90)*M_PI/180.0, (endDeg-90)*M_PI/180.0, 0);
			CGContextClosePath(ctx);
			CGContextStrokePath(ctx);
			
			[component setStartDeg:nextStartDeg];
			[component setEndDeg:endDeg];
			if (nextStartDeg<180)
			{
				[tmpComponents addObject:component];
			}
			else
			{
				if (last_insert==-1)
				{
					last_insert = i;
					[tmpComponents addObject:component];
				}
				else
				{
					[tmpComponents insertObject:component atIndex:last_insert];
				}
			}
			
			nextStartDeg = endDeg;
		}
        
        
        CGContextSetRGBFillColor(ctx, 1.0f, 1.0f, 1.0f, 1.0f);
        CGContextAddEllipseInRect(ctx,CGRectMake(origin_x-45, origin_y-45, 90, 90));
        CGContextClosePath(ctx);
        CGContextFillPath(ctx);
		
    }
}

- (void)dealloc
{
	[self.titleFont release];
	[self.percentageFont release];
    [self.components release];
    [super dealloc];
}


@end
