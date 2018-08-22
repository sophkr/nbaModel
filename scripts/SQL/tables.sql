
CREATE TABLE nbadata.Matched
(
groupId INTEGER (10) NOT NULL ,
teamId  VARCHAR(3) NOT NULL,
gameDate DATE, 
gameTime TIME(0) 
);

ALTER TABLE nbadata.Matched ADD CONSTRAINT Matched_PK
PRIMARY KEY ( groupId, teamId ) ;

CREATE TABLE nbadata.NbaTeams
  (
    teamId VARCHAR(3) NOT NULL ,
    teamLogo VARCHAR(56),
    teamName VARCHAR(24)
  ) ;
CREATE UNIQUE INDEX NbaTeams_teamId_IDX ON nbadata.NbaTeams
  (
    teamId ASC
  )
  ;

CREATE TABLE nbadata.TeamMatch
  (
    groupId    INTEGER(10) NOT NULL,
    teamIdHome  VARCHAR(3),
    teamIdAway  VARCHAR(3),
    predictedWinner VARCHAR(3)
  )
  ;


CREATE UNIQUE INDEX TeamMatch_groupId_IDX ON nbadata.TeamMatch
  (
    groupId ASC
  )
  ;

ALTER TABLE nbadata.Matched ADD CONSTRAINT FK_Matched_1 FOREIGN KEY
( groupId ) REFERENCES nbadata.TeamMatch ( groupId ) ;

ALTER TABLE nbadata.Matched ADD CONSTRAINT FK_Matched_2 FOREIGN KEY
( teamId ) REFERENCES nbadata.NbaTeams ( teamId) ;

INSERT INTO nbadata.NbaTeams 
VALUES("HOU", "https://s3.amazonaws.com/nbalogos/HOU.png","Houston Rockets");

INSERT INTO nbadata.NbaTeams 
VALUES("GSW", "https://s3.amazonaws.com/nbalogos/GSW.png", "Golden State Warriors");

INSERT INTO nbadata.NbaTeams 
VALUES("CHI", "https://s3.amazonaws.com/nbalogos/CHI.png", "Chicago Bulls");

INSERT INTO nbadata.NbaTeams 
VALUES("ATL", "https://s3.amazonaws.com/nbalogos/ATL.png", "Atlanta Hawks");

INSERT INTO nbadata.NbaTeams 
VALUES("BKN", "https://s3.amazonaws.com/nbalogos/BKN.png", "Brooklyn Nets");

INSERT INTO nbadata.NbaTeams 
VALUES("BOS", "https://s3.amazonaws.com/nbalogos/BOS.png", "Boston Celtics");

INSERT INTO nbadata.NbaTeams 
VALUES("CHA", "https://s3.amazonaws.com/nbalogos/CHA.png", "Charlotte Hornets");

INSERT INTO nbadata.NbaTeams 
VALUES("CLE", "https://s3.amazonaws.com/nbalogos/CLE.png", "Cleveland Cavaliers");


INSERT INTO nbadata.NbaTeams 
VALUES("DEN", "https://s3.amazonaws.com/nbalogos/DEN.png", "Denver Nuggets");

INSERT INTO nbadata.NbaTeams 
VALUES("DAL", "https://s3.amazonaws.com/nbalogos/DAL.png", "Dallas Mavericks");

INSERT INTO nbadata.NbaTeams 
VALUES("DET", "https://s3.amazonaws.com/nbalogos/DET.png", "Detroit Pistons");

INSERT INTO nbadata.NbaTeams 
VALUES("IND", "https://s3.amazonaws.com/nbalogos/IND.png", "Indiana Pacers");

INSERT INTO nbadata.NbaTeams 
VALUES("LAC", "https://s3.amazonaws.com/nbalogos/LAC.png", "Los Angeles Clippers");

INSERT INTO nbadata.NbaTeams 
VALUES("LAL", "https://s3.amazonaws.com/nbalogos/LAL.png", "Los Angeles Lakers");

INSERT INTO nbadata.NbaTeams 
VALUES("MEM", "https://s3.amazonaws.com/nbalogos/MEM.png", "Memphis Grizzlies");

INSERT INTO nbadata.NbaTeams 
VALUES("MIA", "https://s3.amazonaws.com/nbalogos/MIA.png", "Miami Heat");

INSERT INTO nbadata.NbaTeams 
VALUES("MIN", "https://s3.amazonaws.com/nbalogos/MIN.png", "Minnesota Timberwolves");

INSERT INTO nbadata.NbaTeams 
VALUES("NOP", "https://s3.amazonaws.com/nbalogos/NOP.png", "New Orleans Pelicans");

INSERT INTO nbadata.NbaTeams 
VALUES("NYK", "https://s3.amazonaws.com/nbalogos/NYK.png", "New York Knicks");

INSERT INTO nbadata.NbaTeams 
VALUES("OKC", "https://s3.amazonaws.com/nbalogos/OKC.png", "Oklahoma City Thunder");

INSERT INTO nbadata.NbaTeams 
VALUES("ORL", "https://s3.amazonaws.com/nbalogos/ORL.png", "Orlando Magic");

INSERT INTO nbadata.NbaTeams 
VALUES("PHI", "https://s3.amazonaws.com/nbalogos/PHI.png", "Philadelphia 76ers");

INSERT INTO nbadata.NbaTeams 
VALUES("PHO", "https://s3.amazonaws.com/nbalogos/PHO.png", "Phoenix Suns");

INSERT INTO nbadata.NbaTeams 
VALUES("POR", "https://s3.amazonaws.com/nbalogos/POR.png", "Portland Trailblazers");

INSERT INTO nbadata.NbaTeams 
VALUES("SAC", "https://s3.amazonaws.com/nbalogos/SAC.png", "Sacramento Kings");

INSERT INTO nbadata.NbaTeams 
VALUES("SAS", "https://s3.amazonaws.com/nbalogos/SAS.png", "San Antonio Spurs");

INSERT INTO nbadata.NbaTeams 
VALUES("TOR", "https://s3.amazonaws.com/nbalogos/TOR.png", "Toronto Raptors");

INSERT INTO nbadata.NbaTeams 
VALUES("UTA", "https://s3.amazonaws.com/nbalogos/UTA.png", "Utah Jazz");

INSERT INTO nbadata.NbaTeams 
VALUES("WAS", "https://s3.amazonaws.com/nbalogos/WAS.png", "Washington Wizards");

INSERT INTO nbadata.TeamMatch
VALUES(123, "HOU", "OKC", "HOU");

INSERT INTO nbadata.TeamMatch
VALUES(124, "LAC", "UTA", "LAC");

INSERT INTO nbadata.TeamMatch
VALUES(125, "SAS", "MEM", "SAS");

INSERT INTO nbadata.Matched
VALUES(123, "HOU", '2017-04-25','20:00:00');

INSERT INTO nbadata.Matched
VALUES(124, "LAC", '2017-04-25','22:30:00');

INSERT INTO nbadata.Matched
VALUES(125, "SAS", '2017-04-25','21:00:00');
