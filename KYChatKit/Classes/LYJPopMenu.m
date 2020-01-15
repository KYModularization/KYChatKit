//
//  LYJPopMenu.m
//  KYKJInternetDoctor
//
//  Created by KuaiYi on 2019/9/29.
//  Copyright © 2019 快医科技. All rights reserved.
//

#import "LYJPopMenu.h"


typedef NS_ENUM(NSUInteger, LYJPopMenuArrowDirection) {
    /**
     *  Up
     */
    LYJPopMenuArrowDirectionUp,
    /**
     *  Down
     */
    LYJPopMenuArrowDirectionDown,
};

#define DefaultMenuArrowRoundRadius 4.f
#define MenuWidth 125
#define MenuRowHeight 35
#define DefaultMargin 4.f
#define DefaultMenuCornerRadius 5.f
#define MenuArrowHeight 8.f
#define MenuArrowWidth 6.f

@interface  LYJPopMenuView()<UITableViewDelegate,UITableViewDataSource>

@property (nonatomic, strong) UITableView *menuTableView;
@property (nonatomic, strong) NSArray *menuStringArray;
@property (nonatomic, strong) NSArray *menuImageArray;
@property (nonatomic, assign) LYJPopMenuArrowDirection arrowDirection;
@property (nonatomic, strong) LYJPopMenuDoneBlock doneBlock;
@property (nonatomic, strong) CAShapeLayer *backgroundLayer;
//@property (nonatomic, strong) LYJPopMenuConfiguration *config;

@end

@implementation LYJPopMenuView

- (UITableView *)menuTableView {
    if (!_menuTableView) {
        _menuTableView = [[UITableView alloc]initWithFrame:CGRectZero style:UITableViewStylePlain];
        _menuTableView.backgroundColor = BLACK_COLOR;
        _menuTableView.separatorColor = [UIColor colorWithWhite:1 alpha:.3f];
        _menuTableView.layer.cornerRadius = 4.f;
        _menuTableView.scrollEnabled = NO;
        _menuTableView.clipsToBounds = YES;
        _menuTableView.delegate = self;
        _menuTableView.dataSource = self;
        [_menuTableView  registerClass:[UITableViewCell class] forCellReuseIdentifier:@"cell"];
        _menuTableView.separatorInset = UIEdgeInsetsZero;
        [self addSubview:_menuTableView];
    }
    return _menuTableView;
}

- (void)showWithFrame:(CGRect )frame
           anglePoint:(CGPoint )anglePoint
        withNameArray:(NSArray *)nameArray
       imageNameArray:(NSArray *)imageNameArray
     shouldAutoScroll:(BOOL)shouldAutoScroll
       arrowDirection:(LYJPopMenuArrowDirection)arrowDirection
            doneBlock:(LYJPopMenuDoneBlock)doneBlock {
    self.frame = frame;
    //    self.config = config ? config : [LYJPopMenuConfiguration defaultConfiguration];
    _menuStringArray = nameArray;
    _menuImageArray = imageNameArray;
    _arrowDirection = arrowDirection;
    self.doneBlock = doneBlock;
    self.menuTableView.scrollEnabled = shouldAutoScroll;
    self.menuTableView.layer.cornerRadius = 4.f;
    
    CGRect menuRect = CGRectMake(0, MenuArrowHeight, MenuWidth, _menuStringArray.count*MenuRowHeight);
    if (_arrowDirection == LYJPopMenuArrowDirectionDown) {
        menuRect = CGRectMake(0, 0, MenuWidth, _menuStringArray.count*MenuRowHeight);
    }
    [self.menuTableView setFrame:menuRect];
    [self.menuTableView reloadData];
    
    [self drawBackgroundLayerWithAnglePoint:anglePoint];
}

- (void)drawBackgroundLayerWithAnglePoint:(CGPoint)anglePoint {
    if (_backgroundLayer) {
        [_backgroundLayer removeFromSuperlayer];
    }
    
    UIBezierPath *path = [UIBezierPath bezierPath];
    CGFloat offset = 2.f*DefaultMenuArrowRoundRadius*sinf(M_PI_4/2.f);
    CGFloat roundcenterHeight = offset + DefaultMenuArrowRoundRadius*sqrtf(2.f);
    CGPoint roundcenterPoint = CGPointMake(anglePoint.x, roundcenterHeight);
    CGFloat menuCornerRadius = 4.f;
    switch (_arrowDirection) {
        case LYJPopMenuArrowDirectionUp:{
            
            [path moveToPoint:CGPointMake(anglePoint.x + MenuArrowWidth, MenuArrowHeight)];
            [path addLineToPoint:anglePoint];
            [path addLineToPoint:CGPointMake( anglePoint.x - MenuArrowWidth, MenuArrowHeight)];
            
            [path addLineToPoint:CGPointMake(menuCornerRadius, MenuArrowHeight)];
            [path addArcWithCenter:CGPointMake(menuCornerRadius, MenuArrowHeight + menuCornerRadius) radius:menuCornerRadius startAngle:-M_PI_2 endAngle:-M_PI clockwise:NO];
            [path addLineToPoint:CGPointMake( 0, self.bounds.size.height - menuCornerRadius)];
            [path addArcWithCenter:CGPointMake(menuCornerRadius, self.bounds.size.height - menuCornerRadius) radius:menuCornerRadius startAngle:M_PI endAngle:M_PI_2 clockwise:NO];
            [path addLineToPoint:CGPointMake( self.bounds.size.width - menuCornerRadius, self.bounds.size.height)];
            [path addArcWithCenter:CGPointMake(self.bounds.size.width - menuCornerRadius, self.bounds.size.height - menuCornerRadius) radius:menuCornerRadius startAngle:M_PI_2 endAngle:0 clockwise:NO];
            [path addLineToPoint:CGPointMake(self.bounds.size.width , menuCornerRadius + MenuArrowHeight)];
            [path addArcWithCenter:CGPointMake(self.bounds.size.width - menuCornerRadius, menuCornerRadius + MenuArrowHeight) radius:menuCornerRadius startAngle:0 endAngle:-M_PI_2 clockwise:NO];
            [path closePath];
            
        }break;
        case LYJPopMenuArrowDirectionDown:{
            
            roundcenterPoint = CGPointMake(anglePoint.x, anglePoint.y - roundcenterHeight);
            
            [path moveToPoint:CGPointMake(anglePoint.x + MenuArrowWidth, anglePoint.y - MenuArrowHeight)];
            [path addLineToPoint:anglePoint];
            [path addLineToPoint:CGPointMake( anglePoint.x - MenuArrowWidth, anglePoint.y - MenuArrowHeight)];
            
            [path addLineToPoint:CGPointMake( menuCornerRadius, anglePoint.y - MenuArrowHeight)];
            [path addArcWithCenter:CGPointMake(menuCornerRadius, anglePoint.y - MenuArrowHeight - menuCornerRadius) radius:menuCornerRadius startAngle:M_PI_2 endAngle:M_PI clockwise:YES];
            [path addLineToPoint:CGPointMake( 0, menuCornerRadius)];
            [path addArcWithCenter:CGPointMake(menuCornerRadius, menuCornerRadius) radius:menuCornerRadius startAngle:M_PI endAngle:-M_PI_2 clockwise:YES];
            [path addLineToPoint:CGPointMake( self.bounds.size.width - menuCornerRadius, 0)];
            [path addArcWithCenter:CGPointMake(self.bounds.size.width - menuCornerRadius, menuCornerRadius) radius:menuCornerRadius startAngle:-M_PI_2 endAngle:0 clockwise:YES];
            [path addLineToPoint:CGPointMake(self.bounds.size.width , anglePoint.y - (menuCornerRadius + MenuArrowHeight))];
            [path addArcWithCenter:CGPointMake(self.bounds.size.width - menuCornerRadius, anglePoint.y - (menuCornerRadius + MenuArrowHeight)) radius:menuCornerRadius startAngle:0 endAngle:M_PI_2 clockwise:YES];
            [path closePath];
            
        }break;
        default:
            break;
    }
    
    _backgroundLayer = [CAShapeLayer layer];
    _backgroundLayer.path = path.CGPath;
    _backgroundLayer.lineWidth = .5f;
    _backgroundLayer.strokeColor = BLACK_COLOR.CGColor;
    [self.layer insertSublayer:_backgroundLayer atIndex:0];
}
#pragma mark- tableView delegate
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return _menuStringArray.count;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell"];
    cell.textLabel.text = _menuStringArray[indexPath.row];
    cell.textLabel.font = FONT(15);
    cell.textLabel.textColor = WHITE_COLOR;
    cell.backgroundColor = [UIColor blackColor];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    return cell;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 35;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (self.doneBlock) {
        self.doneBlock(indexPath.row);
    }
}
@end


@interface LYJPopMenu () <UIGestureRecognizerDelegate>

@property (nonatomic, strong) UIView * backgroundView;
@property (nonatomic, strong) LYJPopMenuView *popMenuView;
@property (nonatomic, strong) LYJPopMenuDoneBlock doneBlock;
@property (nonatomic, strong) LYJPopMenuDismissBlock dismissBlock;

@property (nonatomic, strong) UIView *sender;
@property (nonatomic, assign) CGRect senderFrame;
@property (nonatomic, strong) NSArray<NSString*> *menuArray;
@property (nonatomic, strong) NSArray<NSString*> *menuImageArray;
@property (nonatomic, assign) BOOL isCurrentlyOnScreen;

@end

@implementation LYJPopMenu

+ (LYJPopMenu *)sharedInstance {
    static dispatch_once_t once = 0;
    static LYJPopMenu *shared;
    dispatch_once(&once, ^{ shared = [[LYJPopMenu alloc] init]; });
    return shared;
}
+(void)dismiss {
    [[self sharedInstance] dismiss];
}
+ (void) showForSender:(UIView *)sender
         withMenuArray:(NSArray *)menuArray
             doneBlock:(LYJPopMenuDoneBlock)doneBlock
          dismissBlock:(LYJPopMenuDismissBlock)dismissBlock
{
    [[self sharedInstance] showForSender:sender window:nil senderFrame:CGRectNull withMenu:menuArray imageNameArray:nil doneBlock:doneBlock dismissBlock:dismissBlock];
}
- (void) showForSender:(UIView *)sender
                window:(UIWindow*)window
           senderFrame:(CGRect )senderFrame
              withMenu:(NSArray *)menuArray
        imageNameArray:(NSArray *)imageNameArray
             doneBlock:(LYJPopMenuDoneBlock)doneBlock
          dismissBlock:(LYJPopMenuDismissBlock)dismissBlock {
    dispatch_async(dispatch_get_main_queue(), ^{
        
        
        self.sender = sender;
        self.senderFrame = senderFrame;
        self.menuArray = menuArray;
        self.menuImageArray = imageNameArray;
        self.doneBlock = doneBlock;
        self.dismissBlock = dismissBlock;
        
        [self.backgroundView addSubview:self.popMenuView];
        [KEY_WINDOW addSubview:self.backgroundView];
        
        [self adjustPopOverMenu];
    });
}

- (void)adjustPopOverMenu {
    self.backgroundView.backgroundColor = [UIColor clearColor];
    [self.backgroundView setFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT)];
    
    CGRect senderRect ;
    
    if (self.sender) {
        senderRect = [self.sender.superview convertRect:self.sender.frame toView:self.backgroundView];
        // if run into touch problems on nav bar, use the fowllowing line.
        //        senderRect.origin.y = MAX(64-senderRect.origin.y, senderRect.origin.y);
    } else {
        senderRect = self.senderFrame;
    }
    if (senderRect.origin.y > SCREEN_HEIGHT) {
        senderRect.origin.y = SCREEN_HEIGHT;
    }
    
    CGFloat menuHeight = MenuRowHeight * self.menuArray.count + MenuArrowHeight;
    CGPoint menuArrowPoint = CGPointMake(senderRect.origin.x + (senderRect.size.width)/2, 0);
    CGFloat menuX = 0;
    CGRect menuRect = CGRectZero;
    BOOL shouldAutoScroll = NO;
    LYJPopMenuArrowDirection arrowDirection;
    
    if (senderRect.origin.y + senderRect.size.height/2  < SCREEN_HEIGHT/2) {
        arrowDirection = LYJPopMenuArrowDirectionUp;
        menuArrowPoint.y = 0;
    }else{
        arrowDirection = LYJPopMenuArrowDirectionDown;
        menuArrowPoint.y = menuHeight;
    }
    
    if (menuArrowPoint.x + MenuWidth/2 + DefaultMargin > SCREEN_WIDTH) {
        menuArrowPoint.x = MIN(menuArrowPoint.x - (SCREEN_WIDTH - MenuWidth - DefaultMargin), MenuWidth - MenuWidth - DefaultMargin);
        menuX = SCREEN_WIDTH - MenuWidth - DefaultMargin;
    }else if ( menuArrowPoint.x - MenuWidth/2 - DefaultMargin < 0){
        menuArrowPoint.x = MAX( DefaultMenuCornerRadius + MenuWidth, menuArrowPoint.x - DefaultMargin);
        menuX = DefaultMargin;
    }else{
        menuArrowPoint.x = MenuWidth/2;
        menuX = senderRect.origin.x + (senderRect.size.width)/2 - MenuWidth/2;
    }
    
    if (arrowDirection == LYJPopMenuArrowDirectionUp) {
        menuRect = CGRectMake(menuX, (senderRect.origin.y + senderRect.size.height), MenuWidth, menuHeight);
        // if too long and is out of screen
        if (menuRect.origin.y + menuRect.size.height > SCREEN_HEIGHT) {
            menuRect = CGRectMake(menuX, (senderRect.origin.y + senderRect.size.height), MenuWidth, SCREEN_HEIGHT - menuRect.origin.y - DefaultMargin);
            shouldAutoScroll = YES;
        }
    }else{
        
        menuRect = CGRectMake(menuX, (senderRect.origin.y - menuHeight), MenuWidth, menuHeight);
        // if too long and is out of screen
        if (menuRect.origin.y  < 0) {
            menuRect = CGRectMake(menuX, DefaultMargin, MenuWidth, senderRect.origin.y - DefaultMargin);
            menuArrowPoint.y = senderRect.origin.y;
            shouldAutoScroll = YES;
        }
    }
    
    [self prepareToShowWithMenuRect:menuRect
                     menuArrowPoint:menuArrowPoint
                   shouldAutoScroll:shouldAutoScroll
                     arrowDirection:arrowDirection];
    
    
    [self show];
}

- (void)prepareToShowWithMenuRect:(CGRect)menuRect menuArrowPoint:(CGPoint)menuArrowPoint shouldAutoScroll:(BOOL)shouldAutoScroll arrowDirection:(LYJPopMenuArrowDirection)arrowDirection {
    CGPoint anchorPoint = CGPointMake(menuArrowPoint.x/menuRect.size.width, 0);
    if (arrowDirection ==LYJPopMenuArrowDirectionDown) {
        anchorPoint = CGPointMake(menuArrowPoint.x/menuRect.size.width, 1);
    }
    _popMenuView.transform = CGAffineTransformMakeScale(1, 1);
    
    [_popMenuView showWithFrame:menuRect
                     anglePoint:menuArrowPoint
                  withNameArray:self.menuArray
                 imageNameArray:self.menuImageArray
               shouldAutoScroll:shouldAutoScroll
                 arrowDirection:arrowDirection
                      doneBlock:^(NSInteger selectedIndex) {
                          [self doneActionWithSelectedIndex:selectedIndex];
                      }];
    
    [self setAnchorPoint:anchorPoint forView:_popMenuView];
    
    _popMenuView.transform = CGAffineTransformMakeScale(0.1, 0.1);
}

- (void)setAnchorPoint:(CGPoint)anchorPoint forView:(UIView *)view {
    CGPoint newPoint = CGPointMake(view.bounds.size.width * anchorPoint.x,
                                   view.bounds.size.height * anchorPoint.y);
    CGPoint oldPoint = CGPointMake(view.bounds.size.width * view.layer.anchorPoint.x,
                                   view.bounds.size.height * view.layer.anchorPoint.y);
    
    newPoint = CGPointApplyAffineTransform(newPoint, view.transform);
    oldPoint = CGPointApplyAffineTransform(oldPoint, view.transform);
    
    CGPoint position = view.layer.position;
    
    position.x -= oldPoint.x;
    position.x += newPoint.x;
    
    position.y -= oldPoint.y;
    position.y += newPoint.y;
    
    view.layer.position = position;
    view.layer.anchorPoint = anchorPoint;
}

#pragma mark - UIGestureRecognizerDelegate

- (BOOL)gestureRecognizer:(UIGestureRecognizer *)gestureRecognizer shouldReceiveTouch:(UITouch *)touch {
    CGPoint point = [touch locationInView:_popMenuView];
    if ([NSStringFromClass([touch.view class]) isEqualToString:@"UITableViewCellContentView"]) {
        return NO;
    }else if (CGRectContainsPoint(CGRectMake(0, 0, MenuWidth, MenuRowHeight), point)) {
        [self doneActionWithSelectedIndex:0];
        return NO;
    }
    return YES;
}

#pragma mark - onBackgroundViewTapped

- (void)onBackgroundViewTapped:(UIGestureRecognizer *)gesture {
    [self dismiss];
}

#pragma mark - show animation

- (void)show {
    self.isCurrentlyOnScreen = YES;
    [UIView animateWithDuration:.2f
                     animations:^{
                         self.backgroundView.backgroundColor = [UIColor clearColor];
                         self.popMenuView.alpha = 1;
                         self.popMenuView.transform = CGAffineTransformMakeScale(1, 1);
                     }];
}

#pragma mark - dismiss animation

- (void)dismiss {
    self.isCurrentlyOnScreen = NO;
    [self doneActionWithSelectedIndex:-1];
}

#pragma mark - doneActionWithSelectedIndex

- (void)doneActionWithSelectedIndex:(NSInteger)selectedIndex {
    [UIView animateWithDuration:.2f
                     animations:^{
                         self.backgroundView.backgroundColor = [UIColor clearColor];
                         self.popMenuView.alpha = 0;
                         self.popMenuView.transform = CGAffineTransformMakeScale(0.1, 0.1);
                     }completion:^(BOOL finished) {
                         if (finished) {
                             [self.popMenuView removeFromSuperview];
                             [self.backgroundView removeFromSuperview];
                             self.popMenuView = nil;
                             self.backgroundView = nil;
                             if (selectedIndex < 0) {
                                 if (self.dismissBlock) {
                                     self.dismissBlock();
                                 }
                             }else{
                                 if (self.doneBlock) {
                                     self.doneBlock(selectedIndex);
                                 }
                             }
                         }
                     }];
}
- (UIView *)backgroundView {
    if (!_backgroundView) {
        _backgroundView = [[UIView alloc ]initWithFrame:[UIScreen mainScreen].bounds];
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(onBackgroundViewTapped:)];
        tap.delegate = self;
        [_backgroundView addGestureRecognizer:tap];
        _backgroundView.backgroundColor = [UIColor clearColor];
    }
    return _backgroundView;
}

- (LYJPopMenuView *)popMenuView {
    if (!_popMenuView) {
        _popMenuView = [[LYJPopMenuView alloc] initWithFrame:CGRectMake(0, 0, MenuWidth, _menuArray.count*MenuRowHeight+MenuArrowHeight)];
        _popMenuView.alpha = 0;
    }
    return _popMenuView;
}
- (void)dealloc
{
    [_popMenuView removeFromSuperview];
    [_backgroundView removeFromSuperview];
    _popMenuView = nil;
    _backgroundView = nil;
}
@end

