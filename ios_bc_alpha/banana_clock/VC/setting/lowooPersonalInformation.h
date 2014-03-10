//
//  lowooPersonalInformation.h
//  banana_clock
//
//  Created by MAC on 13-1-10.
//  Copyright (c) 2013年 MAC. All rights reserved.
//

#import "lowooBaseView.h"
#import "UIFolderTableView.h"
#import "SRRefreshView.h"

@interface lowooPersonalInformation : lowooBaseView<UITableViewDataSource,UITableViewDelegate,UIFolderTableViewDelegate,SRRefreshDelegate>
{
    

    
    
    
}





@property (retain, nonatomic) IBOutlet UIFolderTableView *tableView;
@property (nonatomic, retain) SRRefreshView *slimeView;
@property (nonatomic, assign) BOOL reloading;
@property (nonatomic, assign) BOOL isSlimeView;
@property (nonatomic, assign) BOOL myInformation;
@property (nonatomic, assign) BOOL male;


@end
