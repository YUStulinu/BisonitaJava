package cup.example;

import java.util.HashMap;
import java.util.Map;

public class SymbolTable {
    private Map<String, SymbolInfo> symbolTable;

    public SymbolTable() {
        this.symbolTable = new HashMap<>();
    }

    public void addSymbol(String identifier, SymbolInfo symbolInfo) {
        if (!symbolTable.containsKey(identifier)) {
            symbolTable.put(identifier, symbolInfo);
        } else {
            System.err.println("Error: Symbol '" + identifier + "' already defined.");
        }
    }

    public SymbolInfo getSymbol(String identifier) {
        return symbolTable.get(identifier);
    }

    public boolean containsSymbol(String identifier) {
        return symbolTable.containsKey(identifier);
    }
    
    public void printSymbolTable() {
        for (Map.Entry<String, SymbolInfo> entry : symbolTable.entrySet()) {
            String identifier = entry.getKey();
            SymbolInfo symbolInfo = entry.getValue();
            System.out.println("Identifier: " + identifier + ", Type: " + symbolInfo.getType());
        }
    }
}