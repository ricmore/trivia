package org.trivia.trivia.entity;

import lombok.Getter;

public enum PlayerRole
{
    ADULT('A'), KID('K');
    @Getter
    private final char code;

    PlayerRole(char code)
    {
        this.code = code;
    }

    public static PlayerRole fromCode(final String code)
    {
        if (code.length() > 1)
        {
            throw new IllegalArgumentException("Invalid role code " + code);
        }
        return fromCode(code.charAt(0));
    }

    public static PlayerRole fromCode(final char code)
    {
        for (final var role : PlayerRole.values())
        {
            if (role.code == code)
            {
                return role;
            }
        }
        throw new IllegalArgumentException("Unknown role code " + code);
    }
}
