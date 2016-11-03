package dk.danskebank.mobilepayfruitshop;

import java.math.BigDecimal;

class Product {
    private final String name;
    private final BigDecimal price;
    private final int icon;

    public Product(String name, BigDecimal price, int icon) {
        this.name = name;
        this.price = price;
        this.icon = icon;
    }

    public String getName() {
        return name;
    }

    public BigDecimal getPrice() {
        return price;
    }

    public int getIcon() {
        return icon;
    }
}
