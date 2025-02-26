package timetweak.backend.Components;

import com.fasterxml.jackson.annotation.JsonCreator;
import com.fasterxml.jackson.annotation.JsonValue;

public enum slotName {
    A1(0), B1(1), C1(2), D1(3), E1(4),
    A2(5), B2(6), C2(7), D2(8), E2(9),
    A1P(10), B1P(11), C1P(12), D1P(13), E1P(14),
    A2P(15), B2P(16), C2P(17), D2P(18), E2P(19),
    F(20), G(21), H(22), FP(23),
    P1(24), Q1(25), R1(26), S1(27), T1(28),
    P2(29), Q2(30), R2(31), S2(32), T2(33),
    PA1(34), PB1(35), QA1(36), QB1(37), RA1(38), RB1(39), SA1(40), SB1(41), TA1(42), TB1(43),
    PA2(44), PB2(45), QA2(46), QB2(47), RA2(48), RB2(49), SA2(50), SB2(51), TA2(52), TB2(53);

    private final int value;

    slotName(int value) {
        this.value = value;
    }

    @JsonValue
    public int getValue() {
        return value;
    }

    @JsonCreator
    public static slotName fromValue(int value) {
        for (slotName slot : slotName.values()) {
            if (slot.value == value) {
                return slot;
            }
        }
        throw new IllegalArgumentException("Invalid slot value: " + value);
    }
}
