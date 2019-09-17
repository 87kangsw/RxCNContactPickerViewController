//
//  CNContactPickerViewController+Rx.swift
//  ContactRx
//
//  Created by Kanz on 10/09/2019.
//  Copyright © 2019 KanzDevelop. All rights reserved.
//

#if os(iOS)

import ContactsUI
import RxCocoa
import RxSwift

extension Reactive where Base: CNContactPickerViewController {
    
    public var delegate: DelegateProxy<CNContactPickerViewController, CNContactPickerDelegate> {
        return RxCNContactPickerDelegateProxy.proxy(for: base)
    }
    
    public var didSelectContact: ControlEvent<CNContact> {
        let source = delegate.methodInvoked(.didSelectContact)
            .map { a in
                return try castOrThrow(CNContact.self, a[1])
        }
        return ControlEvent(events: source)
    }
    
    public var didSelectContactProperty: ControlEvent<CNContactProperty> {
        let source = delegate.methodInvoked(.didSelectContactProperty)
            .map { a in
                return try castOrThrow(CNContactProperty.self, a[1])
        }
        return ControlEvent(events: source)
    }
    
    public var didSelectContacts: ControlEvent<[CNContact]> {
        let source = delegate.methodInvoked(.didSelectContacts)
            .map { a in
                return try castOrThrow([CNContact].self, a[1])
        }
        return ControlEvent(events: source)
    }
    
    public var didSelectContactProperties: ControlEvent<[CNContactProperty]> {
        let source: Observable<[CNContactProperty]> = delegate.methodInvoked(#selector(CNContactPickerDelegate.contactPicker(_:didSelectContactProperties:)))
            .map { a in
                return try castOrThrow([CNContactProperty].self, a[1])
        }
        return ControlEvent(events: source)
    }
    
    public var didCancel: ControlEvent<Void> {
        let source: Observable<Void> = delegate.methodInvoked(#selector(CNContactPickerDelegate.contactPickerDidCancel(_:)))
            .map { _ in
                return ()
        }
        return ControlEvent(events: source)
    }
}

private func castOrThrow<T>(_ resultType: T.Type, _ object: Any) throws -> T {
    guard let returnValue = object as? T else {
        throw RxCocoaError.castingError(object: object, targetType: resultType)
    }
    return returnValue
}

// https://bugs.swift.org/browse/SR-3062
extension Selector {
    static let didSelectContact = #selector(CNContactPickerDelegate.contactPicker(_:didSelect:) as ((CNContactPickerDelegate) -> (CNContactPickerViewController, CNContact) -> Void)?)
    static let didSelectContactProperty = #selector(CNContactPickerDelegate.contactPicker(_:didSelect:) as ((CNContactPickerDelegate) -> (CNContactPickerViewController, CNContactProperty) -> Void)?)
    static let didSelectContacts = #selector(CNContactPickerDelegate.contactPicker(_:didSelect:) as ((CNContactPickerDelegate) -> (CNContactPickerViewController, [CNContact]) -> Void)?)
}

#endif
