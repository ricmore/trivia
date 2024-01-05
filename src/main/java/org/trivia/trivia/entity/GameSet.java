package org.trivia.trivia.entity;

import lombok.Value;

@Value
public class GameSet
{
    int id;
    int order;
    Team team;
}
