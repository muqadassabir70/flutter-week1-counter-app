// Week3.dart - Library Desk Assistant
// Name: MUQADAS Roll no: 04072313021

final List<Map<String, dynamic>> books = [
  {
    'title': 'Dart in Action',
    'author': 'Ada',
    'year': 2021,
    'copies': 3,
    'tags': ['dart', 'programming'],
  },
  {
    'title': 'Flutter Basics',
    'author': 'Sam',
    'year': 2023,
    'copies': 0,
    'tags': ['flutter', 'mobile'],
  },
  {
    'title': 'Clean Code',
    'author': 'Martin',
    'year': 2008,
    'copies': 2,
    'tags': ['programming', 'design'],
  },
  {
    'title': 'Algorithms',
    'author': 'Knuth',
    'year': 1968,
    'copies': 1,
    'tags': ['programming', 'math'],
  },
  {
    'title': 'UI Design',
    'author': 'Nora',
    'year': 2019,
    'copies': 4,
    'tags': ['design', 'mobile'],
  },
];

// ---------- Part 1 functions ----------
double lateFee(int daysLate, double ratePerDay) => daysLate * ratePerDay;

String formatTitle(String title, [String? author]) {
  if (author == null) {
    return title;
  }
  return '$title by $author';
}

Map<String, dynamic> makeBook({
  required String title,
  required String author,
  int year = 2024,
  int copies = 1,
}) {
  return {'title': title, 'author': author, 'year': year, 'copies': copies};
}

bool isClassic(int year) => year < 2000;

// ---------- Part 2 functions ----------
List<String> transformAll(List<String> items, String Function(String) fn) {
  List<String> result = [];
  for (var item in items) {
    result.add(fn(item));
  }
  return result;
}

int Function() makeCounter() {
  int count = 0;
  return () {
    count++;
    return count;
  };
}

double Function(int) makeFeeCalculator(double rate) {
  return (int days) => days * rate;
}

int sumDigits(int n) {
  if (n < 10) {
    return n;
  }
  return (n % 10) + sumDigits(n ~/ 10);
}

// ---------- Part 3 functions ----------
Map<String, int> buildStock() {
  return {
    for (var book in books) (book['title'] as String): (book['copies'] as int),
  };
}

// ---------- Part 4: generics ----------
class Box<T> {
  T value;
  Box(this.value);
}

T firstOr<T>(List<T> items, T fallback) {
  if (items.isEmpty) {
    return fallback;
  }
  return items.first;
}

class Pair<A, B> {
  final A first;
  final B second;
  Pair(this.first, this.second);

  @override
  String toString() => '($first, $second)';
}

void main() async {
  part1();
  part2();
  part3();
  part4();
  part5();
  await part6();
}

void part1() {
  print('--- Part 1 ---');
  print('Late fee: ${lateFee(5, 0.5)}');
  print(formatTitle('Dart in Action'));
  print(formatTitle('Dart in Action', 'Ada'));
  print(makeBook(title: 'Clean Code', author: 'Martin'));
  print(makeBook(title: 'Algorithms', author: 'Knuth', year: 1968));
  print(isClassic(1968));
  print(isClassic(2021));
}

void part2() {
  print('--- Part 2 ---');

  var titles = ['Dart in Action', 'Clean Code'];
  print(
    transformAll(titles, (String s) {
      return s.toUpperCase();
    }),
  );
  print(transformAll(titles, (s) => '$s!'));

  var desk1 = makeCounter();
  var desk2 = makeCounter();
  print(desk1());
  print(desk1());
  print(desk1());
  print(desk2());

  var studentFee = makeFeeCalculator(0.25);
  var staffFee = makeFeeCalculator(0.10);
  print('Student fee: ${studentFee(4)}');
  print('Staff fee: ${staffFee(4)}');

  print('Sum of digits: ${sumDigits(2024)}');
}

void part3() {
  print('--- Part 3 ---');

  // Task 3.1: map and where
  var titles = books.map((book) => book['title'] as String).toList();
  print('Titles: $titles');

  var available = books
      .where((book) => (book['copies'] as int) > 0)
      .map((book) => book['title'] as String)
      .toList();
  print('Available: $available');

  // Task 3.2: fold and reduce
  int totalCopies = books.fold(0, (sum, book) => sum + (book['copies'] as int));
  print('Total copies: $totalCopies');

  var years = books.map((book) => book['year'] as int).toList();
  int oldest = years.reduce((first, second) => first < second ? first : second);
  print('Oldest year: $oldest');

  // Task 3.3: sort a copy, keep the original untouched
  var sortedBooks = List.of(books);
  sortedBooks.sort((x, y) => (x['year'] as int).compareTo(y['year'] as int));
  var sortedTitles = sortedBooks
      .map((book) => book['title'] as String)
      .toList();
  print('By year: $sortedTitles');

  // Task 3.4: Map
  var stock = buildStock();
  print('Stock: $stock');
  stock.forEach((title, copies) {
    if (copies == 0) {
      print('Out of stock: $title');
    }
  });
  print('Copies of Unknown: ${stock['Unknown'] ?? 0}');

  // Task 3.5: Set
  Set<String> allTags = {
    for (var book in books) ...(book['tags'] as List<String>),
  };
  print('All tags: $allTags');

  var a = {'Dart in Action', 'Clean Code', 'Flutter Basics'};
  var b = {'Clean Code', 'Flutter Basics', 'Algorithms'};
  print('Union: ${a.union(b)}');
  print('Common: ${a.intersection(b)}');
  print('Only in A: ${a.difference(b)}');
}

void part4() {
  print('--- Part 4 ---');

  // Task 4.1: generic class
  var intBox = Box<int>(5);
  var stringBox = Box<String>('dart');
  print('Box<int>: ${intBox.value}');
  print('Box<String>: ${stringBox.value}');
  // intBox.value = 'hello'; // compile error: String can't be assigned to int

  // Task 4.2: generic function
  print(firstOr(['Dart in Action', 'Clean Code'], 'none'));
  print(firstOr<String>([], 'z'));

  // Task 4.3: two type parameters
  print(Pair('Dart in Action', 3));
}

void part5() {
  print('--- Part 5 ---');
}

Future<void> part6() async {
  print('--- Part 6 ---');
}
