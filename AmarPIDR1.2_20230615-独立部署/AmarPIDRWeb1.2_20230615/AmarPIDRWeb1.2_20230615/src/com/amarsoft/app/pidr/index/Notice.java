package com.amarsoft.app.pidr.index;

/**
 * 公告对象
 * @author amarsoft
 *
 */
public class Notice {
	private String boardNo;
	private String boardName;
	private String boardTitle;
	private String isNew;
	private String isEject;
	private String docNo;
	public Notice() {
		super();
	}
	public String getBoardNo() {
		return boardNo;
	}
	public void setBoardNo(String boardNo) {
		this.boardNo = boardNo;
	}
	public String getBoardName() {
		return boardName;
	}
	public void setBoardName(String boardName) {
		this.boardName = boardName;
	}
	public String getBoardTitle() {
		return boardTitle;
	}
	public void setBoardTitle(String boardTitle) {
		this.boardTitle = boardTitle;
	}
	public String getIsNew() {
		return isNew;
	}
	public void setIsNew(String isNew) {
		this.isNew = isNew;
	}
	public String getIsEject() {
		return isEject;
	}
	public void setIsEject(String isEject) {
		this.isEject = isEject;
	}
	public String getDocNo() {
		return docNo;
	}
	public void setDocNo(String docNo) {
		this.docNo = docNo;
	}
	
}
