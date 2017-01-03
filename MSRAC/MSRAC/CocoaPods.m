//
//  CocoaPods.m
//  MSRAC
//
//  Created by ms on 2017/1/3.
//  Copyright © 2017年 mrscorpion. All rights reserved.
//  CocoaPods 笔记

#import <Foundation/Foundation.h>

// CocoaPods 入门篇
/*
 一.CocoaPods背景
 什么是CocoaPods？
 CocoaPods是一个负责管理iOS项目中第三方开源库的工具。
 
 为什么要学习CocoaPods？
    > 提高效率。开发iOS项目不可避免地要使用第三方开源库，CocoaPods可以节省设置和更新第三方开源库的时间。
    > 在使用第三方库时，除了要导入源码，依赖库的手动配置，另外当第三方库发生了更新，还需要手动更新项目。这就显得非常麻烦。
    > 通过CocoaPods，我们可以将第三方的依赖库统一管理起来，配置和更新只需要通过简单的几行命令即可完成。
    > 相比Carthage，CocoaPods对共有组件的版本控制更好，打包时速度也更快些。
 
 如何集成？ Github：CocoaPods/CocoaPods
 https://github.com/CocoaPods/CocoaPods
 
 
 二.下载及安装
 1.查看当前ruby版本？
 mac系统已经默认安装好Ruby环境，如果你不确定自己系统中是否有Ruby的，可以在终端中输入命令行：ruby -v
 ```ObjC
 msdeMacBook-Pro:~ ms$ ruby -v
 ruby 2.2.2p95 (2015-04-13 revision 50295) [x86_64-darwin16]
 ```
 2.下载和安装CocoaPods
 Terminator（终端）中输入命令：gem sources -l
 2.1 检查ruby源？
 ```ObjC
 msdeMacBook-Pro:~ ms$ gem sources -l
 *** CURRENT SOURCES ***
 
 https://ruby.taobao.org/
 https://gems.ruby-china.org/
 ```
 2.2 如何更换源？[详见拓展]
 
 3. 判断的CocoaPods是否可以使用？
 用CocoaPods的搜索功能验证一下。在终端中输入： pod search AFNetworking
 ```ObjC
 msdeMacBook-Pro:~ ms$ pod search ReactiveCocoa
 
 -> ReactiveCocoa (5.0.0-alpha.3)
 Streams of values over time
 pod 'ReactiveCocoa', '~> 5.0.0-alpha.3'
 - Homepage: https://github.com/ReactiveCocoa/ReactiveCocoa
 - Source:   https://github.com/ReactiveCocoa/ReactiveCocoa.git
 - Versions: 5.0.0-alpha.3, 5.0.0-alpha.2, 4.2.2, 4.2.1, 4.1.0, 4.0.4-alpha-4,
 4.0.4-alpha-1, 4.0.3-alpha-3, 4.0.3-alpha-1, 4.0.2-alpha-3, 4.0.2-alpha-1,
 4.0.1, 4.0.1-alpha-3, 4.0.1-alpha-1, 4.0.0, 4.0.0-alpha-3, 4.0.0-alpha-2,
 4.0.0-alpha-1, 4.0.0-RC.2, 4.0.0-RC.1, 3.0.0, 3.0.0-swift2, 3.0-beta.9,
 3.0-beta.6, 3.0-alpha.3, 3.0.0-alpha.1, 3.0-RC.1, 2.5, 2.4.7, 2.4.6, 2.4.5,
 2.4.4, 2.4.2, 2.3.1, 2.3, 2.2.4, 2.2.3, 2.2.2, 2.2, 2.1.8, 2.1.7, 2.1.6,
 2.1.5, 2.1.4, 2.1.3, 2.1.2, 2.1.1, 2.1, 2.0, 1.9.7, 1.9.6, 1.9.5, 1.9.4,
 1.8.1, 1.8.0, 1.7.2, 1.7.1, 1.7.0, 1.6.0, 1.5.0, 1.4.0, 1.3.1, 1.0.0, 0.17.1,
 0.16.1, 0.13.1, 0.12.0, 0.10.0, 0.9.0, 0.8.0, 0.6.0, 0.5.0, 0.0.1 [master
 repo]
 ```
 按键Q退出搜索
 
 4. Cocoapods的使用
 4.1 首先来到你的项目文件：cd 项目文件的位置
 ```ObjC
 msdeMacBook-Pro:~ ms$ cd /Users/ms/Desktop/MSRAC
 ```
 4.2 创建Podfile  输入 vim Podfile  按键 i开始编辑
 ```ObjC
 platform:ios,'8.1'
 target 'MSRAC' do
 use_frameworks!
 pod 'ReactiveCocoa', '~> 4.2.2'
 end
 ```
 输入完成后按ESC 退出编辑模式 输入 :wq 保存并退出文件。此时可以发现在项目目录下多了一个Podfile的文件，请注意这个文件必须与.xcodeproj在同一目录下。
 4.3 最后输入：pod install --verbose --no-repo-update [忽略更新：不升级CocoaPods的spec仓库]
 ```ObjC
 msdeMacBook-Pro:MSRAC ms$ pod install --verbose --no-repo-update
 
 -> Pod installation complete! There is 1 dependency from the Podfile and 2 total pods installed.
 ```
*/


/*
 拓展篇一：CocoaPods的安装使用
 1 .如何下载和安装CocoaPods
 　　1.1 在安装CocoaPods之前，首先要在本地安装好Ruby环境。(MAC一般自带)
 　　1.2 在Mac终端执行sudo gem install cocoapods
 　　1.3 在Mac终端执行$ gem sources --remove https://rubygems.org/ //等有反应之后再敲入以下命令 $ gem sources -a http://ruby.taobao.org/
 
 　　为了验证你的Ruby镜像是并且仅是taobao，可以用以下命令查看：
 　　$ gem sources -l
 
 　　只有在终端中出现下面文字才表明你上面的命令是成功的：
 　　*** CURRENT SOURCES *** http://ruby.taobao.org/
 
 　　1.4这时候，你再次在终端中运行：
 　　$ sudo gem install cocoapods
 　　等上十几秒钟，CocoaPods就可以在你本地下载并且安装好了，不再需要其他设置。
 
2. CocoaPods的使用
 　　2.1 新建一个名为 Podfile 的文件，以如下格式，将依赖的库名字依次列在文件中即可,例如
 　　platform :ios
 　　pod 'JSONKit',       '~> 1.4
 　　'pod 'Reachability',  '~> 3.0.0'
 　　pod 'ASIHTTPRequest'pod 'RegexKitLite'
 　　然后你将编辑好的 Podfile 文件放到你的项目根目录中，执行如下命令即可：
 　　2.2 在命令行通过cd指令进入到项目根目录
 　　2.3执行"pod install (如果终端出现updating local specs repositories,那么请用ctrl+c强制结束命令进程,然后执行 pod install --verbose --no-repo-update
 　　2.4 现在，你的所有第三方库都已经下载完成并且设置好了编译参数和依赖，你只需要记住如下 2 点即可：
 　　使用 CocoaPods 生成的 .xcworkspace 文件来打开工程，而不是以前的 .xcodeproj 文件。
 　　每次更改了 Podfile 文件，你需要重新执行一次pod update命令。
 
3.CocoaPods的使用注意
 　　3.1目前在GitHub上大部分的开源项目都支持CocoaPods
 　　3.2对于新的IOS开发人员来说,CocoaPods是开发项目必须掌握的一门技术
 */


/*
拓展篇二：Podfile文件剖析 & Pod命令解析
 pod install 和 pod update
 
 1. 用途：更新或者是安装一个新的第三方框架
    a. pod install：是在有新的第三方框架引入是运行
    b. pod update：是纯粹为了更新本地的第三框架
    c. pod repo update：更新本地已有的所有第三框框架
 2. 参数
    a. --no-repo-update
        i. 在执行pod install和pod update两条命令时，会执行pod repo update的操作
        ii. 这个命令可以只更新当前项目的第三方框架
    b. --verbose 和 --silent
        i. 作用：控制pod命令执行过程中的输出
        ii. --silent不展示输出的情况
        iii. --verbose展示具体的出错信息（打印信息）
 */
