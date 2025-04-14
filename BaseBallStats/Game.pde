public class Game {
    boolean isWin;
    private int id;
    String date;
    String teamScore;
    String opponentScore;
    String opponent;
    BattingStats battingStats;
    PitchingStats pitchingStats;

    public int getId() {
        return id;
    }

    // Constructor
    Game(String date, String teamScore, String opponentScore, String opponent,
         BattingStats battingStats, PitchingStats pitchingStats) {
        this.date = date;
        this.teamScore = teamScore;
        this.opponentScore = opponentScore;
        this.opponent = opponent;
        this.battingStats = battingStats;
        this.pitchingStats = pitchingStats;
        this.isWin = calculateWin();
    }

    // Calculate if the game was a win
    boolean calculateWin() {
        try {
            int teamScoreInt = Integer.parseInt(teamScore);
            int opponentScoreInt = Integer.parseInt(opponentScore);
            return teamScoreInt > opponentScoreInt;
        } catch (NumberFormatException e) {
            return false; // Default to false in case of parsing error
        }
    }

    // Get a summary of the game
    String getSummary() {
        return (isWin ? "Win: " : "Loss: ") + date + " - " + teamScore + " - " + opponentScore + " vs " + opponent;
    }

    // Convert the game to a format suitable for database insertion
    public String toInsertQuery() {
        // Assuming a database table `games` with the following fields:
        // id (auto-generated), date, teamScore, opponentScore, opponent, isWin,
        // and battingStats/pitchingStats as serialized JSON or individual fields.
        return String.format(
            "INSERT INTO games (date, teamScore, opponentScore, opponent, isWin, " +
            "atBats, hits, homeRuns, runs, rbi, stolenBases, inningsPitched, strikeouts, hitsAllowed, " +
            "runsAllowed, walksAllowed, strikes, balls) VALUES ('%s', '%s', '%s', '%s', %b, " +
            "%d, %d, %d, %d, %d, %d, %d, %d, %d, %d, %d, %d);",
            date, teamScore, opponentScore, opponent, isWin,
            battingStats.atBats, battingStats.hits, battingStats.homeRuns,
            battingStats.runs, battingStats.runsBattedIn, battingStats.stolenBases,
            pitchingStats.inningsPitched, pitchingStats.strikeouts, pitchingStats.hitsAllowed,
            pitchingStats.runsAllowed, pitchingStats.walksAllowed, pitchingStats.strikes, pitchingStats.balls
        );
    }

    // Method to convert the Game object to a String (used for debugging or printing)
    @Override
    public String toString() {
        return String.format("Game[date=%s, teamScore=%s, opponentScore=%s, opponent=%s, isWin=%b]",
                date, teamScore, opponentScore, opponent, isWin);
    }
}
