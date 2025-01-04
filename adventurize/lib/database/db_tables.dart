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
        points INTEGER,
        shared INTEGER
      )''';

String memories = '''
      CREATE TABLE IF NOT EXISTS memories (
        memoryID INTEGER PRIMARY KEY AUTOINCREMENT,
        userID INTEGER,
        userAvatarPath TEXT,
        userName TEXT,
        title TEXT,
        description TEXT,
        imagePath TEXT,
        date TEXT,
        isFavourite INTEGER,
        latitude REAL,
        longitude REAL
      )''';

String userChallenges = '''
      CREATE TABLE IF NOT EXISTS userchallenges (
        userID INTEGER,
        challengeID INTEGER,
        shared INTEGER
      )''';

String userMemories = '''
      CREATE TABLE IF NOT EXISTS userphotos (
        userID INTEGER,
        photoID INTEGER
      )''';
