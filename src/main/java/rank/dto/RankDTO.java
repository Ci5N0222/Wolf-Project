package rank.dto;



public class RankDTO {
    private String nickname;
    private String avatar;
    private int score;
    private int rank; 

    // 생성자
    public RankDTO(String nickname, String avatar, int score, int rank) {
        this.nickname = nickname;
        this.avatar = avatar;
        this.score = score;
        this.rank = rank;
    }

    public RankDTO() {
		// TODO Auto-generated constructor stub
	}

	// getter 및 setter 메서드 (필요에 따라)
    public String getNickname() {
        return nickname;
    }

    public void setNickname(String nickname) {
        this.nickname = nickname;
    }

    public String getAvatar() {
        return avatar;
    }

    public void setAvatar(String avatar) {
        this.avatar = avatar;
    }

    public int getScore() {
        return score;
    }

    public void setScore(int score) {
        this.score = score;
    }

    public int getRank() {
        return rank;
    }

    public void setRank(int rank) {
        this.rank = rank;
    }
}
