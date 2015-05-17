//
//  FTWorkTimesFormViewController.swift
//  TimeSheet
//
//  Created by TomomuraRyota on 2015/05/16.
//  Copyright (c) 2015年 TomomuraRyota. All rights reserved.
//

import UIKit
import XLForm

protocol FTWorkTimesForm {
    func updatedWorkTime(targetDate: NSDate, workTime: WorkTime)
}

class FTWorkTimesFormViewController: XLFormViewController, XLFormDescriptorDelegate {
    
    // MARK: Tags
    
    // フォームの部品を識別するTag
    struct tag {
        static let startTime = "startTime"
        static let endTime = "endTime"
        static let setRegularTimeToStartTime = "setRegularTimeToStartTime"
        static let setRegularTimeToEndTime = "setRegularTimeToEndTime"
        static let destory = "destroy"
    }
    
    // MARK: Variables
    var targetDate : NSDate!
    var workTime : WorkTime?
    var delegate: FTWorkTimesForm?
    
    // MARK: IBOutlets
    @IBOutlet weak var saveButton: UIBarButtonItem!
    
    // MARK: View Life Cycles
    
    override func viewDidLoad() {
        self.workTime = WorkTime.findByTargetDate(self.targetDate, context: NSManagedObjectContext.MR_defaultContext())
        self.initializeForm()
        super.viewDidLoad()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    // MARK: Initialize Forms
    
    /**
    出勤時間を入力するフォームの生成
    
    :param: form <#form description#>
    */
    func setFormForStartTime(form: XLFormDescriptor) {
        let section : XLFormSectionDescriptor = XLFormSectionDescriptor.formSectionWithTitle("出勤時間") as! XLFormSectionDescriptor
        var row : XLFormRowDescriptor

        row = XLFormRowDescriptor(tag: tag.startTime, rowType: XLFormRowDescriptorTypeTimeInline, title: "出勤")
        row.value = self.workTime?.startTime != nil ? self.workTime!.startTime : NSDate().roundDateToFlooringMinutes(15)
        row.cellConfigAtConfigure.setObject(15, forKey: "minuteInterval")
        section.addFormRow(row)
        
        row = XLFormRowDescriptor(tag: tag.setRegularTimeToStartTime, rowType: XLFormRowDescriptorTypeButton, title: "定時")
        row.action.formSelector = "onClickSetRegularTime:"
        section.addFormRow(row)

        form.addFormSection(section)
    }
    
    /**
    退勤時間を入力するフォームの生成
    
    :param: form <#form description#>
    */
    func setFormForEndTime(form: XLFormDescriptor) {
        let section : XLFormSectionDescriptor = XLFormSectionDescriptor.formSectionWithTitle("退勤時間") as! XLFormSectionDescriptor
        var row : XLFormRowDescriptor
        
        row = XLFormRowDescriptor(tag: tag.endTime, rowType: XLFormRowDescriptorTypeTimeInline, title: "退勤")
        row.value = self.workTime?.endTime != nil ? self.workTime!.endTime : NSDate().roundDateToFlooringMinutes(15)
        row.cellConfigAtConfigure.setObject(15, forKey: "minuteInterval")
        section.addFormRow(row)
        
        row = XLFormRowDescriptor(tag: tag.setRegularTimeToEndTime, rowType: XLFormRowDescriptorTypeButton, title: "定時")
        row.action.formSelector = "onClickSetRegularTime:"
        section.addFormRow(row)
        
        form.addFormSection(section)
    }
    
    /**
    データを削除するためのフォームボタンの設置
    
    :param: form <#form description#>
    */
    func setFormForDestory(form: XLFormDescriptor) {
        if self.workTime != nil {
            let section : XLFormSectionDescriptor = XLFormSectionDescriptor.formSectionWithTitle(nil) as! XLFormSectionDescriptor
            form.addFormSection(section)
            
            let row : XLFormRowDescriptor = XLFormRowDescriptor(tag: tag.destory, rowType: XLFormRowDescriptorTypeButton, title: "削除")
            row.cellConfig.setObject(UIColor.redColor(), forKey: "contentView.backgroundColor")
            row.cellConfig.setObject(UIColor.whiteColor(), forKey: "textLabel.textColor")
            row.action.formSelector = "onClickDestory"
            
            section.addFormRow(row)
        }
    }
    
    // MARK: Form Actions
    
    /**
    当該データの削除
    */
    func onClickDestory() {
        self.workTime!.MR_deleteEntity()
        self.saveDefaultContenxt()
    }
    
    /**
    対象の時間に定時を設定する
    
    :param: row <#row description#>
    */
    func onClickSetRegularTime(row: XLFormRowDescriptor) {
        println(row.tag)
    }
    
    // MARK: Helpers
    
    /**
    入力フォームの初期化
    
    :returns: <#return value description#>
    */
    func initializeForm() {
        var form : XLFormDescriptor
        
        let formatter = NSDateFormatter()
        formatter.dateStyle = NSDateFormatterStyle.MediumStyle
        formatter.timeStyle = NSDateFormatterStyle.NoStyle
        form = XLFormDescriptor(title: formatter.stringFromDate(self.targetDate)) as XLFormDescriptor
        
        self.setFormForStartTime(form)
        self.setFormForEndTime(form)
        self.setFormForDestory(form)
        
        self.form = form
    }
    
    /**
    デフォルトコンテキストの保存
    */
    func saveDefaultContenxt() {
        NSManagedObjectContext.MR_defaultContext().MR_saveOnlySelfWithCompletion { (result, error) -> Void in
            self.delegate?.updatedWorkTime(self.targetDate!, workTime: self.workTime!)
            self.navigationController?.popToRootViewControllerAnimated(true)
        }
    }
    
    // MARK: IBActions
    
    /**
    Saveを押下した際に呼び出される
    
    :param: sender <#sender description#>
    */
    @IBAction func onClickSave(sender: AnyObject) {
        
        var attributes = [String: AnyObject]()
        
        for section in self.form.formSections {
            let sectionDescriptor : XLFormSectionDescriptor = section as! XLFormSectionDescriptor
            for row in sectionDescriptor.formRows {
                let sectionDescriptor : XLFormSectionDescriptor = section as! XLFormSectionDescriptor
                let rowDescriptor : XLFormRowDescriptor = row as! XLFormRowDescriptor
                
                if rowDescriptor.value != nil {
                    attributes[rowDescriptor.tag] = rowDescriptor.value
                }
            }
        }
        
        if (self.workTime == nil) {
            self.workTime = WorkTime.MR_createEntity() as! WorkTime!
        }
        
        self.workTime!.setValuesForKeysWithDictionary(attributes)
        self.workTime!.targetDate = self.targetDate
        
        self.saveDefaultContenxt()
    }
    
    // MARK: Highlight/Unhighlight
    
    override func beginEditing(rowDescriptor: XLFormRowDescriptor!) {
        super.beginEditing(rowDescriptor)
        
        self.saveButton.enabled = false
    }
    
    override func endEditing(rowDescriptor: XLFormRowDescriptor!) {
        super.endEditing(rowDescriptor)
        
        self.saveButton.enabled = true
    }
}
