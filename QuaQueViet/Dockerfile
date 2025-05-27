# Sử dụng Tomcat 9 với JDK 17
FROM tomcat:10.1-jdk17

# Copy file WAR đã build vào thư mục webapps của Tomcat
COPY dist/QuaQueViet.war /usr/local/tomcat/webapps/ROOT.war

# Expose port 8080
EXPOSE 8080

# Khởi động Tomcat
CMD ["catalina.sh", "run"]