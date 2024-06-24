package game.dto;

public class ScoreDTO {

	private int score;
	private String member_id;
	private int game_seq;
	
	public int getScore() {
		return score;
	}
	public void setScore(int score) {
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
	
	public ScoreDTO() {}
	
	public ScoreDTO(int score, String member_id, int game_seq) {
		super();
		this.score = score;
		this.member_id = member_id;
		this.game_seq = game_seq;
	}
	
	
	
	
}
