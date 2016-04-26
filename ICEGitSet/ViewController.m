//
//  ViewController.m
//  ICEGitSet
//
//  Created by WLY on 16/4/25.
//  Copyright © 2016年 ICE. All rights reserved.
//

#import "ViewController.h"
#import "ICESimpleLayout.h"

@interface ViewController ()<UICollectionViewDelegate,UICollectionViewDataSource>

@property (nonatomic, strong) UICollectionView *collectionView;


@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self.view addSubview:self.collectionView];
    [_collectionView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(0);
        make.left.mas_equalTo(0);
        make.right.mas_equalTo(0);
        make.bottom.mas_equalTo(0);
    }];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

- (UICollectionView *)collectionView{
    
    if (!_collectionView) {
        UICollectionViewLayout *layout = [self layout];
        _collectionView = [[UICollectionView alloc] initWithFrame:CGRectMake(0, 0, 0, 0) collectionViewLayout:layout];
        _collectionView.backgroundColor = [UIColor clearColor];
        _collectionView.delegate = self;
        _collectionView.dataSource = self;
        [_collectionView registerClass:[UICollectionViewCell class] forCellWithReuseIdentifier:@"CELL"];
        
    }
    return _collectionView;
}

- (UICollectionViewLayout *)layout{
    
    ICESimpleLayout *layout = [[ICESimpleLayout alloc] init];
    layout.interItemSpacing = 10;
    layout.lineItemSpacing = 10;
    
    [layout returnCellSize:^CGSize(NSIndexPath *indexPath) {
        return CGSizeMake(1 + indexPath.row * 10, indexPath.row * 10 + 1);
    }];
    
    [layout getSectionHeight:^(NSInteger section, CGFloat height) {
        NSLog(@"%ld,%f",section,height);
    }];
    
    [layout returnSupplementaryViewSize:^CGSize(NSInteger section, SupplementaryType type) {
        switch (type) {
            case SupplementaryTypeHeader: {
                return CGSizeMake(300, 25);
                break;
            }
            case SupplementaryTypeFoot: {
                return CGSizeMake(300, 25);
                break;
            }
        }
    }];
    
    [layout returnSupplementaryView:^UIView *(NSInteger section, SupplementaryType type) {
        UIView *view = [[UIView alloc] init];
        switch (type) {
            case SupplementaryTypeHeader: {
                view.backgroundColor = [UIColor blueColor];
                break;
            }
            case SupplementaryTypeFoot: {
                view.backgroundColor = [UIColor yellowColor];
                break;
            }
        }
        return view;
    }];
    return layout;
}

#pragma mark - UICollectionViewDelegate
- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView{
    return 3;
}
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    
    return 7;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    
    UICollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"CELL" forIndexPath:indexPath];
    cell.backgroundColor = [UIColor redColor];
    return cell;
}

@end
