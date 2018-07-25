//
//  EWKJShare.m
//  EarLinesTech
//
//  Created by apple   on 2018/4/25.
//  Copyright © 2018年  RWLi. All rights reserved.
//

#import "EWKJShare.h"

#import <UIKit/UIKit.h>

@implementation EWKJShare

+(instancetype)share{
    static EWKJShare *share ;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        share = [[EWKJShare alloc]init];
    });
    return share;
}

-(void)shareWithJSHAREPlatform:(JSHAREPlatform)platform JSHAREMediaType:(JSHAREMediaType)type complete:(void(^)(JSHAREState state, NSError *error))complete {
    _completeBlock = complete;
            switch (type) {
                case JSHAREText:
                    [self shareTextWithPlatform:platform];
                    break;
                case JSHAREImage:
                    [self shareImageWithPlatform:platform];
                    break;
                case JSHARELink:
                    [self shareLinkWithPlatform:platform];
                    break;
                case JSHAREAudio:
                    [self shareMusicWithPlatform:platform];
                    break;
                case JSHAREVideo:
                    [self shareVideoWithPlatform:platform];
                    break;
                case JSHAREApp:
                    [self shareAppWithPlatform:platform];
                    break;
                case JSHAREEmoticon:
                    [self shareEmoticonWithPlatform:platform];
                    break;
                case JSHAREFile:
                    [self shareFileWithPlatform:platform];
                    break;
                default:
                    [self getUserInfoWithPlatform:platform];
                    break;
            }
    
}

-(void)shareLinkWithJSHAREPlatform:(JSHAREPlatform)platform JSHAREMessage:(JSHAREMessage*)message complete:(void(^)(JSHAREState state, NSError *error))complete{
     [self shareLinkWithPlatform:platform andMessage:message];
}

-(void)shareWithJSHAREPlatform:(JSHAREPlatform)platform imgData:(NSData *)data complete:(void (^)(JSHAREState, NSError *))complete{
    _completeBlock = complete;
    [self shareImageWithPlatform:platform andImgData:data];
}

- (void)shareTextWithPlatform:(JSHAREPlatform)platform {
    JSHAREMessage *message = [JSHAREMessage message];
    message.text = [NSString stringWithFormat:@"时间:%@ JShare SDK支持主流社交平台、帮助开发者轻松实现社会化功能！",[self localizedStringTime]];
    message.platform = platform;
    message.mediaType = JSHAREText;
    WeakSelf
    [JSHAREService share:message handler:^(JSHAREState state, NSError *error) {
        if (weakSelf.completeBlock) {
            weakSelf.completeBlock(state,error);
        }
    }];
}

- (void)shareImageWithPlatform:(JSHAREPlatform)platform {
    JSHAREMessage *message = [JSHAREMessage message];
    NSData *imageData = UIImagePNGRepresentation([UIImage imageNamed:@"index_banner.jpg"]);
    message.mediaType = JSHAREImage;
    message.text = [NSString stringWithFormat:@"时间:%@ JShare SDK支持主流社交平台、帮助开发者轻松实现社会化功能！",[self localizedStringTime]];
    message.platform = platform;
    message.image = imageData;
    
    
    
    /*QQ 空间 / Facebook/Messenger /Twitter 支持多张图片
     1.QQ 空间图片数量限制为20张。若只分享单张图片使用 image 字段即可。
     2.Facebook/Messenger 图片数量限制为6张。如果分享单张图片，图片大小建议不要超过12M；如果分享多张图片，图片大小建议不要超过700K，否则可能出现重启手机或者不能分享。
     3、Twitter最多支持4张*/
    
        //message.images = @[imageData,imageData];
    WeakSelf
    [JSHAREService share:message handler:^(JSHAREState state, NSError *error) {
        if (weakSelf.completeBlock) {
            weakSelf.completeBlock(state,error);
        }
    }];
}

- (void)shareImageWithPlatform:(JSHAREPlatform)platform andImgData:(NSData*)imgdata {
    JSHAREMessage *message = [JSHAREMessage message];
    message.mediaType = JSHAREImage;
    message.text = [NSString stringWithFormat:@"时间:%@ JShare SDK支持主流社交平台、帮助开发者轻松实现社会化功能！",[self localizedStringTime]];
    message.platform = platform;
    message.image = imgdata;
    
    /*QQ 空间 / Facebook/Messenger /Twitter 支持多张图片
     1.QQ 空间图片数量限制为20张。若只分享单张图片使用 image 字段即可。
     2.Facebook/Messenger 图片数量限制为6张。如果分享单张图片，图片大小建议不要超过12M；如果分享多张图片，图片大小建议不要超过700K，否则可能出现重启手机或者不能分享。
     3、Twitter最多支持4张*/
    
    //message.images = @[imageData,imageData];
    WeakSelf
    [JSHAREService share:message handler:^(JSHAREState state, NSError *error) {
        if (weakSelf.completeBlock) {
            weakSelf.completeBlock(state,error);
        }
    }];
}
- (void)shareLinkWithPlatform:(JSHAREPlatform)platform {
    JSHAREMessage *message = [JSHAREMessage message];
    message.mediaType = JSHARELink;
    message.url = @"https://www.jiguang.cn/";
    message.text = [NSString stringWithFormat:@"时间:%@ JShare SDK支持主流社交平台、帮助开发者轻松实现社会化功能！",[self localizedStringTime]];
    message.title = @"欢迎使用极光社会化组件JShare";
    message.platform = platform;
    NSString *imageURL = @"http://img2.3lian.com/2014/f5/63/d/23.jpg";
    NSData *imageData = [NSData dataWithContentsOfURL:[NSURL URLWithString:imageURL]];
    
    message.image = imageData;
    WeakSelf
    [JSHAREService share:message handler:^(JSHAREState state, NSError *error) {
        if (weakSelf.completeBlock) {
            weakSelf.completeBlock(state,error);
        }
    }];
}

- (void)shareLinkWithPlatform:(JSHAREPlatform)platform andMessage:(JSHAREMessage*)message{
    WeakSelf
    [JSHAREService share:message handler:^(JSHAREState state, NSError *error) {
        if (weakSelf.completeBlock) {
            weakSelf.completeBlock(state,error);
        }
    }];
}

- (void)shareMusicWithPlatform:(JSHAREPlatform)platform {
    JSHAREMessage *message = [JSHAREMessage message];
    message.mediaType = JSHAREAudio;
    message.url =  @"https://y.qq.com/n/yqq/song/003RCA7t0y6du5.html";
    message.text = [NSString stringWithFormat:@"时间:%@ JShare SDK支持主流社交平台、帮助开发者轻松实现社会化功能！",[self localizedStringTime]];
    message.title = @"欢迎使用极光社会化组件JShare";
    message.platform = platform;
    WeakSelf
    [JSHAREService share:message handler:^(JSHAREState state, NSError *error) {
        if (weakSelf.completeBlock) {
            weakSelf.completeBlock(state,error);
        }
    }];
}

- (void)shareVideoWithPlatform:(JSHAREPlatform)platform {
    JSHAREMessage *message = [JSHAREMessage message];
    message.mediaType = JSHAREVideo;
    message.url =@"http://v.youku.com/v_show/id_XOTQwMDE1ODAw.html?from=s1.8-1-1.2&spm=a2h0k.8191407.0.0";
    message.text = [NSString stringWithFormat:@"时间:%@ JShare SDK支持主流社交平台、帮助开发者轻松实现社会化功能！",[self localizedStringTime]];
    message.title = @"欢迎使用极光社会化组件JShare";
    if (platform == JSHAREPlatformTwitter) {
        NSString *path = [[NSBundle mainBundle] pathForResource:@"jiguangVideoForTwitter" ofType:@"mp4"];
        NSData *data = [NSData dataWithContentsOfFile:path];
        message.videoData = data;
    }
    message.platform = platform;
    WeakSelf
    [JSHAREService share:message handler:^(JSHAREState state, NSError *error) {
        if (weakSelf.completeBlock) {
            weakSelf.completeBlock(state,error);
        }
    }];
}

- (void)shareAppWithPlatform:(JSHAREPlatform)platform {
    Byte* pBuffer = (Byte *)malloc(10*1024*1024);
    memset(pBuffer, 0, 10*1024);
    NSData* data = [NSData dataWithBytes:pBuffer length:10*1024*1024];
    free(pBuffer);
    
    JSHAREMessage *message = [JSHAREMessage message];
    message.mediaType = JSHAREApp;
    message.url =@"https://www.jiguang.cn/";
    message.text = [NSString stringWithFormat:@"时间:%@ JShare SDK支持主流社交平台、帮助开发者轻松实现社会化功能！",[self localizedStringTime]];
    message.title = @"欢迎使用极光社会化组件JShare";
    message.extInfo = @"<xml>extend info</xml>";
    message.fileData = data;
    message.platform = platform;
    WeakSelf
    [JSHAREService share:message handler:^(JSHAREState state, NSError *error) {
        if (weakSelf.completeBlock) {
            weakSelf.completeBlock(state,error);
        }
        
    }];
}

- (void)shareEmoticonWithPlatform:(JSHAREPlatform)platform {
    JSHAREMessage *message = [JSHAREMessage message];
    message.mediaType = JSHAREEmoticon;
    NSString *filePath = [[NSBundle mainBundle] pathForResource:@"res6" ofType:@"gif"];
    NSData *emoticonData = [NSData dataWithContentsOfFile:filePath];
    message.emoticonData = emoticonData;
    message.platform = platform;
    WeakSelf
    [JSHAREService share:message handler:^(JSHAREState state, NSError *error) {
        if (weakSelf.completeBlock) {
            weakSelf.completeBlock(state,error);
        }
    }];
}

- (void)shareFileWithPlatform:(JSHAREPlatform)platform {
    JSHAREMessage *message = [JSHAREMessage message];
    message.mediaType = JSHAREFile;
    NSString *filePath = [[NSBundle mainBundle] pathForResource:@"jiguang" ofType:@"mp4"];
    NSData *fileData = [NSData dataWithContentsOfFile:filePath];
    message.fileData = fileData;
    message.fileExt = @"mp4";
    message.platform = platform;
    message.title = @"jiguang.mp4";
    WeakSelf
    [JSHAREService share:message handler:^(JSHAREState state, NSError *error) {
        if (weakSelf.completeBlock) {
            weakSelf.completeBlock(state,error);
        }
    }];
}

- (void)shareLinkToSinaWeiboContact{
    JSHAREMessage *message = [JSHAREMessage message];
    message.mediaType = JSHARELink;
    message.url = @"https://www.jiguang.cn/";
    message.text = [NSString stringWithFormat:@"时间:%@ JShare SDK支持主流社交平台、帮助开发者轻松实现社会化功能！",[self localizedStringTime]];
    message.title = @"欢迎使用极光社会化组件JShare";
    message.platform = JSHAREPlatformSinaWeiboContact;
    NSString *imageURL = @"http://img2.3lian.com/2014/f5/63/d/23.jpg";
    NSData *imageData = [NSData dataWithContentsOfURL:[NSURL URLWithString:imageURL]];
    
    message.image = imageData;
    WeakSelf
    [JSHAREService share:message handler:^(JSHAREState state, NSError *error) {
        if (weakSelf.completeBlock) {
            weakSelf.completeBlock(state,error);
        }
    }];
}

- (void)getUserInfoWithPlatform:(JSHAREPlatform)platfrom{
    [JSHAREService getSocialUserInfo:platfrom handler:^(JSHARESocialUserInfo *userInfo, NSError *error) {
        NSString *alertMessage;
        NSString *title;
        if (error) {
            title = @"失败";
            alertMessage = @"无法获取到用户信息";
        }else{
            title = userInfo.name;
            NSString *gender = nil;
            if (userInfo.gender == 1) {
                gender = @"男";
            }else if (userInfo.gender == 2){
                gender = @"女";
            }else{
                gender = @"未知";
            }
            
            alertMessage = [NSString stringWithFormat:@"昵称: %@\n 头像链接: %@\n 性别: %@\n",userInfo.name,userInfo.iconurl,gender];
        }
        UIAlertView *Alert = [[UIAlertView alloc] initWithTitle:title message:alertMessage delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil];
        dispatch_async(dispatch_get_main_queue(), ^{
            [Alert show];
        });
        
        
    }];
}

- (NSString *)localizedStringTime{
    NSDateFormatter*formatter = [[NSDateFormatter alloc]init];[formatter setDateFormat:@"yyy-MM-dd HH:mm:ss"];
    NSString*dateTime = [formatter stringFromDate:[NSDate date]];
    return dateTime;
}

@end
