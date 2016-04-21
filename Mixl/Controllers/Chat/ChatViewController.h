//
//  ChatViewController.h
//  Mixl
//
//  Created by Jose on 4/19/16.
//  Copyright © 2016 Brani. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ChatViewController : BaseViewController <UITableViewDelegate, UITableViewDataSource, UITextViewDelegate, UIActionSheetDelegate, UIImagePickerControllerDelegate, UINavigationControllerDelegate>
@property (weak, nonatomic) IBOutlet UILabel *lblChatUserName;

@property (weak, nonatomic) IBOutlet UIView *viewBack;
@property (weak, nonatomic) IBOutlet UITableView    *chatHistoryTable;
@property (weak, nonatomic) IBOutlet UITextView *txtMessage;
@property (weak, nonatomic) IBOutlet UIButton *btnSend;

@property (strong, nonatomic) NSMutableDictionary   *issueInfo;

@end
