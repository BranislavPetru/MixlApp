//
//  ChatViewController.m
//  Mixl
//
//  Created by Jose on 4/19/16.
//  Copyright © 2016 Brani. All rights reserved.
//

#import "ChatViewController.h"
#import "MessageTableViewCell.h"
#import "MJRefresh.h"
#import "MJRefreshAutoFooter.h"
#import "MJRefreshFooter.h"
#import "MJRefreshHeader.h"
#import "MJRefreshComponent.h"

static const CGFloat MJDuration = 1.0;

@interface ChatViewController (){
    
    NSDictionary *_firstMessage;
    NSMutableArray *_chatHistoryArray;
    NSString *_limit, *_allcount;
}

@end

@implementation ChatViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self initView];
    [self registerNotifications];
    [self initData];
    [self MSRefresh];
    if ([self checkUnread]) {
        [self setReadAll];
    }

}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


#pragma mark -
#pragma mark UITableView
- (void)MSRefresh
{
    __weak __typeof(self) weakSelf = self;
    
    self.chatHistoryTable.header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        [weakSelf loadNewData];
    }];
    
    [self.chatHistoryTable.header beginRefreshing];
    
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.5 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [self.chatHistoryTable.header beginRefreshing];
    });
}

#pragma mark
#pragma mark
- (void)loadNewData
{
//    NSInteger index = _chatHistoryArray.count;
//    NSMutableDictionary* loadhistory = [[NSMutableDictionary alloc] initWithObjectsAndKeys:
//                                        [[UserInformation sharedInstance].accessToken stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding], @"AccessToken",
//                                        [self.issueInfo objectForKey:@"IssueID"], @"IssueID",
//                                        [NSString stringWithFormat:@"%ld", index], @"Begin",
//                                        @5, @"Limit",
//                                        nil];
//    
//    [[BDCRedmineAPI sharedManager] loadMessage:loadhistory onSuccess:^(id json) {
//        if([[json objectForKey:@"ResponseResult"]  isEqual:@"YES"]){
//            //[JSWaiter HideWaiter];
//            if([[json objectForKey:@"ResponseContent"] objectForKey:@"MessageHistory"] != [NSNull null]){
//                NSMutableArray* insertHistoryArray = [[NSMutableArray alloc] initWithArray:[[json objectForKey:@"ResponseContent"] objectForKey:@"MessageHistory"]];
//                
//                if (index == 0) {
//                    _chatHistoryArray = insertHistoryArray;
//                }
//                else{
//                    _chatHistoryArray = [[NSMutableArray alloc] initWithArray:[_chatHistoryArray arrayByAddingObjectsFromArray:insertHistoryArray]];
//                }
//                dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(MJDuration * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
//                    [self.chatHistoryTable reloadData];
//                    [self.chatHistoryTable.header endRefreshing];
//                });
//            }
//            else
//            {   [JSWaiter HideWaiter];
//                UIAlertView* alert = [[UIAlertView alloc] initWithTitle:nil
//                                                                message:NSLocalizedString(@"Message empty", nil)
//                                                               delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil];
//                [alert show];
//                return;
//                
//            }
//        }
//        else
//        {
//            UIAlertView* alert = [[UIAlertView alloc] initWithTitle:nil
//                                                            message:NSLocalizedString(@"IssueID invalid", nil)
//                                                           delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil];
//            [alert show];
//            return;
//        }
//    } onFailure:^(NSInteger statusCode, id json) {
//        
//    }];
}

- (void)initData {
    
    NSDateFormatter* formatter = [[NSDateFormatter alloc] init];
    [formatter setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
    //NSString* dateString = [formatter stringFromDate:[NSDate date]];
    //[JSWaiter ShowWaiter:self.view title:NSLocalizedString(@"Loading...", nil) type:0];
//    if (self.selectHelp) {
//        _firstMessage = [[NSDictionary alloc] initWithObjectsAndKeys:NSLocalizedString(@"Hello dear. How may we help you?", nil), @"Message",
//                         @"" , @"SentOn",
//                         @"Server", @"Sender", nil];
//    } else {
//        NSString *let = NSLocalizedString(@"has been created. Let's start communicating on this issue, our team will try our best to assist you.", nil);
//        _firstMessage = [[NSDictionary alloc] initWithObjectsAndKeys:[NSString stringWithFormat:
//                                                                      @"Issue %@ %@", [self.issueInfo objectForKey:@"Title"], let], @"Message",
//                         @"", @"SentOn",
//                         @"Server", @"Sender", nil];
//    }
}

- (void)initView {

    _lblChatUserName.text = @"Jessy";
    _txtMessage.layer.borderColor = [UIColor lightGrayColor].CGColor;
    _txtMessage.layer.borderWidth = 2.0f;
    _txtMessage.layer.cornerRadius = 3.0f;
    
    self.chatHistoryTable.delegate = self;
    self.chatHistoryTable.dataSource = self;
    _txtMessage.delegate = self;
    [self.btnSend setImage:[UIImage imageNamed:@"ic_send_disabled"] forState:UIControlStateNormal];
    self.btnSend.userInteractionEnabled = NO;
    
}

- (void)onSendSuccess {
    
//    NSMutableDictionary* MessageInfo = [[NSMutableDictionary alloc] initWithObjectsAndKeys:[self.issueInfo objectForKey:@"Title" ], @"Title",
//                                        self.txtInput.text, @"Message",nil];
//    
//    NSMutableDictionary* Message = [[NSMutableDictionary alloc] initWithObjectsAndKeys:
//                                    [[UserInformation sharedInstance].accessToken stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding], @"AccessToken",
//                                    [self.issueInfo objectForKey:@"IssueID"], @"IssueID",
//                                    MessageInfo, @"MessageInfo", nil];
//    [[BDCRedmineAPI sharedManager] sendMessage:Message onSuccess:^(id json) {
//        if([[json objectForKey:@"ResponseResult"]  isEqual:@"YES"]){
//            //[JSWaiter HideWaiter];
//            
            NSDateFormatter* formatter = [[NSDateFormatter alloc] init];
            [formatter setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
            NSString* dateString = [formatter stringFromDate:[NSDate date]];
            NSMutableDictionary* sendMessage = [[NSMutableDictionary alloc] initWithObjectsAndKeys:@"Me", @"Sender",
                                                _txtMessage.text, @"Message",
                                                dateString, @"SentOn", nil];
            
            [_chatHistoryArray insertObject:sendMessage atIndex:0];
            [self.chatHistoryTable reloadData];
            [self scrollToNewestMessage];
            self.chatHistoryTable.footer.hidden = YES;
            [self.chatHistoryTable.footer endRefreshing];
            _txtMessage.text = @"";
            [self textViewDidChange:_txtMessage];
//
//            
//        }
//        else
//        {   //[JSWaiter HideWaiter];
//            UIAlertView* alert = [[UIAlertView alloc] initWithTitle:nil
//                                                            message:NSLocalizedString(@"IssueID invalid", nil)
//                                                           delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil];
//            [alert show];
//            return;
//        }
//    } onFailure:^(NSInteger statusCode, id json) {
//        
//    }];
}

- (void)onReceiveMessageNotify:(NSNotification*)notification {
    NSDictionary* userInfo = notification.userInfo;
//    if ([[userInfo objectForKey:@"IssueID"] intValue] == [[self.issueInfo objectForKey:@"IssueID"] intValue] ) {
//        // ADD received message to history
//        NSMutableDictionary* recieveMessage = [[NSMutableDictionary alloc] initWithObjectsAndKeys:[[userInfo objectForKey:@"MessageInfo"] objectForKey:@"Sender"], @"Sender",
//                                               [[userInfo objectForKey:@"MessageInfo"] objectForKey:@"Message"], @"Message",
//                                               [[userInfo objectForKey:@"MessageInfo"] objectForKey:@"SentOn"], @"SentOn", nil];
//        
//        [_chatHistoryArray insertObject:recieveMessage atIndex:0];
//        [self.chatHistoryTable reloadData];
//        // Set read all
//        [self setReadAll];
//    }
}

- (void)onReloadMessageNotify {
    if ([self checkUnread]) {
        // Reload message
        NSMutableArray* reChatHistoryArray = [[NSMutableArray alloc] init];
        _chatHistoryArray = reChatHistoryArray;
        [self loadNewData];
        // Set read all
        [self setReadAll];
    }
}

- (BOOL)checkUnread {
//    NSArray* unreadIssues = [[DBUtil sharedInstance] loadUnreadIssues];
//    if ([unreadIssues indexOfObject:[self.issueInfo objectForKey:@"IssueID"]] != NSNotFound) {
//        return YES;
//    } else  {
//        return NO;
//    }
    return YES;
}

- (void)setReadAll {
//    NSMutableDictionary* param = [[NSMutableDictionary alloc] initWithObjectsAndKeys:
//                                  [[UserInformation sharedInstance].accessToken stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding], @"AccessToken",
//                                  [self.issueInfo objectForKey:@"IssueID"], @"Id", nil];
//    
//    [[BDCRedmineAPI sharedManager] setRead:param onSuccess:^(id json) {
//        if ([[json objectForKey:@"ResponseResult"] isEqual:@"YES"]) {
//            [[DBUtil sharedInstance] removeUnreadIssue:[self.issueInfo objectForKey:@"IssueID"]];
//        }
//    } onFailure:nil];
}

- (void) scrollToNewestMessage
{
    // The newest message is at the bottom of the table
    if (_chatHistoryArray.count > 0)
    {
        NSIndexPath* indexPath = [NSIndexPath indexPathForRow:(_chatHistoryArray.count - 1) inSection:0];
        [self.chatHistoryTable scrollToRowAtIndexPath:indexPath atScrollPosition:UITableViewScrollPositionTop animated:YES];
    }
    
}

// Setting up keyboard notifications.
- (void)registerNotifications
{
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(keyboardWasShown:)
                                                 name:UIKeyboardWillShowNotification object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(keyboardWillBeHidden:)
                                                 name:UIKeyboardWillHideNotification object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(onReceiveMessageNotify:)
                                                 name:APP_DidReceiveMessage
                                               object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(onReloadMessageNotify)
                                                 name:APP_ReloadIssueMessage
                                               object:nil];
    
}

// Called when the UIKeyboardDidShowNotification is sent.
- (void)keyboardWasShown:(NSNotification*)aNotification
{
    NSDictionary* info = [aNotification userInfo];
    CGSize kbSize = [[info objectForKey:UIKeyboardFrameEndUserInfoKey] CGRectValue].size;
    CGPoint viewOrigin = self.viewBack.frame.origin;
    CGSize viewSize = self.viewBack.frame.size;
    viewSize.height = [[UIScreen mainScreen] bounds].size.height - viewOrigin.y - kbSize.height;
    [self.viewBack setFrame:CGRectMake(viewOrigin.x, viewOrigin.y, viewSize.width, viewSize.height)];
    [self scrollToNewestMessage];
}

// Called when the UIKeyboardWillHideNotification is sent
- (void)keyboardWillBeHidden:(NSNotification*)aNotification
{
    CGPoint viewOrigin = self.viewBack.frame.origin;
    CGSize viewSize = self.viewBack.frame.size;
    viewSize.height = [[UIScreen mainScreen] bounds].size.height - viewOrigin.y;
    [self.viewBack setFrame:CGRectMake(viewOrigin.x, viewOrigin.y, viewSize.width, viewSize.height)];
}

- (IBAction)sendClicked:(id)sender {
    
    [_txtMessage resignFirstResponder];
    if (_txtMessage.text.length > 0) {
        //[JSWaiter ShowWaiter:self.view title:NSLocalizedString(@"Sending...", nil) type:0];
        
        self.chatHistoryTable.footer = [MJRefreshAutoNormalFooter footerWithRefreshingBlock:^{
            
        }];
        [self scrollToNewestMessage];
        [self.chatHistoryTable.footer beginRefreshing];
        
        [self performSelector:@selector(onSendSuccess) withObject:nil afterDelay:0.5];
    }
    

}

- (IBAction)cameraClicked:(id)sender {
    
    UIActionSheet *alertCamera = [[UIActionSheet alloc] initWithTitle:nil
                                                             delegate:self
                                                    cancelButtonTitle:@"Cancel"
                                               destructiveButtonTitle:nil
                                                    otherButtonTitles:@"Take a picture",
                                  @"Select photos from camera roll", nil];
    alertCamera.tag = 1;
    [alertCamera showInView:[UIApplication sharedApplication].keyWindow];
}



#pragma mark - UITextViewDelegate
- (void)textViewDidChange:(UITextView *)textView {
    if (textView.text.length == 0) {
        [self.btnSend setImage:[UIImage imageNamed:@"ic_send_disabled"] forState:UIControlStateNormal];
        self.btnSend.userInteractionEnabled = NO;
    } else {
        [self.btnSend setImage:[UIImage imageNamed:@"ic_send_enabled"] forState:UIControlStateNormal];
        self.btnSend.userInteractionEnabled = YES;
    }
}

- (BOOL)textViewShouldEndEditing:(UITextView *)textView{
    [textView resignFirstResponder];
    return YES;
}

#pragma mark - UITableViewDataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section  {
    return _chatHistoryArray.count ;
}

- (UITableViewCell*)tableView:(UITableView*)tableView cellForRowAtIndexPath:(NSIndexPath*)indexPath
{
    static NSString* CellIdentifier = @"MessageCellIdentifier";
    
    MessageTableViewCell* cell = (MessageTableViewCell*)[tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        cell = [[MessageTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
    }
    
    if (_chatHistoryArray.count  == 0) {
        [cell setMessage:_firstMessage];
    } else {
        [cell setMessage:[_chatHistoryArray objectAtIndex:_chatHistoryArray.count - indexPath.row -1 ]];
    }
    
    return cell;
}

#pragma mark -
#pragma mark UITableView Delegate

- (CGFloat)tableView:(UITableView*)tableView heightForRowAtIndexPath:(NSIndexPath*)indexPath
{
    NSDictionary *message = (indexPath.row == 0)?_firstMessage:[_chatHistoryArray objectAtIndex:indexPath.row-1];
    CGSize bubbleSize = [SpeechBubbleView sizeForText:[message objectForKey:@"Message"]];
    
    return bubbleSize.height + 26;
}


- (void) actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex
{
    UIImagePickerController *picker = [[UIImagePickerController alloc] init];
    picker.allowsEditing = YES;
    picker.delegate = self;
    switch (buttonIndex) {
            
        case 0:
            picker.sourceType = UIImagePickerControllerSourceTypeCamera;
            [self presentViewController:picker animated:YES completion:nil];
            break;
            
        case 1:
            picker.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
            [self presentViewController:picker animated:YES completion:nil];
            break;
            
        default:
            break;
    }
    
    NSLog(@"%ld , %ld", (long)actionSheet.tag , (long)buttonIndex);
}

- (void) imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info
{
    [picker dismissViewControllerAnimated:YES completion:nil];
    UIImage *imageSEL = info[UIImagePickerControllerEditedImage];
    //[_imgUser setImage:imageSEL];
    
}

- (void) imagePickerControllerDidCancel:(UIImagePickerController *)picker
{
    [picker dismissViewControllerAnimated:YES completion:NULL];
    
}


@end
