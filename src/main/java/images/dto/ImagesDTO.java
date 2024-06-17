package images.dto;

public class ImagesDTO {
	
	/** ImagesDTO **/
	private int seq;
	private String oriname;
	private String sysname;
	private int image_code;
	private int parent_seq;
	private String member_id;
	
	/** Getter & Setter **/
	public int getSeq() {
		return seq;
	}
	public void setSeq(int seq) {
		this.seq = seq;
	}
	public String getOriname() {
		return oriname;
	}
	public void setOriname(String oriname) {
		this.oriname = oriname;
	}
	public String getSysname() {
		return sysname;
	}
	public void setSysname(String sysname) {
		this.sysname = sysname;
	}
	public int getImage_code() {
		return image_code;
	}
	public void setImage_code(int image_code) {
		this.image_code = image_code;
	}
	public int getParent_seq() {
		return parent_seq;
	}
	public void setParent_seq(int parent_seq) {
		this.parent_seq = parent_seq;
	}
	public String getMember_id() {
		return member_id;
	}
	public void setMember_id(String member_id) {
		this.member_id = member_id;
	}
	
	/** Constructor **/
	public ImagesDTO(int seq, String oriname, String sysname, int image_code, int parent_seq, String member_id) {
		super();
		this.seq = seq;
		this.oriname = oriname;
		this.sysname = sysname;
		this.image_code = image_code;
		this.parent_seq = parent_seq;
		this.member_id = member_id;
	}
	
	public ImagesDTO() {
		
	}
	
}
