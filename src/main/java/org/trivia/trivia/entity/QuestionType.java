package org.trivia.trivia.entity;

public enum QuestionType
{
    OPTIONS('O');
    private final char code;

    QuestionType(char code)
    {
        this.code = code;
    }

    public static QuestionType fromCode(final String code)
    {
        if (code.length() > 1)
        {
            throw new IllegalArgumentException("Invalid question type code " + code);
        }
        return fromCode(code.charAt(0));
    }

    public static QuestionType fromCode(final char code)
    {
        for (final var role : QuestionType.values())
        {
            if (role.code == code)
            {
                return role;
            }
        }
        throw new IllegalArgumentException("Unknown question type code " + code);
    }

}
