import de.bezier.data.sql.*;

public class DatabaseManager {
    private SQLite db;
    private PApplet parent;

    public DatabaseManager(PApplet parent, String dbName) {
        db = new SQLite(parent, dbName);
        if (db.connect()) {
            println("Connection successful!");
        } else {
            println("Connection failed!");
        }
    }

    public void insertGame(Game game) {
        String insertGameQuery = "INSERT INTO games (date, teamScore, opponentScore, opponent) VALUES ('" + game.date + "', '" + game.teamScore + "', '" + game.opponentScore + "', '" + game.opponent + "')";
        db.query(insertGameQuery);

        db.query("SELECT last_insert_rowid() as last_id");
        int gameId = -1;
        if (db.next()) {
            gameId = db.getInt("last_id");
        }

        if (gameId != -1) {
            insertBattingStats(game.battingStats, gameId);
            insertPitchingStats(game.pitchingStats, gameId);
        } else {
            println("Failed to insert game");
        }
    }

    private void insertBattingStats(BattingStats stats, int gameId) {
        String insertQuery = "INSERT INTO batting_stats (game_id, atBats, hits, homeRuns, runs, runsBattedIn, stolenBases) " +
                             "VALUES ('" + gameId + "', '" + stats.atBats + "', '" + stats.hits + "', '" + stats.homeRuns + "', '" + stats.runs + "', '" + stats.runsBattedIn + "', '" + stats.stolenBases + "')";
        db.query(insertQuery);
    }

    private void insertPitchingStats(PitchingStats stats, int gameId) {
        String insertQuery = "INSERT INTO pitching_stats (game_id, thrownPitches, inningsPitched, strikeouts, hitsAllowed, runsAllowed, walksAllowed, strikes, balls) " +
                             "VALUES ('" + gameId + "', '" + stats.thrownPitches + "', '" + stats.inningsPitched + "', '" + stats.strikeouts + "', '" + stats.hitsAllowed + "', '" + stats.runsAllowed + "', '" + stats.walksAllowed + "', '" + stats.strikes + "', '" + stats.balls + "')";
        db.query(insertQuery);
    }

    public ArrayList<Game> getAllGames() {
        ArrayList<Game> games = new ArrayList<>();
        println("Executing query: SELECT * FROM Games");
        db.query("SELECT * FROM Games");
        println("Query executed. Starting to process results.");
        while (db.next()) {
            int id = db.getInt("id");
            String date = db.getString("date");
            String teamScore = db.getString("teamScore");
            String opponentScore = db.getString("opponentScore");
            String opponent = db.getString("opponent");

            BattingStats battingStats = getBattingStats(id);
            PitchingStats pitchingStats = getPitchingStats(id);
            Game game = new Game(date, teamScore, opponentScore, opponent, battingStats, pitchingStats);
            games.add(game);
            println("Added game: " + game);
            }
        println("Finished processing. Found " + games.size() + " games");
        return games;
    }

    private BattingStats getBattingStats(int gameId) {
        db.query("SELECT * FROM batting_stats WHERE game_id ="+ gameId);
        if (db.next()) {
            return new BattingStats(
                db.getInt("atBats"),
                db.getInt("hits"),
                db.getInt("homeRuns"),
                db.getInt("runs"),
                db.getInt("runsBattedIn"),
                db.getInt("stolenBases")
            );
        }
        return null;
    }

    private PitchingStats getPitchingStats(int gameId) {
        db.query("SELECT * FROM pitching_stats WHERE game_id ="+ gameId);
        if (db.next()) {
            return new PitchingStats(
                db.getInt("thrownPitches"),
                db.getInt("inningsPitched"),
                db.getInt("strikeouts"),
                db.getInt("hitsAllowed"),
                db.getInt("runsAllowed"),
                db.getInt("walksAllowed"),
                db.getInt("strikes"),
                db.getInt("balls")
            );
        }
        return null;
    }

    public void updateGame(int gameId, Game game) {
        String updateQuery = "UPDATE games SET date = '" + game.date + "', teamScore = '" + game.teamScore + "', opponentScore = '" + game.opponentScore + "', opponent = '" + game.opponent + "' WHERE id = " + gameId;
        db.execute(updateQuery);

        updateBattingStats(game.battingStats, gameId);
        updatePitchingStats(game.pitchingStats, gameId);
    }

    private void updateBattingStats(BattingStats stats, int gameId) {
        String updateQuery = "UPDATE batting_stats SET atBats = '" + stats.atBats + "', hits = '" + stats.hits + "', homeRuns = '" + stats.homeRuns + "', runs = '" + stats.runs + "', runsBattedIn = '" + stats.runsBattedIn + "', stolenBases = '" + stats.stolenBases + "' WHERE game_id = " + gameId;
        db.execute(updateQuery);
    }

    private void updatePitchingStats(PitchingStats stats, int gameId) {
        String updateQuery = "UPDATE pitching_stats SET thrownPitches = '" + stats.thrownPitches + "', inningsPitched = '" + stats.inningsPitched + "', strikeouts = '" + stats.strikeouts + "', hitsAllowed = '" + stats.hitsAllowed + "', runsAllowed = '" + stats.runsAllowed + "', walksAllowed = '" + stats.walksAllowed + "', strikes = '" + stats.strikes + "', balls = '" + stats.balls + "' WHERE game_id = " + gameId;
        db.execute(updateQuery);
    }

    public void deleteGame(int gameId) {
        db.execute("DELETE FROM games WHERE id ="+ gameId);
        db.execute("DELETE FROM batting_stats WHERE game_id ="+ gameId);
        db.execute("DELETE FROM pitching_stats WHERE game_id ="+ gameId);
    }

    public void close() {
        db.close();
    }
}


