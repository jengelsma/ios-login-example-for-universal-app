ios-login-example-for-universal-app
===================================

Assume you want to implement a universal master/detail style iOS app that  utilizes UISplitViewController on the iPad. However, unlike the master/detail the xCode project creation wizard generates for you, there are some additional requirements.

* You want a modal login screen to appear before the master and/or the master/detail (e.g. if you are in landscape on an iPad) shows up.

* If you happen to come up in landscape on an iPad, and the master has no items to display, then you want to swap out the normal detail view in the split view with a different detail split view that indicates there is no data to display, or perhaps just be blank. 

This example app uses a UISplitViewControllerDelegate to customize the out-of-the-box UISplitViewController to accomplish the above.  The code was inspired in part by Apple's MultipleDetailsViews example code. 
