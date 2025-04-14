public class PitchingStats {
    int thrownPitches;
    int inningsPitched;
    int strikeouts;
    int hitsAllowed;
    int runsAllowed;
    int walksAllowed;
    int strikes;
    int balls;

    PitchingStats(int thrownPitches, int inningsPitched, int strikeouts, int hitsAllowed, int runsAllowed, int walksAllowed, int strikes, int balls) {
        this.thrownPitches = thrownPitches;
        this.inningsPitched = inningsPitched;
        this.strikeouts = strikeouts;
        this.hitsAllowed = hitsAllowed;
        this.runsAllowed = runsAllowed;
        this.walksAllowed = walksAllowed;
        this.strikes = strikes;
        this.balls = balls;
    }

    public String toInsertQuery(int gameId) {
        return String.format(
            "INSERT INTO pitching_stats (game_id, thrownPitches, inningsPitched, strikeouts, hitsAllowed, runsAllowed, walksAllowed, strikes, balls) " +
            "VALUES (%d, %d, %d, %d, %d, %d, %d, %d, %d);",
            gameId, thrownPitches, inningsPitched, strikeouts, hitsAllowed, runsAllowed, walksAllowed, strikes, balls
        );
    }

    @Override
    public String toString() {
        return String.format("PitchingStats[thrownPitches=%d, inningsPitched=%d, strikeouts=%d, hitsAllowed=%d, runsAllowed=%d, walksAllowed=%d, strikes=%d, balls=%d]",
                thrownPitches, inningsPitched, strikeouts, hitsAllowed, runsAllowed, walksAllowed, strikes, balls);
    }
}
