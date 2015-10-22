//
//  ReseriorViewController.m
//  XiaKouStander
//  **********白水坑水库**********
//  Created by teddy on 15/10/12.
//  Copyright (c) 2015年 teddy. All rights reserved.
//

#import "ReseriorViewController.h"
#import "ItemCell.h"

@interface ReseriorViewController ()<UICollectionViewDataSource,UICollectionViewDelegate>
{
    NSMutableArray *_itemList;//数据源
}
@property (weak, nonatomic) IBOutlet UICollectionView *collectionView;

@end

@implementation ReseriorViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.collectionView.delegate = self;
    self.collectionView.dataSource = self;
    self.collectionView.backgroundColor = BG_COLOR;
    _itemList = [NSMutableArray arrayWithObjects:@"rain",@"qixiang", nil];
    
    //必须注册，否则会崩溃
    [self.collectionView registerNib:[UINib nibWithNibName:@"ItemCell" bundle:[NSBundle mainBundle]] forCellWithReuseIdentifier:@"itemCell"];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - UICollectionVIewDataSource

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return _itemList.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    ItemCell *myCell = (ItemCell *)[collectionView dequeueReusableCellWithReuseIdentifier:@"itemCell" forIndexPath:indexPath];
    
    myCell.itemImageView.image = [UIImage imageNamed:_itemList[indexPath.row]];
    myCell.itemImageView.contentMode = UIViewContentModeScaleAspectFit;
    
    myCell.itemNameLabel.text = @"库区巡查";
    
    return myCell;
    
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath
{
    return CGSizeMake(100, 100);
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    [collectionView deselectItemAtIndexPath:indexPath animated:YES];
    switch (indexPath.row) {
        case 0:
        {
           // [self performSegueWithIdentifier:@"damPartrol" sender:nil];
        }
            break;
        case 1:
        {
            
        }
            break;
        default:
            break;
    }
}

@end
