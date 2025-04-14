public class BattingStats {
    int atBats;
    int hits;
    int homeRuns;
    int runs;
    int runsBattedIn;
    int stolenBases;

    BattingStats(int atBats, int hits, int homeRuns, int runs, int runsBattedIn, int stolenBases) {
        this.atBats = atBats;
        this.hits = hits;
        this.homeRuns = homeRuns;
        this.runs = runs;
        this.runsBattedIn = runsBattedIn;
        this.stolenBases = stolenBases;
    }

    public String toInsertQuery(int gameId) {
        return String.format(
            "INSERT INTO batting_stats (game_id, atBats, hits, homeRuns, runs, rbi, stolenBases) " +
            "VALUES (%d, %d, %d, %d, %d, %d, %d);",
            gameId, atBats, hits, homeRuns, runs, runsBattedIn, stolenBases
        );
    }

    @Override
    public String toString() {
        return String.format("BattingStats[atBats=%d, hits=%d, homeRuns=%d, runs=%d, rbi=%d, stolenBases=%d]",
                atBats, hits, homeRuns, runs, runsBattedIn, stolenBases);
    }
}
