package timetweak.backend.Components;

import com.fasterxml.jackson.annotation.JsonCreator;
import com.fasterxml.jackson.annotation.JsonValue;

public enum timing {
    EIGHT_AM("08:00"),
    NINE_AM("09:00"),
    TEN_AM("10:00"),
    ELEVEN_AM("11:00"),
    TWELVE_PM("12:00"),
    ONE_PM("13:00"),
    TWO_PM("14:00"),
    THREE_PM("15:00"),
    FOUR_PM("16:00"),
    FIVE_PM("17:00"),
    SIX_PM("18:00"),
    EIGHT_FIFTY_AM("08:50"),
    NINE_FIFTY_AM("09:50"),
    TEN_FIFTY_AM("10:50"),
    ELEVEN_FIFTY_AM("11:50"),
    TWELVE_FIFTY_AM("12:50"),
    ONE_FIFTY_AM("13:50"),
    TWO_FIFTY_AM("14:50"),
    THREE_FIFTY_AM("15:50"),
    FOUR_FIFTY_AM("16:50"),
    FIVE_FIFTY_AM("17:50");


    private final String time;

    timing(String time) {
        this.time = time;
    }

    @JsonValue
    public String getTime() {
        return time;
    }

    @JsonCreator
    public static timing fromTime(String time) {
        for (timing t : timing.values()) {
            if (t.time.equals(time)) {
                return t;
            }
        }
        throw new IllegalArgumentException("Invalid timing: " + time);
    }

}
