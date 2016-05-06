//
//  ICEPickerMessageModel.m
//  ICEGitSet
//
//  Created by WLY on 16/5/6.
//  Copyright © 2016年 ICE. All rights reserved.
//

#import "ICEPickerMessageModel.h"
#import "UIImageView+WebCache.h"
#import "ICEPhotoLibrary.h"


@implementation ICEPickerMessageModel

- (void)imageMessage:(LoadImgBlock)imageBlock{

    NSURL *URL = [NSURL URLWithString:self.imageURL];
    //网络图片
    if ([self.imageURL hasPrefix:@"http"]) {
        UIImageView *imageV = [[UIImageView alloc] init];
        [imageV sd_setImageWithURL:URL completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, NSURL *imageURL) {
            
            if (error) {
                imageBlock(nil);
            }else{
                imageBlock(image);
            }
        }];
        
    }else{
        
        [ICEPhotoLibrary getImage:self.imageURL fromAlbum:nil success:^(UIImage *image) {
            imageBlock(image);
        } faliure:^{
            imageBlock(nil);
        }];
        
    }

}

@end
