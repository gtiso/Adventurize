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
        challengeID INTEGER PRIMARY KEY AUTOINCREMENT,
        title TEXT,
        desc TEXT,
        photoPath TEXT,
        status TEXT,
        points INTEGER,
        shared INTEGER
      )''';
