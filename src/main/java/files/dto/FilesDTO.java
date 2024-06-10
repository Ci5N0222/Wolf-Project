package files.dto;

public class FilesDTO {
	private int seq;
	private String oriname;
	private String sysname;
	private int board_seq;
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
	public int getBoard_seq() {
		return board_seq;
	}
	public void setBoard_seq(int board_seq) {
		this.board_seq = board_seq;
	}
	public FilesDTO(int seq, String oriname, String sysname, int board_seq) {
		super();
		this.seq = seq;
		this.oriname = oriname;
		this.sysname = sysname;
		this.board_seq = board_seq;
	}
	public FilesDTO() {
		super();
	}
	
	
}
