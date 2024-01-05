package org.trivia.trivia.entity;

import lombok.Value;

@Value
public class Player
{
    int id;
    String name;
    PlayerRole role;
}
