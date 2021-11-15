//
//  Observable.swift
//  Starships
//
//  Created by TejaDanasvi on 15/11/21.
//
import Foundation

final class Observable<T> {
  typealias Listener = (T) -> Void
  private(set) var listeners: [Listener] = []
  let queue: DispatchQueue?

  var value: T {
    didSet {
      self.executeListeners()
    }
  }

  init(_ value: T, syncQueue: DispatchQueue? = nil) {
    self.value = value
    self.queue = syncQueue
  }

  convenience init?(_ value: T?, syncQueue: DispatchQueue? = nil) {
    guard let v = value else { return nil }
    self.init(v, syncQueue: syncQueue)
  }

  func executeListeners() {
    listeners.forEach { $0(value) }
  }

  func unbindAllListeners() {
    listeners.removeAll()
  }

  func bind(executeImmediately: Bool = true, listener: @escaping Listener) {
    self.listeners.append(listener)
    if executeImmediately {
      listener(value)
    }
  }

  func singleBind(executeImmediately: Bool = true, listener: @escaping Listener) {
    unbindAllListeners()
    bind(executeImmediately: executeImmediately, listener: listener)
  }
}

extension Observable where T: Collection {
  var isEmpty: Bool { self.value.isEmpty }
  
  var isNotEmpty: Bool { !self.isEmpty }
}

