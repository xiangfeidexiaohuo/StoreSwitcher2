#import <UIKit/UIKit.h>
#import "SSViewController.h"

@interface AppStoreAccountViewController: UIViewController
@end

%hook AppStoreAccountViewController

- (id)init {
  return %orig;
}

- (void)viewDidLoad {
	%orig;
    UIBarButtonItem *switcherButton = [[UIBarButtonItem alloc]
        initWithTitle:@"⚙️"
        style:UIBarButtonItemStylePlain
        target:self
        action:@selector(openSwitcher:)];

    [(UIViewController *)self navigationItem].leftBarButtonItem = switcherButton;
}

%new
- (void)openSwitcher:(UIButton *)button {
	SSViewController *viewController = [[SSViewController alloc] init];
	[viewController setModalPresentationStyle:UIModalPresentationPageSheet];
	[self presentViewController:viewController animated:YES completion:nil];
}

%end

%ctor {
  %init(AppStoreAccountViewController = objc_getClass("AppStore.AccountViewController")
	);
}
