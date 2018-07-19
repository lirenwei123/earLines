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
   self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"选择照片"
                                                             style:UIBarButtonItemStylePlain
                                                            target:self
                                                            action:@selector(changePhoto)];
    self.navigationItem.rightBarButtonItem.tintColor = [UIColor whiteColor];
    
    

    
    
}

-(void)changePhoto{
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
        UploadParam *upImg = [[UploadParam alloc]init];
        upImg.data = UIImagePNGRepresentation(img);
        upImg.name = @"head";
        upImg.filename = @"head.png";
        upImg.mimeType = @"image/png";
        WeakSelf
        [[EWKJRequest request]uploadWithAPIId:user23 Icons:@[upImg] completed:^(id datas) {
            if (datas) {
                NSDictionary *dic = (NSDictionary*)datas;
                USERBaseClass *user = [USERBaseClass user];
                user.imageUrl = dic[Data][@"ImageUrl"];
                [NSKeyedArchiver archiveRootObject:user toFile:USERINFOPATH];
            }
            
        } error:^(NSError *error) {
            if (error) {
                [weakSelf alertWithString:[NSString stringWithFormat:@"%@",error]];
            }
        }];
    }
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
