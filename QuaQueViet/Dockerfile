FROM tomcat:10.1-jdk17

# Copy file WAR đã build vào thư mục webapps của Tomcat
COPY dist/QuaQueViet.war /usr/local/tomcat/webapps/ROOT.war

# Render sẽ set biến môi trường PORT, cần sửa server.xml để Tomcat lắng nghe đúng cổng này
CMD sed -i "s/port=\"8080\"/port=\"${PORT:-8080}\"/" /usr/local/tomcat/conf/server.xml && catalina.sh run