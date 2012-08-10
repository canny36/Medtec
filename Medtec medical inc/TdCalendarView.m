
//  CalendarView.m

#import "TdCalendarView.h"
#import <QuartzCore/QuartzCore.h>
//#import "ScheduleListViewController.h"

const float headHeight=60;
const float itemHeight=35;
const float prevNextButtonSize=20;
const float prevNextButtonSpaceWidth=15;
const float prevNextButtonSpaceHeight=12;
const float titleFontSize=20;
const int	weekFontSize=12;

@implementation TdCalendarView

@synthesize dateString;
@synthesize currentMonthDate;
@synthesize currentSelectDate;
@synthesize currentTime;
@synthesize viewImageView;
@synthesize calendarViewDelegate;
@synthesize cController;
@synthesize dateTimeString;


-(void)initCalView{
	currentTime=CFAbsoluteTimeGetCurrent();
	currentMonthDate=CFAbsoluteTimeGetGregorianDate(currentTime,CFTimeZoneCopyDefault());
	currentMonthDate.day=1;
	currentSelectDate.year=0;
	monthFlagArray=malloc(sizeof(int)*31);
    
   	[self clearAllDayFlag];		

	
}


- (id)initWithCoder:(NSCoder *)coder {
    if (self == [super initWithCoder:coder]) 
    {
        //cController.tdView=self;
        
       
      [self initCalView];
		flag=FALSE;
			
    }
    return self;
}

- (id)initWithFrame:(CGRect)frame 
{
	
	if (self == [super initWithFrame:frame]) {
       //cController.tdView=self;
        
		[self initCalView];
	}
    
     
	return self;
}

-(int)getDayCountOfaMonth:(CFGregorianDate)date{
	switch (date.month) {
		case 1:
		case 3:
		case 5:
		case 7:
		case 8:
		case 10:
		case 12:
		return 31;
		case 2:
		if(date.year%4==0 && date.year%100!=0)
		return 29;
		else
		return 28;
		case 4:
		case 6:
		case 9:		
		case 11:
		return 30;
		default:
		return 31;
	}
}

-(void)drawPrevButton:(CGPoint)leftTop
{
	CGContextRef ctx=UIGraphicsGetCurrentContext();
	CGContextSetGrayStrokeColor(ctx,0,1);
	CGContextMoveToPoint	(ctx, 0 + leftTop.x, prevNextButtonSize/2 + leftTop.y);
	CGContextAddLineToPoint	(ctx, prevNextButtonSize + leftTop.x,  0 + leftTop.y);
	CGContextAddLineToPoint	(ctx, prevNextButtonSize + leftTop.x,  prevNextButtonSize + leftTop.y);
	CGContextAddLineToPoint	(ctx, 0 + leftTop.x,  prevNextButtonSize/2 + leftTop.y);
	CGContextFillPath(ctx);
}

-(void)drawNextButton:(CGPoint)leftTop
{
	CGContextRef ctx=UIGraphicsGetCurrentContext();
	CGContextSetGrayStrokeColor(ctx,0,1);
	CGContextMoveToPoint	(ctx,  0 + leftTop.x,  0 + leftTop.y);
	CGContextAddLineToPoint	(ctx, prevNextButtonSize + leftTop.x,  prevNextButtonSize/2 + leftTop.y);
	CGContextAddLineToPoint	(ctx,  0 + leftTop.x,  prevNextButtonSize + leftTop.y);
	CGContextAddLineToPoint	(ctx,  0 + leftTop.x,  0 + leftTop.y);
	CGContextFillPath(ctx);
}
-(int)getDayFlag:(int)day
{
	if(day>=1 && day<=31)
	{
		return *(monthFlagArray+day-1);
	}
	else 
		return 0;
}
-(void)clearAllDayFlag
{
	memset(monthFlagArray,0,sizeof(int)*31);
}
-(void)setDayFlag:(int)day flag:(int)flag
{
	if(day>=1 && day<=31)
	{
		if(flag>0)
			*(monthFlagArray+day-1)=1;
		else if(flag<0)
			*(monthFlagArray+day-1)=-1;
	}
	
}
-(void)drawTopGradientBar{
	
	CGContextRef ctx=UIGraphicsGetCurrentContext();
	
	size_t num_locations = 3;
	CGFloat locations[3] = { 0.0, 0.5, 1.0};
	CGFloat components[12] = {  
		1.0, 1.0, 1.0, 1.0,
		0.5, 0.5, 0.5, 1.0,
		1.0, 1.0, 1.0, 1.0 
	};
	
	
	CGGradientRef myGradient;
	CGColorSpaceRef myColorspace = CGColorSpaceCreateDeviceRGB();
	myGradient = CGGradientCreateWithColorComponents (myColorspace, components,
											  locations, num_locations);
	CGPoint myStartPoint, myEndPoint;
	myStartPoint.x = headHeight;
	myStartPoint.y = 0.0;
	myEndPoint.x = headHeight;
	myEndPoint.y = headHeight;
	
	CGContextDrawLinearGradient(ctx,myGradient,myStartPoint, myEndPoint, 0);
	CGGradientRelease(myGradient);

	[self drawPrevButton:CGPointMake(prevNextButtonSpaceWidth,prevNextButtonSpaceHeight)];
	[self drawNextButton:CGPointMake(self.frame.size.width-prevNextButtonSpaceWidth-prevNextButtonSize,prevNextButtonSpaceHeight)];
}

-(void)drawTopBarWords{
	int width=self.frame.size.width;
	int s_width=width/7;
//for mon, tue , month labels color
	//[[UIColor blackColor] set];
	[[UIColor colorWithRed:207/255.0 green:90/255.0 blue:22/255.0 alpha:1.0]set];
	
	int fontsize=[UIFont buttonFontSize];
	UIFont *font=[UIFont systemFontOfSize:titleFontSize];
	CGPoint location=CGPointMake(width/2-2.5*titleFontSize,0);
	NSString *title_Month;
	switch (currentMonthDate.month) {
		case 1:
		{
						
			title_Month=[[NSString alloc ]initWithFormat:@"January %d",currentMonthDate.year];				
			[title_Month drawAtPoint:location withFont:font];
			[title_Month release];
		}
		break;
		case 2:
		{
			
            title_Month=[[NSString alloc ]initWithFormat:@"February  %d",currentMonthDate.year];
			[title_Month drawAtPoint:location withFont:font];
			[title_Month release];
		}
		break;
		case 3:
		
		{
            title_Month=[[NSString alloc ]initWithFormat:@"March %d",currentMonthDate.year];
            [title_Month drawAtPoint:location withFont:font];
            [title_Month release];
		}
		break;
		case 4:
		{
	
		title_Month=[[NSString alloc ]initWithFormat:@"April %d",currentMonthDate.year];
	[title_Month drawAtPoint:location withFont:font];
			[title_Month release];
		}
		break;
		case 5:
		{
		
			title_Month=[[NSString alloc ]initWithFormat:@"May %d",currentMonthDate.year];
			[title_Month drawAtPoint:location withFont:font];
				[title_Month release];
		}
		break;
		case 6:
		{
			
            title_Month=[[NSString alloc ]initWithFormat:@"June %d",currentMonthDate.year];
			[title_Month drawAtPoint:location withFont:font];
				[title_Month release];
		}
		break;
		case 7:
		{
	
            title_Month=[[NSString alloc ]initWithFormat:@"July %d",currentMonthDate.year];
			[title_Month drawAtPoint:location withFont:font];
			[title_Month release];
		}
		break;
		case 8:
		{
		
            title_Month=[[NSString alloc ]initWithFormat:@"August %d",currentMonthDate.year];
			[title_Month drawAtPoint:location withFont:font];
			[title_Month release];
		}
		break;
		case 9:
		{
            title_Month=[[NSString alloc ]initWithFormat:@"September %d",currentMonthDate.year];
			[title_Month drawAtPoint:location withFont:font];
			[title_Month release];
			
		}
		break;
		case 10:
		{
			
		title_Month=[[NSString alloc ]initWithFormat:@"October %d",currentMonthDate.year];
        [title_Month drawAtPoint:location withFont:font];
        [title_Month release];
            
		}
		break;
		case 11:
		{
            
        title_Month=[[NSString alloc ]initWithFormat:@"November %d",currentMonthDate.year];
        [title_Month drawAtPoint:location withFont:font];
        [title_Month release];
            
		}
		break;
		case 12:
		{
            title_Month=[[NSString alloc ]initWithFormat:@"December %d",currentMonthDate.year];
			[title_Month drawAtPoint:location withFont:font];
			[title_Month release];
		}
		break;
		default:
		break;
	}

	
	UIFont *weekfont=[UIFont boldSystemFontOfSize:weekFontSize];
	fontsize+=3;
	fontsize+=20;
		
		[@"Mon" drawAtPoint:CGPointMake(s_width*0+13,fontsize) withFont:weekfont];
		[@"Tue" drawAtPoint:CGPointMake(s_width*1+13,fontsize) withFont:weekfont];
		[@"Wed" drawAtPoint:CGPointMake(s_width*2+13,fontsize) withFont:weekfont];
		[@"Thu" drawAtPoint:CGPointMake(s_width*3+13,fontsize) withFont:weekfont];
		[@"Fri" drawAtPoint:CGPointMake(s_width*4+13,fontsize) withFont:weekfont];
		//[[UIColor redColor] set];
		[@"Sat" drawAtPoint:CGPointMake(s_width*5+13,fontsize) withFont:weekfont];
		[@"Sun" drawAtPoint:CGPointMake(s_width*6+13,fontsize) withFont:weekfont];
		[[UIColor blackColor] set];
	//[[UIColor orangeColor] set];
		

	
}

-(void)drawGirdLines{
	
	CGContextRef ctx=UIGraphicsGetCurrentContext();
	int width=self.frame.size.width;
	int row_Count=([self getDayCountOfaMonth:currentMonthDate]+[self getMonthWeekday:currentMonthDate]-2)/7+1;

	
	int s_width=width/7;
	int tabHeight=row_Count*itemHeight+headHeight;

	CGContextSetGrayStrokeColor(ctx,0,1);
	
	CGContextMoveToPoint	(ctx,0,headHeight);
	CGContextAddLineToPoint	(ctx,0,tabHeight);
	CGContextStrokePath		(ctx);
	CGContextMoveToPoint	(ctx,width,headHeight);
	CGContextAddLineToPoint	(ctx,width,tabHeight);
	CGContextStrokePath		(ctx);
	
	for(int i=1;i<7;i++){
		CGContextSetGrayStrokeColor(ctx,1,1);
		
		CGContextMoveToPoint(ctx, i*s_width-1, headHeight);
		CGContextAddLineToPoint( ctx, i*s_width-1,tabHeight);
		CGContextStrokePath(ctx);
	}
	
	for(int i=0;i<row_Count+1;i++){
		CGContextSetGrayStrokeColor(ctx,1,1);
		CGContextMoveToPoint(ctx, 0, i*itemHeight+headHeight+3);
		CGContextAddLineToPoint( ctx, width,i*itemHeight+headHeight+3);
		CGContextStrokePath(ctx);
		
		CGContextSetGrayStrokeColor(ctx,0.3,1);
		
		CGContextMoveToPoint(ctx, 0, i*itemHeight+headHeight);
		CGContextAddLineToPoint( ctx, width,i*itemHeight+headHeight);
		CGContextStrokePath(ctx);
	}
	for(int i=1;i<7;i++){
		//CGContextSetGrayStrokeColor(ctx,0.3,1);
       // CGContextSetRGBStrokeColor(ctx, 190.0/255.0, 182.0/255.0, 208.0/255.0, 1.0);
        CGContextSetRGBStrokeColor(ctx, 48.0/255.0, 52.0/255.0, 111.0/255.0, 1.0);
		CGContextMoveToPoint(ctx, i*s_width+2, headHeight);
		CGContextAddLineToPoint( ctx, i*s_width+2,tabHeight);
		CGContextStrokePath(ctx);
	}
}


-(int)getMonthWeekday:(CFGregorianDate)date
{
	CFTimeZoneRef tz = CFTimeZoneCopyDefault();
	CFGregorianDate month_date;
	month_date.year=date.year;
	month_date.month=date.month;
	month_date.day=1;
	month_date.hour=0;
	month_date.minute=0;
	month_date.second=1;
	return (int)CFAbsoluteTimeGetDayOfWeek(CFGregorianDateGetAbsoluteTime(month_date,tz),tz);
}

-(void)drawDateWords{
	CGContextRef ctx=UIGraphicsGetCurrentContext();

	int width=self.frame.size.width;
	
	int dayCount=[self getDayCountOfaMonth:currentMonthDate];
	int day=0;
	int x=0;
	int y=0;
	int s_width=width/7;
	int curr_Weekday=[self getMonthWeekday:currentMonthDate];
	UIFont *weekfont=[UIFont boldSystemFontOfSize:17];
    	for(int i=1;i<dayCount+1;i++)
	{
		day=i+curr_Weekday-2;
		x=day % 7;
		y=day / 7;
        NSString *date,*month;
        
        if(i<10)
            date=[NSString stringWithFormat:@"0%d",i];
        else
            date=[NSString stringWithFormat:@"%d",i];

      if(currentMonthDate.month<10)
          month=[NSString stringWithFormat:@"0%d",currentMonthDate.month];
        else
            month=[NSString stringWithFormat:@"%d",currentMonthDate.month];
        
       // NSString *t=[NSString stringWithFormat:@"%@/%@/%d",date,month,currentMonthDate.year];
        
        //NSLog(@"t:%@",t);
        
               // NSString *t=[NSString stringWithFormat:@"%@/%d/%d",date,currentMonthDate.month,currentMonthDate.year];
         
		[date drawAtPoint:CGPointMake(x*s_width+15,y*itemHeight+headHeight+7) withFont:weekfont];
    
        
		if([self getDayFlag:i]==1)
		{
		CGContextSetRGBFillColor(ctx, 1, 0, 0, 1);
			//CGContextSetRGBFillColor(ctx, 0, 1, 0, 1);
		[@"." drawAtPoint:CGPointMake(x*s_width+19,y*itemHeight+headHeight+3) withFont:[UIFont boldSystemFontOfSize:25]];
		}
		else if([self getDayFlag:i]==-1)
		{
		CGContextSetRGBFillColor(ctx, 0, 8.5, 0.3, 1);
		[@"." drawAtPoint:CGPointMake(x*s_width+19,y*itemHeight+headHeight+3) withFont:[UIFont boldSystemFontOfSize:25]];
		}
			
		//CGContextSetRGBFillColor(ctx, 9/255.0, 71/255.0, 75/255.0, 1.0);
        CGContextSetRGBFillColor(ctx, 48/255.0, 52/255.0, 111/255.0, 1.0);
        // CGContextSetRGBStrokeColor(ctx, 48.0/255.0, 52.0/255.0, 111.0/255.0, 1.0);
		
	}	

}


- (void) movePrevNext:(int)isPrev{
	currentSelectDate.year=0;
	[calendarViewDelegate beforeMonthChange:self willto:currentMonthDate];
	int width=self.frame.size.width;
	int posX;
	if(isPrev==1)
	{
	posX=width;
	}
	else
	{
	posX=-width;
	}	
	
       
	UIImage *viewImage;
	UIGraphicsBeginImageContext(self.bounds.size);
	[self.layer renderInContext:UIGraphicsGetCurrentContext()];	
	viewImage= UIGraphicsGetImageFromCurrentImageContext();
	UIGraphicsEndImageContext();
	if(viewImageView==nil)
	{
	viewImageView=[[UIImageView alloc] initWithImage:viewImage];
	viewImageView.center=self.center;
	[[self superview] addSubview:viewImageView];
	}
	else
	{
	viewImageView.image=viewImage;
	}
    /////////Changed bool value by SaiKumar
	viewImageView.hidden=YES;
	viewImageView.transform=CGAffineTransformMakeTranslation(0, 0);
	self.hidden=YES;
	[self setNeedsDisplay];
	self.transform=CGAffineTransformMakeTranslation(posX,0);
	
	float height;
	int row_Count=([self getDayCountOfaMonth:currentMonthDate]+[self getMonthWeekday:currentMonthDate]-2)/7+1;
	height=row_Count*itemHeight+headHeight;
	//self.frame=CGRectMake(self.frame.origin.x, self.frame.origin.y, self.frame.size.width, height);
	self.hidden=NO;
	[UIView beginAnimations:nil	context:nil];
	[UIView setAnimationDuration:0.5];
	self.transform=CGAffineTransformMakeTranslation(0,0);
	viewImageView.transform=CGAffineTransformMakeTranslation(-posX, 0);
	[UIView commitAnimations];
	[calendarViewDelegate monthChanged:currentMonthDate viewLeftTop:self.frame.origin height:height];
	
}


-(void)ourMethod
{
    /*int m=[[dateTimeString substringToIndex:2]intValue];
     
     long int y = [[dateTimeString substringFromIndex:3]longLongValue];
     
     if( currentMonthDate.year == y)
     {
     if(currentMonthDate.month > m)
     {
     currentMonthDate.month= currentMonthDate.month -m;
     }
     
     
     
     }*/
    
    int m=[[dateTimeString substringToIndex:2]intValue];
    long int y = [[dateTimeString substringFromIndex:3]longLongValue];
    
    int bufferm=currentMonthDate.month;
    long int buffery=currentMonthDate.year;
    
    currentMonthDate.month=m;
    currentMonthDate.year = y;
    
    
    if( y >buffery )
        [self movePrevNext:1];
    else if( y < buffery )
        [self movePrevNext:0];
    else if( y == buffery )
    {
        if( m > bufferm)
            [self movePrevNext:1];
        else
            [self movePrevNext:0];
    }
    
    
    
}

- (void)movePrevMonth{
	if(currentMonthDate.month>1)
	currentMonthDate.month-=1;
	else
	{
	currentMonthDate.month=12;
	currentMonthDate.year-=1;
	}
	[self movePrevNext:0];
}
- (void)moveNextMonth{
	if(currentMonthDate.month<12)
		currentMonthDate.month+=1;
	else
	{
		currentMonthDate.month=1;
		currentMonthDate.year+=1;
	}
	[self movePrevNext:1];	
}
- (void) drawToday{
	int x;
	int y;
	int day;
	CFGregorianDate today=CFAbsoluteTimeGetGregorianDate(currentTime, CFTimeZoneCopyDefault());
	if(today.month==currentMonthDate.month && today.year==currentMonthDate.year)
	{
		int width=self.frame.size.width;
		int swidth=width/7;
		int weekday=[self getMonthWeekday:currentMonthDate];
		day=today.day+weekday-2;
		x=day%7;
		y=day/7;
		CGContextRef ctx=UIGraphicsGetCurrentContext(); 
		//CGContextSetRGBFillColor(ctx, 0.5, 0.5, 0.5, 1);
        CGContextSetRGBFillColor(ctx, 207/255.0, 90/255.0, 22/255.0, 1.0);
		//CGContextSetRGBFillColor(ctx, 86/255.0, 110/255.0, 139/255.0, 1.0);
		CGContextMoveToPoint(ctx, x*swidth+1, y*itemHeight+headHeight);
		CGContextAddLineToPoint(ctx, x*swidth+swidth+2, y*itemHeight+headHeight);
		CGContextAddLineToPoint(ctx, x*swidth+swidth+2, y*itemHeight+headHeight+itemHeight);
		CGContextAddLineToPoint(ctx, x*swidth+1, y*itemHeight+headHeight+itemHeight);
		CGContextFillPath(ctx);

		CGContextSetRGBFillColor(ctx, 1, 1, 1, 1);
		UIFont *weekfont=[UIFont boldSystemFontOfSize:17];
		NSString *date=[[[NSString alloc] initWithFormat:@"%2d",today.day] autorelease];
		[date drawAtPoint:CGPointMake(x*swidth+15,y*itemHeight+headHeight+7) withFont:weekfont];
		if([self getDayFlag:today.day]==1)
		{
			CGContextSetRGBFillColor(ctx, 1, 0, 0, 1);
			[@"." drawAtPoint:CGPointMake(x*swidth+19,y*itemHeight+headHeight+7) withFont:[UIFont boldSystemFontOfSize:25]];
		}
		else if([self getDayFlag:today.day]==-1)
		{
			CGContextSetRGBFillColor(ctx, 0, 8.5, 0.3, 1);
			[@"." drawAtPoint:CGPointMake(x*swidth+19,y*itemHeight+headHeight+7) withFont:[UIFont boldSystemFontOfSize:25]];
		}

	}
}

	//SelectedDate.
- (void) drawCurrentSelectDate
{

	int x;
	int y;
	int day;
	int todayFlag;
	if(currentSelectDate.year!=0)
	{
		flag=TRUE;
		CFGregorianDate today=CFAbsoluteTimeGetGregorianDate(currentTime, CFTimeZoneCopyDefault());

		if(today.year==currentSelectDate.year && today.month==currentSelectDate.month && today.day==currentSelectDate.day)
			todayFlag=1;
		else
			todayFlag=0;
		
		int width=self.frame.size.width;
		int swidth=width/7;
		int weekday=[self getMonthWeekday:currentMonthDate];
		day=currentSelectDate.day+weekday-2;
		x=day%7;
		y=day/7;
		CGContextRef ctx=UIGraphicsGetCurrentContext();
		
		if(todayFlag==1)
			CGContextSetRGBFillColor(ctx, 0, 0, 0.7, 1);
            //CGContextSetRGBFillColor(ctx, 254/255.0, 157/255.0, 0/255.0, 1.0);
		else
		//CGContextSetRGBFillColor(ctx, 0, 0.5, 1, 1);
            CGContextSetRGBFillColor(ctx, 254/255.0, 157/255.0, 0/255.0, 1.0);
			
			//CGContextSetRGBFillColor(ctx, 0.7, 0.5, 0.7, 1);
		CGContextMoveToPoint(ctx, x*swidth+1, y*itemHeight+headHeight);
		CGContextAddLineToPoint(ctx, x*swidth+swidth+2, y*itemHeight+headHeight);
		CGContextAddLineToPoint(ctx, x*swidth+swidth+2, y*itemHeight+headHeight+itemHeight);
		CGContextAddLineToPoint(ctx, x*swidth+1, y*itemHeight+headHeight+itemHeight);
		CGContextFillPath(ctx);	
		
		if(todayFlag==1)
		{
			CGContextSetRGBFillColor(ctx, 0, 0, 1, 1);
           // CGContextSetRGBFillColor(ctx, 207/255.0, 90/255.0, 22/255.0, 1.0);
			CGContextMoveToPoint	(ctx, x*swidth+4,			y*itemHeight+headHeight+3);
			CGContextAddLineToPoint	(ctx, x*swidth+swidth-1,	y*itemHeight+headHeight+3);
			CGContextAddLineToPoint	(ctx, x*swidth+swidth-1,	y*itemHeight+headHeight+itemHeight-3);
			CGContextAddLineToPoint	(ctx, x*swidth+4,			y*itemHeight+headHeight+itemHeight-3);
			CGContextFillPath(ctx);	
		}
		
		CGContextSetRGBFillColor(ctx, 1, 1, 1, 1);

		UIFont *weekfont=[UIFont boldSystemFontOfSize:17];
		NSString *date=[[[NSString alloc] initWithFormat:@"%2d",currentSelectDate.day] autorelease];
		[date drawAtPoint:CGPointMake(x*swidth+15,y*itemHeight+headHeight+7) withFont:weekfont];
		if([self getDayFlag:currentSelectDate.day]!=0)
		{
			[@"." drawAtPoint:CGPointMake(x*swidth+15,y*itemHeight+headHeight+7) withFont:[UIFont boldSystemFontOfSize:25]];
		}
		
        NSString *date2,*month;
        
        if(currentSelectDate.day<10)
            date2=[NSString stringWithFormat:@"0%d",currentSelectDate.day];
        else
            date2=[NSString stringWithFormat:@"%d",currentSelectDate.day];
        
        if(currentSelectDate.month<10)
            month=[NSString stringWithFormat:@"0%d",currentSelectDate.month];
        else
            month=[NSString stringWithFormat:@"%d",currentSelectDate.month];
        

       // dateString=[NSString stringWithFormat:@"%@/%@/%d", date2, month, currentSelectDate.year];
        dateString=[NSString stringWithFormat:@"%@/%@/%d", month, date2, currentSelectDate.year];

	
		[NSThread detachNewThreadSelector:@selector(passtodelegate:) toTarget:self withObject:dateString];	
			
		
	}
}

-(void)passtodelegate:(NSString*)ds
{
	
	NSAutoreleasePool *pool=[[NSAutoreleasePool alloc] init];
	
		[calendarViewDelegate go:ds];
		//NSLog(@"ds:%@",ds);
    //[cController dateDone:ds];
       //[cController getDate:ds];
        [pool drain];		
        flag=FALSE;
}



- (void) touchAtDate:(CGPoint) touchPoint{

	int x;
	int y;
	int width=self.frame.size.width;
	int weekday=[self getMonthWeekday:currentMonthDate];
	int monthDayCount=[self getDayCountOfaMonth:currentMonthDate];
	x=touchPoint.x*7/width;
	y=(touchPoint.y-headHeight)/itemHeight;
	int monthday=x+y*7-weekday+2;
	if(monthday>0 && monthday<monthDayCount+1)
	{
		currentSelectDate.year=currentMonthDate.year;
		currentSelectDate.month=currentMonthDate.month;
		currentSelectDate.day=monthday;
		currentSelectDate.hour=0;
		currentSelectDate.minute=0;
		currentSelectDate.second=1;
		[calendarViewDelegate selectDateChanged:currentSelectDate];
		[self setNeedsDisplay];
	}
}

- (void) touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event {
	
	if(!flag){
		int width=self.frame.size.width;
		UITouch* touch=[touches anyObject];
		CGPoint touchPoint=[touch locationInView:self];
		//UIView* theview=[self hitTest:touchPoint withEvent:event];
		if(touchPoint.x<40 && touchPoint.y<headHeight)
			[self movePrevMonth];
		else if(touchPoint.x>width-40 && touchPoint.y<headHeight)
			[self moveNextMonth];
		else if(touchPoint.y>headHeight)
		{
			[self touchAtDate:touchPoint];
		}
			
	}	
}

- (void)drawRect:(CGRect)rect{

	static int once=0;
	currentTime=CFAbsoluteTimeGetCurrent();	
	[self drawTopGradientBar];
	[self drawTopBarWords];
	[self drawGirdLines];
	
	if(once==0)
	{
		once=1;
		float height;
		int row_Count=([self getDayCountOfaMonth:currentMonthDate]+[self getMonthWeekday:currentMonthDate]-2)/7+1;
		height=row_Count*itemHeight+headHeight;
		[calendarViewDelegate monthChanged:currentMonthDate viewLeftTop:self.frame.origin height:height];
		[calendarViewDelegate beforeMonthChange:self willto:currentMonthDate];

	}
	[self drawDateWords];
	[self drawToday];
	[self drawCurrentSelectDate];
	
}

- (void)dealloc {
	[super dealloc];
	[dateString release];
   
   	free(monthFlagArray);
}


@end
