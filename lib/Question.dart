class Question {
  String question;
  List<int> scoreList;
  List<String> selectList;

  Question(this.question, this.scoreList, this.selectList);
}

Map<String, Question> quizdata = {
  "A0": Question("元気や覇気がないと言われる？", [4,2,1,0], ["よくある", "たまにある", "めったにない", "まったくない"]),
  "A1": Question("年齢より幼く見られがち？", [4,2,1,0], ["よくある", "たまにある", "めったにない", "まったくない"]),
  "A2": Question("知らない人と話すのは苦手？", [4,2,1,0], ["よくある", "たまにある", "めったにない", "まったくない"]),
  "A3": Question("三種のチーズ牛丼を注文する？", [4,2,1,0], ["よくある", "たまにある", "めったにない", "まったくない"]),
  "A4": Question("髪の毛をセットする？", [0,1,2,4], ["よくある", "たまにある", "めったにない", "まったくない"]),
  "A5": Question("自分に自信がある？", [0,1,2,4], ["ある", "すこしある", "あまりない", "まったくない"]),
  "A6": Question("グループ決めで最後まで決まらないことがある？", [4,2,1,0], ["よくある", "たまにある", "めったにない", "まったくない"]),
  "A7": Question("メガネをかけている？", [4,0], ["はい","いいえ"]),
  "A8": Question("ドライヤーで髪を乾かす？", [0,1,2,4], ["よくある", "たまにある", "めったにない", "まったくない"]),
  "A9": Question("眉毛は整える？", [0,1,2,4], ["よくある", "たまにある", "めったにない", "まったくない"]),
  "A10": Question("一人で行動することがある？", [4,2,1,0], ["よくある", "たまにある", "めったにない", "まったくない"]),
  "A11": Question("他人の気持ちを理解できる？", [0,1,2,4], ["よくできる", "すこしできる", "あまりできない", "まったくできない"]),
  "A12": Question("電車が好き？", [4, 0],  ["はい","いいえ"]),
  "A13": Question("アニメが好き？", [4, 0],  ["はい","いいえ"]),
  "A14": Question("VTuberが好き？", [4, 0],  ["はい","いいえ"]),
  "A15": Question("体育の授業が苦手？", [4, 0],  ["はい","いいえ"]),
  "A16": Question("姿勢が悪い？", [4, 0], ["はい", "いいえ"]),
  "A17": Question("友達はいる？", [0, 4], ["はい", "いいえ"]),
  "A18": Question("口呼吸をしている？", [4,2,1,0], ["よくある", "たまにある", "めったにない", "まったくない"]),
  "A19": Question("異性が苦手？", [4,0],  ["はい", "いいえ"]),
  "A20": Question("一般常識的な知識がある？",[0,1,2,4], ["ある", "すこしある", "あまりない", "まったくない"]),
  "A21": Question("恋人がいたことがある？",[0,4],  ["はい", "いいえ"]),
  //"": Question("",[,],[,]),
};
