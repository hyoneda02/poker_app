
class CardJudge

  def self.judge(hands)

   score = {
    'ストレートフラッシュ' => 9,
    'フォー・オブ・ア・カインド'=> 8,
    'フルハウス'=> 7,
    'フラッシュ'=> 6,
    'ストレート'=> 5,
    'スリー・オブ・ア・カインド'=> 4,
    'ツーペア'=> 3,
    'ワンペア'=> 2,
    'ハイカード'=> 1
    }

    scores = hands.map { |hand| score[hand] }
    #handsの配列の各要素に対してscoreを当てはめた新しい配列scoresを作る
    best_card = score.key(scores.max)
    #maxscoreのvalueを持つ役名keyをbest_cardとする
    best_list = []

    (0...hands.length).each { |i|
      if hands[i] == best_card
        #役名同士を照らし合わせる
       best_list << i
       #何番目のhandがbestかを判定し、配列に入れる
      end
    }

    best_list
    #bestな役名の番号（何番目のhandsか）が返る


  end

end

