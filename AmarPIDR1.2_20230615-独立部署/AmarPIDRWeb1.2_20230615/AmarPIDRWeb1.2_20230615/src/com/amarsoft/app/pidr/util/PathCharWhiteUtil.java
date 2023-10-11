/*
 * 文件名：PathCharWhiteUtil.java
 * 版权：Copyright by www.amarsoft.com
 * 描述：
 * 修改人：kyan
 * 修改时间：2019年4月22日
 * 跟踪单号：
 * 修改单号：
 * 修改内容：
 */

package com.amarsoft.app.pidr.util;

import java.util.HashMap;

/**
 * 白名单，用于防止路径篡改
 * @author amarsoft
 * @version 2019年5月5日
 * @see PathCharWhiteUtil
 * @since
 */
public class PathCharWhiteUtil {

	/** 路径白名单 */
	private final static HashMap<String, String> pathCharWiteMap = new HashMap<String, String>();
	static {
		pathCharWiteMap.put("0", "0");
		pathCharWiteMap.put("1", "1");
		pathCharWiteMap.put("2", "2");
		pathCharWiteMap.put("3", "3");
		pathCharWiteMap.put("4", "4");
		pathCharWiteMap.put("5", "5");
		pathCharWiteMap.put("6", "6");
		pathCharWiteMap.put("7", "7");
		pathCharWiteMap.put("8", "8");
		pathCharWiteMap.put("9", "9");

		pathCharWiteMap.put("a", "a");
		pathCharWiteMap.put("b", "b");
		pathCharWiteMap.put("c", "c");
		pathCharWiteMap.put("d", "d");
		pathCharWiteMap.put("e", "e");
		pathCharWiteMap.put("f", "f");
		pathCharWiteMap.put("g", "g");
		pathCharWiteMap.put("h", "h");
		pathCharWiteMap.put("i", "i");
		pathCharWiteMap.put("j", "j");
		pathCharWiteMap.put("k", "k");
		pathCharWiteMap.put("l", "l");
		pathCharWiteMap.put("m", "m");
		pathCharWiteMap.put("n", "n");
		pathCharWiteMap.put("o", "o");
		pathCharWiteMap.put("p", "p");
		pathCharWiteMap.put("q", "q");
		pathCharWiteMap.put("r", "r");
		pathCharWiteMap.put("s", "s");
		pathCharWiteMap.put("t", "t");
		pathCharWiteMap.put("u", "u");
		pathCharWiteMap.put("v", "v");
		pathCharWiteMap.put("w", "w");
		pathCharWiteMap.put("x", "x");
		pathCharWiteMap.put("y", "y");
		pathCharWiteMap.put("z", "z");

		pathCharWiteMap.put("A", "A");
		pathCharWiteMap.put("B", "B");
		pathCharWiteMap.put("C", "C");
		pathCharWiteMap.put("D", "D");
		pathCharWiteMap.put("E", "E");
		pathCharWiteMap.put("F", "F");
		pathCharWiteMap.put("G", "G");
		pathCharWiteMap.put("H", "H");
		pathCharWiteMap.put("I", "I");
		pathCharWiteMap.put("J", "J");
		pathCharWiteMap.put("K", "K");
		pathCharWiteMap.put("L", "L");
		pathCharWiteMap.put("M", "M");
		pathCharWiteMap.put("N", "N");
		pathCharWiteMap.put("O", "O");
		pathCharWiteMap.put("P", "P");
		pathCharWiteMap.put("Q", "Q");
		pathCharWiteMap.put("R", "R");
		pathCharWiteMap.put("S", "S");
		pathCharWiteMap.put("T", "T");
		pathCharWiteMap.put("U", "U");
		pathCharWiteMap.put("V", "V");
		pathCharWiteMap.put("W", "W");
		pathCharWiteMap.put("X", "X");
		pathCharWiteMap.put("Y", "Y");
		pathCharWiteMap.put("Z", "Z");

		pathCharWiteMap.put(":", ":");
		pathCharWiteMap.put("/", "/");
		pathCharWiteMap.put("-", "-");
		pathCharWiteMap.put("_", "_");
		pathCharWiteMap.put("\\", "/");
		pathCharWiteMap.put(".", ".");

		pathCharWiteMap.put("?", "?");
		pathCharWiteMap.put("&", "&");
		pathCharWiteMap.put("=", "=");
	}

	public static String pathCharWhite(String path) {
		String temp = "";
		StringBuffer buffer = new StringBuffer();
		for (int i = 0; i < path.length(); i++) {
			String pathChar = pathCharWiteMap.get(path.charAt(i) + "");
			if (pathChar != null)
				buffer.append(pathChar);
		}
		temp = buffer.toString();
		return temp;
	}

	public static String filterPath(String path) {
		char[] pchars = null;
		if ((path == null) || ("".equals(path))){
			return "";
		}else{
			pchars = path.toCharArray();
		}
		for (int i = 1; i < path.length(); i++) {
			if ((pchars[i] != '.') || (pchars[(i - 1)] != '.'))
				continue;
			pchars[i] = '%';
		}
		return new String(pchars);
	}

	public static String filterFile(String aString) {
		if (aString == null) return null;
		String cleanString = "";
		StringBuffer buffer = new StringBuffer();
		for (int i = 0; i < aString.length(); i++) {
			buffer.append(cleanString + cleanChar(aString.charAt(i)));
		}
		cleanString = buffer.toString();
		return cleanString;
	}

	private static char cleanChar(char aChar) {
		for (int i = 48; i < 58; i++){//过滤数字
			if (aChar == i) return (char) i;
		}
		for (int i = 65; i < 91; i++){//过滤小写字母
			if (aChar == i) return (char) i;
		}
		for (int i = 97; i < 123; i++){//过滤大写字母
			if (aChar == i) return (char) i;
		}
		for (int i = 19968; i < 40891; i++){//过滤汉字
			if (aChar == i) return (char) i;
		}
		switch (aChar) {//过滤特殊字符
			case '/':
				return '/';
			case '.':
				return '.';
			case '-':
				return '-';
			case '_':
				return '_';
			case '\\':
				return '/';
			case ' ':
				return ' ';
			case '&':
				return '&';
			case '=':
				return '=';
		}
		return '%';
	}
}