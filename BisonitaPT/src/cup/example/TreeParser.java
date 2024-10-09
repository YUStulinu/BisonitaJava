package cup.example;

import java.util.ArrayList;
import java.util.List;

class TreeNode {
    String label;
    List<TreeNode> children;


    String symbolName;
    String symbolType;

    public TreeNode(String label) {
        this.label = label;
        this.children = new ArrayList<>();
    }

    public TreeNode(String label, String symbolName, String symbolType) {
        this.label = label;
        this.children = new ArrayList<>();
        this.symbolName = symbolName;
        this.symbolType = symbolType;
    }

    public void addChild(TreeNode child) {
        this.children.add(child);
    }
    
    public List<TreeNode> getChildren() {
        return this.children;
    }

    public TreeNode getChild(String label) {
        for (TreeNode child : children) {
            if (child.label.equals(label)) {
                return child;
            }
        }
        return null;
    }

    public void removeChild(TreeNode child) {
        this.children.remove(child);
    }
}

public class TreeParser {
    private TreeNode root;

    public TreeParser(String label) {
        this.root = new TreeNode(label);
    }


    public void addChild(String label, String symbolName, String symbolType) {
        TreeNode child = new TreeNode(label, symbolName, symbolType);
        this.root.addChild(child);
    }

    public void printTree() {
        printTree(root, 0);
    }

    private void printTree(TreeNode node, int level) {
        if (node == null) {
            return;
        }

        StringBuilder indent = new StringBuilder();
        for (int i = 0; i < level; i++) {
            indent.append("  ");
        }

        System.out.println(indent.toString() + node.label);


        if (node.symbolName != null && node.symbolType != null) {
            System.out.println(indent.toString() + "  Symbol Name: " + node.symbolName);
            System.out.println(indent.toString() + "  Symbol Type: " + node.symbolType);
        }

        for (TreeNode child : node.children) {
            printTree(child, level + 1);
        }
    }
}