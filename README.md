# DovMess

-----------
&nbsp;&nbsp;&nbsp;&nbsp;An easy way to send callback message from UIView to UIViewController.  

## Scenario
-----------
&nbsp;&nbsp;&nbsp;&nbsp;You have a UIViewController that includes a UIView name firstView. FirstView includes secondView, secondView includes thirdView, thirdView includes fourthView, fourthView includes fifthView. Then, there is a button in the fifthView, and such action callback is in the root(UIViewController). Like below: 

|UIViewController  
|  |  |  FirstView  
|  |  |  |  |  SecondView  
|  |  |  |  |  |  |  ThirdView  
|  |  |  |  |  |  |  |  |  FourthView  
|  |  |  |  |  |  |  |  |  |  |  FifthView  
|  |  |  |  |  |  |  |  |  |  |  |  |  Button  
  

&nbsp;&nbsp;&nbsp;&nbsp;Usually, there are two solutions to handle the action from Button to UIViewController:  
#####No.1   
&nbsp;&nbsp;&nbsp;&nbsp;Adding delegates to every UIViews between Button and UIViewController.  This would generals massive code in the middle.

#####No.2  
&nbsp;&nbsp;&nbsp;&nbsp;Button sent a notification, and UIViewController observes it.However, this may not as you wish because this beyonds your design since everybody could receive this notification message.  
DovMess provides you the third way to handle it.

## Adding DovMess to your project
-----------
&nbsp;&nbsp;&nbsp;&nbsp;The simplest way to add DovMess to your project is to use [CocoaPods](http://cocoapods.org).  
Add the following line to your Podfile:    

```
	pod 'DovMess'
```  
  
&nbsp;&nbsp;&nbsp;&nbsp;If you'd prefer to manually integrate it, just copy 'Pod/Classes/*.{m,h}' into your project.  
  
## Adding Message Sender
-----------
&nbsp;&nbsp;&nbsp;&nbsp;In the example we described above, just add button clicked action in the fifthView for button click:  
  
```
- (void)buttonClicked {
    DOVMessage *message = [[DOVMessage alloc] initWithName:@"ViewController.holy" from:self];
    [DOVMessageBus sendMessage:message];
}
```  
&nbsp;&nbsp;&nbsp;&nbsp;In this example, message name described the filterReceiver("ViewController") and the signal name("holy").
  
## Adding Message Receiver 
-----------
&nbsp;&nbsp;&nbsp;&nbsp;In the example we described above, just add DovMess Message Handler:  

```
DOVE_MESSAGE_HANDLER2(ViewController, holy, message) {
    NSLog(@"I'm ViewController , I already handled this message");
}
```  
  
&nbsp;&nbsp;&nbsp;&nbsp;Then finished!  
  
## How It Works
-----------
&nbsp;&nbsp;&nbsp;&nbsp;While sending a message from view, DovMess will search UIView's NextResponder, and see whether this NextResponder could responds the method(selector).   
## Example  
-----------
&nbsp;&nbsp;&nbsp;&nbsp;See example in the Example Folder.  
## Changlog    
-----------
### 0.1.1    
* Bugfix for instance method    

### 0.1
* Initial release
  
## Contacts
-----------
Any Questions, just send e-mail to me: cendymails@gmail.com
