# PopupActivityView
A customizing system-styled uiactivity, without airdrop support.

Note : This is not uiactivity, but a customized view with same ui layout, to avoid uiactivity's annoying system-defined actions.

To use this, import the "PopActivityView" folder into project. Subclass "PopupActivityItem", and customize its title, image and action. And add your subclassed PopupActivityItems when initializing "PopupActivityView", then use PopupActivityView's "pop" and "hide" function to show and hide this view. 

一个系统风格的uiactivity，暂时不支持airdrop分享。它并不是一个uiactivity，而是拥有相同ui布局的自定义控件，用来摆脱uiactivity的自带操作。

使用时，将PopActivityView文件夹导入工程。自定义子类继承PopupActivityItem来设置标题、图标以及响应操作。在初始化PopupActivityView时将自定义的PopupActivityItem子类实例加入。最后，使用pop和hide方法来显示、隐藏该view。
