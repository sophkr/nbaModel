SELECT *
FROM Matched M
LEFT JOIN
    NbaTeams ON M.teamId = NbaTeams.teamId
LEFT JOIN TeamMatch on M.teamId = NbaTeams.teamId collate NbaTeams.teamId=T.teamIdAway;

select teamLogo AS 'away_logo', teamId AS 'away_id', teamName AS 'away_name'
FROM NbaTeams, TeamMatch where NbaTeams.teamId=TeamMatch.teamIdAway 
select teamLogo AS 'home_logo', teamId AS 'home_id', teamName AS 'home_name' FROM TeamMatch, NbaTeams where NbaTeams.teamId=TeamMatch.teamIdHome;




        