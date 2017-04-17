package com.system.utils;

import java.util.UUID;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;


public class UuidUtil {

	private static final Logger logger = LoggerFactory.getLogger(UuidUtil.class);

	public static String get32UUID() {
		String uuid = UUID.randomUUID().toString().trim().replaceAll("-", "");
		return uuid;
	}

	public static void main(String[] args) {
		logger.debug(get32UUID());
	}
}
