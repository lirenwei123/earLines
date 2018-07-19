//
//  EWKJBtn
//  initVC
//
//  Created by QianLong on 2017/9/5.
//  Copyright © 2017年 lrw. All rights reserved.
//

#import "EWKJBtn.h"




@interface EWKJBtn ()
@property(nonatomic,strong)UIImage * disableIMG;
@property(nonatomic,strong)UIImage * ableIMG;
@property(nonatomic,strong)UIImage * clickedIMG;

@end


@implementation EWKJBtn

#define W frame.size.width
#define H frame.size.height
-(instancetype)initWithFrame:(CGRect)frame  img:(UIImage *)img title:(NSString *)title touchEvent:(T)event andbtnType:(BTNTYPE)type{
    if (self = [super initWithFrame:frame]) {
        UIImageView *imgv = [[UIImageView alloc]initWithFrame:CGRectMake(W*0.4-H*0.5, H*0.25, H*0.5, H*0.5)];
        imgv.image = img;
        UILabel *lab = [[UILabel alloc]initWithFrame:CGRectMake(W*0.5, H*0.1, W*0.5, H*0.8)];
        lab.text  = title;
        lab.textAlignment = NSTextAlignmentCenter;
        _lab = lab;
        _imgv = imgv;
        if (type == BTNTYPELR) {
            lab.textAlignment = NSTextAlignmentLeft;
        CGRect rect = [lab.text boundingRectWithSize:CGSizeMake(MAXFLOAT,fontsize) options:NSStringDrawingUsesFontLeading attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:fontsize]} context:nil];
            CGFloat leftMagrgin = (W-rect.size.width - H*0.5-5)*0.5;
            imgv.frame = CGRectMake(leftMagrgin, H*0.25, H*0.5, H*0.5);
            lab.frame = CGRectMake(leftMagrgin +5+H*0.5, H*0.1, rect.size.width, H*0.8);
            [self addSubview:imgv];
            [self addSubview:lab];
        }
        else if (type == BTNTYPERL) {
            lab.textAlignment = NSTextAlignmentLeft;
            lab.frame = CGRectMake(0, 0, W-15, H);
            imgv.frame = CGRectMake(W-10,(H-20)/2,10,20);
            [self addSubview:imgv];
            [self addSubview:lab];
        }
        else if (type == BTNTYPEUD) {
            imgv.frame = CGRectMake(W*0.25, H*0.1,W*0.5,H*0.5 );
            lab.frame = CGRectMake(0, H*0.6, W, H*0.4);
            [self addSubview:imgv];
            [self addSubview:lab];
        }
       else if (type == BTNTYPEIMG) {
            imgv.frame = CGRectMake(W*0.1, H*0.1,W*0.8,H*0.8 );
            [self addSubview:imgv];
        }
       else if (type == BTNTYPETEXT) {
            lab.frame = CGRectMake(W*0.1, H*0.2,W*0.8,H*0.6 );
            [self addSubview:lab];
        }
       else if (type == BTNTYPEEWKJ){
           lab.frame = self.bounds;
           lab.backgroundColor = [UIColor clearColor];
           lab.textColor = [UIColor whiteColor];
           lab.font = EWKJboldFont(16);
           imgv.frame = self.bounds;
           imgv.image = img;
           [self addSubview:imgv];
           [self addSubview:lab];
       }
       else if (type == BTNTYPEEWKJ_share){
           lab.textAlignment = NSTextAlignmentLeft;
           imgv.frame = CGRectMake(10,12, 20,20);
           lab.frame = CGRectMake(10+20+12, 0,W-42, H);
           [self addSubview:imgv];
           [self addSubview:lab];
       }
       else if (type == BTNTYPEOTHER) {
            imgv.frame = CGRectMake(W*0.1, H*0.3,H*0.8,H*0.8 );
            lab.frame = CGRectMake(H*0.8+W*0.2, H*0.2, W-H*0.8-W*0.2, H*0.6);
            lab.textAlignment = NSTextAlignmentLeft;
            CGPoint center1 = lab.center;
            center1.y = imgv.center.y;
            lab.center = center1;
            [self addSubview:imgv];
            [self addSubview:lab];
        }
       else if (type == BTNTYPEEWKJ_personalCenter_rightdetail){
           imgv.frame  = CGRectMake(0, H*0.25, H*0.5, H*0.5);
           lab.frame = CGRectMake(H*0.5 +8, 0, 200, H);
           lab.textAlignment = NSTextAlignmentLeft;
           
           UILabel *rightLab = [[UILabel alloc]initWithFrame:CGRectMake(W-37, (H-20)/2, 20, 20)];
           rightLab.backgroundColor = COLOR(0xde);
           rightLab.textColor = COLOR(0x33);
           rightLab.font = EWKJfont(13);
           rightLab.clipsToBounds = YES;
           rightLab.layer.cornerRadius = 10;
           rightLab.textAlignment = NSTextAlignmentCenter;
           _rightDetailLab = rightLab;
           
           UIImageView *rightIMGV =  [[UIImageView alloc]initWithFrame:CGRectMake(W-10, (H-20)/2, 10, 20)];
           rightIMGV.image  =  [UIImage imageNamed:@"Personal_l"];
           [self addSubview:rightIMGV];
           rightIMGV.userInteractionEnabled = YES;
           
           [self addSubview:lab];
           [self addSubview:imgv];
           [self addSubview:rightIMGV];
           [self addSubview:_rightDetailLab];
       }
       else if (type == BTNTYPEEWKJ_personalCenter){
           imgv.frame  = CGRectMake(0, H*0.25, H*0.5, H*0.5);
           lab.frame = CGRectMake(H*0.5 +8, 0, 200, H);
           lab.textAlignment = NSTextAlignmentLeft;
           UIImageView *rightIMGV =  [[UIImageView alloc]initWithFrame:CGRectMake(W-10, (H-20)/2, 10, 20)];
           rightIMGV.image  =  [UIImage imageNamed:@"Personal_l"];
           [self addSubview:rightIMGV];
           rightIMGV.userInteractionEnabled = YES;
           [self addSubview:lab];
           [self addSubview:imgv];
           [self addSubview:rightIMGV];
       }else if (type == BTNTYPE_mallClass){
           imgv.frame = CGRectMake(0, 0,W,60 );
           lab.frame = CGRectMake(0, 60, W, H-60);
           
           lab.font = EWKJfont(12);
           lab.textColor = COLOR(0x66);
           [self addSubview:imgv];
           [self addSubview:lab];
       }
    }
    
    _touchEvent = event;
    return self;
}


-(instancetype)initWithFrame:(CGRect)frame   titleLeft:(NSString *)titleL titleRight:(NSString *)titleR touchEvent:(T)event {
    if (self = [super initWithFrame:frame]) {
        
        CGRect rect = [titleR boundingRectWithSize:CGSizeMake(MAXFLOAT, fontsize) options:NSStringDrawingUsesFontLeading attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:fontsize]} context:nil];
        CGRect rect1 = [titleL boundingRectWithSize:CGSizeMake(MAXFLOAT, fontsize) options:NSStringDrawingUsesFontLeading attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:fontsize]} context:nil];
    
       CGFloat margin =  (frame.size.width - rect.size.width - rect1.size.width)*0.5;
        
        UILabel *lab = [[UILabel alloc]initWithFrame:CGRectMake(margin+rect1.size.width, 0, rect.size.width, H)];
        lab.text  = titleR;
        lab.textAlignment = NSTextAlignmentLeft;
        lab.font = [UIFont systemFontOfSize:fontsize];
        _lab = lab;
        _lab.backgroundColor = [UIColor clearColor];
        [self addSubview:_lab];
        
        UILabel *lab1 = [[UILabel alloc]initWithFrame:CGRectMake(margin, 0, rect1.size.width, H)];
        lab1.text  = titleL;
        lab1.textAlignment = NSTextAlignmentRight;
        lab1.font = [UIFont systemFontOfSize:fontsize];
        lab1.backgroundColor = [UIColor clearColor];
        [self addSubview:lab1];
        _otherLab = lab1;
        
       
    }
     _touchEvent = event;
    return self;
}




-(instancetype)initWithFrame:(CGRect)frame normalImg:(UIImage *)img1 clickedImage:(UIImage *)clickImg disableImg:(UIImage *)img2 title:(NSString *)title touchEvent:(T)event andbtnType:(BTNTYPE)type{
    _disableIMG = img2;
    _ableIMG = img1;
    _clickedIMG = clickImg;
   return  [self initWithFrame:frame img:img1 title:title touchEvent:event andbtnType:type];
    
}


-(instancetype)initEWKJDetailBtnFrame:(CGRect)frame Title:(NSString *)title touchEvent:(T)event{
 
    if (self = [super initWithFrame:frame]) {
        UIImageView *imgv = [[UIImageView alloc]initWithFrame:CGRectMake(W-20,(H-20)/2, 10, 20)];
        UIImage* image = [UIImage imageNamed:@"Personal_l"];
        if (image) {
            imgv.image =  image;
        }
        imgv.userInteractionEnabled = YES;
        
        UILabel *lab = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, W-30, H)];
        lab.text  = title;
        lab.textAlignment = NSTextAlignmentRight;
        lab.textColor =  [UIColor grayColor];
        lab.font = [UIFont boldSystemFontOfSize:fontsize];
        _lab = lab;
        _imgv = imgv;
        [self addSubview:_lab];
        [self addSubview:_imgv];
        
    }
    _touchEvent = event;
    return self;
}

-(instancetype)initEWKJDetailBtnFrame:(CGRect)frame ImageName:(NSString *)imgName touchEvent:(T)event{
    if (self = [super initWithFrame:frame]) {
        UIImageView *imgv = [[UIImageView alloc]initWithFrame:CGRectMake(W-20,(H-20)/2, 10, 20)];
        UIImage* image = [UIImage imageNamed:@"Personal_l"];
        if (image) {
            imgv.image =  image;
        }
        imgv.userInteractionEnabled =YES;
        
        
        UIImageView *leftImgv =  [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, H, H)];
        UIImage* imageleft = [UIImage imageNamed:imgName];
        if (imageleft) {
            leftImgv.image =  imageleft;
        }
        leftImgv.clipsToBounds = YES;
        leftImgv.layer.cornerRadius = H/2;
        leftImgv.userInteractionEnabled = YES;
        _imgv = leftImgv;
        [self addSubview:imgv];
        [self addSubview:leftImgv];
    }
    _touchEvent = event;
    return self;
}

-(void)setBtnState:(BTNCONTOLSTATE)btnState{
    _btnState = btnState;
    if (_btnState == BTNCONTOLDISABLE) {
        self.userInteractionEnabled = NO;
        if (_disableIMG) {
            _imgv.image = _disableIMG;
        }
    }else if (_btnState == BTNCONTOLNORMAL ){
        self.userInteractionEnabled = YES;
        if (_ableIMG) {
            _imgv.image = _ableIMG;
        }
    }

                                             
}

-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
   
    if (_clickedIMG) {
        _imgv.image = _clickedIMG;
    }


}


-(void)touchesEnded:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    
    if (_touchEvent) {
        _touchEvent(self);
    }
    
    if (_ableIMG) {
        _imgv.image = _ableIMG;
    }


}


@end
