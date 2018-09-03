
import java.awt.Color;
import java.awt.Component;
import javax.swing.JTable;
import javax.swing.table.DefaultTableCellRenderer;

/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */

/**
 *
 * @author fernando
 */
class FormatoTabla extends DefaultTableCellRenderer
{  
    @Override
    public Component getTableCellRendererComponent(JTable jTable1,Object value,boolean selected, boolean focused, int row, int column)
    { 
        super.getTableCellRendererComponent(jTable1, value, selected, focused, row, column);
        String g =(String)jTable1.getValueAt(row,4);
        float y = Float.parseFloat(g);
        if (y<100)
        {
            this.setOpaque(true);
            this.setBackground(Color.RED);
            this.setForeground(Color.BLACK);
        } else{
            
                this.setOpaque(true);
                this.setBackground(Color.GREEN);
                this.setForeground(Color.BLACK);
            
           


        }
          super.getTableCellRendererComponent(jTable1, value, selected, focused, row, column);     
          return this;
    } }