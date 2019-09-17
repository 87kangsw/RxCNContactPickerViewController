//
//  RxCNContactPickerDelegateProxy.swift
//  ContactRx
//
//  Created by Kanz on 09/09/2019.
//  Copyright © 2019 KanzDevelop. All rights reserved.
//

import ContactsUI
import RxCocoa
import RxSwift

extension CNContactPickerViewController: HasDelegate {
    public typealias Delegate = CNContactPickerDelegate
}

public class RxCNContactPickerDelegateProxy: DelegateProxy<CNContactPickerViewController, CNContactPickerDelegate>, DelegateProxyType, CNContactPickerDelegate {
   
    public weak private(set) var pickerVC: CNContactPickerViewController?
    
    public init(pickerVC: ParentObject) {
        self.pickerVC = pickerVC
        super.init(parentObject: pickerVC, delegateProxy: RxCNContactPickerDelegateProxy.self)
    }
    
    static func registerKnownImplementations() {
        self.register { RxCNContactPickerDelegateProxy(pickerVC: $0) }
    }
    
    static func currentDelegate(for object: CNContactPickerViewController) -> CNContactPickerDelegate? {
        return object.delegate
    }
    
    static func setCurrentDelegate(_ delegate: CNContactPickerDelegate?, to object: CNContactPickerViewController) {
        object.delegate = delegate
    }
}
