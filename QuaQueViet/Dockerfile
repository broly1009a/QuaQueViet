FROM tomcat:10.1-jdk17

ENV TZ=Asia/Ho_Chi_Minh

# Copy file WAR đã build vào thư mục webapps của Tomcat
COPY dist/QuaQueViet.war /usr/local/tomcat/webapps/ROOT.war

# Sửa server.xml và set timezone cho JVM
CMD sed -i "s/port=\"8080\"/port=\"${PORT:-8080}\"/" /usr/local/tomcat/conf/server.xml && \
    export TZ=Asia/Ho_Chi_Minh && \
    catalina.sh run -Duser.timezone=Asia/Ho_Chi_Minh