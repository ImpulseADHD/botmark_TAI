/**
 * @author: Izan Cuetara Diez (a.k.a. Unstavle)
 * @version: v2.0 | 2022-07-08
 */


-- create database discord_bots_db


CREATE TABLE bots(
	clientId VARCHAR(25) PRIMARY KEY NOT NULL,
	botName VARCHAR(32) UNIQUE NOT NULL,
	joinLink VARCHAR(300)
);


CREATE TABLE servers(
	serverId VARCHAR(25) NOT NULL,
	botId VARCHAR(25) NOT NULL,
	name VARCHAR(100) NOT NULL,
	greetChannel VARCHAR(25),
    generalChannel VARCHAR(25),
    botLogChannel VARCHAR(25),
    botChannel VARCHAR(25),
    gamesChannel VARCHAR(25),
    doGreeting BOOLEAN DEFAULT(false),
    doReminders BOOLEAN DEFAULT(true),
    doBookmarks BOOLEAN DEFAULT(true),
    beMean BOOLEAN DEFAULT(false),
    bookmarkCount INTEGER DEFAULT(0) NOT NULL,
	PRIMARY KEY(serverId, botId),
	FOREIGN KEY(botId) REFERENCES bots(clientId) ON DELETE NO ACTION,
	UNIQUE(serverId),
	UNIQUE(botId)
);

CREATE TABLE daily_quotes(
	serverId VARCHAR(25) NOT NULL,
	botId VARCHAR(25) NOT NULL,
	doDailyQuotes BOOLEAN DEFAULT(false),
	dqChannel VARCHAR(25),
	timeHours INTEGER DEFAULT(9),
	timeMins INTEGER DEFAULT(0),
	frequencyH INTEGER DEFAULT(24),
	lastQuoteIndex INTEGER DEFAULT(0),
	quoteColor CHAR(7) DEFAULT('#bf5ae6'),
	timeZone VARCHAR(50) DEFAULT('America/Winnipeg'),
	PRIMARY KEY(serverId, botId),
	FOREIGN KEY(serverId, botId) REFERENCES servers(serverId, botId) ON DELETE CASCADE ON UPDATE CASCADE
);

CREATE TABLE fun_reminders(
	serverId VARCHAR(25) NOT NULL,
	botId VARCHAR(25) NOT NULL,
	name VARCHAR(32) NOT NULL,
	doFunReminders BOOLEAN DEFAULT(false),
	timerAmountMins INTEGER DEFAULT(60),
	startMark INTEGER DEFAULT(0),
	funRemindersChannel VARCHAR(25),
	funRemindersRoles VARCHAR(25)[],
	timeRange VARCHAR(11) DEFAULT(NULL),
	PRIMARY KEY(serverId, botId, name),
	FOREIGN KEY(serverId, botId) REFERENCES servers(serverId, botId) ON DELETE CASCADE ON UPDATE CASCADE
);

CREATE TABLE users(
	serverId VARCHAR(25) NOT NULL,
	botId VARCHAR(25) NOT NULL,
	userId VARCHAR(25) NOT NULL,
	name VARCHAR(32)  DEFAULT('default-san'),
	levelPts INTEGER DEFAULT(0),
	pomodoro INTEGER[3] DEFAULT(ARRAY[25,5,15]), -- format: {work,break,long break}
	timeZone VARCHAR(50) DEFAULT('America/Winnipeg'),
	bookmarkCount INTEGER DEFAULT(0) NOT NULL,
	PRIMARY KEY(serverId, botId, userId),
	FOREIGN KEY(serverId) REFERENCES servers(serverId) ON DELETE CASCADE ON UPDATE CASCADE,
    FOREIGN KEY(botId) REFERENCES servers(botId) ON DELETE CASCADE ON UPDATE CASCADE
);

CREATE TABLE reminders(
	reminderId VARCHAR(25) NOT NULL,
	userId VARCHAR(25) NOT NULL,
	botId VARCHAR(25) NOT NULL,
	channelId VARCHAR(25) NOT NULL,
	serverId VARCHAR(25) NOT NULL,
	date CHAR(24) NOT NULL,
	action VARCHAR(300) NOT NULL,
	PRIMARY KEY(reminderId, userId, serverId, botId),
	FOREIGN KEY(serverId, botId, userId) REFERENCES users(serverId, botId, userId) ON DELETE CASCADE ON UPDATE CASCADE
);

CREATE TABLE recurrent_reminders(
	reminderId VARCHAR(25) NOT NULL,
	userId VARCHAR(25) NOT NULL,
	serverId VARCHAR(25) NOT NULL,
	botId VARCHAR(25) NOT NULL,
	channelId VARCHAR(25) NOT NULL,
	action VARCHAR(300) NOT NULL,
	active BOOLEAN DEFAULT(true),
	timerAmountMins INTEGER NOT NULL,
	startMark INTEGER NOT NULL,
	timeRange VARCHAR(11) DEFAULT(NULL),
	PRIMARY KEY(reminderId, userId, serverId, botId),
	FOREIGN KEY(serverId, botId, userId) REFERENCES users(serverId, botId, userId) ON DELETE CASCADE ON UPDATE CASCADE
);

CREATE TABLE ranking(
	serverId VARCHAR(25) NOT NULL,
	botId VARCHAR(25) NOT NULL,
	userId VARCHAR(25) NOT NULL,
	points INTEGER DEFAULT(0),
	PRIMARY KEY(serverId, botId, userId),
	FOREIGN KEY(serverId, botId, userId) REFERENCES users(serverId, botId, userId) ON DELETE CASCADE ON UPDATE CASCADE
);


-----------------------------------------------------------------------------------------------------------------------

-- INSERT BOTS
	-- INSERT INTO bots(clientid, botname, joinlink) VALUES ('1055029666794184744', 'BotMark TAI', 'https://discord.com/api/oauth2/authorize?client_id=1055029666794184744&permissions=117760&redirect_uri=postgres%3A%2F%2Fpostgres%3AmJeYrnrXjMr0Gwx%40botmark-impulse.flycast%3A5432&response_type=code&scope=bot%20applications.commands');

-- INSERT SERVERS
  -- BOTMARK
	-- INSERT INTO servers(serverid, name, botid) VALUES ('806941792532168735', 'The ADHD Indian', '1055029666794184744');
	-- INSERT INTO servers(serverid, name, botid) VALUES ('1065317298325438525', 'Test Server TAI', '1055029666794184744');
