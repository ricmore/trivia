package org.trivia.trivia.repo;

import static org.jooq.impl.DSL.max;

import java.util.ArrayList;
import java.util.Comparator;
import java.util.List;

import org.jooq.DSLContext;
import org.jooq.Record1;
import org.jooq.Result;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;
import org.trivia.jooq.Tables;
import org.trivia.jooq.tables.records.GameRecord;
import org.trivia.jooq.tables.records.GameSetRecord;
import org.trivia.jooq.tables.records.PlayerRecord;
import org.trivia.jooq.tables.records.QuestionOptionsRecord;
import org.trivia.jooq.tables.records.QuestionRecord;
import org.trivia.jooq.tables.records.TeamRecord;
import org.trivia.trivia.entity.Game;
import org.trivia.trivia.entity.GameEntry;
import org.trivia.trivia.entity.Player;
import org.trivia.trivia.entity.PlayerRole;
import org.trivia.trivia.entity.Question;
import org.trivia.trivia.entity.QuestionOption;
import org.trivia.trivia.entity.QuestionTarget;
import org.trivia.trivia.entity.QuestionType;
import org.trivia.trivia.entity.Team;

@Repository
public class GameRepo
{
    private final DSLContext dsl;

    public GameRepo(@Autowired DSLContext dsl)
    {
        this.dsl = dsl;
    }

    public List<Game> games()
    {
        Result<GameRecord> result = dsl.selectFrom(Tables.GAME).fetch();
        return result.stream()
            .map(record -> new Game(record.get(Tables.GAME.ID), record.get(Tables.GAME.NAME)))
            .toList();
    }

    Team team(final int teamId)
    {
        Result<TeamRecord> result = dsl.selectFrom(Tables.TEAM).where(Tables.TEAM.ID.eq(teamId)).fetch();
        final var singleRecord = result.get(0);
        final var adult = player(singleRecord.getAdultPlayerId());
        final var kid = player(singleRecord.getKidPlayerId());
        return new Team(singleRecord.getId(), adult, kid);
    }

    Player player(final int playerId)
    {
        Result<PlayerRecord> result = dsl.selectFrom(Tables.PLAYER).where(Tables.PLAYER.ID.eq(playerId)).fetch();
        final var singleRecord = result.get(0);
        return new Player(singleRecord.get(Tables.PLAYER.ID),
            singleRecord.get(Tables.PLAYER.NAME),
            PlayerRole.fromCode(singleRecord.get(Tables.PLAYER.ROLE)));
    }

    public List<GameEntry> gameEntries(final int gameId)
    {
        Result<GameSetRecord> result = dsl.selectFrom(Tables.GAME_SET)
            .where(Tables.GAME_SET.GAME_ID.eq(gameId)).fetch();
        final List<GameEntry> entries = new ArrayList<>();
        for (final var record : result)
        {
            final var team = team(record.getTeamId());
            final GameEntry gameEntry = new GameEntry(team, record.getSetId());
            entries.add(gameEntry);
        }
        return entries;
    }

    public Question question(final int questionSetId, final int number)
    {
        Integer max = dsl.select(max(Tables.QUESTION.NUMBER)).from(Tables.QUESTION)
            .where(Tables.QUESTION.SET_ID.eq(questionSetId)).fetch().get(0).getValue(0, Integer.class);

        Result<QuestionRecord> result = dsl.selectFrom(Tables.QUESTION)
            .where(Tables.QUESTION.SET_ID.eq(questionSetId)).and(Tables.QUESTION.NUMBER.eq(number)).fetch();
        final var singleRecord = result.get(0);
        return new Question(singleRecord.getId(),
            singleRecord.getText(),
            QuestionType.fromCode(singleRecord.getType()),
            QuestionTarget.fromCode(singleRecord.getTarget()),
            max.intValue() == singleRecord.getNumber().intValue()
        );
    }

    public List<QuestionOption> questionOptions(final int questionId)
    {
        Result<QuestionOptionsRecord> result = dsl.selectFrom(Tables.QUESTION_OPTIONS)
            .where(Tables.QUESTION_OPTIONS.QUESTION_ID.eq(questionId)).fetch();
        List<QuestionOption> questionOptions = new ArrayList<>();
        result.stream().sorted(Comparator.comparingInt(QuestionOptionsRecord::getOrder)).forEach(option ->
        {
            questionOptions.add(new QuestionOption(option.getText(), option.getCorrect(), option.getOrder()));
        });
        return questionOptions;
    }

}
