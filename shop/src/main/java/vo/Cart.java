package vo;

public class Cart {
	private int goodsNo;
	private String customerId;
	private int cartQuantity;
	private String createDate;
	private String updateDate;
	
	
	public int getGoodsNo() {
		return goodsNo;
	}
	public void setGoodsNo(int goodsNo) {
		this.goodsNo = goodsNo;
	}
	public String getCustomerId() {
		return customerId;
	}
	public void setCustomerId(String customerId) {
		this.customerId = customerId;
	}
	public int getCartQuantity() {
		return cartQuantity;
	}
	public void setCartQuantity(int cartQuantity) {
		this.cartQuantity = cartQuantity;
	}
	public String getCreateDate() {
		return createDate;
	}
	public void setCreateDate(String createDate) {
		this.createDate = createDate;
	}
	public String getUpdateDate() {
		return updateDate;
	}
	public void setUpdateDate(String updateDate) {
		this.updateDate = updateDate;
	}
	
	
	@Override
	public String toString() {
		return "Cart [goodsNo=" + goodsNo + ", customerId=" + customerId + ", cartQuantity=" + cartQuantity
				+ ", createDate=" + createDate + ", updateDate=" + updateDate + "]";
	}
}
