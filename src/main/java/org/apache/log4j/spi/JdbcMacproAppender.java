package org.apache.log4j.spi;

import java.util.UUID;

import org.apache.log4j.MDC;
import org.apache.log4j.jdbc.JDBCAppender;
import org.apache.log4j.spi.LoggingEvent;

public class JdbcMacproAppender extends JDBCAppender {
	@Override
	public void append(LoggingEvent event) {
		MDC.put("UUID", UUID.randomUUID().toString().replaceAll("-", ""));
		try {
			super.append(event.cutMessager(512));
		} catch (Exception e) {
			super.append(event);
		}
	}
}
