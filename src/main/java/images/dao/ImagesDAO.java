package images.dao;

public class ImagesDAO {
	
	private ImagesDAO() {}
	
	private static ImagesDAO instance;
	
	public static ImagesDAO  getInstance() {
		if(instance == null) instance = new ImagesDAO();
		return instance;
	}
	
	
}
