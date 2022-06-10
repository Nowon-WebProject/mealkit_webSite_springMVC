package kr.co.EZHOME.config;

import org.apache.commons.dbcp2.BasicDataSource;
import org.apache.ibatis.session.SqlSessionFactory;
import org.mybatis.spring.SqlSessionFactoryBean;
import org.mybatis.spring.mapper.MapperFactoryBean;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.ComponentScan;
import org.springframework.context.annotation.Configuration;
import org.springframework.context.annotation.PropertySource;
import org.springframework.web.multipart.MultipartResolver;
import org.springframework.web.multipart.support.StandardServletMultipartResolver;
import org.springframework.web.servlet.config.annotation.EnableWebMvc;
import org.springframework.web.servlet.config.annotation.ResourceHandlerRegistry;
import org.springframework.web.servlet.config.annotation.ViewResolverRegistry;
import org.springframework.web.servlet.config.annotation.WebMvcConfigurer;

import kr.co.EZHOME.database.BoardMapper;
import kr.co.EZHOME.database.CartMapper;
import kr.co.EZHOME.database.ItemMapper;
import kr.co.EZHOME.database.MyPageMapper;
import kr.co.EZHOME.database.OrderMapper;
import kr.co.EZHOME.database.UserMapper;

// Spring MVC 프로젝트에 관련된 설정을 하는 클래스
@Configuration
// Controller 어노테이션이 셋팅되어 있는 클래스를 Controller로 등록한다.
@EnableWebMvc
// 스캔할 패키지를 지정한다.
@ComponentScan("kr.co.EZHOME.controller")
@ComponentScan("kr.co.EZHOME.domain")
@ComponentScan("kr.co.EZHOME.dao")
@ComponentScan("kr.co.EZHOME.dto")
@ComponentScan("kr.co.EZHOME.beans")
@PropertySource("/WEB-INF/properties/db.properties")
public class ServletAppContext implements WebMvcConfigurer {

	@Value("${db.classname}")
	private String db_classname;

	@Value("${db.url}")
	private String db_url;

	@Value("${db.username}")
	private String db_username;

	@Value("${db.password}")
	private String db_password;

	// Controller의 메서드가 반환하는 jsp의 이름 앞뒤에 경로와 확장자를 붙혀주도록 설정한다.
	@Override
	public void configureViewResolvers(ViewResolverRegistry registry) {
		// TODO Auto-generated method stub
		WebMvcConfigurer.super.configureViewResolvers(registry);
		registry.jsp("/WEB-INF/views/", ".jsp");
	}

	// 정적 파일의 경로를 매핑한다.
	@Override
	public void addResourceHandlers(ResourceHandlerRegistry registry) {
		// TODO Auto-generated method stub
		WebMvcConfigurer.super.addResourceHandlers(registry);
		registry.addResourceHandler("/**").addResourceLocations("/resources/");
	}

	// 데이터베이스 접속 정보 관리
	@Bean
	public BasicDataSource dataSource() {
		BasicDataSource source = new BasicDataSource();
		source.setDriverClassName(db_classname);
		source.setUrl(db_url);
		source.setUsername(db_username);
		source.setPassword(db_password);

		return source;
	}

	// 쿼리문과 접속을 관리하는 객체
	@Bean
	public SqlSessionFactory factory(BasicDataSource source) throws Exception {
		SqlSessionFactoryBean factoryBean = new SqlSessionFactoryBean();
		factoryBean.setDataSource(source);

		SqlSessionFactory factory = factoryBean.getObject();

		return factory;
	}

	// 쿼리문 실행을 위한 객체
	@Bean
	public MapperFactoryBean<UserMapper> user_mapper(SqlSessionFactory factory) throws Exception {
		MapperFactoryBean<UserMapper> factoryBean = new MapperFactoryBean<UserMapper>(UserMapper.class);
		factoryBean.setSqlSessionFactory(factory);

		return factoryBean;

	}

	@Bean
	public MapperFactoryBean<ItemMapper> item_mapper(SqlSessionFactory factory) throws Exception {
		MapperFactoryBean<ItemMapper> factoryBean = new MapperFactoryBean<ItemMapper>(ItemMapper.class);
		factoryBean.setSqlSessionFactory(factory);

		return factoryBean;
	}

	@Bean
	public MapperFactoryBean<CartMapper> cart_mapper(SqlSessionFactory factory) throws Exception {
		MapperFactoryBean<CartMapper> factoryBean = new MapperFactoryBean<CartMapper>(CartMapper.class);
		factoryBean.setSqlSessionFactory(factory);

		return factoryBean;
	}

	@Bean
	public MapperFactoryBean<OrderMapper> order_mapper(SqlSessionFactory factory) throws Exception {
		MapperFactoryBean<OrderMapper> factoryBean = new MapperFactoryBean<OrderMapper>(OrderMapper.class);
		factoryBean.setSqlSessionFactory(factory);

		return factoryBean;
	}
	
	@Bean
	public MapperFactoryBean<MyPageMapper> myPage_mapper(SqlSessionFactory factory)throws Exception{
		MapperFactoryBean<MyPageMapper> factoryBean=new MapperFactoryBean<MyPageMapper>(MyPageMapper.class);
		factoryBean.setSqlSessionFactory(factory);
		
		return factoryBean;
	}
	
	@Bean
	public MapperFactoryBean<BoardMapper> board_mapper(SqlSessionFactory factory) throws Exception {
		MapperFactoryBean<BoardMapper> factoryBean = new MapperFactoryBean<BoardMapper>(BoardMapper.class);
		factoryBean.setSqlSessionFactory(factory);

		return factoryBean;
	}

	//standardServletMultipartResolver 빈을 스프링에 등록
	@Bean
	public MultipartResolver multipartResolver() {

		StandardServletMultipartResolver multipartResolver = new StandardServletMultipartResolver();
		return multipartResolver;
	}
}

