//
//  selectHeadPhotoCtrl.m
//  EarLinesTech
//
//  Created by apple   on 2018/4/19.
//  Copyright © 2018年  RWLi. All rights reserved.
//

#import "selectHeadPhotoCtrl.h"
#import "USERBaseClass.h"

@interface selectHeadPhotoCtrl ()<UINavigationControllerDelegate,UIImagePickerControllerDelegate>
@property(nonatomic,strong)UIImagePickerController *imgPicker;
@property(nonatomic,strong)UIImage *currentImg;
@property(nonatomic,strong)void (^changeHead)(UIImage *);
@end

@implementation selectHeadPhotoCtrl

-(instancetype)initWithimg:(UIImage *)head complechangeHead:(void (^)(UIImage *))comleteChangeHead{
    if (self == [super init]) {
        _currentImg = head;
        _changeHead = comleteChangeHead;
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

-(void)addUI{
    self.navigationTitle.text = @"头像";
    self.view.backgroundColor = [UIColor blackColor];
    
    UIImageView *imgV = [[UIImageView alloc]initWithFrame:CGRectMake(0, (SH-SW)/2, SW, SW)];
//    imgV.image = _headPhoto;
    
    imgV.image = _currentImg;
    imgV.tag = 100;
    [self.view addSubview:imgV];
    
    
    //增加右上角菜单
    
    [self addRightBtnWithtitle:@"选择照片"];
  
    
    

    
    
}

-(void)rightNavitemCLick{
    UIAlertController *alerVC = [[UIAlertController alloc]init];
    UIAlertAction *photoAction = [UIAlertAction actionWithTitle:@"拍照" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        if([UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera]){
            self.imgPicker.sourceType = UIImagePickerControllerSourceTypeCamera;
            [self presentViewController:self.imgPicker animated:YES completion:nil];
        }
    }];
    UIAlertAction * blumAction = [UIAlertAction actionWithTitle:@"从手机相册选择" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
         if([UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeSavedPhotosAlbum]){
        self.imgPicker.sourceType = UIImagePickerControllerSourceTypeSavedPhotosAlbum;
        [self presentViewController:self.imgPicker animated:YES completion:nil];
         }
        
    }];
    UIAlertAction *cancellAction  = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:nil];
    
    [alerVC addAction:photoAction];
    [alerVC addAction:blumAction];
    [alerVC addAction:cancellAction];
    [self presentViewController:alerVC animated:YES completion:nil];
}

#pragma mark -UIImagePickerControllerDelegate
- (void)imagePickerControllerDidCancel:(UIImagePickerController *)picker{
    [self.imgPicker dismissViewControllerAnimated:NO completion:nil];
}
- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary<NSString *,id> *)info{
    
    UIImage *img = [info objectForKey:UIImagePickerControllerOriginalImage];
    
    [self.imgPicker dismissViewControllerAnimated:NO completion:nil];
    if (img) {
        if (_changeHead) {
            _changeHead(img);
        }
        
        
        UIImageView *imgv = [self.view viewWithTag:100];
        imgv.image = img;
        //网络上传
        //处理下图片大小
        UIImage *useImg = [self reSizeImage:img toSize:CGSizeMake(SW, SW*img.scale)];
        UploadParam *upImg = [[UploadParam alloc]init];
        upImg.data = UIImagePNGRepresentation(useImg);
        upImg.name = @"head";
        upImg.filename = @"head.png";
        upImg.mimeType = @"image/png";
        WeakSelf
//        更新用户头像 如何上传头像： 1. 调用API api/file/upload (header需要带上 Token ClientId UuId, body需要带上 FILETYPE = 1 及上传的文件) 2. 调用完此接口后会返回上传文件的URL 3. 然后再调用此接口修改用户的头像
        [SVProgressHUD showWithStatus:@"正在上传头像，请稍后 ..."];
        [HttpRequest lirw_uploadWithURLString: [NSString stringWithFormat:@"%@user/file/upload",httpHead] parameters:@{@"FileType":@"1"}.mutableCopy uploadParams:@[upImg] success:^(id responseObject) {
            
            if (responseObject) {
                NSDictionary *imgUrlDic = responseObject[Data];
                if (imgUrlDic) {
                    
                    [[EWKJRequest request]requestWithAPIId:user23 httphead:nil bodyParaDic:imgUrlDic completed:^(id datas) {
                        [SVProgressHUD dismiss];
                        [weakSelf alertWithString:@"上传用户头像成功"];
                        //更新本地头像
                        USERBaseClass *user = [USERBaseClass user];
                        user.imageUrl = imgUrlDic[@"ImageUrl"];
                        [NSKeyedArchiver archiveRootObject:user toFile:USERINFOPATH];
                    } error:^(NSError *error, NSInteger statusCode) {
                        [SVProgressHUD dismiss];
                         [weakSelf alertWithString:@"上传用户头像失败！"];
                    }];
                }
            }
            
        } failure:^(NSError *error, NSInteger errorCode) {
            
            [weakSelf TipWithErrorCode:errorCode];
            [SVProgressHUD dismiss];
        }];
        
        
       
    
    }
}

- (UIImage *)reSizeImage:(UIImage *)image toSize:(CGSize)reSize
{
    UIGraphicsBeginImageContext(CGSizeMake(reSize.width, reSize.height));
    [image drawInRect:CGRectMake(0, 0, reSize.width, reSize.height)];
    UIImage *reSizeImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    return reSizeImage;
    
}


-(UIImagePickerController *)imgPicker{
    if (!_imgPicker) {
        _imgPicker =  [[UIImagePickerController alloc]init];
        _imgPicker.delegate = self;
    }
    return _imgPicker;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
