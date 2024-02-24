## ➕➖계산기✖️➗

### 목차
[1. 소개](#1-소개)  
[2. 팀원](#2-팀원)  
[3. 타임라인](#3-타임라인)  
[4. 프로젝트 구조](#4-프로젝트-구조)  
[5. 실행 화면](#5-실행-화면)  
[6. 트러블슈팅](#6-트러블슈팅)  
[7. 팀 회고](#7-팀-회고)  
[8. 참고 자료](#8-참고-자료)  

---
### 1. 소개
#### **➕➖계산기✖️➗**
간단한 사칙연산을 수행하는 계산기입니다. 계산할 때마다 계산 내역을 기록해 어떤 계산을 했는 지 스크롤 뷰를 조작해 확인할 수 있습니다. 🔎

<br>

### 2. 팀원
| <img src="https://avatars.githubusercontent.com/u/27756800?s=48&v=4" width="200"> | <img src="https://avatars.githubusercontent.com/u/65929788?v=4" width="200"> |
| :---: | :---: |
| Prism ([Github](https://github.com/PrismSpirit)) | Hamzzi ([Github](https://github.com/kkomgi)) |

<br>

### 3. 타임라인
#### 🗓 2024/02/22

| 변경사항 | 설명 |
| -------- | ---- |
| **ViewController 추가** | 새로운 `ViewController`가 프로젝트에 추가됨 |
| **CalculateError 추가** | 계산 중 발생할 수 있는 에러를 관리하는 `CalculateError` 타입 추가 |
| **String 확장 이동** | `String(with:)` 메소드가 `extension` 폴더에서 `ExpressionParser`로 이동. Prism과 Hamzzi 코드 혼합 |
| **View Controller 합치기** | 여러 `ViewController`를 합치는 과정에서 `@IBOutlet` 재연결 완료 |
| **연산자 문자 변경** | 빼기, 곱하기, 나누기 연산자의 문자 변경 |
| **0으로 나누기 에러 핸들링 추가** | 0으로 나누었을 때의 에러 핸들링 로직 추가 |
| **계산기 구현 수정** | `Model/Formula.swift`에서 `result()` 함수 수정: 오류 처리, 검증 로직 및 계산 로직 수정 |
| **DoublyLinkedList 및 Node 추가** | `Queue`에서 사용할 `DoublyLinkedList`와 `Node` 추가 |
| **Queue 카운트 방법 수정** | `Queue`의 카운트 방법 수정 |
| **StringForm 이동** | `StringForm`을 `ViewController` 안으로 이동 |
| **ViewCtrl 명칭 변경 및 final 추가** | `ViewController`의 명칭 변경 및 `final` 키워드 추가 |
| **Private 접근 제어 추가** | 외부에서 접근하지 않는 경우 `private` 접근 제어자 추가 |
| **메소드 및 변수명 변경** | `[acButtonTouchedUP]` -> `[acButtonTouchedUp]`, `operator`와 `operand` 변수명 변경 |

<br>

### 4. 프로젝트 구조
#### Class Diagram
![img](<https://raw.githubusercontent.com/kkomgi/ios-calculator-app/Team_step1/Calculator_ClassDiagram.png>)

<br>

### 5. 실행 화면

| ![img](<https://raw.githubusercontent.com/kkomgi/ios-calculator-app/Team_step1/Screenshots/subtract.gif>) | ![img](<https://raw.githubusercontent.com/kkomgi/ios-calculator-app/Team_step1/Screenshots/ACButton.gif>) | ![img](<https://raw.githubusercontent.com/kkomgi/ios-calculator-app/Team_step1/Screenshots/CEButton.gif>) |
| :---: | :---: | :---: |
| 뺄셈 계산하기 | AC버튼 누르기 | CE버튼 누르기 |

| ![img](<https://raw.githubusercontent.com/kkomgi/ios-calculator-app/Team_step1/Screenshots/signToggleButton.gif>) | ![img](<https://raw.githubusercontent.com/kkomgi/ios-calculator-app/Team_step1/Screenshots/dotOnlyOnce.gif>) | ![img](<https://raw.githubusercontent.com/kkomgi/ios-calculator-app/Team_step1/Screenshots/operatorsInput.gif>) |
| :---: | :---: | :---: |
| 부호 변환하기 | 소수점은 한 번만 | 연산자 바꾸기 |

| ![img](<https://raw.githubusercontent.com/kkomgi/ios-calculator-app/Team_step1/Screenshots/divisionByZero.gif>) | ![img](<https://raw.githubusercontent.com/kkomgi/ios-calculator-app/Team_step1/Screenshots/automaticallyChangeDoubleToIntWhenFractionIs0.gif>) | ![img](<https://raw.githubusercontent.com/kkomgi/ios-calculator-app/Team_step1/Screenshots/automaticallyScrollDownToBottom.gif>) |
| :---: | :---: | :---: |
| 0으로 나누기 | 결과가 정수일 경우 소수점 생략 | 계산 입력 시 자동 스크롤 |

<br>

### 6. 트러블슈팅

#### *Calculator/Calculator/Model/Formula.swift*
```swift
// 변경 전
-    mutating func result() -> Double {
-        var result = 0.0
-        while !operands.isEmpty {
-            if let operand = operands.dequeue() {
-                result += operand
```
```swift
// 변경 후
+    mutating func result() throws -> Double {
+        guard operands.count == operators.count + 1,
+              var result = operands.dequeue() else {
+            throw CalculateError.invalidFormula
+        }
+        
+        while !operators.isEmpty {
+            guard let `operator` = operators.dequeue(),
+                  let operand = operands.dequeue() else {
+                throw CalculateError.invalidFormula
             }
+            
+            result = try `operator`.calculate(lhs: result, rhs: operand)
         }
+        
```
- 수식의 유효성 검증: 초기 코드는 피연산자들만을 더하는 간단한 계산을 수행했고, 연산자의 유무나 수식의 정확성을 검증하지 않았습니다. 변경된 코드는 피연산자의 수가 연산자 수보다 하나 더 많은지 확인합니다. 수식이 유효한지 먼저 검증합니다. 이것은 수식의 구조적 정확성을 보장합니다.
- 오류 처리: 변경 전 코드는 잘못된 수식이 입력되었을 때 이를 대응하는 방법이 없었습니다. 수정된 코드는 
유효하지 않은 수식이 입력되었을 때 CalculateError.invalidFormula 로 오류를 명확히 알릴 수 있습니다.
- 계산 로직 재구현: 초기 코드는 모든 피연산자를 단순히 더하는 방식으로 구현되어 있습니다. 다양한 종류의 연산자를 처리할 수 없었습니다. 변경된 코드는 연산자 큐에서 연산자를 꺼내서 해당 연산자에 따라 동적으로 계산을 수행할 수 있게 되었습니다.
- 타입 안전성: try 키워드의 사용으로 인해, calculate 메소드가 오류를 던질 가능성이 있는 경우 이를 명시적으로 처리할 수 있게 되었습니다.


#### *Calculator/Calculator/Model/CalculatorItemQueue.swift*
```swift
// 변경 전
-    var count: Int {
-        guard head != nil else { return 0 }
-        
-        var cnt = 0
-        var current = head
-        
-        repeat {
-            cnt += 1
-            current = current?.next
-        } while current != nil
-        
-        return cnt
-    }
```
```swift
// 변경 후
+    var count: Int = 0
```
- 집합에 대해서는 이 방법이 성능 저하를 일으킬 수 있습니다. 변경된 코드에서는 count를 직접 관리함으로써, 큐의 길이를 O(1) 시간 복잡도로 즉시 얻을 수 있게 되었습니다. 이는 특히 큐의 크기가 크거나 count 속성에 자주 접근해야 하는 경우 중요한 성능 이점을 제공합니다.
- 코드 간소화: 큐의 길이를 계산하기 위해 모든 노드를 순회하는 로직은 코드를 복잡하게 만들고, 오류 발생 가능성을 높일 수 있습니다. count 변수를 직접 업데이트하는 방식으로 변경함으로써 코드의 복잡성을 크게 줄였습니다. 이는 코드의 가독성과 유지보수성을 향상시킵니다.
- 오류 감소: 노드 순회를 통한 count 계산 방식은 현재 노드를 추적하는 로직에서 실수하기 쉽습니다. 예를 들어, 순회 로직에서 current 노드의 업데이트를 잘못 처리하면 무한 루프나 잘못된 count 값이 발생할 수 있습니다. count 변수를 직접 관리함으로써 이러한 종류의 오류 가능성을 줄일 수 있습니다.


#### *Calculator/Calculator/Controller/ViewController.swift*
```swift
// 변경 전
-enum StringForm {
-    case input
-    case output
-}
```
```swift
// 변경 후
class ViewController: UIViewController {
+    enum StringForm {
+        case input
+        case output
+    }
+    
```
- 스코프 제한: StringForm 열거형을 ViewController 내부로 이동시킴으로써, 이 열거형의 사용 범위를 ViewController로 제한합니다. 다른 클래스나 모듈에서 StringForm 열거형을 실수로 잘못 사용하는 것을 방지합니다.
- 네임스페이스 충돌 방지: 프로젝트 내에 동일한 이름의 다른 열거형이나 타입이 있을 경우, 스코프를 한정짓지 않으면 이름 충돌이 발생할 수 있습니다. ViewController 내부로 StringForm을 이동시킴으로써 이러한 충돌 위험을 줄일 수 있습니다.
- 코드의 가독성 향상: StringForm 열거형을 클래스 내부에 위치시키면, StringForm과 ViewController와의 관계를 더 쉽게 이해할 수 있습니다.
- 캡슐화 : 특정 클래스 내에서만 타입이 사용되면 클래스의 내부 구현을 외부로부터 잘 숨겨줍니다. 결과적으로 클래스의 인터페이스만을 통해 상호작용하게 합니다.


#### *Calculator/Calculator/Controller/ViewController.swift*
```swift
// 변경 전
-class ViewController: UIViewController {
```
```swift
// 변경 후
+final class CalculateViewController: UIViewController {
     enum StringForm {
         case input
         case output
```
- 명확한 클래스 이름: ViewController에서 CalculateViewController로 이름을 변경함으로써, 이 클래스의 역할과 사용 목적이 더 명확해집니다.
- 상속 방지: final 키워드를 클래스 선언에 추가함으로써, 이 클래스가 다른 클래스에 의해 상속되는 것을 방지합니다. 또한 이것은 확장을 위해 설계되지 않았음을 명시적으로 나타냅니다.


#### *Calculator/Calculator/Controller/ViewController.swift*
```swift
// 변경 전
-    var expression = ""
-    var `operator`: Operator?
-    var operand = "0"
-    var isOperatorActivated = false
-    var errorHasOccured = false
+    private var expression = ""
+    private var `operator`: Operator?
+    private var operand = "0"
+    private var isOperatorActivated = false
+    private var errorHasOccured = false
```
```swift
// 변경 후
-    @IBOutlet var operatorLabel: UILabel!
-    @IBOutlet var operandLabel: UILabel!
-    @IBOutlet var logsStackView: UIStackView!
+    @IBOutlet private var operatorLabel: UILabel!
+    @IBOutlet private var operandLabel: UILabel!
+    @IBOutlet private var logsStackView: UIStackView!
```
- 캡슐화 강화: private 접근 제어자는 해당 변수나 함수를 정의한 클래스 또는 구조체의 내부에서만 접근할 수 있게 제한합니다.
- 잘못된 외부 접근 방지: 클래스 내부 상태를 관리하는 변수나 UI 요소가 외부에서 임의로 변경되는 것을 방지합니다.

<br>

### 7. 팀 회고
#### 잘한 점 😍
- 프로젝트를 시작할 때 UML을 먼저 그리고 Model의 각 타입에 대해 모듈화하여 코드를 작성했기 때문에, 각자 작성한 코드를 비교하여 합칠 때 비교적 간단하게 코드를 교체할 수 있었습니다.

#### 개인적으로 아쉬웠던 점 💦
- Prism: 사용자 입력이 매우 다양한 조합으로 들어올 수 있기 때문에 정말 많은 경우에 대해 예외 처리를 고려해야 했습니다. 꽤나 많은 예외(소수점은 각 피연산자에 하나만 있어야함, 0으로 나누기, 사용자가 보게되는 숫자에 대해 thousand separator`,`찍기, 결과가 정수일 경우 소수점 생략하기 등)에 대해 적절한 처리를 해주었습니다만 그럼에도 불구하고 처리되지 않은 예외(double형의 정확도 문제, 매우 큰 수에 대해 계산 버튼을 2번 누를 경우 parse가 오작동하는 문제)가 있어 아쉬움이 남았습니다.
- Hamzzi: 같은 팀원의 진도보다 뒤쳐진 상태였기 때문에 직접 구현한 코드가 매우 기초적인 상태였던 점이 매우 아쉬웠습니다. 또한 그 상태에서 직접 보완하지 못 하였던 점도 있습니다. 하지만 프리즘과 저의 코드가 합쳐지면서 트러블 슈팅을 한 눈에 볼 수 있었습니다. 부족한 시간임에도 계산기 프로젝트의 완성 루트를 확인해볼 수 있었습니다. 좋은 경험이었습니다.

<br>

### 8. 참고 자료
📍[Generics](<https://docs.swift.org/swift-book/documentation/the-swift-programming-language/generics>)  
📍[Protocols](<https://docs.swift.org/swift-book/documentation/the-swift-programming-language/protocols>)  
📍[Testing your apps in Xcode](<https://developer.apple.com/documentation/xcode/testing-your-apps-in-xcode>)  
📍[View Programming Guide for iOS](<https://developer.apple.com/library/archive/documentation/WindowsViews/Conceptual/ViewPG_iPhoneOS/WindowsandViews/WindowsandViews.html#//apple_ref/doc/uid/TP40009503-CH2-SW1>)  
📍[UIStackView](<https://developer.apple.com/documentation/uikit/uistackview>)  
📍[UIScrollView](<https://developer.apple.com/documentation/uikit/uiscrollview>)  
