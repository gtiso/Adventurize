String users = '''
      CREATE TABLE IF NOT EXISTS users (
      userID INTEGER PRIMARY KEY AUTOINCREMENT,
      fullname TEXT,
      username TEXT,
      email TEXT UNIQUE,
      password TEXT,
      birthdate TEXT,
      points INTEGER DEFAULT 0,
      avatarPath TEXT
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

String photos = '''
      CREATE TABLE IF NOT EXISTS photos (
        photoID INTEGER,
        name TEXT,
        location TEXT
      )''';

String userChalls = '''
      CREATE TABLE IF NOT EXISTS userchalls (
        userID INTEGER,
        challengeID INTEGER,
        shared INTEGER
      )''';

String userPhotos = '''
      CREATE TABLE IF NOT EXISTS userphotos (
        userID INTEGER,
        photoID INTEGER
      )''';