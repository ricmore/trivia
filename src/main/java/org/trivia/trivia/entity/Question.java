package org.trivia.trivia.entity;

import lombok.Value;

@Value
public class Question
{
    int id;
    String text;
    QuestionType type;
    QuestionTarget target;
    boolean last;
}
