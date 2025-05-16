import 'dart:ffi';

class Stack<T> {
  final List<T> stackList = [];

  void push(T) {
    stackList.add(T);
  }

  T? pop() {
    if (isEmpty()) return null;
    return stackList.removeLast();
  }

  @override
  String toString() {
    return 'Stack: ${stackList.join('\n')}';
  }

  bool isEmpty() {
    return stackList.isEmpty;
  }

  void removeAll() {
    stackList.clear();
  }
}

class Challenge {
  Stack stack = Stack();
  LinkedList linkdList = LinkedList();

  Challenge(Stack customStack) {
    stack = customStack;
  }
  Challenge.linkedlistCh(LinkedList customlink) {
    linkdList = customlink;
  }
  Challenge.defaultCh() {}

  void reverseList() {
    if (stack.stackList.isEmpty)
      print("Empty list...");
    else
      print(stack.stackList.reversed.join('\n'));
  }

  bool BalancetheParentheses(String word) {
    stack.removeAll();
    String char = "";
    for (int i = 0; i < word.length; ++i) {
      char = word[i];

      if (char.trim() == "") continue;

      if (char == "(" || char == "[" || char == "{") {
        stack.push(char);
      } else if (char == ")" || char == "]" || char == "}") {
        if (stack.isEmpty()) return false;
        String popedElement = stack.pop();
        if (popedElement == "(" && char != ")" ||
            popedElement == "[" && char != "]" ||
            popedElement == "{" && char != "}")
          return false;
      }
    }
    return stack.isEmpty();
  }

  void printReversedLinkedList() {
    if (linkdList.isEmpty) {
      print('Empty list');
      return;
    }

    List stack = [];
    Node? current = linkdList.head;

    while (current != null) {
      stack.add(current.value);
      current = current.next;
    }

    print(stack.reversed.join(' -> '));
  }

  Node? findMiddleNode() {
    if (linkdList.isEmpty) return null;
    int middleIndex = linkdList.numberOfNodes ~/ 2;
    return linkdList.nodeAt(middleIndex - 1);
  }

  void reverseOriginLinkedList() {
    Node? previous = null;
    Node? current = linkdList.head;
    linkdList.tail = linkdList.head;
    while (current != null) {
      Node? nextNode = current.next;
      current.next = previous;
      previous = current;
      current = nextNode;
    }
    linkdList.head = previous;
  }

  void removeAllOcurencesOf<E>(E value) {
    while (linkdList.head != null && linkdList.head!.value == value) {
      linkdList.head = linkdList.head!.next;
      linkdList.numberOfNodes--;
    }

    if (linkdList.head == null) {
      linkdList.tail = null;
      return;
    }

    Node? current = linkdList.head;
    while (current?.next != null) {
      if (current!.next!.value == value) {
        current.next = current.next!.next;
        linkdList.numberOfNodes--;
        if (current.next == null) {
          linkdList.tail = current;
        }
      } else {
        current = current.next;
      }
    }
  }
}

class Node<T> {
  Node({required this.value, this.next});
  T value;
  Node<T>? next;
  @override
  String toString() {
    if (next == null) return '$value';
    return '$value -> ${next.toString()}';
  }
}

class LinkedList<E> {
  Node<E>? head;
  Node<E>? tail;
  int numberOfNodes = 0;

  bool get isEmpty => head == null;

  void push(E value) {
    head = Node(value: value, next: head);
    tail ??= head;
    numberOfNodes += 1;
  }

  void append(E value) {
    if (isEmpty) {
      push(value);
      return;
    }

    tail!.next = Node(value: value);
    tail = tail!.next;
    numberOfNodes += 1;
  }

  Node<E>? nodeAt(int index) {
    var currentNode = head;
    var currentIndex = 0;

    while (currentNode != null && currentIndex < index) {
      currentNode = currentNode.next;
      currentIndex += 1;
    }
    return currentNode;
  }

  Node<E> insertAfter(Node<E> node, E value) {
    if (tail == node) {
      append(value);
      return tail!;
    }

    node.next = Node(value: value, next: node.next);
    numberOfNodes += 1;

    return node.next!;
  }

  //remove from the front of list
  E? pop() {
    final value = head?.value;
    head = head?.next;
    if (isEmpty) {
      tail = null;
    }
    numberOfNodes -= 1;

    return value;
  }

  //remove from the last(change the tail):
  E? removeLast() {
    if (head?.next == null) return pop();

    var current = head;
    while (current!.next != tail) {
      current = current.next;
    }

    final value = tail?.value;
    tail = current;
    tail?.next = null;
    numberOfNodes -= 1;

    return value;
  }

  E? removeAfter(Node<E> node) {
    final value = node.next?.value;
    if (node.next == tail) {
      tail = node;
    }
    node.next = node.next?.next;
    numberOfNodes -= 1;

    return value;
  }

  @override
  String toString() {
    if (isEmpty) return 'Empty list';
    return head.toString();
  }
}

void main(List<String> args) {
  ///////////////Stack///////////////////
  print("****************************Stack Challenges**********");
  Stack<int> stack = Stack();
  stack.push(1);
  stack.push(2);
  stack.push(3);
  stack.push(4);
  // stack.pop();
  Challenge(stack).reverseList();
  Challenge chal = Challenge.defaultCh();
  print(chal.BalancetheParentheses("(and"));
  print(chal.BalancetheParentheses("(and}"));
  print(chal.BalancetheParentheses("{and}"));
  print(chal.BalancetheParentheses("[and["));
  print("*********************************************");

  ///////////////////////Linked List/////////////////
  // var list = LinkedList<int>();
  // list.push(3);
  // list.push(2);
  // list.push(1); //move head

  // print(list);

  // list.append(25); //move tail
  // list.append(26);
  // list.append(27);

  // print(list);

  // ////
  // list = LinkedList<int>();
  // list.push(3);
  // list.push(2);
  // list.push(1);

  // print('Before: $list');

  // var middleNode = list.nodeAt(1)!;
  // list.insertAfter(middleNode, 42);

  // print('After:  $list');

  // ///
  // list = LinkedList<int>();
  // list.push(3);
  // list.push(2);
  // list.push(1);

  // print('Before: $list');

  // final poppedValue = list.pop();

  // print('After:  $list');
  // print('Popped value: $poppedValue');
  // ////
  // list = LinkedList<int>();
  // list.push(3);
  // list.push(2);
  // list.push(1);

  // print('Before: $list');

  // final removedValue = list.removeLast();

  // print('After:  $list');
  // print('Removed value: $removedValue');

  // ///
  // list = LinkedList<int>();
  // list.push(3);
  // list.push(2);
  // list.push(1);

  // print('Before: $list');

  // final firstNode = list.nodeAt(0);
  // final removedValueInMiddle = list.removeAfter(firstNode!);

  // print('After:  $list');
  // print('Removed value: $removedValueInMiddle');

  /// challenge list
  print("**********************************Challenge of linkedLList");
  final chLinList = LinkedList<int>();
  chLinList.push(4);

  chLinList.push(3);
  chLinList.push(2);
  chLinList.push(1);
  // list.push(null);

  print(chLinList);
  print("print reverse linked list");
  Challenge.linkedlistCh(chLinList).printReversedLinkedList();
  print(chLinList);
  print("Middle elment is ");

  print(Challenge.linkedlistCh(chLinList).findMiddleNode()!.value);

  print("origin linked list : $chLinList");
  Challenge.linkedlistCh(chLinList).reverseOriginLinkedList();

  print("reversed linked list : $chLinList");

  print("Remove All Occurrences");

  final chlist2 = LinkedList<int>();
  chlist2.push(4);

  chlist2.push(3);

  chlist2.push(3);
  chlist2.push(3);
  chlist2.push(1);
  print("origin linked list : $chlist2");
  print("Remove the ocureences 3");
  Challenge.linkedlistCh(chlist2).removeAllOcurencesOf(3);
  print(chlist2);
}
