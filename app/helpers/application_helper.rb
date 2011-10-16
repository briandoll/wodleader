module ApplicationHelper

  def leaderboard_ranking(athletes)
    rankings = []
    previous_rank_value = nil
    previous_rank = nil

    athletes.each_with_index do |athlete, index|
      rank = previous_rank
      tr = athlete.competition_rank_total
      if !same_scores(tr, previous_rank_value)
        rank = (index + 1) #index is zero based
      end
      rankings << [athlete, rank]
      
      previous_rank_value = tr
      previous_rank = rank
    end
    rankings
  end

  def same_scores(score_a, score_b)
    if score_a.is_a?(Float) && score_b.is_a?(Float)
      score_a.round_to(12).eql?(score_b.round_to(12))
    else
      score_a.eql?(score_b)
    end
  end


end
