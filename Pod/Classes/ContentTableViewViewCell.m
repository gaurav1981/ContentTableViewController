//
//  ContentTableViewViewCell.h
//  ContentTableViewViewCell
//
//  Created by Julian Weiss on 2/20/15.
//  Copyright (c) 2015 insanj. All rights reserved.
//

#import "ContentTableViewViewCell.h"
#import "ContentTableViewController.h"

@interface ContentTableViewViewCell ()

@property (strong, nonatomic) ContentTableViewController *parentController;

@property (strong, nonatomic) UIColor *displayViewBackgroundColor;

@end

@implementation ContentTableViewViewCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
	self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
	
	if (self) {		
		self.displayView = [[UIView alloc] initWithFrame:CGRectMake(0.0, 0.0, 40.0, 40.0)];
		[self.contentView addSubview:self.displayView];
	}
	
	return self;
}

- (void)setDisplayView:(UIView *)displayView {
	if (_displayView) {
		[_displayView removeFromSuperview];
	}
	
	_displayView = displayView;
	self.displayViewBackgroundColor = _displayView.backgroundColor;
	_displayView.translatesAutoresizingMaskIntoConstraints = NO;
	[self.contentView addSubview:_displayView];
	
	// update constraints and appearance if already configured to do so
	if (_parentController) {
		[self setParentController:_parentController];
	}
}

- (void)setParentController:(ContentTableViewController *)parentController {
	[super setParentController:parentController];
	self.displayView.contentMode = parentController.itemCellContentMode;
	
	NSLayoutConstraint *leftInsetAttribute = [NSLayoutConstraint constraintWithItem:self.displayView attribute:NSLayoutAttributeLeft relatedBy:NSLayoutRelationEqual toItem:self.contentView attribute:NSLayoutAttributeLeft multiplier:1 constant:parentController.itemCellInsets.left];
	NSLayoutConstraint *topInsetAttribute = [NSLayoutConstraint constraintWithItem:self.displayView attribute:NSLayoutAttributeTop relatedBy:NSLayoutRelationEqual toItem:self.contentView attribute:NSLayoutAttributeTop multiplier:1 constant:parentController.itemCellInsets.top];
	NSLayoutConstraint *rightInsetAttribute = [NSLayoutConstraint constraintWithItem:self.displayView attribute:NSLayoutAttributeRight relatedBy:NSLayoutRelationEqual toItem:self.contentView attribute:NSLayoutAttributeRight multiplier:1 constant:-parentController.itemCellInsets.right];
	NSLayoutConstraint *bottomInsetAttribute = [NSLayoutConstraint constraintWithItem:self.displayView attribute:NSLayoutAttributeBottom relatedBy:NSLayoutRelationEqual toItem:self.contentView attribute:NSLayoutAttributeBottom multiplier:1 constant:-parentController.itemCellInsets.bottom];
	[self.contentView addConstraints:@[leftInsetAttribute, topInsetAttribute, rightInsetAttribute, bottomInsetAttribute]];
	
	[self.contentView updateConstraintsIfNeeded];
}

@end
