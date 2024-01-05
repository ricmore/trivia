package org.trivia.trivia.controller;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.CrossOrigin;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RestController;
import org.trivia.trivia.entity.Game;
import org.trivia.trivia.entity.GameEntry;
import org.trivia.trivia.entity.Question;
import org.trivia.trivia.entity.QuestionOption;
import org.trivia.trivia.repo.GameRepo;

@RestController
public class GameController
{

    private final GameRepo repo;

    public GameController(@Autowired final GameRepo repo)
    {
        this.repo = repo;
    }

    @CrossOrigin
    @GetMapping("/games")
    List<Game> games()
    {
        return repo.games();
    }

    @CrossOrigin
    @GetMapping("/game/{gameId}/entries")
    List<GameEntry> gameEntries(@PathVariable final int gameId)
    {
        return repo.gameEntries(gameId);
    }

    @CrossOrigin
    @GetMapping("/questionSet/{questionSetId}/question/{questionId}")
    Question question(@PathVariable final int questionSetId,
                      @PathVariable final int questionId)
    {
        return repo.question(questionSetId, questionId);
    }

    @CrossOrigin
    @GetMapping("/question/{questionId}/options")
    List<QuestionOption> questionOptions(@PathVariable final int questionId)
    {
        return repo.questionOptions(questionId);
    }

}
