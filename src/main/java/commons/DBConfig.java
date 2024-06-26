package commons;

import java.sql.Connection;

import javax.naming.Context;
import javax.naming.InitialContext;
import javax.sql.DataSource;

public class DBConfig {
	public static Connection getConnection () throws Exception{
		Context ctx = new InitialContext();
		DataSource ds = (DataSource)ctx.lookup("java:comp/env/jdbc/oracle");
		return ds.getConnection();
	}
	public static String realPath="C:\\Program Files\\Apache Software Foundation\\Tomcat 9.0\\images\\";
}
