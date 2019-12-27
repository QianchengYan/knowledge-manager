**1. 循环渲染**

通过 List 的 `where` 和 `map` 方法，实现过滤和map

```dart
static List<Map<String, dynamic>> _listBody = [
    {
        "index": 0,
        "title": "吃早饭",
        "status": 1
    },
    {
        "index": 1,
        "title": "吃午饭",
        "status": -1
    },
]

child: ListBody(
    children: _listBody
    .where((value) => value["status"] == 1)
    .map((value) {
        return GestureDetector(
```

