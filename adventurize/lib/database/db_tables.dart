String users = '''
      CREATE TABLE IF NOT EXISTS users (
      userID INTEGER PRIMARY KEY AUTOINCREMENT,
      fullname TEXT,
      username TEXT,
      email TEXT UNIQUE NOT NULL,
      password TEXT NOT NULL,
      birthdate TEXT,
      points INTEGER DEFAULT 0,
      avatarPath TEXT DEFAULT 'lib/assets/avatars/avatar1.png'
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
        longitude REAL,
        FOREIGN KEY (userID) REFERENCES users(userID)
      )''';

String friends = '''
    CREATE TABLE IF NOT EXISTS friends (
      id INTEGER PRIMARY KEY AUTOINCREMENT,
      userID INTEGER NOT NULL,
      friendID INTEGER NOT NULL,
      FOREIGN KEY (userID) REFERENCES users(userID),
      FOREIGN KEY (friendID) REFERENCES users(userID)
    )''';

// String userChallenges = '''
//       CREATE TABLE IF NOT EXISTS userchallenges (
//         userID INTEGER,
//         challengeID INTEGER,
//         shared INTEGER
//       )''';