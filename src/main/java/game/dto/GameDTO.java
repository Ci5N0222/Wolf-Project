package game.dto;

public class GameDTO {
	private int seq;
	private String title;
	private String discription;
	private String contents;
	private String thumbnail;
	private int service_code;
	
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
	public String getDiscription() {
		return discription;
	}
	public void setDiscription(String discription) {
		this.discription = discription;
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
	public int getService_code() {
		return service_code;
	}
	public void setService_code(int service_code) {
		this.service_code = service_code;
	}
	
	public GameDTO(int seq, String title, String discription, String contents, String thumbnail, int service_code) {
		super();
		this.seq = seq;
		this.title = title;
		this.discription = discription;
		this.contents = contents;
		this.thumbnail = thumbnail;
		this.service_code = service_code;
	}
	public GameDTO() {
		
	}
	
	
}
