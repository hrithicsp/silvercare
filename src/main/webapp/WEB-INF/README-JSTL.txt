SilverCare uses JSTL (Jakarta Standard Tag Library) for internationalization (i18n).
To enable the language switcher (English, Chinese, Malay, Tamil), add these JARs to WEB-INF/lib:

1. jakarta.servlet.jsp.jstl-api-3.0.0.jar (or 3.0.2)
   - Maven: jakarta.servlet.jsp.jstl:jakarta.servlet.jsp.jstl-api:3.0.0
   - https://mvnrepository.com/artifact/jakarta.servlet.jsp.jstl/jakarta.servlet.jsp.jstl-api

2. jakarta.servlet.jsp.jstl-3.0.1.jar (implementation, e.g. GlassFish)
   - Maven: org.glassfish.web:jakarta.servlet.jsp.jstl:3.0.1
   - https://mvnrepository.com/artifact/org.glassfish.web/jakarta.servlet.jsp.jstl

Download both JARs and place them in WEB-INF/lib, then restart the server.
Translation keys are in src/main/java/com/silvercare/i18n/messages_*.properties (en, zh, ms, ta).
