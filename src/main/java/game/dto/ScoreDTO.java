package game.dto;

public class ScoreDTO {
	/*
	 *     score number default 0,
    member_id varchar(20) not null,
    game_seq number not null
    */
	private String score;
	private String member_id;
	private int game_seq;
	
	public ScoreDTO() {
		super();
	}
	public ScoreDTO(String score, String member_id, int game_seq) {
		super();
		this.score = score;
		this.member_id = member_id;
		this.game_seq = game_seq;
	}
	public String getScore() {
		return score;
	}
	public void setScore(String score) {
		this.score = score;
	}
	public String getMember_id() {
		return member_id;
	}
	public void setMember_id(String member_id) {
		this.member_id = member_id;
	}
	public int getGame_seq() {
		return game_seq;
	}
	public void setGame_seq(int game_seq) {
		this.game_seq = game_seq;
	}
	
	
}
