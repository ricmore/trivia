package org.trivia.trivia.entity;

import lombok.Value;

@Value
public class QuestionOption
{
    String text;
    boolean correct;
    int order;
}
