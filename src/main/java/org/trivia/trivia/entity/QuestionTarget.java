package org.trivia.trivia.entity;

public enum QuestionTarget
{
    KID('K'), ADULT('A'), TEAM('T');
    private final char code;

    QuestionTarget(char code)
    {
        this.code = code;
    }

    public static QuestionTarget fromCode(final String code)
    {
        if (code.length() > 1)
        {
            throw new IllegalArgumentException("Invalid question target code " + code);
        }
        return fromCode(code.charAt(0));
    }

    public static QuestionTarget fromCode(final char code)
    {
        for (final var role : QuestionTarget.values())
        {
            if (role.code == code)
            {
                return role;
            }
        }
        throw new IllegalArgumentException("Unknown question target code " + code);
    }

}
