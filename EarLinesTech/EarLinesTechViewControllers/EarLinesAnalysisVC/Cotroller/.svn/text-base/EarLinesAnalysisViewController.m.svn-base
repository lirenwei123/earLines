//
//  EarLinesAnalysisViewController.m
//  EarLinesTech
//
//  Created by  RWLi on 2018/4/10.
//  Copyright © 2018年  RWLi. All rights reserved.
//

#import "EarLinesAnalysisViewController.h"
#import "AnalysisResultViewController.h"
#import <Photos/Photos.h>
#import "analyseResultDataModels.h"



@interface EarLinesAnalysisViewController()<UIImagePickerControllerDelegate,UINavigationControllerDelegate>

    @property(nonatomic,strong)UIImage *leftImg;
    @property(nonatomic,strong)UIImage *rightImg;
    @property(nonatomic,strong)NSMutableArray *uploadImgs;
    @property(nonatomic,assign)BOOL isLeft;
    @property(nonatomic,assign)BOOL isAlum;

    @property(nonatomic,strong)UIImagePickerController *imgPicker;
    @property(nonatomic,assign)CGRect imgRect;
    @property(nonatomic,assign)int currentBtnTag;
    @property(nonatomic,strong)void (^completePhoto)(UIImage *photo);
    @property(nonatomic,assign)BOOL anayzeResult;
    
     @property(nonatomic,strong)UIImageView *juhuaView;
   @property(nonatomic,strong)NSTimer *donghuaTimer;

@end



@implementation EarLinesAnalysisViewController


-(void)viewDidLoad{
    [super viewDidLoad];
    _uploadImgs = @[].mutableCopy;
   
   _donghuaTimer =  [NSTimer scheduledTimerWithTimeInterval:0.1 target:self selector:@selector(amazing) userInfo:nil repeats:YES];
    _donghuaTimer.fireDate = [NSDate distantFuture];
}

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    if (_anayzeResult) {
        _anayzeResult = NO;
        [self initBtnState];
    }
}

-(void)addUI{
    self.navigationTitle.text = @"耳纹分析";
    CGFloat margin = 25;
    CGFloat top = 150;
    CGFloat w =SW/2 - margin*2;
    CGFloat h  = w;
    CGFloat corner = 5;
    
    UIButton * btn1  =[UIButton buttonWithType:UIButtonTypeSystem];
    btn1.frame = CGRectMake(margin, top, w, h);
    btn1.layer.cornerRadius = corner;
    [btn1 setTitle:@"请上传左耳照片" forState:0];
    [btn1 setTitleColor:[UIColor whiteColor] forState:0];
    btn1.clipsToBounds = YES;
    [btn1 setBackgroundImage:[UIImage imageNamed:@"img_bg"] forState:0];
    [btn1 setImage:[[UIImage imageNamed:@"img_l"]imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal] forState:UIControlStateNormal];
    btn1.contentHorizontalAlignment = UIControlContentHorizontalAlignmentCenter;//使图片和文字水平居中显示
    [btn1 setTitleEdgeInsets:UIEdgeInsetsMake(btn1.imageView.frame.size.height+w/4 ,-btn1.imageView.frame.size.width, 0.0,0.0)];//文字距离上边框的距离增加imageView的高度，距离左边框减少imageView的宽度，距离下边框和右边框距离不变
    [btn1 setImageEdgeInsets:UIEdgeInsetsMake(0.0, 0.0,0.0, -btn1.titleLabel.bounds.size.width)];//图片距离右边框距离减少图片的宽度，其它不边
    [btn1 addTarget:self action:@selector(Ear:) forControlEvents:UIControlEventTouchUpInside];
    btn1.tag = 100;
    [self.view addSubview:btn1];
    
    
    UIButton * btn2  =[UIButton buttonWithType:UIButtonTypeSystem];
    btn2.frame = CGRectMake(SW-margin-w, top, w, h);
    btn2.layer.cornerRadius = corner;
    [btn2 setTitle:@"请上传右耳照片" forState:0];
     [btn2 setTitleColor:[UIColor whiteColor] forState:0];
    [btn2 setBackgroundImage:[UIImage imageNamed:@"img_bg"] forState:0];
    btn2.clipsToBounds = YES;
    [btn2 setImage:[[UIImage imageNamed:@"img_r"]imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal] forState:UIControlStateNormal];
    btn2.contentHorizontalAlignment = UIControlContentHorizontalAlignmentCenter;//使图片和文字水平居中显示
    [btn2 setTitleEdgeInsets:UIEdgeInsetsMake(btn2.imageView.frame.size.height+w/4 ,-btn2.imageView.frame.size.width, 0.0,0.0)];//文字距离上边框的距离增加imageView的高度，距离左边框减少imageView的宽度，距离下边框和右边框距离不变
    [btn2 setImageEdgeInsets:UIEdgeInsetsMake(0.0, 0.0,0.0, -btn2.titleLabel.bounds.size.width)];//图片距离右边框距离减少图片的宽度，其它不边
    [btn2 addTarget:self action:@selector(Ear:) forControlEvents:UIControlEventTouchUpInside];
    btn2.tag = 200;
    [self.view addSubview:btn2];
    
    UIButton * btn3  =[UIButton buttonWithType:UIButtonTypeSystem];
    btn3.frame = CGRectMake(0,0,SW-margin*2,50);
    btn3.center = self.view.center;
    btn3.layer.cornerRadius = corner;
    btn3.clipsToBounds = YES;
    [btn3 setTitleColor:[UIColor whiteColor] forState:0];
    [btn3 setTitle:@"开始分析" forState:0];
    btn3.backgroundColor = [UIColor redColor];
    btn3.tag = 300;
    [btn3 addTarget:self action:@selector(Ear:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:btn3];
     WeakSelf
    self.completePhoto = ^(UIImage *photo) {
        if(weakSelf.isLeft){
            weakSelf.leftImg = photo;
            if (photo) {
                UIButton *leftB = [weakSelf.view viewWithTag:100];
                [leftB setBackgroundImage:photo forState:UIControlStateNormal];
                [leftB setTitle:@"" forState:UIControlStateNormal];
                [leftB setImage:nil forState:UIControlStateNormal];
                
                UploadParam *upImg = [[UploadParam alloc]init];
                upImg.data = UIImagePNGRepresentation(photo);
                upImg.name = @"left";
                upImg.filename = @"left.png";
                upImg.mimeType = @"image/png";
                [weakSelf.uploadImgs addObject:upImg];
                
            }
        }else{
            weakSelf.rightImg = photo;
            if (photo) {
                UIButton *rightB = [weakSelf.view viewWithTag:200];
                [rightB setBackgroundImage:photo forState:UIControlStateNormal];
                [rightB setTitle:@"" forState:UIControlStateNormal];
                [rightB setImage:nil forState:UIControlStateNormal];
                
                UploadParam *upImg = [[UploadParam alloc]init];
                upImg.data = UIImagePNGRepresentation(photo);
                upImg.name = @"right";
                upImg.filename = @"right.png";
                upImg.mimeType = @"image/png";
                [weakSelf.uploadImgs addObject:upImg];
            }
        }
       
    };
    
}

-(void)initBtnState{
    UIButton * btn1 = [self.view viewWithTag:100];
    [btn1 setTitle:@"请上传左耳照片" forState:0];
     [btn1 setImage:[[UIImage imageNamed:@"img_l"]imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal] forState:UIControlStateNormal];
    [btn1 setBackgroundImage:[UIImage imageNamed:@"img_bg"] forState:0];
    
    UIButton *btn2 = [self.view viewWithTag:200];
    [btn2 setTitle:@"请上传右耳照片" forState:0];
    [btn2 setImage:[[UIImage imageNamed:@"img_r"]imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal] forState:UIControlStateNormal];
    [btn2 setBackgroundImage:[UIImage imageNamed:@"img_bg"] forState:0];
    
    
}

-(void)Ear:(UIButton *)sender{
    NSInteger tag = sender.tag;
    switch (tag) {
        case 100:
        [self photoClickWithisLeft:YES];
        break;
        case 200:
         [self photoClickWithisLeft:NO];
        break;
        case 300:
        {
        if(self.uploadImgs.count>1){
//             [SVProgressHUD showWithStatus:@"正在分析"];
            [self startAmazing];
            sender.enabled = NO;
           
            WeakSelf
            [[EWKJRequest request]uploadWithAPIId:ear1 Icons:self.uploadImgs completed:^(id datas) {
                sender.enabled = YES;
                [weakSelf.uploadImgs removeAllObjects];
//                [SVProgressHUD dismiss];
                [weakSelf stopAmazing];
                if(datas){
                    if ([datas isKindOfClass:[NSDictionary class]]) {
                        NSDictionary *dict = (NSDictionary*)datas[Data];
                        if (dict) {
                            if ([dict[@"IsEar"]intValue] ==1 ) {
                                
                                if ([dict[@"IsNotUserEar"]intValue]) {
                                    [weakSelf alertWithString:@"该账号已经分析并绑定了耳朵，若要继续分析，请重新注册账号"];
                                    [weakSelf initBtnState];
                                }else{
                                    analyseResult *anayModel = [analyseResult modelObjectWithDictionary:dict];
                                    AnalysisResultViewController *result = [[AnalysisResultViewController alloc]init];
                                    result.resultModel = anayModel;
                                    result.ewImg = self.leftImg;
                                    [weakSelf.navigationController pushViewController:result animated:NO];
                                    weakSelf.anayzeResult = YES;
                                }
                            }else{
//                                [self alertWithString:@"请重新上传更清晰的耳朵照片"];
                                [weakSelf alertWithString:@"耳纹识别失败，请正对耳朵，务必区分左右耳，并确保耳朵在相框中部，请重试！"];
                                [weakSelf initBtnState];
                            
                            }
                        }
                        
                    }
                   
                }
            } error:^(NSError *error,NSInteger code) {
//                [SVProgressHUD dismiss];
                [weakSelf stopAmazing];
                [weakSelf.uploadImgs removeAllObjects];
                sender.enabled = YES;
                DebugLog(@"%@",error);
                
                [weakSelf initBtnState];
                [weakSelf TipWithErrorCode:code];
            }];
        }else{
            //请上传照片
            [self alertWithString:@"请上传左/右耳照片"];
        }
        
        }
        break;
        
        default:
        break;
    }
}

    
    

#pragma mark - 点击选择照片
- (void)photoClickWithisLeft:(BOOL)isleft{
       _isLeft = isleft;
      if([UIImagePickerController availableMediaTypesForSourceType:UIImagePickerControllerSourceTypeCamera]){
          self.imgPicker.sourceType = UIImagePickerControllerSourceTypeCamera;
           self.imgPicker.showsCameraControls = NO;
           self.imgPicker.cameraFlashMode = UIImagePickerControllerCameraFlashModeOff;
          [self.imgPicker updateFocusIfNeeded];
          
          if([UIImagePickerController isCameraDeviceAvailable:UIImagePickerControllerCameraDeviceRear]){
              self.imgPicker.cameraDevice = UIImagePickerControllerCameraDeviceRear;
              UIView *overlayView = [self overLayViewWithImgName:isleft?@"wl":@"wr" centerPoint:self.imgPicker.view.center isLeft:isleft];
              self.imgPicker.cameraOverlayView = overlayView;
              _isAlum = NO;
              
              CGSize screenBounds = [UIScreen mainScreen].bounds.size;
              
              CGFloat cameraAspectRatio = 4.0f/3.0f;
              
              CGFloat camViewHeight = screenBounds.width * cameraAspectRatio;
              
              CGFloat scale = screenBounds.height / camViewHeight;
              
              _imgPicker.cameraViewTransform = CGAffineTransformMakeTranslation(0, (screenBounds.height - camViewHeight) / 2.0);
              
              _imgPicker.cameraViewTransform = CGAffineTransformScale(_imgPicker.cameraViewTransform, scale, scale);
              
              [self presentViewController:self.imgPicker animated:YES completion:nil];
          }
      }else{
          if([UIImagePickerController availableMediaTypesForSourceType:UIImagePickerControllerSourceTypeSavedPhotosAlbum]){
              self.imgPicker.sourceType = UIImagePickerControllerSourceTypeSavedPhotosAlbum;
              _isAlum = YES;
              [self presentViewController:self.imgPicker animated:YES completion:nil];
          }
      }
}
    

#pragma mark - UIImagePickerControllerDelegate
- (void)imagePickerControllerDidCancel:(UIImagePickerController *)picker{
    [self.imgPicker dismissViewControllerAnimated:NO completion:nil];
}
- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary<NSString *,id> *)info{
    [picker dismissViewControllerAnimated:NO completion:nil];
    UIImage *Img = [info objectForKey:UIImagePickerControllerOriginalImage];
    UIImage * EditImg = [self reSizeImage:Img];
    if (_completePhoto) {
        _completePhoto(EditImg);
    }

        //保存图片到相册
    if(!_isAlum){
        [[PHPhotoLibrary sharedPhotoLibrary]performChanges:^{
            [PHAssetChangeRequest creationRequestForAssetFromImage:EditImg];
        } completionHandler:^(BOOL success, NSError * _Nullable error) {
            if (error) {
                DebugLog(@"保存相片错误");
            }
        }];
    }
    
}
    
#pragma mark -
    
-(UIImagePickerController *)imgPicker{
    if (!_imgPicker) {
        _imgPicker =  [[UIImagePickerController alloc]init];
        _imgPicker.delegate = self;
        _imgPicker.modalTransitionStyle = UIModalTransitionStyleCoverVertical;
       
    }
    return _imgPicker;
}
    
    
-(CGRect)imgRectWithCenter:(CGPoint)center imgsize:(CGSize)imgSize{
    CGFloat w = SW/3;
    CGFloat rate =  w/imgSize.width;
    CGFloat h = imgSize.height*rate;
    CGRect rect = CGRectMake(center.x-w/2, center.y-40-h/2, w, h);
//    CGRect rect = CGRectMake(center.x-w/2, 140, w, h);
    _imgRect =  rect;
    return _imgRect;
}
    
-(UIView*)overLayViewWithImgName:(NSString *)imgname centerPoint:(CGPoint)centerP isLeft:(BOOL)isleft{
    
    UIView * OverlayView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, CGRectGetWidth(self.imgPicker.view.frame), CGRectGetHeight(self.imgPicker.view.frame))];
    OverlayView.backgroundColor = [UIColor clearColor];
    
    UIButton *cancell = [[UIButton alloc]initWithFrame:CGRectMake(OverlayView.frame.size.width-100, 20, 80, 30)];
    [cancell setTitle:@"取消" forState:0];
    cancell.backgroundColor = [UIColor clearColor];
    [cancell addTarget:self action:@selector(cancellClick:) forControlEvents:UIControlEventTouchUpInside];
    [OverlayView addSubview:cancell];
    
    UIImage *ewimg = [UIImage imageNamed:imgname];
    UIImageView *imgv = [[UIImageView alloc]initWithImage:ewimg];
    CGRect imgrect = [self imgRectWithCenter:centerP imgsize:ewimg.size];
    imgv.frame = imgrect;
    [OverlayView addSubview:imgv];
    
    UILabel *tip = [[UILabel alloc]initWithFrame:CGRectMake(0, CGRectGetMaxY(imgrect)+20, SW, 30)];
    tip.backgroundColor = [UIColor clearColor];
    tip.textAlignment = NSTextAlignmentCenter;
    tip.text = isleft?@"请对准左耳拍摄":@"请对准右耳拍摄";
    tip.font = EWKJfont(15);
    tip.textColor = RGB(0xe8,1, 1);
    [OverlayView addSubview:tip];
    
        //相册 拍照 旋转
    CGFloat wh = 50;
    CGFloat magin = (SW-15*2-3*wh)/2;
    NSArray *imgNames = @[@"camera_1",@"camera",@"images"];
    for(int i = 0 ;i<3 ;i++){
        UIButton * btn = [[UIButton alloc]initWithFrame:CGRectMake(15+i*(wh+magin), CGRectGetHeight(OverlayView.frame)-30-wh, wh, wh)];
        btn.backgroundColor = [UIColor cyanColor];
        [btn addTarget:self action:@selector(photoBtn:) forControlEvents:UIControlEventTouchUpInside];
        [btn setBackgroundImage:[UIImage imageNamed:imgNames[i]] forState:UIControlStateNormal];
        [btn setBackgroundColor:[UIColor clearColor]];
        btn.tag = i;
        if(i==1){
            _currentBtnTag = i;
        }
        [OverlayView addSubview:btn];
    }
    
    return OverlayView;
}


-(void)cancellClick:(UIButton*)sender{
    [self  imagePickerControllerDidCancel:self.imgPicker];
}
-(void)photoBtn:(UIButton *)sender{
        NSInteger tag = sender.tag;
    _isAlum = NO;
        switch (tag) {
            case 0:
            if(_currentBtnTag == 1){
                if([UIImagePickerController isCameraDeviceAvailable:UIImagePickerControllerCameraDeviceFront]){
                    self.imgPicker.modalTransitionStyle = UIModalTransitionStyleFlipHorizontal;
                    self.imgPicker.cameraDevice = UIImagePickerControllerCameraDeviceFront;
                    _currentBtnTag = 0;
                }
            }else{
                if([UIImagePickerController isCameraDeviceAvailable:UIImagePickerControllerCameraDeviceRear]){
                     self.imgPicker.modalTransitionStyle = UIModalTransitionStyleCoverVertical;
                    self.imgPicker.cameraDevice = UIImagePickerControllerCameraDeviceRear;
                    _currentBtnTag = 1;
                }
            }
            break;
            case 1:
            [self.imgPicker takePicture];
            break;
            case 2:
              if([UIImagePickerController availableMediaTypesForSourceType:UIImagePickerControllerSourceTypeSavedPhotosAlbum]){
                  self.imgPicker.sourceType = UIImagePickerControllerSourceTypeSavedPhotosAlbum;
                  _isAlum = YES;
              }
            break;
            
            default:
            break;
        }
}


- (UIImage *)reSizeImage:(UIImage *)image
{
    UIGraphicsBeginImageContext(CGSizeMake(720,1080));
    [image drawInRect:CGRectMake(0, 0, 720, 1080)];
    UIImage *reSizeImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    return reSizeImage;
    
}


-(void)amazing{
    self.juhuaView.transform = CGAffineTransformTranslate(_juhuaView.transform, 0,10);
    self.juhuaView.transform = CGAffineTransformRotate(_juhuaView.transform, M_PI/8);
}
-(void)startAmazing{
   
    self.donghuaTimer.fireDate = [NSDate distantPast];
}

-(void)stopAmazing{
    _donghuaTimer.fireDate = [NSDate distantFuture];
    [_juhuaView removeFromSuperview];
    _juhuaView = nil;
}

-(UIImageView *)juhuaView{
    if (!_juhuaView) {
        _juhuaView = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, 100, 100)];
        _juhuaView.image = [UIImage imageNamed:@"a_banner_bg"];
        _juhuaView.center = self.view.center;
        _juhuaView.clipsToBounds = YES;
        _juhuaView.layer.cornerRadius  = 50;
         [self.view addSubview:_juhuaView];
    }
    return _juhuaView;
}

@end
