//
//  MainViewController.m
//  XiaKouStander
//  *********主界面**********
//  Created by teddy on 15/10/12.
//  Copyright (c) 2015年 teddy. All rights reserved.
//

#import "MainViewController.h"
#import "ItemCell.h"

@interface MainViewController ()<UICollectionViewDataSource,UICollectionViewDelegate>
{
    NSMutableArray *_itemList;//数据源
}
@property (weak, nonatomic) IBOutlet UICollectionView *itemCollection;

@end

@implementation MainViewController

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [self.navigationItem setHidesBackButton:YES];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.itemCollection.delegate = self;
    self.itemCollection.dataSource = self;
    self.itemCollection.backgroundColor = BG_COLOR;
    _itemList = [NSMutableArray arrayWithObjects:@"rain",@"qixiang", nil];
    
    //必须注册，否则会崩溃
    [self.itemCollection registerNib:[UINib nibWithNibName:@"ItemCell" bundle:[NSBundle mainBundle]] forCellWithReuseIdentifier:@"itemCell"];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - UICollectionViewData
#pragma mark - UICollectionViewDataSource
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return _itemList.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    ItemCell *myCell = (ItemCell *)[collectionView dequeueReusableCellWithReuseIdentifier:@"itemCell" forIndexPath:indexPath];
    
    myCell.itemImageView.image = [UIImage imageNamed:_itemList[indexPath.row]];
    myCell.itemImageView.contentMode = UIViewContentModeScaleAspectFit;
    
    switch (indexPath.row) {
        case 0:
            myCell.itemNameLabel.text = @"白水坑水库";
            break;
        case 1:
            myCell.itemNameLabel.text = @"峡口水库";
            break;
        default:
            break;
    }

    return myCell;
    
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath
{
    return CGSizeMake(100, 100);
}

- (UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout insetForSectionAtIndex:(NSInteger)section
{
    return UIEdgeInsetsMake(20, 8, 10, 8);
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    [collectionView deselectItemAtIndexPath:indexPath animated:YES];
    switch (indexPath.row) {
        case 0:
        {
            [self performSegueWithIdentifier:@"baishuiken" sender:nil];
        }
            break;
        case 1:
        {
           [self performSegueWithIdentifier:@"xiakou" sender:nil]; 
        }
            break;
        default:
            break;
    }
}
@end
