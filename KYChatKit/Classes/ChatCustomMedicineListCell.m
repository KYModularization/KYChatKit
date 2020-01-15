//
//  ChatCustomMedicineListCell.m
//  KYKJInternetDoctor
//
//  Created by KuaiYi on 2019/11/1.
//  Copyright © 2019 快医科技. All rights reserved.
//

#import "ChatCustomMedicineListCell.h"

@interface ChatCustomMedicineListCell ()

@property (nonatomic, strong) UILabel *titleLabel;
@property (nonatomic, strong) UILabel *detailLabel;

@property (nonatomic, strong) UIView *bgView;
@property (nonatomic, strong) UIView *bgView1;
@property (nonatomic, strong) UIView *bgView2;

@property (nonatomic, strong) UILabel *medicineNameLabel1;
@property (nonatomic, strong) UILabel *countLabel1;
@property (nonatomic, strong) UILabel *organizationNameLabel1;
@property (nonatomic, strong) UILabel *specificationLabel1;

@property (nonatomic, strong) UILabel *medicineNameLabel2;
@property (nonatomic, strong) UILabel *countLabel2;
@property (nonatomic, strong) UILabel *organizationNameLabel2;
@property (nonatomic, strong) UILabel *specificationLabel2;

@property (nonatomic, strong) UILabel *senderTitleLabel;
@property (nonatomic, strong) UILabel *senderDetailLabel;

@property (nonatomic, strong) UIView *senderBgView;
@property (nonatomic, strong) UIView *senderBgView1;
@property (nonatomic, strong) UIView *senderBgView2;

@property (nonatomic, strong) UILabel *senderMedicineNameLabel1;
@property (nonatomic, strong) UILabel *senderCountLabel1;
@property (nonatomic, strong) UILabel *senderOrganizationNameLabel1;
@property (nonatomic, strong) UILabel *senderSpecificationLabel1;

@property (nonatomic, strong) UILabel *senderMedicineNameLabel2;
@property (nonatomic, strong) UILabel *senderCountLabel2;
@property (nonatomic, strong) UILabel *senderOrganizationNameLabel2;
@property (nonatomic, strong) UILabel *senderSpecificationLabel2;


@end

@implementation ChatCustomMedicineListCell
- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self)
    {
        [self setSubviews];
    }
    return self;
}

- (void)setSubviews
{
  
        _senderBgView = [UIView new];
            _senderBgView.backgroundColor = WHITE_COLOR;
            [self.senderView addSubview:_senderBgView];

            [_senderBgView mas_makeConstraints:^(MASConstraintMaker *make) {
                make.edges.equalTo(self.senderView);
            }];
            
            UITapGestureRecognizer *tap1 = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapAction)];
            [_senderBgView addGestureRecognizer:tap1];
            
            _senderTitleLabel = [UILabel makeLabel:^(LabelMaker *make) {
                make.textColor(UIColorWithHex(0xFE9B00)).font(BOLD_FONT(15)).text(@"药品清单").addToSuperView(self.senderBgView);
            }];
            [_senderTitleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
                make.left.top.equalTo(self.senderBgView).mas_offset(10);
            }];
            
            UIImageView *open1 = [UIImageView new];
            open1.image = IMAGE(@"orange_arrow");
            [_senderBgView addSubview:open1];
            [open1 mas_makeConstraints:^(MASConstraintMaker *make) {
                make.width.height.mas_equalTo(24);
                make.top.equalTo(self.senderBgView).mas_offset(5);
                make.right.equalTo(self.senderBgView).mas_offset(-5);
            }];
            
            UIView *line1 = [UIView new];
            line1.backgroundColor = LINE_COLOR;
            [_senderBgView addSubview:line1];
            [line1 mas_makeConstraints:^(MASConstraintMaker *make) {
                make.height.mas_equalTo(.5f);
                make.left.equalTo(self.senderBgView).mas_offset(10);
                make.right.equalTo(self.senderBgView).mas_offset(-10);
                make.top.equalTo(open1.mas_bottom).mas_offset(10);
            }];
            
            _senderBgView1 = [[UIView alloc] init];
            [_senderBgView addSubview:_senderBgView1];
            [_senderBgView1 mas_makeConstraints:^(MASConstraintMaker *make) {
                make.top.equalTo(line1.mas_bottom).mas_offset(15);
                make.left.equalTo(self.senderBgView).mas_offset(14.5);
                make.right.equalTo(self.senderBgView).mas_offset(-14.5);
            }];
            
            
            _senderBgView2 = [[UIView alloc] init];
            [_senderBgView addSubview:_senderBgView2];
            [_senderBgView2 mas_makeConstraints:^(MASConstraintMaker *make) {
                make.top.equalTo(_senderBgView1.mas_bottom).mas_offset(15);
                make.left.equalTo(self.senderBgView).mas_offset(14.5);
                make.right.equalTo(self.senderBgView).mas_offset(-14.5);
                make.bottom.equalTo(self.senderBgView).mas_offset(-14.5);
            }];
            
            
            _senderCountLabel1 = [UILabel makeLabel:^(LabelMaker *make) {
                make.textColor(LIGHT_BLACK_COLOR).font(FONT(13)).textAlignment(NSTextAlignmentRight).addToSuperView(self.senderBgView1);
            }];
            
            [_senderCountLabel1 mas_makeConstraints:^(MASConstraintMaker *make) {
                make.right.top.equalTo(_senderBgView1);
            }];
            
            _senderMedicineNameLabel1 = [UILabel makeLabel:^(LabelMaker *make) {
                make.textColor(TEXT_BLACK_COLOR).font(FONT(14)).textAlignment(NSTextAlignmentLeft).addToSuperView(self.senderBgView1);
            }];
            [_senderMedicineNameLabel1 mas_makeConstraints:^(MASConstraintMaker *make) {
                make.left.top.equalTo(_senderBgView1);
                make.right.equalTo(_senderCountLabel1.mas_left).mas_offset(-10);
            }];
            [self.senderCountLabel1 setContentCompressionResistancePriority:UILayoutPriorityRequired forAxis:UILayoutConstraintAxisHorizontal];
            _senderSpecificationLabel1 = [UILabel makeLabel:^(LabelMaker *make) {
                  make.font(FONT(12)).addToSuperView(self.senderBgView1);
               }];
            
            [_senderSpecificationLabel1 mas_makeConstraints:^(MASConstraintMaker *make) {
                make.top.equalTo(_senderCountLabel1.mas_bottom).mas_offset(12.5);
                make.right.equalTo(_senderBgView1);
            }];
            _senderOrganizationNameLabel1 = [UILabel makeLabel:^(LabelMaker *make) {
               make.textColor(TEXT_GRAY_COLOR_2).font(FONT(12)).addToSuperView(self.senderBgView1);
            }];
            [_senderOrganizationNameLabel1 mas_makeConstraints:^(MASConstraintMaker *make) {
        //        make.top.equalTo(_medicineNameLabel1.mas_bottom).mas_offset(12.5);
                make.centerY.equalTo(self.senderSpecificationLabel1);
                make.left.equalTo(_senderBgView1);
                make.right.equalTo(_senderSpecificationLabel1.mas_left).mas_offset(-10);
                make.bottom.equalTo(_senderBgView1);
            }];
            
            [self.senderSpecificationLabel1 setContentCompressionResistancePriority:UILayoutPriorityRequired forAxis:UILayoutConstraintAxisHorizontal];
            
            
            _senderCountLabel2 = [UILabel makeLabel:^(LabelMaker *make) {
                   make.textColor(LIGHT_BLACK_COLOR).font(FONT(13)).textAlignment(NSTextAlignmentRight).addToSuperView(self.senderBgView2);
            }];

                
            [_senderCountLabel2 mas_makeConstraints:^(MASConstraintMaker *make) {
                make.right.top.equalTo(_senderBgView2);
            }];
            
                
            _senderMedicineNameLabel2 = [UILabel makeLabel:^(LabelMaker *make) {
                make.textColor(TEXT_BLACK_COLOR).font(FONT(14)).textAlignment(NSTextAlignmentLeft).addToSuperView(self.senderBgView1);
            }];
            [_senderMedicineNameLabel2 mas_makeConstraints:^(MASConstraintMaker *make) {
                make.left.top.equalTo(_senderBgView2);
                make.right.equalTo(_senderCountLabel2.mas_left).mas_offset(-10);
            }];
            [self.senderCountLabel2 setContentCompressionResistancePriority:UILayoutPriorityRequired forAxis:UILayoutConstraintAxisHorizontal];
            _senderSpecificationLabel2 = [UILabel makeLabel:^(LabelMaker *make) {
                make.font(FONT(12)).addToSuperView(self.senderBgView2);
            }];
                
            [_senderSpecificationLabel2 mas_makeConstraints:^(MASConstraintMaker *make) {
                make.top.equalTo(_senderCountLabel2.mas_bottom).mas_offset(12.5);
                make.right.equalTo(_senderBgView2);
            }];
            _senderOrganizationNameLabel2 = [UILabel makeLabel:^(LabelMaker *make) {
                make.textColor(TEXT_GRAY_COLOR_2).font(FONT(12)).addToSuperView(self.senderBgView2);
            }];
            [_senderOrganizationNameLabel2 mas_makeConstraints:^(MASConstraintMaker *make) {
        //        make.top.equalTo(_medicineNameLabel2.mas_bottom).mas_offset(12.5);
                make.centerY.equalTo(self.senderSpecificationLabel2);
                make.left.equalTo(self.senderBgView2);
                make.right.equalTo(self.senderSpecificationLabel2.mas_left).mas_offset(-10);
                make.bottom.mas_equalTo(self.senderBgView2);
            }];
            
            [self.senderSpecificationLabel2 setContentCompressionResistancePriority:UILayoutPriorityRequired forAxis:UILayoutConstraintAxisHorizontal];

        _bgView = [UIView new];
        _bgView.backgroundColor = WHITE_COLOR;
        [self.receiveView addSubview:_bgView];
        [_bgView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.edges.equalTo(self.receiveView);
        }];
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapAction)];
           [_bgView addGestureRecognizer:tap];
         _titleLabel = [UILabel makeLabel:^(LabelMaker *make) {
                make.textColor(UIColorWithHex(0xFE9B00)).font(BOLD_FONT(15)).text(@"药品清单").addToSuperView(self.bgView);
            }];
            [_titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
                make.left.top.equalTo(self.bgView).mas_offset(10);
            }];
            
            UIImageView *open = [UIImageView new];
            open.image = IMAGE(@"orange_arrow");
            [_bgView addSubview:open];
            [open mas_makeConstraints:^(MASConstraintMaker *make) {
                make.width.height.mas_equalTo(24);
                make.top.equalTo(self.bgView).mas_offset(5);
                make.right.equalTo(self.bgView).mas_offset(-5);
            }];
            
            UIView *line = [UIView new];
            line.backgroundColor = LINE_COLOR;
            [_bgView addSubview:line];
            [line mas_makeConstraints:^(MASConstraintMaker *make) {
                make.height.mas_equalTo(.5f);
                make.left.equalTo(self.bgView).mas_offset(10);
                make.right.equalTo(self.bgView).mas_offset(-10);
                make.top.equalTo(open.mas_bottom).mas_offset(10);
            }];
            
            _bgView1 = [[UIView alloc] init];
            [_bgView addSubview:_bgView1];
            [_bgView1 mas_makeConstraints:^(MASConstraintMaker *make) {
                make.top.equalTo(line.mas_bottom).mas_offset(15);
                make.left.equalTo(self.bgView).mas_offset(14.5);
                make.right.equalTo(self.bgView).mas_offset(-14.5);
            }];
            
            
            _bgView2 = [[UIView alloc] init];
            [_bgView addSubview:_bgView2];
            [_bgView2 mas_makeConstraints:^(MASConstraintMaker *make) {
                make.top.equalTo(_bgView1.mas_bottom).mas_offset(15);
                make.left.equalTo(self.bgView).mas_offset(14.5);
                make.right.equalTo(self.bgView).mas_offset(-14.5);
                make.bottom.equalTo(self.bgView).mas_offset(-14.5);
            }];
            
            
            _countLabel1 = [UILabel makeLabel:^(LabelMaker *make) {
                make.textColor(LIGHT_BLACK_COLOR).font(FONT(13)).textAlignment(NSTextAlignmentRight).addToSuperView(self.bgView1);
            }];
            
            [_countLabel1 mas_makeConstraints:^(MASConstraintMaker *make) {
                make.right.top.equalTo(_bgView1);
            }];
            
            _medicineNameLabel1 = [UILabel makeLabel:^(LabelMaker *make) {
                make.textColor(TEXT_BLACK_COLOR).font(FONT(14)).textAlignment(NSTextAlignmentLeft).addToSuperView(self.bgView1);
            }];
            [_medicineNameLabel1 mas_makeConstraints:^(MASConstraintMaker *make) {
                make.left.top.equalTo(_bgView1);
                make.right.equalTo(_countLabel1.mas_left).mas_offset(-10);
            }];
            [self.countLabel1 setContentCompressionResistancePriority:UILayoutPriorityRequired forAxis:UILayoutConstraintAxisHorizontal];
            _specificationLabel1 = [UILabel makeLabel:^(LabelMaker *make) {
                  make.font(FONT(12)).addToSuperView(self.bgView1);
               }];
            
            [_specificationLabel1 mas_makeConstraints:^(MASConstraintMaker *make) {
                make.top.equalTo(_countLabel1.mas_bottom).mas_offset(12.5);
                make.right.equalTo(_bgView1);
            }];
            _organizationNameLabel1 = [UILabel makeLabel:^(LabelMaker *make) {
               make.textColor(TEXT_GRAY_COLOR_2).font(FONT(12)).addToSuperView(self.bgView1);
            }];
            [_organizationNameLabel1 mas_makeConstraints:^(MASConstraintMaker *make) {
        //        make.top.equalTo(_medicineNameLabel1.mas_bottom).mas_offset(12.5);
                make.centerY.equalTo(self.specificationLabel1);
                make.left.equalTo(_bgView1);
                make.right.equalTo(_specificationLabel1.mas_left).mas_offset(-10);
                make.bottom.equalTo(_bgView1);
            }];
            
            [self.specificationLabel1 setContentCompressionResistancePriority:UILayoutPriorityRequired forAxis:UILayoutConstraintAxisHorizontal];
            
            
            _countLabel2 = [UILabel makeLabel:^(LabelMaker *make) {
                   make.textColor(LIGHT_BLACK_COLOR).font(FONT(13)).textAlignment(NSTextAlignmentRight).addToSuperView(self.bgView2);
            }];

                
            [_countLabel2 mas_makeConstraints:^(MASConstraintMaker *make) {
                make.right.top.equalTo(_bgView2);
            }];
            
                
            _medicineNameLabel2 = [UILabel makeLabel:^(LabelMaker *make) {
                make.textColor(TEXT_BLACK_COLOR).font(FONT(14)).textAlignment(NSTextAlignmentLeft).addToSuperView(self.bgView1);
            }];
            [_medicineNameLabel2 mas_makeConstraints:^(MASConstraintMaker *make) {
                make.left.top.equalTo(_bgView2);
                make.right.equalTo(_countLabel2.mas_left).mas_offset(-10);
            }];
            [self.countLabel2 setContentCompressionResistancePriority:UILayoutPriorityRequired forAxis:UILayoutConstraintAxisHorizontal];
            _specificationLabel2 = [UILabel makeLabel:^(LabelMaker *make) {
                make.font(FONT(12)).addToSuperView(self.bgView2);
            }];
                
            [_specificationLabel2 mas_makeConstraints:^(MASConstraintMaker *make) {
                make.top.equalTo(_countLabel2.mas_bottom).mas_offset(12.5);
                make.right.equalTo(_bgView2);
            }];
            _organizationNameLabel2 = [UILabel makeLabel:^(LabelMaker *make) {
                make.textColor(TEXT_GRAY_COLOR_2).font(FONT(12)).addToSuperView(self.bgView2);
            }];
            [_organizationNameLabel2 mas_makeConstraints:^(MASConstraintMaker *make) {
        //        make.top.equalTo(_medicineNameLabel2.mas_bottom).mas_offset(12.5);
                make.centerY.equalTo(self.specificationLabel2);
                make.left.equalTo(_bgView2);
                make.right.equalTo(_specificationLabel2.mas_left).mas_offset(-10);
                make.bottom.mas_equalTo(_bgView2);
            }];
            
            [self.specificationLabel2 setContentCompressionResistancePriority:UILayoutPriorityRequired forAxis:UILayoutConstraintAxisHorizontal];
            
  
    
}

- (void)tapAction
{
    if (self.delegate && [self.delegate respondsToSelector:@selector(customMessageOperation:)])
    {
        TIMCustomElem *elem = (TIMCustomElem *)[self.model.message getElem:0];
        NSDictionary *dictionary =[NSJSONSerialization JSONObjectWithData:elem.data options:NSJSONReadingMutableLeaves error:nil];
        [self.delegate customMessageOperation:dictionary];
    }
}

#pragma mark - setter
- (void)setModel:(ChatCellModel *)model
{
    [super setModel:model];
    
    if (model.isSender) {
        _bgView.hidden = YES;
        _senderBgView.hidden = NO;
    }else{
        _senderBgView.hidden = YES;
        _bgView.hidden = NO;
    }

    _medicineNameLabel1.text = @"";
    _medicineNameLabel2.text = @"";
    _specificationLabel1.text = @"";
    _specificationLabel2.text = @"";
    _organizationNameLabel1.text = @"";
    _organizationNameLabel2.text = @"";
    _countLabel1.text = @"";
    _countLabel2.text = @"";
    
    _senderMedicineNameLabel1.text = @"";
    _senderMedicineNameLabel2.text = @"";
    _senderSpecificationLabel1.text = @"";
    _senderSpecificationLabel2.text = @"";
    _senderOrganizationNameLabel1.text = @"";
    _senderOrganizationNameLabel2.text = @"";
    _senderCountLabel1.text = @"";
    _senderCountLabel2.text = @"";
    
    TIMCustomElem *elem = (TIMCustomElem *)[self.model.message getElem:0];
    NSDictionary *dictionary =[NSJSONSerialization JSONObjectWithData:elem.data options:NSJSONReadingMutableLeaves error:nil];
    NSArray *dragList = dictionary[@"dragList"];
    
    if (dragList.count>1) {
        [_bgView2 mas_updateConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(self.bgView1.mas_bottom).mas_offset(15);
            make.bottom.equalTo(self.bgView).mas_offset(-14.5);
        }];
        [_senderBgView2 mas_updateConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(self.senderBgView1.mas_bottom).mas_offset(15);
            make.bottom.equalTo(self.senderBgView).mas_offset(-14.5);
        }];
        NSDictionary *dragDic1 = dragList[0];
        NSDictionary *dragDic2 = dragList[1];
        self.countLabel1.text = [NSString stringWithFormat:@"%@%@",[dragDic1 objectForKey:@"shippingQuantity"],[dragDic1 objectForKey:@"shippingUnitText"]];
        self.senderCountLabel1.text = [NSString stringWithFormat:@"%@%@",[dragDic1 objectForKey:@"shippingQuantity"],[dragDic1 objectForKey:@"shippingUnitText"]];
            self.medicineNameLabel1.text = [dragDic1 objectForKey:@"medicineName"];
            self.senderMedicineNameLabel1.text = [dragDic1 objectForKey:@"medicineName"];
        
            self.organizationNameLabel1.text = [dragDic1 objectForKey:@"medicineManufacturer"];
        self.senderOrganizationNameLabel1.text = [dragDic1 objectForKey:@"medicineManufacturer"];
        
            NSMutableAttributedString *str1 = [[NSMutableAttributedString alloc] initWithString:[NSString stringWithFormat:@"规格：%@",[dragDic1 objectForKey:@"standard"]]];
            [str1 addAttributes:@{NSForegroundColorAttributeName : TEXT_GRAY_COLOR_2} range:NSMakeRange(0, 3)];
            [str1 addAttributes:@{NSForegroundColorAttributeName : LIGHT_BLACK_COLOR} range:NSMakeRange(3, str1.length-3)];
            _specificationLabel1.attributedText = str1;
        _senderSpecificationLabel1.attributedText = str1;
            
            self.countLabel2.text = [NSString stringWithFormat:@"%@%@",[dragDic2 objectForKey:@"shippingQuantity"],[dragDic2 objectForKey:@"shippingUnitText"]];
        self.senderCountLabel2.text = [NSString stringWithFormat:@"%@%@",[dragDic2 objectForKey:@"shippingQuantity"],[dragDic2 objectForKey:@"shippingUnitText"]];
            self.medicineNameLabel2.text = [dragDic2 objectForKey:@"medicineName"];
        self.senderMedicineNameLabel2.text = [dragDic2 objectForKey:@"medicineName"];
            
            self.organizationNameLabel2.text = [dragDic2 objectForKey:@"medicineManufacturer"];
        self.senderOrganizationNameLabel2.text = [dragDic2 objectForKey:@"medicineManufacturer"];
            NSMutableAttributedString *str2 = [[NSMutableAttributedString alloc] initWithString:[NSString stringWithFormat:@"规格：%@",[dragDic2 objectForKey:@"standard"]]];
            [str2 addAttributes:@{NSForegroundColorAttributeName : TEXT_GRAY_COLOR_2} range:NSMakeRange(0, 3)];
            [str2 addAttributes:@{NSForegroundColorAttributeName : LIGHT_BLACK_COLOR} range:NSMakeRange(3, str2.length-3)];
            _specificationLabel2.attributedText = str2;
         _senderSpecificationLabel2.attributedText = str2;
    }
    else if(dragList.count == 1){
        NSDictionary *dragDic1 = dragList[0];
        self.countLabel1.text = [NSString stringWithFormat:@"%@%@",[dragDic1 objectForKey:@"shippingQuantity"],[dragDic1 objectForKey:@"shippingUnitText"]];
        self.senderCountLabel1.text = [NSString stringWithFormat:@"%@%@",[dragDic1 objectForKey:@"shippingQuantity"],[dragDic1 objectForKey:@"shippingUnitText"]];
            self.medicineNameLabel1.text = [dragDic1 objectForKey:@"medicineName"];
        self.senderMedicineNameLabel1.text = [dragDic1 objectForKey:@"medicineName"];
            
            self.organizationNameLabel1.text = [dragDic1 objectForKey:@"medicineManufacturer"];
        self.senderOrganizationNameLabel1.text = [dragDic1 objectForKey:@"medicineManufacturer"];

            NSMutableAttributedString *str1 = [[NSMutableAttributedString alloc] initWithString:[NSString stringWithFormat:@"规格：%@",[dragDic1 objectForKey:@"standard"]]];
            [str1 addAttributes:@{NSForegroundColorAttributeName : TEXT_GRAY_COLOR_2} range:NSMakeRange(0, 3)];
            [str1 addAttributes:@{NSForegroundColorAttributeName : LIGHT_BLACK_COLOR} range:NSMakeRange(3, str1.length-3)];
            _specificationLabel1.attributedText = str1;
        _senderSpecificationLabel1.attributedText = str1;
        [_bgView2 mas_updateConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(self.bgView1.mas_bottom);
            make.bottom.equalTo(self.bgView);
        }];
        [_senderBgView2 mas_updateConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(self.senderBgView1.mas_bottom);
            make.bottom.equalTo(self.senderBgView);
        }];
    }
    else{
        [_bgView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.width.mas_equalTo(SCREEN_WIDTH-130);
        }];
        [_senderBgView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.width.mas_equalTo(SCREEN_WIDTH-130);
        }];
    }
    
    
    
//    [self layoutIfNeeded];
}

@end
