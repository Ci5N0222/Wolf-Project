package mypage.dto;

public class GameScoreDTO {

	private String title;
	private int score;
	private String member_id;
	private int game_seq;
	private String thumbnail;
	
	
	public GameScoreDTO() {
	}


	public GameScoreDTO(String title, int score, String member_id, int game_seq, String thumbnail) {
		super();
		this.title = title;
		this.score = score;
		this.member_id = member_id;
		this.game_seq = game_seq;
		this.thumbnail = thumbnail;
	}


	public String getTitle() {
		return title;
	}


	public void setTitle(String title) {
		this.title = title;
	}


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


	public String getThumbnail() {
		return thumbnail;
	}


	public void setThumbnail(String thumbnail) {
		this.thumbnail = thumbnail;
	}

	
}
