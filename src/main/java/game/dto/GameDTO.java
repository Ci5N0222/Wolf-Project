package game.dto;

public class GameDTO {
	private int seq;
	private String title;
	private String contents;
	private String thumbnail;
	
	public GameDTO() {
		super();
	}
	public GameDTO(int seq, String title, String contents, String thumbnail) {
		super();
		this.seq = seq;
		this.title = title;
		this.contents = contents;
		this.thumbnail = thumbnail;
	}
	public int getSeq() {
		return seq;
	}
	public void setSeq(int seq) {
		this.seq = seq;
	}
	public String getTitle() {
		return title;
	}
	public void setTitle(String title) {
		this.title = title;
	}
	public String getContents() {
		return contents;
	}
	public void setContents(String contents) {
		this.contents = contents;
	}
	public String getThumbnail() {
		return thumbnail;
	}
	public void setThumbnail(String thumbnail) {
		this.thumbnail = thumbnail;
	}
	
	
}
