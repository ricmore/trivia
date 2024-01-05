package org.trivia.trivia.entity;

import lombok.Value;

@Value
public class Team
{
    int id;
    Player adult;
    Player kid;
}
