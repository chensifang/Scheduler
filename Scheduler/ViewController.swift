//
//  ViewController.swift
//  Scheduler
//
//  Created by 陈四方 on 2023/5/12.
//

import Cocoa

let springWidth = 200.0
let springHeight = 40.0


class ViewController: NSViewController {
    var springs:[Spring] = []

    override func viewDidLoad() {
        super.viewDidLoad()
        setSprings()
        var right = 0.0
        for (index, spring) in springs.enumerated() {
            let springView = SpringView(spring: spring)
            if index > 0 {
                let last = self.view.subviews.last!
                right = last.frame.origin.x + last.frame.size.width
            }
            springView.frame = CGRect(x: right + 3, y: springView.frame.origin.y, width: springView.frame.size.width, height: springView.frame.size.height)
            self.view.addSubview(springView)
        }
    }
    
    func setSprings() {
        
        springs = [
            Spring(title: "185", tasks: [
                Task(title: "连接诊断系统", progress: 100, springProgress: 1),
            ]),
            Spring(title: "186", tasks: [
                Task(title: "三方心率设备直连(数据平台)", progress:  100, springProgress: 1),
            ]),
            Spring(title: "187 + 188", tasks: [
                Task(title: "手环新绑定设计/讨论", progress: 100, springProgress: 0.4 * 2),
                Task(title: "手环新绑定", progress: 10, springProgress: 0.6 * 2),
            ], length: 2),
          
            Spring(title: "189", tasks: [
                Task(title: "小器械首页容器化(APP)", progress: 0, springProgress: 0.3),
                Task(title: "三星手表接入(增长)", progress: 0, springProgress: 0.7),
            ]),
            Spring(title: "190", tasks: [
                Task(title: "睡眠新体系", progress: 0, springProgress: 1),
            ]),
            
            Spring(title: "191", tasks: [
                Task(title: "消息通知诊断", progress: 0, springProgress: 1),
            ]),
        ]
    }
}

class Spring {
    var title = ""
    var tasks:[Task] = []
    var length = 1
    
    
    init(title: String = "", tasks: [Task], length: Int = 1) {
        self.title = title
        self.tasks = tasks
        self.length = length
    }
}

class SpringView: NSView {
    var spring = Spring(title: "", tasks: [])
    
    init(spring: Spring) {
        super.init(frame: CGRect(x: 0, y: 200, width: springWidth * Double(spring.length), height: springHeight + 40))
        self.color = NSColor.lightGray.withAlphaComponent(0.2)
        self.spring = spring
        var right = 0.0
        
        let titleLebel = NSTextView.init()
        titleLebel.string = spring.title
        titleLebel.frame = CGRect(x: 0, y: springHeight + 20, width: self.frame.size.width, height: 40)
        self.addSubview(titleLebel)
        titleLebel.color = NSColor.clear
        titleLebel.drawsBackground = false
        titleLebel.isEditable = false
        titleLebel.alignment = .center
        titleLebel.font = NSFont.systemFont(ofSize: 15)
        
        for (index, task) in spring.tasks.enumerated() {
            let taskView = TaskView.init(task: task)
            if index > 0 {
                let last = self.subviews.last!
                if last != titleLebel {
                    right = last.frame.origin.x + last.frame.size.width
                }
            }
            taskView.frame = CGRect(x: right, y: taskView.frame.origin.y, width: taskView.frame.size.width, height: taskView.frame.size.height)
            self.addSubview(taskView)
        }
        self.layer?.cornerRadius = 7
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

class Task {
    var title: String = ""
    var progress: Int = 0
    var springProgress = 0.0
    
    init(title: String, progress: Int, springProgress: Double) {
        self.title = title
        self.progress = progress
        self.springProgress = springProgress
    }
}

class TaskView: NSView {
    var label: NSTextView = NSTextView.init()
    var progressView: NSView! = NSView.init()
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    init(task:Task) {
        super.init(frame: NSRect.zero)
        self.color = NSColor.lightGray.withAlphaComponent(0.2)
        addSubview(progressView)
        addSubview(label)
        self.layer?.cornerRadius = 7
        self.layer?.masksToBounds = true
        
        self.frame = CGRect(x: 0, y: 0, width: task.springProgress * springWidth, height: springHeight)
        self.label.string = task.title
        self.label.alignment = .center
        self.label.font = NSFont.systemFont(ofSize: 12)
        
        print(self.frame.size.width / Double(task.title.count))
        
        let x = self.frame.size.width / Double(task.title.count)
        if x < 13 {
            self.label.font = NSFont.systemFont(ofSize: 11)
        }
        if x < 11 {
            self.label.font = NSFont.systemFont(ofSize: 10)
        }
        if x < 10 {
            self.label.font = NSFont.systemFont(ofSize: 8)
        }
        
//        if task.title.count > 7 {
//            self.label.font = NSFont.systemFont(ofSize: 11)
//        } else if task.title.count > 9 {
//            self.label.font = NSFont.systemFont(ofSize: 10)
//        }
        
        self.label.drawsBackground = false
        self.label.color = NSColor.clear
        self.label.alphaValue = 0.8
        self.label.isEditable = false
        self.label.frame = CGRect(x: 0, y: 0, width: self.frame.size.width, height: 0)
        self.label.sizeToFit()
        self.label.frame = CGRect(x: 0, y: (self.frame.size.height - self.label.frame.size.height) * 0.5, width: self.frame.size.width, height: self.label.frame.size.height)
        self.progressView.frame = CGRect(x: 0, y: 0, width: self.frame.size.width * CGFloat(task.progress) / 100.0, height: self.frame.size.height)
        
        if task.progress == 0 {
            progressView.color = NSColor.init(hex: "EA6B66")
        } else if (task.progress == 100) {
            progressView.color = NSColor.init(hex: "97D077")
        } else {
            progressView.color = NSColor.init(hex: "FFD966")
        }
        self.color = progressView.color?.withAlphaComponent(0.3)
        self.layer?.borderWidth = 1
        self.layer?.borderColor = progressView.color!.cgColor
    }
}



