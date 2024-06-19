package admin.dto;

public class AdminDTO {
	
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
