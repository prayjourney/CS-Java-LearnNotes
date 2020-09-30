###  exe和msi安装格式的区别
***

#### exe
Setup.exe是一个安装引导程序。它是安装工程通过MSBuild创建的，其中包含了一个XML文件，定义了应用程序所需要的系统必备安装包信息。*Setup.exe程序会检查这些系统必备安装包是否需要被下载和安装，如果需要，它就会先安装那些系统必备程序*。当我们运行它的时候，它会读取setup.ini来确定安装所需要的配置并开始安装流程。

如果这个setup.exe是在Visual Studio 2005中生成的，那么用户就必须有管理员权限才能运行它。我们可以看见在setup.exe的图标上有一个防护盾，这就意味着这个程序只有管理员才能运行它。如果这个setup.exe是在Visual Studio 2008中生成的，那么用户不一定需要有管理员的权限就能执行它，当有一些特定操作需要管理员的权限时，系统会显示UAC对话框要求提升权限。这类Setup.exe的图标上不会显示防护盾。



#### msi
Setup.msi是一个Windows Installer包。*和setup.exe不一样，直接运行MSI安装包就不会自动安装自定义系统必备。它只会安装主应用程序*。在安装项目的属性对话框中修改输出文件的名字，我们可以自定义MSI包的文件名。当我们“运行”它的时候，其实是Windows Installer在执行MSI包定义的各项操作。因此我们需要安装Windows Installer的正确版本才能运行setup.msi。我们也可以使用msiexec命令去安装setup.msi文件。

ref:

1.[FAQs: Setup.msi和Setup.exe有什么不同？](https://social.msdn.microsoft.com/Forums/tr-TR/d67ea2ae-381a-4ca0-8489-fb157e06ce43/faqs-setupmsisetupexe)
