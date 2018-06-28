package utils;

public enum SessionVars {
    CLIENTE ("cliente"),
    PEDIDO ("pedidoId"),
    ITEMS_PEDIDOS ("itemsPedidos"),
    ERROR_MESSAGE("error");

    private final String name;

    private SessionVars(String s) {
        name = s;
    }

    public boolean equalsName(String otherName) {
        return name.equals(otherName);
    }

    public String getValue() {
        return name;
    }

    public String toString() {
        return this.name;
    }
}
