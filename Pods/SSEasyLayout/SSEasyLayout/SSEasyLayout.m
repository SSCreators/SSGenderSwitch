//
//  SSEasyLayout.m
//  Sha
//  Version 1.1
//  Created by SebastianSha on 27/05/17.
//  Copyright © 2017 SebastianSha. All rights reserved.
//

#import "SSEasyLayout.h"

@implementation SSEasyLayout
//Default init
- (instancetype)init
{
    self = [super init];
    
    if (self)
    {
        _layoutType = SSEasyLayoutTypeDefault;
        
        [self initializeFields];
    }
    
    return self;
}

//Custom init
- (instancetype)initWithLayoutType:(SSEasyLayoutType)layoutTypeInner
{
    self = [super init];
    
    if (self)
    {
        _layoutType = layoutTypeInner;
        
        [self initializeFields];
    }
    
    return self;
}

//Initialize basic fields
- (void)initializeFields
{
    _metricsDictonary   = [NSMutableDictionary new];
    _viewsDictionary    = [NSMutableDictionary new];
    _constraintsArray   = [NSMutableArray new];
}

//View fourSide constraint with SuperView
- (NSArray <NSLayoutConstraint *> *)constraintWithItem:(id)view marginConstraintsWithEdgeInset:(UIEdgeInsets)edgeInset
{
    return [self constraintWithItem:view marginConstraintsWithEdgeInset:edgeInset relatedBy:NSLayoutRelationEqual];
}

//View fourSide constraint with SuperView and Relation
- (NSArray <NSLayoutConstraint *> *)constraintWithItem:(id)view marginConstraintsWithEdgeInset:(UIEdgeInsets)edgeInset relatedBy:(NSLayoutRelation)relation
{
    return [self constraintWithItem:view marginConstraintsWithEdgeInset:edgeInset forMarginView:((UIView *)view).superview relatedBy:relation];
}

//View fourSide constraint with MarginView
- (NSArray <NSLayoutConstraint *> *)constraintWithItem:(id)view marginConstraintsWithEdgeInset:(UIEdgeInsets)edgeInset forMarginView:(id)marginView
{
    return [self constraintWithItem:view marginConstraintsWithEdgeInset:edgeInset forMarginView:marginView relatedBy:NSLayoutRelationEqual];
}

//View fourSide constraint with MarginView and Relation
- (NSArray <NSLayoutConstraint *> *)constraintWithItem:(id)view marginConstraintsWithEdgeInset:(UIEdgeInsets)edgeInset forMarginView:(id)marginView relatedBy:(NSLayoutRelation)relation
{
    NSMutableArray <NSLayoutConstraint *> * constraintsArrayInner = [NSMutableArray new];
    
    void(^commonMargin)(CGFloat, NSLayoutAttribute) = ^(CGFloat constant, NSLayoutAttribute attribute)
    {
        if (constant == -0)
            constant = 0;
        
        if (constant != SSEasyLayoutNoValue && constant != - SSEasyLayoutNoValue)
        {
            [constraintsArrayInner addObject:[self constraintWithItem:view attribute:attribute toItem:marginView constant:constant relatedBy:relation]];
        }
    };
    
    float multiplyValue = (_layoutType == SSEasyLayoutTypeCustomInverse ? 1 : -1);
    
    commonMargin(edgeInset.top,                         NSLayoutAttributeTop);
    commonMargin(edgeInset.bottom * multiplyValue,      NSLayoutAttributeBottom);
    commonMargin(edgeInset.left,                        NSLayoutAttributeLeading);
    commonMargin(edgeInset.right * multiplyValue,       NSLayoutAttributeTrailing);
    
    return constraintsArrayInner;
}

//SuperView Equal Constraint with Attribute
- (NSLayoutConstraint *)constraintWithItem:(id)view equalToSuperViewAttribute:(NSLayoutAttribute)attr
{
    return [self constraintWithItem:view equalToSuperViewAttribute:attr constant:0.];
}

//SuperView Less Constraint with Attribute
- (NSLayoutConstraint *)constraintWithItem:(id)view lessToSuperViewAttribute:(NSLayoutAttribute)attr
{
    return [self constraintWithItem:view lessToSuperViewAttribute:attr constant:0.];
}

//SuperView Grater Constraint with Attribute
- (NSLayoutConstraint *)constraintWithItem:(id)view greaterToSuperViewAttribute:(NSLayoutAttribute)attr
{
    return [self constraintWithItem:view greaterToSuperViewAttribute:attr constant:0.];
}

//SuperView Equal Constraint with Attribute and Constant
- (NSLayoutConstraint *)constraintWithItem:(id)view equalToSuperViewAttribute:(NSLayoutAttribute)attr constant:(CGFloat)constant
{
    return [self constraintWithItem:view superViewAttribute:attr constant:constant relatedBy:NSLayoutRelationEqual];
}

//SuperView Less Constraint with Attribute and Constant
- (NSLayoutConstraint *)constraintWithItem:(id)view lessToSuperViewAttribute:(NSLayoutAttribute)attr constant:(CGFloat)constant
{
    return [self constraintWithItem:view superViewAttribute:attr constant:constant relatedBy:NSLayoutRelationLessThanOrEqual];
}

//SuperView Grater Constraint with Attribute and Constant
- (NSLayoutConstraint *)constraintWithItem:(id)view greaterToSuperViewAttribute:(NSLayoutAttribute)attr constant:(CGFloat)constant
{
    return [self constraintWithItem:view superViewAttribute:attr constant:constant relatedBy:NSLayoutRelationGreaterThanOrEqual];
}

//ToView Constraint with CenterX and CenterY
- (NSArray <NSLayoutConstraint *> *)constraintWithItemCenter:(id)view toItem:(id)view2
{
    return @[
             [self constraintWithItem:view attribute:NSLayoutAttributeCenterX toItem:view2],
             [self constraintWithItem:view attribute:NSLayoutAttributeCenterY toItem:view2]
             ];
}

//SuperView Constraint with CenterX and CenterY
- (NSArray <NSLayoutConstraint *> *)constraintWithItemSuperViewCenter:(id)view
{
    return @[
             [self constraintWithItemSuperViewCenter:view withAttribute:NSLayoutAttributeCenterX],
             [self constraintWithItemSuperViewCenter:view withAttribute:NSLayoutAttributeCenterY]
             ];
}

//SuperView Center Constraint with Attribute
- (NSLayoutConstraint *)constraintWithItemSuperViewCenter:(id)view withAttribute:(NSLayoutAttribute)attribute
{
    return [self constraintWithItemSuperViewCenter:view withAttribute:attribute constant:0];
}

//SuperView Center Constraint with Attribute and Constant
- (NSLayoutConstraint *)constraintWithItemSuperViewCenter:(id)view withAttribute:(NSLayoutAttribute)attribute constant:(CGFloat)constant
{
    return [self constraintWithItem:view superViewAttribute:attribute constant:constant relatedBy:NSLayoutRelationEqual];
}

//SuperView Constraint with Attribute, Relation and Constant
- (NSLayoutConstraint *)constraintWithItem:(id)view superViewAttribute:(NSLayoutAttribute)attr constant:(CGFloat)constant relatedBy:(NSLayoutRelation)relation
{
    return [self constraintWithItem:view
                          attribute:attr
                             toItem:((UIView *)view).superview
                           constant:constant
                          relatedBy:relation];
}

//Height for view
- (NSLayoutConstraint *)constraintWithItem:(id)view heightForView:(CGFloat)constant
{
    return [self constraintWithItem:view
                      heightForView:constant
                          relatedBy:NSLayoutRelationEqual];
}

//Height for view with Relation
- (NSLayoutConstraint *)constraintWithItem:(id)view heightForView:(CGFloat)constant relatedBy:(NSLayoutRelation)relation
{
    return [self constraintWithItem:view
                          attribute:NSLayoutAttributeHeight
                          relatedBy:relation
                             toItem:nil
                          attribute:NSLayoutAttributeNotAnAttribute
                           constant:constant];
}

//Width for view
- (NSLayoutConstraint *)constraintWithItem:(id)view widthForView:(CGFloat)constant
{
    return [self constraintWithItem:view
                       widthForView:constant
                          relatedBy:NSLayoutRelationEqual];
}

//Width for view with Relation
- (NSLayoutConstraint *)constraintWithItem:(id)view widthForView:(CGFloat)constant relatedBy:(NSLayoutRelation)relation
{
    return [self constraintWithItem:view
                          attribute:NSLayoutAttributeWidth
                          relatedBy:relation
                             toItem:nil
                          attribute:NSLayoutAttributeNotAnAttribute
                           constant:constant];
}

//Equal Height And Width for View
- (NSArray <NSLayoutConstraint *> *)constraintWithItem:(id)view equalHeightAndWidthSizeForView:(CGSize)size
{
    NSMutableArray <NSLayoutConstraint *> * constraintsArrayInner = [NSMutableArray new];
    
    void(^commonSize)(CGFloat, NSLayoutAttribute) = ^(CGFloat constant, NSLayoutAttribute attribute)
    {
        if (constant != SSEasyLayoutNoValue && constant != - SSEasyLayoutNoValue)
        {
            [constraintsArrayInner addObject:[self constraintWithItem:view
                                                            attribute:attribute
                                                            relatedBy:NSLayoutRelationEqual
                                                               toItem:nil
                                                            attribute:NSLayoutAttributeNotAnAttribute
                                                             constant:constant]];
        }
    };
    
    commonSize(size.width,  NSLayoutAttributeWidth);
    commonSize(size.height, NSLayoutAttributeHeight);
    
    return constraintsArrayInner;
}

//Constraint for Two Views with Attribute
- (NSLayoutConstraint *)constraintWithItem:(id)view1 attribute:(NSLayoutAttribute)attr toItem:(nullable id)view2
{
    return [self constraintWithItem:view1 attribute:attr toItem:view2 constant:0 relatedBy:NSLayoutRelationEqual];
}

//Constraint for Two Views with Attribute and Constant
- (NSLayoutConstraint *)constraintWithItem:(id)view1 attribute:(NSLayoutAttribute)attr toItem:(nullable id)view2 constant:(CGFloat)constant
{
    return [self constraintWithItem:view1 attribute:attr toItem:view2 constant:constant relatedBy:NSLayoutRelationEqual];
}

//Constraint for Two Views with Attribute, Relation and Constant
- (NSLayoutConstraint *)constraintWithItem:(id)view1 attribute:(NSLayoutAttribute)attr toItem:(nullable id)view2 constant:(CGFloat)constant relatedBy:(NSLayoutRelation)relation
{
    return [self constraintWithItem:view1
                          attribute:attr
                          relatedBy:relation
                             toItem:view2
                          attribute:attr
                           constant:constant];
}

//Constraint for Two Views with Attribute, Constant
- (NSLayoutConstraint *)constraintWithItem:(id)view1 attribute:(NSLayoutAttribute)attr1 toItem:(nullable id)view2 attribute:(NSLayoutAttribute)attr2 constant:(CGFloat)constant
{
    return [self constraintWithItem:view1
                          attribute:attr1
                          relatedBy:NSLayoutRelationEqual
                             toItem:view2
                          attribute:attr2
                           constant:constant];
}

//Default constraintWithItem method with arrray addObject
- (NSLayoutConstraint *)constraintWithItem:(id)view1 attribute:(NSLayoutAttribute)attr1 relatedBy:(NSLayoutRelation)relation toItem:(nullable id)view2 attribute:(NSLayoutAttribute)attr2 constant:(CGFloat)constant
{
    if (_layoutType == SSEasyLayoutTypeCustomInverse)
    {
        if (attr1 == NSLayoutAttributeTrailing || attr1 == NSLayoutAttributeRight || attr1 == NSLayoutAttributeBottom)
        {
            if (relation == NSLayoutRelationGreaterThanOrEqual)
                relation = NSLayoutRelationLessThanOrEqual;
            else if (relation == NSLayoutRelationLessThanOrEqual)
                relation = NSLayoutRelationGreaterThanOrEqual;
            
            constant *= -1;
        }
    }
    
    NSLayoutConstraint * constraint = [NSLayoutConstraint constraintWithItem:[self translatesAutoresizingForView:view1]
                                                                   attribute:attr1
                                                                   relatedBy:relation
                                                                      toItem:view2
                                                                   attribute:attr2
                                                                  multiplier:1
                                                                    constant:constant];
    [self addConstraint:constraint];
    
    return constraint;
}

//Priority For Constraint
- (NSLayoutConstraint *)priorityForConstraint:(NSLayoutConstraint *)constraint priority:(UILayoutPriority)priority
{
    constraint.priority = priority;
    
    [self removeExistingAndAddConstraint:constraint];
    
    return constraint;
}

//TranslatesAutoresizingMaskIntoConstraints for view
- (UIView *)translatesAutoresizingForView:(UIView *)view
{
    if (view.translatesAutoresizingMaskIntoConstraints != NO)
        view.translatesAutoresizingMaskIntoConstraints = NO;
    
    return view;
}

//Constriant for multiple items to align vertical or horizontal
- (NSArray <NSLayoutConstraint *> *)constraintWithMultipleItems:(NSArray <id> *)viewArray forAxis:(UILayoutConstraintAxis)axis
{
    return [self constraintWithMultipleItems:viewArray forAxis:axis forMarginConstant:0. forItemDistanceConstant:0.];
}

//Constriant for multiple items to align vertical or horizontal with MarginConstant and ItemDistanceConstant
- (NSArray <NSLayoutConstraint *> *)constraintWithMultipleItems:(NSArray <id> *)viewArray forAxis:(UILayoutConstraintAxis)axis forMarginConstant:(CGFloat)marginConstant forItemDistanceConstant:(CGFloat)itemDistanceConstant
{
    NSString * marginString = [NSString stringWithFormat:@"-(%f)-",marginConstant];
    
    NSString * constraintString = marginString;
    
    NSString * previousViewName = @"";
    
    for (int index=0; index < [viewArray count]; index++)
    {
        UIView * view = [self translatesAutoresizingForView:(viewArray[index])];
        
        NSString * viewName = [NSString stringWithFormat:@"view%d",index];
        
        [_viewsDictionary setValue:view forKey:viewName];
        
        NSString * distanceString = [NSString stringWithFormat:@"-(%f)-",itemDistanceConstant];
        NSString * equalViewString = [NSString stringWithFormat:@"(%@)",previousViewName];
        
        if (index == 0)
        {
            distanceString = equalViewString = @"";
        }
        
        constraintString = [NSString stringWithFormat:@"%@%@[%@%@]",constraintString,distanceString,viewName,equalViewString];
        
        previousViewName = viewName;
    }
    
    NSLayoutFormatOptions options;
    NSString * prefixString = @"";
    
    if (axis == UILayoutConstraintAxisVertical)
    {
        prefixString = @"V:|";
        options = NSLayoutFormatAlignAllLeading | NSLayoutFormatAlignAllTrailing;
    }
    else
    {
        prefixString = @"H:|";
        options = NSLayoutFormatAlignAllTop | NSLayoutFormatAlignAllBottom;
    }
    
    constraintString = [NSString stringWithFormat:@"%@%@%@%@",prefixString,constraintString,marginString,@"|"];
    
    return [self constraintsWithVisualFormat:constraintString options:options];
}

//Visual format constraints
- (NSArray <NSLayoutConstraint *> *)constraintsWithVisualFormat:(NSString *)format
{
    return [self constraintsWithVisualFormat:format options:0];
}

//Visual format constraints with Options
- (NSArray <NSLayoutConstraint *> *)constraintsWithVisualFormat:(NSString *)format options:(NSLayoutFormatOptions)opts
{
    NSArray <NSLayoutConstraint *> * constraintsArrayInner = [NSLayoutConstraint constraintsWithVisualFormat:format
                                                                                                     options:opts
                                                                                                     metrics:_metricsDictonary
                                                                                                       views:_viewsDictionary];
    
    [self addConstraints:constraintsArrayInner];
    
    return constraintsArrayInner;
}

//Remove and add single constraint into _constraintsArray
- (NSLayoutConstraint *)removeExistingAndAddConstraint:(NSLayoutConstraint *)constraint
{
    [self removeConstraint:constraint];
    [self addConstraint:constraint];
    
    return constraint;
}

//Add single constraint into _constraintsArray
- (NSLayoutConstraint *)addConstraint:(NSLayoutConstraint *)constraint
{
    [_constraintsArray addObject:constraint];
    
    return constraint;
}

//Remove single constraint into _constraintsArray
- (NSLayoutConstraint *)removeConstraint:(NSLayoutConstraint *)constraint
{
    if ([_constraintsArray containsObject:constraint])
        [_constraintsArray removeObject:constraint];
    
    return constraint;
}

//Add multiple constraints into _constraintsArray
- (NSArray <NSLayoutConstraint *> *)addConstraints:(NSArray <NSLayoutConstraint *> *)constraints
{
    [_constraintsArray addObjectsFromArray:constraints];
    
    return constraints;
}

//Remove multiple constraints into _constraintsArray
- (NSArray <NSLayoutConstraint *> *)removeConstraints:(NSArray <NSLayoutConstraint *> *)constraints
{
    [_constraintsArray removeObjectsInArray:constraints];
    
    return constraints;
}

//Active all constraints in _constraintsArray
- (void)activeAllConstraints
{
    if ([_constraintsArray count])
    {
        [NSLayoutConstraint activateConstraints:_constraintsArray];
        
        [self initializeFields];
    }
}

//Get Constraint for View by Attribute
+ (NSLayoutConstraint *)getConstraintForView:(id)view attribute:(NSLayoutAttribute)attribute
{
    UIView * viewInner = view;
    
    NSArray * layoutConstraintArray;
    
    switch (attribute)
    {
        case NSLayoutAttributeWidth:
        case NSLayoutAttributeHeight:
        {
            layoutConstraintArray = viewInner.constraints;
            break;
        }
            
        default:
        {
            layoutConstraintArray = viewInner.superview.constraints;
            break;
        }
    }
    
    NSPredicate * predicate = [NSPredicate predicateWithFormat:@"(firstAttribute = %d && firstItem = %@) || (secondAttribute = %d && secondItem = %@)", attribute, viewInner, attribute, viewInner];
    
    NSArray * fillteredArray = [layoutConstraintArray filteredArrayUsingPredicate:predicate];
    
    NSLayoutConstraint * constraint;
    
    if([fillteredArray count])
    {
        constraint = fillteredArray.firstObject;
    }
    
    return constraint;
}

//Change Constraint for View by Attribute and constant
+ (NSLayoutConstraint *)changeConstraintValueForView:(id)view attribute:(NSLayoutAttribute)attribute constant:(float)constant
{
    UIView * viewInner = view;
    
    NSLayoutConstraint * constraint = [SSEasyLayout getConstraintForView:viewInner attribute:attribute];
    
    if(constraint)
    {
        constraint.constant = constant;
        
        constraint.active = YES;
    }
    
    return constraint;
}

//Remove Constraint for View by Attribute
+ (void)removeConstraintForView:(UIView *)view removeAttributeArray:(NSArray <NSNumber *> *)removeAttributeArray
{
    for (NSNumber * attributeNumber in removeAttributeArray)
    {
        NSLayoutAttribute attribute = (NSLayoutAttribute)[attributeNumber integerValue];
        
        NSLayoutConstraint * constraint = [SSEasyLayout getConstraintForView:view attribute:attribute];
        
        if(constraint)
        {
            constraint.active = NO;
            [view removeConstraint:constraint];
        }
    }
}

//View HuggingPriority for priosrityAxis
+ (void)setContentHuggingPriorityForView:(id)view priosrityAxis:(UILayoutConstraintAxis)priosrityAxis
{
    [view setContentHuggingPriority:UILayoutPriorityRequired forAxis:priosrityAxis];
}

//View CompressionResistancePriority for priosrityAxis
+ (void)setContentCompressionResistancePriorityForView:(id)view priosrityAxis:(UILayoutConstraintAxis)priosrityAxis
{
    [view setContentCompressionResistancePriority:UILayoutPriorityRequired forAxis:priosrityAxis];
}

//View HuggingPriority & CompressionResistancePriority for priosrityAxis
+ (void)setContentHuggingAndCompressionPriorityForView:(id)view priosrityAxis:(UILayoutConstraintAxis)priosrityAxis
{
    [SSEasyLayout setContentHuggingPriorityForView:view priosrityAxis:priosrityAxis];
    [SSEasyLayout setContentCompressionResistancePriorityForView:view priosrityAxis:priosrityAxis];
}

//SSEasyLayout with block method to add and active constraints
+ (void)SSEasyLayoutWithActiveConstraints:(void (^) (SSEasyLayout * layout))blockLayout
{
    [self SSEasyLayoutWithActiveConstraintsLayoutType:SSEasyLayoutTypeDefault blockLayout:blockLayout];
}

//SSEasyLayout with type block method to add and active constraints
+ (void)SSEasyLayoutWithActiveConstraintsLayoutType:(SSEasyLayoutType)layoutTypeInner blockLayout:(void (^) (SSEasyLayout * layout))blockLayout
{
    SSEasyLayout * layout = [[SSEasyLayout alloc] initWithLayoutType:layoutTypeInner];
    
    blockLayout(layout);
    
    [layout activeAllConstraints];
}

@end

NSString * removeSelfFromDictionaryOfVariableBindings(NSString * variableName)
{
    NSArray <NSString *> * variableNameArray = [variableName componentsSeparatedByString:@" "];
    
    NSMutableArray <NSString *> * variableNameMutableArray = [NSMutableArray new];
    
    for (NSString * variableNameString in variableNameArray)
    {
        if ([variableNameString containsString:@"."])
        {
            NSArray <NSString *> * variableNameArray = [variableNameString componentsSeparatedByString:@"."];
            
            if ([variableNameArray count])
                [variableNameMutableArray addObject:[variableNameArray lastObject]];
        }
        else
        {
            [variableNameMutableArray addObject:variableNameString];
        }
    }
    
    if ([variableNameMutableArray count])
    {
        variableNameArray = variableNameMutableArray;
    }
    
    variableName = [variableNameArray componentsJoinedByString:@" "];
    
    return variableName;
}

void SSEasyLayoutWithActiveConstraints(void (^ blockLayout) (SSEasyLayout * layout))
{
    [SSEasyLayout SSEasyLayoutWithActiveConstraints:blockLayout];
}

void SSEasyLayoutWithActiveConstraintsLayoutType(SSEasyLayoutType layoutTypeInner, void (^ blockLayout) (SSEasyLayout * layout))
{
    [SSEasyLayout SSEasyLayoutWithActiveConstraintsLayoutType:layoutTypeInner blockLayout:blockLayout];
}

UIEdgeInsets SSEasyLayoutEdgeCommonValue(CGFloat value)
{
    return UIEdgeInsetsMake(value, value, value, value);
}

UIEdgeInsets SSEasyLayoutEdgeTopAndBottom(CGFloat value)
{
    return UIEdgeInsetsMake(value, SSEasyLayoutNoValue, value, SSEasyLayoutNoValue);
}

UIEdgeInsets SSEasyLayoutEdgeLeftAndRight(CGFloat value)
{
    return UIEdgeInsetsMake(SSEasyLayoutNoValue, value, SSEasyLayoutNoValue, value);
}

CGSize SSEasyLayoutSizeCommonValue(CGFloat value)
{
    return CGSizeMake(value, value);
}
