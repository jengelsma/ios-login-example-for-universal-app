ios-login-example-for-universal-app
===================================

In an iOS universal app, the UISplitViewController has to be the root controller.  This example shows how to do a modal push to a login screen while maximizing code reuse within the universal app.  In the viewWillAppear method of the MasterViewController we check if we are authenticated, and if not we push to the login screen.  

However, if the app is brought up on an iPad in portrait mode, the MasterView will not be displayed by default.  We address this by forcing the MasterView to be displayed in portrait mode the very first time the app is launched. 
