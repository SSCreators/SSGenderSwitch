//
//  SSEasyLayout.h
//  Sha
//  Version 1.1
//  Created by SebastianSha on 27/05/17.
//  Copyright © 2017 SebastianSha. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

typedef enum
{
    SSEasyLayoutTypeDefault,
    SSEasyLayoutTypeCustomInverse
} SSEasyLayoutType;

static CGFloat SSEasyLayoutNoValue        = 1000000000;

#define SSEasyLayoutDictionaryOfVariableBindings(...)   _NSDictionaryOfVariableBindings(removeSelfFromDictionaryOfVariableBindings(@"" # __VA_ARGS__), __VA_ARGS__, nil)

NS_ASSUME_NONNULL_BEGIN

@interface SSEasyLayout : NSObject

@property (nonatomic, assign) SSEasyLayoutType                                    layoutType;

@property (nonatomic, strong) NSMutableDictionary <NSString *, NSNumber *>      * metricsDictonary;

@property (nonatomic, strong) NSMutableDictionary <NSString *, id>              * viewsDictionary;

@property (nonatomic, strong) NSMutableArray <NSLayoutConstraint *>             * constraintsArray;

//Default init
- (instancetype)init;

//Custom init
- (instancetype)initWithLayoutType:(SSEasyLayoutType)layoutTypeInner;

//Initialize basic fields
- (void)initializeFields;

//View fourSide constraint with SuperView
- (NSArray <NSLayoutConstraint *> *)constraintWithItem:(id)view marginConstraintsWithEdgeInset:(UIEdgeInsets)edgeInset;

//View fourSide constraint with SuperView and Relation
- (NSArray <NSLayoutConstraint *> *)constraintWithItem:(id)view marginConstraintsWithEdgeInset:(UIEdgeInsets)edgeInset relatedBy:(NSLayoutRelation)relation;

//View fourSide constraint with MarginView
- (NSArray <NSLayoutConstraint *> *)constraintWithItem:(id)view marginConstraintsWithEdgeInset:(UIEdgeInsets)edgeInset forMarginView:(id)marginView;

//View fourSide constraint with MarginView and Relation
- (NSArray <NSLayoutConstraint *> *)constraintWithItem:(id)view marginConstraintsWithEdgeInset:(UIEdgeInsets)edgeInset forMarginView:(id)marginView relatedBy:(NSLayoutRelation)relation;

//SuperView Equal Constraint with Attribute
- (NSLayoutConstraint *)constraintWithItem:(id)view equalToSuperViewAttribute:(NSLayoutAttribute)attr;

//SuperView Less Constraint with Attribute
- (NSLayoutConstraint *)constraintWithItem:(id)view lessToSuperViewAttribute:(NSLayoutAttribute)attr;

//SuperView Grater Constraint with Attribute
- (NSLayoutConstraint *)constraintWithItem:(id)view greaterToSuperViewAttribute:(NSLayoutAttribute)attr;

//SuperView Equal Constraint with Attribute and Constant
- (NSLayoutConstraint *)constraintWithItem:(id)view equalToSuperViewAttribute:(NSLayoutAttribute)attr constant:(CGFloat)constant;

//SuperView Less Constraint with Attribute and Constant
- (NSLayoutConstraint *)constraintWithItem:(id)view lessToSuperViewAttribute:(NSLayoutAttribute)attr constant:(CGFloat)constant;

//SuperView Grater Constraint with Attribute and Constant
- (NSLayoutConstraint *)constraintWithItem:(id)view greaterToSuperViewAttribute:(NSLayoutAttribute)attr constant:(CGFloat)constant;

//ToView Constraint with CenterX and CenterY
- (NSArray <NSLayoutConstraint *> *)constraintWithItemCenter:(id)view toItem:(id)view2;

//SuperView Constraint with CenterX and CenterY
- (NSArray <NSLayoutConstraint *> *)constraintWithItemSuperViewCenter:(id)view;

//SuperView Center Constraint with Attribute
- (NSLayoutConstraint *)constraintWithItemSuperViewCenter:(id)view withAttribute:(NSLayoutAttribute)attribute;

//SuperView Center Constraint with Attribute and Constant
- (NSLayoutConstraint *)constraintWithItemSuperViewCenter:(id)view withAttribute:(NSLayoutAttribute)attribute constant:(CGFloat)constant;

//SuperView Constraint with Attribute and Relation
- (NSLayoutConstraint *)constraintWithItem:(id)view superViewAttribute:(NSLayoutAttribute)attr constant:(CGFloat)constant relatedBy:(NSLayoutRelation)relation;

//Height for view
- (NSLayoutConstraint *)constraintWithItem:(id)view heightForView:(CGFloat)constant;

//Height for view with Relation
- (NSLayoutConstraint *)constraintWithItem:(id)view heightForView:(CGFloat)constant relatedBy:(NSLayoutRelation)relation;

//Width for view
- (NSLayoutConstraint *)constraintWithItem:(id)view widthForView:(CGFloat)constant;

//Width for view with Relation
- (NSLayoutConstraint *)constraintWithItem:(id)view widthForView:(CGFloat)constant relatedBy:(NSLayoutRelation)relation;

//Equal Height And Width for View
- (NSArray <NSLayoutConstraint *> *)constraintWithItem:(id)view equalHeightAndWidthSizeForView:(CGSize)size;

//Constraint for Two Views with Attribute
- (NSLayoutConstraint *)constraintWithItem:(id)view1 attribute:(NSLayoutAttribute)attr toItem:(nullable id)view2;

//Constraint for Two Views with Attribute and Constant
- (NSLayoutConstraint *)constraintWithItem:(id)view1 attribute:(NSLayoutAttribute)attr toItem:(nullable id)view2 constant:(CGFloat)constant;

//Constraint for Two Views with Attribute, Relation and Constant
- (NSLayoutConstraint *)constraintWithItem:(id)view1 attribute:(NSLayoutAttribute)attr toItem:(nullable id)view2 constant:(CGFloat)constant relatedBy:(NSLayoutRelation)relation;

//Constraint for Two Views with Attribute, Constant
- (NSLayoutConstraint *)constraintWithItem:(id)view1 attribute:(NSLayoutAttribute)attr1 toItem:(nullable id)view2 attribute:(NSLayoutAttribute)attr2 constant:(CGFloat)constant;

//Default constraintWithItem method with arrray addObject
- (NSLayoutConstraint *)constraintWithItem:(id)view1 attribute:(NSLayoutAttribute)attr1 relatedBy:(NSLayoutRelation)relation toItem:(nullable id)view2 attribute:(NSLayoutAttribute)attr2 constant:(CGFloat)c;

//Priority For Constraint
- (NSLayoutConstraint *)priorityForConstraint:(NSLayoutConstraint *)constraint priority:(UILayoutPriority)priority;

//TranslatesAutoresizingMaskIntoConstraints for view
- (UIView *)translatesAutoresizingForView:(UIView *)view;

//Constriant for multiple items to align vertical or horizontal
- (NSArray <NSLayoutConstraint *> *)constraintWithMultipleItems:(NSArray <id> *)viewArray forAxis:(UILayoutConstraintAxis)axis;

//Constriant for multiple items to align vertical or horizontal with MarginConstant and ItemDistanceConstant
- (NSArray <NSLayoutConstraint *> *)constraintWithMultipleItems:(NSArray <id> *)viewArray forAxis:(UILayoutConstraintAxis)axis forMarginConstant:(CGFloat)marginConstant forItemDistanceConstant:(CGFloat)itemDistanceConstant;

//Visual format constraints
- (NSArray <NSLayoutConstraint *> *)constraintsWithVisualFormat:(NSString *)format;

//Visual format constraints
- (NSArray <NSLayoutConstraint *> *)constraintsWithVisualFormat:(NSString *)format options:(NSLayoutFormatOptions)opts;

//Remove and add single constraint into _constraintsArray
- (NSLayoutConstraint *)removeExistingAndAddConstraint:(NSLayoutConstraint *)constraint;

//Add single constraint into _constraintsArray
- (NSLayoutConstraint *)addConstraint:(NSLayoutConstraint *)constraint;

//Remove single constraint into _constraintsArray
- (NSLayoutConstraint *)removeConstraint:(NSLayoutConstraint *)constraint;

//Add multiple constraints into _constraintsArray
- (NSArray <NSLayoutConstraint *> *)addConstraints:(NSArray <NSLayoutConstraint *> *)constraints;

//Remove multiple constraints into _constraintsArray
- (NSArray <NSLayoutConstraint *> *)removeConstraints:(NSArray <NSLayoutConstraint *> *)constraints;

//Active all constraints in _constraintsArray
- (void)activeAllConstraints;

//Get Constraint for View by Attribute
+ (NSLayoutConstraint *)getConstraintForView:(id)view attribute:(NSLayoutAttribute)attribute;

//Change Constraint for View by Attribute and constant
+ (NSLayoutConstraint *)changeConstraintValueForView:(id)view attribute:(NSLayoutAttribute)attribute constant:(float)constant;

//Remove Constraint for View by Attribute
+ (void)removeConstraintForView:(UIView *)view removeAttributeArray:(NSArray <NSNumber *> *)removeAttributeArray;

//View HuggingPriority for priosrityAxis
+ (void)setContentHuggingPriorityForView:(id)view priosrityAxis:(UILayoutConstraintAxis)priosrityAxis;

//View CompressionResistancePriority for priosrityAxis
+ (void)setContentCompressionResistancePriorityForView:(id)view priosrityAxis:(UILayoutConstraintAxis)priosrityAxis;

//View HuggingPriority & CompressionResistancePriority for priosrityAxis
+ (void)setContentHuggingAndCompressionPriorityForView:(id)view priosrityAxis:(UILayoutConstraintAxis)priosrityAxis;

//SSEasyLayout with block method to add and active constraints
+ (void)SSEasyLayoutWithActiveConstraints:(void (^) (SSEasyLayout * layout))blockLayout;

@end

NSString * removeSelfFromDictionaryOfVariableBindings(NSString * variableName);

void SSEasyLayoutWithActiveConstraints(void (^ blockLayout) (SSEasyLayout * layout));

void SSEasyLayoutWithActiveConstraintsLayoutType(SSEasyLayoutType layoutTypeInner, void (^ blockLayout) (SSEasyLayout * layout));

UIEdgeInsets SSEasyLayoutEdgeCommonValue(CGFloat value);

UIEdgeInsets SSEasyLayoutEdgeTopAndBottom(CGFloat value);

UIEdgeInsets SSEasyLayoutEdgeLeftAndRight(CGFloat value);

CGSize SSEasyLayoutSizeCommonValue(CGFloat value);

NS_ASSUME_NONNULL_END

