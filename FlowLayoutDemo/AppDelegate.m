//
//  Copyright (c) 2013 Luke Scott
//  https://github.com/lukescott/DraggableCollectionView
//  Distributed under MIT license
//

#import "AppDelegate.h"

@implementation AppDelegate

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    WelcomeView=[[ViewController alloc]initWithNibName:nil bundle:nil];
    
    UINavigationController *navi=[[UINavigationController alloc]initWithRootViewController:WelcomeView];
    self.window.rootViewController=navi;
    [navi.navigationBar setHidden:YES];
    [self.window makeKeyAndVisible];
    return YES;
}

@end
