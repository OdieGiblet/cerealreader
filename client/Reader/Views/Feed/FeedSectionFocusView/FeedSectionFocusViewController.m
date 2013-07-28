//
//  FeedSectionFocusViewController.m
//  Reader
//
//  Created by Mike Odom on 7/28/13.
//  Copyright (c) 2013 Mike Odom. All rights reserved.
//

#import "FeedSectionFocusViewController.h"
#import "FeedItemControl.h"
#import "BookDTO.h"
#import "UINavigationController+Extras.h"

@interface FeedSectionFocusViewController ()

@end

@implementation FeedSectionFocusViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.

	[self addReaderNavigationItems];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
	return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
	return (NSInteger)ceil([_section.items count] / 2.0f);
}

// Row display. Implementers should *always* try to reuse cells by setting each cell's reuseIdentifier and querying for available reusable cells with dequeueReusableCellWithIdentifier:
// Cell gets various attributes set automatically based on table (separators) and data source (accessory views, editing controls)

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
	UITableViewCell *view = [tableView dequeueReusableCellWithIdentifier:@"feedSection"];

	if ( !view ) {
		static UINib *viewNib = nil;
		if ( !viewNib ) {
			viewNib = [UINib nibWithNibName:@"FeedItemSmallControl" bundle:[NSBundle mainBundle]];
		}

		view = [[UITableViewCell alloc] initWithFrame:CGRectMake(0, 0, 320, 140)];

		FeedItemControl *leftItem = [FeedItemControl itemFromNib:viewNib];
		[view addSubview:leftItem];

		CGRect itemFrame = leftItem.frame;

		itemFrame.origin.x += itemFrame.size.width + 10;

		FeedItemControl *rightItem = [FeedItemControl itemFromNib:viewNib];
		rightItem.frame = itemFrame;
		[view addSubview:rightItem];
	}

	int index = [indexPath indexAtPosition:0];

	BookDTO *leftBook = [_section.items objectAtIndex:(NSUInteger)index*2];
	FeedItemControl *leftItem = [[view subviews] objectAtIndex:0];

	[leftItem setBook:leftBook];

	BookDTO *rightBook = [_section.items objectAtIndex:(NSUInteger)index*2+1];
	FeedItemControl *rightItem = [[view subviews] objectAtIndex:1];

	[rightItem setBook:rightBook];

	return view;
}

@end