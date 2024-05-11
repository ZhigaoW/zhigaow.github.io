/// https://docs.swift.org/swift-book/documentation/the-swift-programming-language
/// 财富的积累是瞬间的；年轻的时候重点应该放在能力的软硬件提升

/// 简体中文文档
/// https://developer.apple.com/cn/documentation/






/// 类型别名
typealias AudioSample = UInt16

///  swift 的语法
let cannotBeNegative: UInt8 = 0

/// tuple 类型的使用方法
let http404Error = (404, "Not Found")
let http200Status = (statusCode: 200, description: "OK")
print("The status code is \(http200Status.statusCode)")

/// swift 语言 有一种类型叫做 Optionals
/// optionals indicate that a constant or variable is allowed to have “no value”
/// no value 一般用 nil表示 (nil not just a null pointer)

/// Optionals is just a enum
/*
enum Optional<T> {
  case none
  case some(T) 
}

var hello: String?  var hello: Optional<String> = .none
var hello: String? = "hello"  var hello: Optional<String> = .some(hello)
var hello: String? = nil  var hello: Optional<String> = .none
*/

/// 此时 possibleNumber 是 Non-Optionals
let possibleNumber = "aabb";
/// The type of convertedNumber is "optional Int"
/// 因为被强制转化，类型发生了变化
let convertedNumber = Int(possibleNumber)
/// ?的使用 serverResponseCode是一个Optional类型
var serverResponseCode: Int? = 404
/// 这个时候serverResponseCode是无值（no value）
serverResponseCode = nil

/// Optional使用前必须做一些事情
/// 1. 一种展开Optionals值的方法
if let actualNumber = Int(possibleNumber) {
    print("The string \"\(possibleNumber)\" has an integer value of \(actualNumber)")
} else {
    print("The string \"\(possibleNumber)\" couldn't be converted to an integer")
}

/// 2. 给Optional 提供可选值
/// 有值选左边，没有值选右边
let name: String? = "Best"
let greeting = "Hello, " + (name ?? "friend") + "!"
print(greeting)
/// Prints "Hello, friend!"

/// 3. 这里是强制展开(force unwrap)
/// 程序员需要对枪支展开的结果负责
/// let number = possibleNumber!
let input = readLine()
let inputValue = Int(input!)
guard let number = inputValue else {
    /// 这里必须是fatal error?
    fatalError("The number was invalid")
}


/// Implicity Unwrapped Optionals
var assumedString: String! = "An implicitly unwrapped optional string."
let implicitString: String = assumedString /// Unwrapped automatically
assumedString = nil /// 这样是ok的不会导致程序崩溃 但是需要你去保证不会导致程序崩溃

/// 总结：swift 一共有三种类型
/// 1. Non-optional: 不能是nil，使用的时候大可放心
/// 2. Optional: 可能会是nil，使用前必须做判断；或者强制解包
/// 3. Implictiy Unwrapped Optionals: 使用前不必解包，需要程序员自己去保证不会引发程序崩溃




/// swift 语言的 foundation 和 standard 有什么区别
/// https://developer.apple.com/documentation/foundation/
/// https://developer.apple.com/documentation/swift/swift-standard-library
/// 简单来讲相当于c语言的标准库和<linux/xxx.h>之于linux的区别
/// foundation 是 <linux/xxx.h>




/// Error Handling
/// You use error handling to respond to error conditions your program may encounter during execution.
/// https://docs.swift.org/swift-book/documentation/the-swift-programming-language/errorhandling

///
/// 1. swift 语言中的一种常用用法是用enum 来定义 Error
/// 2. func (xxx: Xxx) throws -> [] {} 这种形式来写可能抛出异常的函数
/// 3. 异常的赋值前面需要有 try
/// 4. do catch  |  try!  | try? 三种方式来进行错误处理

struct Item {
    var price: Int
    var count: Int
}


enum VendingMachineError: Error {
    case invalidSelection
    /// 这个东西是function还是什么
    case insufficientFunds(coinsNeeded: Int)
    case outOfStock
}

/// VendingMachine: 自动贩卖机
class VendingMachine {
    var inventory = [
        "Candy Bar": Item(price: 12, count: 7),
        "Chips": Item(price: 10, count: 4),
        "Pretzels": Item(price: 7, count: 11)
    ]
    
    /// 存入的硬币
    var coinsDeposited = 0
    func vend(itemNamed name: String) throws {
        guard let item = inventory[name] else {
            throw VendingMachineError.invalidSelection
        }
    
        guard item.price > 0 else {
            throw VendingMachineError.outOfStock
        }
        
        guard item.price <= coinsDeposited else {
            throw VendingMachineError.insufficientFunds(coinsNeeded: item.price - coinsDeposited)
        }
        
        coinsDeposited -= item.price
        
        var newItem = item
        newItem.count -= 1
        inventory[name] = newItem
        print("Dispensing \(name)")
    }
}

/// init  函数也会向上传递
struct PurchasedSnack {
    let name: String
    init(name: String, vendingMachine: VendingMachine) throws {
        try vendingMachine.vend(itemNamed: name)
        self.name = name
    }
}

var v1: VendingMachine = VendingMachine()

/// 前面必须有 try ， 否则报错
/// PurchasedSnack(name: "testPurchasedSnack", vendingMachine: v1)
/// 一般是配合 do catch 使用
try PurchasedSnack(name: "testPurchasedSnack", vendingMachine: v1)

let favoriteSnacks = [
    "Alice": "Chips",
    "Bob": "Licorice",
    "Eve": "Pretzels",
]

/// try语句会把错误一直向上传递
func buyFavoriteSnack(person: String, vendingMachine: VendingMachine) throws {
    let snackName = favoriteSnacks[person] ?? "Candy Bar"
    try vendingMachine.vend(itemNamed: snackName)
}

var vendingMachine = VendingMachine()
vendingMachine.coinsDeposited = 8
do {
    try buyFavoriteSnack(person: "Alice", vendingMachine: vendingMachine)
    print("Success! Yum.")
} catch VendingMachineError.invalidSelection {
    print("Invalid Selection.")
} catch VendingMachineError.outOfStock {
    print("Out of Stock.")
} catch VendingMachineError.insufficientFunds(let coinsNeeded) {
    print("Insufficient funds. Please insert an additional \(coinsNeeded) coins.")
} catch {
    print("Unexpected error: \(error).")
}

/// try? converable to optional
/// try! disable error to propagation



/* Assertions and Preconditions */
/* Debugging with Assertions */
/* Enforcing Preconditions */




/// 属性
/// Properties
/// Access stored and computed values that are part of an instance or type.
/// Swift 提供了多种属性修饰符（或称为特性），它们用于给变量、常量、类型或函数提供额外的信息或修改其行为。除了 @propertyWrapper，还有一些其他重要的属性修饰符：

/// 1. @IBOutlet 和 @IBAction: 这些修饰符专用于 Apple 的 iOS 和 macOS 开发，在 Interface Builder 中用于连接 UI 组件和代码。@IBOutlet 用于引用界面元素，而 @IBAction 用于响应界面元素的动作（如按钮点击）。
/// 2. @objc 和 @objcMembers: 这些修饰符用于 Swift 与 Objective-C 的互操作性。@objc 可用于标记单个成员（如方法、属性或类），使其在 Objective-C 代码中可见。@objcMembers 应用于类，使得类的所有成员默认都在 Objective-C 中可见。
/// 3. @autoclosure: 用于自动将表达式封装成闭包。这对于延迟表达式的计算很有用，尤其是在条件语句或断言中。
/// 4. @escaping: 当闭包作为参数传递给函数，并且这个闭包在函数返回后才被调用时，需要使用 @escaping 修饰符。这对于异步操作或存储闭包以后使用的情况很重要。
/// 5. @discardableResult: 用于函数或方法，允许调用者忽略返回值而不产生警告。这在设计一些返回值不总是必需的 API 时很有用。
/// 6. @available: 用于指定特定的平台和版本要求。它可以帮助开发者处理不同版本间的兼容性问题，通过标记某个类、结构、枚举、函数或方法仅在特定的操作系统版本或更高版本中可用。
/// 7. @dynamicMemberLookup: 允许实例动态地调用其属性或方法，而无需在编译时定义它们。这对于与动态语言的互操作性或某些特殊的编程模式很有用。
/// 8. @main: 用于标记程序的入口点。在 Swift 5.3 及以后的版本中，@main 用于指示哪个类或结构体包含了程序的启动逻辑。
/// 9. @resultBuilder: 用于构建特定格式或结构的结果，如在 Swift 的 DSL（领域特定语言）中常见。

/// 这些修饰符在 Swift 编程中扮演重要角色，可以用来控制代码的访问性、性能、兼容性和其他特性。了解和正确使用这些修饰符对于编写高效、可维护和功能强大的 Swift 代码至关重要。



/// 对于 @propertyWraper 的使用方法如下
/// 1. 可以设置被赋值和改变值的行为

/// Property Wrappers

@propertyWrapper
struct TwelveOrLess {
    private var number = 0
    var wrappedValue: Int {
        /// 右值
        get {
            print("get ...")
            return number
        }
        /// 左值
        set {
///            print("change the value")
            number = min(newValue, 12)
        }
    }
}

struct SmallRectangle {
    @TwelveOrLess var height: Int
    @TwelveOrLess var width: Int
}

var rectangle = SmallRectangle()
print(rectangle.height)




/* 并发 */
// async
// throws 和 async 如何配合



/* Optional Chain */
// https://docs.swift.org/swift-book/documentation/the-swift-programming-language/optionalchaining



/// difference between Struct & Class 
/// Struct    Value type        Copyed        Copy on write      Functional Programming        No-inheritance        Free init with all vars    let / var
/// Class     Reference type    Pointers      reference count    Object-oriented Programming   Inheritance(sigle)    Free init with no vars     always var



/// protocol only define func it can be inhert
/// actutally it is a type, can be use in normal place
/// can use some key words some or any





