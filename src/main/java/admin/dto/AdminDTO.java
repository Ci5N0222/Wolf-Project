package admin.dto;

import java.sql.Timestamp;

public class AdminDTO {
	
	public static class BoardListDTO{
		private int seq;
		private String title;
		private String contents;
		private int count;
		private String member_id;
		private String nickname;
		private int board_code;
		private Timestamp write_date;
		
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
		public int getCount() {
			return count;
		}
		public void setCount(int count) {
			this.count = count;
		}
		public String getMember_id() {
			return member_id;
		}
		public void setMember_id(String member_id) {
			this.member_id = member_id;
		}
		public String getNickname() {
			return nickname;
		}
		public void setNickname(String nickname) {
			this.nickname = nickname;
		}
		public int getBoard_code() {
			return board_code;
		}
		public void setBoard_code(int board_code) {
			this.board_code = board_code;
		}
		public Timestamp getWrite_date() {
			return write_date;
		}
		public void setWrite_date(Timestamp write_date) {
			this.write_date = write_date;
		}
		
		public BoardListDTO(int seq, String title, String contents, int count, String member_id, String nickname,
				int board_code, Timestamp write_date) {
			super();
			this.seq = seq;
			this.title = title;
			this.contents = contents;
			this.count = count;
			this.member_id = member_id;
			this.nickname = nickname;
			this.board_code = board_code;
			this.write_date = write_date;
		}
		
		public BoardListDTO() {}
	}
	
	public static class AdminAgeGroupDTO{
		
		private String age;
		private int membersCount;
		
		public String getAge() {
			return age;
		}
		public void setAge(String age) {
			this.age = age;
		}
		public int getMembersCount() {
			return membersCount;
		}
		public void setMembersCount(int membersCount) {
			this.membersCount = membersCount;
		}
		
		public AdminAgeGroupDTO(String age, int membersCount) {
			this.age = age;
			this.membersCount = membersCount;
		}
		
		public AdminAgeGroupDTO() {}
		
	}
}
