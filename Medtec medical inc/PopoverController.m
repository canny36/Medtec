//
//  PopoverController.m
//  Medtec medical inc
//
//  Created by Logic2 on 11/08/12.
//  Copyright (c) 2012 LogicTree. All rights reserved.
//

#import "PopoverController.h"

@implementation PopoverController
@synthesize array , delegate;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)didReceiveMemoryWarning
{
    // Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
    
    // Release any cached data, images, etc that aren't in use.
}

#pragma mark - View lifecycle

- (void)viewDidLoad
{
    [super viewDidLoad];
//    // Do any additional setup after loading the view from its nib.
//
//    // Add a label to the popover's view controller.
//	UILabel *popoverLabel = [[UILabel alloc] initWithFrame:CGRectMake(0., 0., 320., 320.)];
//	popoverLabel.text = @"POP!";
//	popoverLabel.font = [UIFont boldSystemFontOfSize:100.];
//	popoverLabel.textAlignment = UITextAlignmentCenter;
//	popoverLabel.textColor = [UIColor redColor];
//	[self.view addSubview:popoverLabel];
//	[popoverLabel release];
    
//    self.array = [NSArray arrayWithObjects:@"One",@"Two", nil];
}

- (void)viewDidUnload
{
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    // Return YES for supported orientations
	return YES;
}

#pragma mark -tableViewDatasourcemethods


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return [self.array count];
}

// Row display. Implementers should *always* try to reuse cells by setting each cell's reuseIdentifier and querying for available reusable cells with dequeueReusableCellWithIdentifier:
// Cell gets various attributes set automatically based on table (separators) and data source (accessory views, editing controls)

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    UITableViewCell *cell =[[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"cell"];
    cell.textLabel.text = [self.array objectAtIndex:indexPath.row];
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [delegate didSelectRow:indexPath.row];
}

@end
