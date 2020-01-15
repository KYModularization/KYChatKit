//
//  EnumMacro.h
//  KYKJInternetDoctor
//
//  Created by KuaiYi on 2018/11/7.
//  Copyright © 2018年 快医科技. All rights reserved.
//

#ifndef EnumMacro_h
#define EnumMacro_h

typedef NS_ENUM(NSInteger, EditType) {
    EditTypeUsage = 0,
    EditTypeFrequence = 1
};
typedef NS_ENUM(NSInteger, DiagnosisInputTextViewType) {
    DiagnosisInputTextViewEndType = 0,
    DiagnosisInputTextViewTemplatType = 1 ,
    DiagnosisInputTextViewApplyType = 2
};
typedef NS_ENUM(NSInteger, QuickPrescriptionViewType) {
    QuickPrescriptionViewAddQuickPresciptionType = 0,  //开具快速处方
    QuickPrescriptionViewAddPatientType = 1,           //填写患者信息
    QuickPrescriptionViewNormalType = 2 ,               //展示患者信息
    QuickPrescriptionViewAddVisitPatientType = 3                //复诊患者添加
};
typedef NS_ENUM (NSUInteger, PRESCRIPTION_TYPE){
    STANDARD_PRESCRIPTION = 0,
    E_PRESCRIPTION = 1,
    RETURN_VISIT_PRESCRIPTION = 2,
};
typedef NS_ENUM(NSUInteger,SCHEDULE_TYPE){
    All_SCHEDULE_TYPE = 0,
    CYCLE_SCHEDULE_TYPE = 1,
};
typedef NS_ENUM(NSUInteger,TEMPLATE_TYPE){
    DRUG_TEMPLATE_TYPE = 0,
    RECIPE_TEMPLATE_TYPE = 1,
};

typedef NS_ENUM(NSInteger, TIP_YEPE) {
    REVISIT_TIP_TYPE = 0,
    PHARMACY_TIP_TYPE = 1
};

#endif /* EnumMacro_h */
