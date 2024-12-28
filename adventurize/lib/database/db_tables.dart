String users = '''
      CREATE TABLE IF NOT EXISTS users (
      userID INTEGER PRIMARY KEY AUTOINCREMENT,
      fullname TEXT,
      username TEXT,
      email TEXT UNIQUE,
      password TEXT,
      birthdate TEXT,
      points INTEGER DEFAULT 0
      )''';

String challenges = '''
      CREATE TABLE IF NOT EXISTS challenges (
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        title TEXT,
        photoPath TEXT,
        dateCompleted TEXT,
        shared INTEGER
      )''';