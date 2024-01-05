package org.trivia.trivia.entity;

import lombok.Value;

@Value
public class GameEntry
{
    Team team;
    int questionSetId;
}
