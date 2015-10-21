//
//  XiaKouController.m
//  XiaKouStander
//  ********峡口水库******
//  Created by teddy on 15/10/21.
//  Copyright (c) 2015年 teddy. All rights reserved.
//

#import "XiaKouController.h"
#import "ItemCell.h"

@interface XiaKouController ()<UICollectionViewDataSource,UICollectionViewDelegate>
{
    NSMutableArray *_itemList;//数据源
}
@property (weak, nonatomic) IBOutlet UICollectionView *collectionView;

@end

@implementation XiaKouController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.collectionView.delegate = self;
    self.collectionView.dataSource = self;
    self.collectionView.backgroundColor = BG_COLOR;
    
    _itemList = [NSMutableArray arrayWithObjects:@"库区",@"大坝巡查",@"钢闸门",@"水情遥感",@"闸门",@"锥形阀", nil];
    
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
    
    myCell.itemImageView.image = [UIImage imageNamed:@"rain.png"];
    myCell.itemImageView.contentMode = UIViewContentModeScaleAspectFit;
    
    myCell.itemNameLabel.text = _itemList[indexPath.row];
    
    return myCell;
    
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath
{
    return CGSizeMake(100, 100);
}

//- (UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout insetForSectionAtIndex:(NSInteger)section
//{
//    return UIEdgeInsetsMake(20, 8, 10, 8);
//}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    [collectionView deselectItemAtIndexPath:indexPath animated:YES];
    switch (indexPath.row) {
        case 0:
        {
            //[self performSegueWithIdentifier:@"damPartrol" sender:nil];
        }
            break;
        case 1:
        {
            [self performSegueWithIdentifier:@"damPartrol" sender:nil];
        }
            break;
        case 2:
        {
            [self performSegueWithIdentifier:@"steelGate" sender:nil];
        }
            break;
        case 3:
        {
            //[self performSegueWithIdentifier:@"steelGate" sender:nil];
        }
            break;
        case 4:
        {
           // [self performSegueWithIdentifier:@"valve" sender:nil];
        }
            break;
        case 5:
        {
            [self performSegueWithIdentifier:@"valve" sender:nil];
        }
            break;
        default:
            break;
    }
}

@end
