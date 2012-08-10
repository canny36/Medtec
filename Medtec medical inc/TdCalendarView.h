


#import <UIKit/UIKit.h>
//#import "SearchPatientViewController.h"

@protocol CalendarViewDelegate;

@class SearchPatientViewController;

@interface TdCalendarView : UIView{
	CFGregorianDate currentMonthDate;
	CFGregorianDate currentSelectDate;
	CFAbsoluteTime	currentTime;
	UIImageView* viewImageView;
	id<CalendarViewDelegate> calendarViewDelegate;
	int *monthFlagArray; 
	NSString *dateString;
	//SearchPatientViewController *cController;
    NSString *dateTimeString;
		
}

@property CFGregorianDate currentMonthDate;
@property CFGregorianDate currentSelectDate;
@property CFAbsoluteTime  currentTime;
@property (nonatomic,retain)NSString *dateString;
@property (nonatomic, retain) UIImageView* viewImageView;
@property (nonatomic, assign) id<CalendarViewDelegate> calendarViewDelegate;
@property(nonatomic,retain)SearchPatientViewController *cController;
@property (nonatomic, assign) NSString *dateTimeString;


-(int)getDayCountOfaMonth:(CFGregorianDate)date;
-(int)getMonthWeekday:(CFGregorianDate)date;
-(int)getDayFlag:(int)day;
-(void)setDayFlag:(int)day flag:(int)flag;
-(void)clearAllDayFlag;
-(void)passtodelegate:(NSString*)ds;
//- (NSString *)dataFilePath;
-(void)ourMethod;

@end



@protocol CalendarViewDelegate<NSObject>
@optional
- (void) selectDateChanged:(CFGregorianDate) selectDate;
- (void) monthChanged:(CFGregorianDate) currentMonth viewLeftTop:(CGPoint)viewLeftTop height:(float)height;
- (void) beforeMonthChange:(TdCalendarView*) calendarView willto:(CFGregorianDate) currentMonth;
- (void)go:(NSString *)selectedDate;
BOOL flag;

@end