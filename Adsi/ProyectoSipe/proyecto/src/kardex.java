
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import javax.swing.table.DefaultTableModel;

////

import java.io.*;
import java.util.logging.Level;
import java.util.logging.Logger;
import javax.swing.*;
import jxl.write.*;
import jxl.*;

/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */

/**
 *
 * @author ferpa
 */
public class kardex extends javax.swing.JInternalFrame {

    ///
    

     
     ///
    int n=0;
    public kardex() {
        initComponents();
        nombre.removeAllItems();
    }

     public void mostrar(){
        
        try {

            Class.forName("com.mysql.jdbc.Driver");
            Connection miConexion = DriverManager.getConnection("jdbc:mysql://localhost:3306/sipe", "root", "");
            System.out.println("conexion establecidad");
            PreparedStatement miSentencia = miConexion.prepareStatement("{CALL detallesProducto(?)}");

         
            miSentencia.setString(1,(String)nombre.getSelectedItem());
            Statement st;
            
            DefaultTableModel model = new DefaultTableModel();
            model.addColumn("Id Producto");
            model.addColumn("Nombre Articulo");
            model.addColumn("Ubicacion Articulo");
            model.addColumn("Cantidad Existencia");
            model.addColumn("Costo Unidad");
            model.addColumn("Costo por Mayor");
            
            
            jTable1.setModel(model);
            
            
            String[] dato = new String[6];
            
            st=miConexion.createStatement();
            
            ResultSet rs = miSentencia.executeQuery();
            
            while(rs.next()){
            
                System.out.println(rs.getString(1));
                dato[0]=rs.getString(1);
                dato[1]=rs.getString(2);
                dato[2]=rs.getString(3);
                dato[3]=rs.getString(4);
                dato[4]=rs.getString(5);
                dato[5]=rs.getString(6);
                
                model.addRow(dato);
               
            }
                     

        } catch (ClassNotFoundException ce) {
            ce.printStackTrace();
        } catch (SQLException se) {
            se.printStackTrace();
        }
    
    
    }
     
     
     
     public String[][] obtnerInformacion(){
     
         
     
    
     int numFilas=jTable2.getModel().getRowCount();
     int numColumnas=jTable2.getModel().getColumnCount();
     boolean isCapturedTheTitles=false;
     
     String matrix[][]= new String[numFilas+1][numColumnas];
     
     for(int F=0;F<numFilas;F++){
     
         for(int C=0;C<numColumnas;C++){
             
             if(!isCapturedTheTitles){
             
             matrix[0][C]=jTable2.getColumnName(C);
             isCapturedTheTitles=(F>0)?true:false;
             
             }
             
             matrix[F+1][C]=(String)jTable2.getValueAt((F), C);
         
         
         }
     
     }
     
     return matrix;
     
     }
     
     public void Entrada(){
        
        try {

            Class.forName("com.mysql.jdbc.Driver");
            Connection miConexion = DriverManager.getConnection("jdbc:mysql://localhost:3306/sipe", "root", "");
            System.out.println("conexion establecidad");
            PreparedStatement miSentencia = miConexion.prepareStatement("{CALL Entradas(?)}");

         
            miSentencia.setString(1,(String)nombre.getSelectedItem());
            Statement st;
            
            DefaultTableModel model = new DefaultTableModel();
            
            model.addColumn("NumeroFactura");
            model.addColumn("Fecha");
            model.addColumn("Proveedor");
            model.addColumn("Cantidad");
            model.addColumn("Precio");
            
            
            
            
            
            jTable2.setModel(model);
            
            
            String[] dato = new String[5];
            
            st=miConexion.createStatement();
            
            ResultSet rs = miSentencia.executeQuery();
            
            int cantidad=0,unidad=0,mayor=0;
            
            while(rs.next()){
            
                System.out.println(rs.getString(1));
                
                dato[0]=rs.getString(1);
                dato[1]=rs.getString(2);
              
                dato[2]=rs.getString(3);
                
                dato[3]=rs.getString(4);
                
                dato[4]=rs.getString(5);
                
                
                
                model.addRow(dato);
               
            }
                     

        } catch (ClassNotFoundException ce) {
            ce.printStackTrace();
        } catch (SQLException se) {
            se.printStackTrace();
        }
    
    
    }
    /**
     * This method is called from within the constructor to initialize the form.
     * WARNING: Do NOT modify this code. The content of this method is always
     * regenerated by the Form Editor.
     */
    @SuppressWarnings("unchecked")
    // <editor-fold defaultstate="collapsed" desc="Generated Code">//GEN-BEGIN:initComponents
    private void initComponents() {

        jLabel1 = new javax.swing.JLabel();
        jLabel2 = new javax.swing.JLabel();
        jScrollPane1 = new javax.swing.JScrollPane();
        jTable1 = new javax.swing.JTable();
        jScrollPane2 = new javax.swing.JScrollPane();
        jTable2 = new javax.swing.JTable();
        jLabel3 = new javax.swing.JLabel();
        jLabel4 = new javax.swing.JLabel();
        btnRegresar5 = new javax.swing.JButton();
        jButton1 = new javax.swing.JButton();
        imprimir = new javax.swing.JButton();
        nombre = new javax.swing.JComboBox<>();

        jLabel1.setFont(new java.awt.Font("Comic Sans MS", 1, 14)); // NOI18N
        jLabel1.setHorizontalAlignment(javax.swing.SwingConstants.CENTER);
        jLabel1.setText("Kardex");

        jLabel2.setText("Buscar Producto por Nombre o Codigo:");

        jTable1.setModel(new javax.swing.table.DefaultTableModel(
            new Object [][] {
                {null, null, null, null, null, null},
                {null, null, null, null, null, null},
                {null, null, null, null, null, null},
                {null, null, null, null, null, null}
            },
            new String [] {
                "IdArticulo", "NombreArticulo", "Ubicacion Articulo", "Cantidad Existencia", "Costo Unidad", "Costo por Mayor"
            }
        ));
        jScrollPane1.setViewportView(jTable1);

        jTable2.setModel(new javax.swing.table.DefaultTableModel(
            new Object [][] {
                {null, null, null, null, null},
                {null, null, null, null, null},
                {null, null, null, null, null},
                {null, null, null, null, null}
            },
            new String [] {
                "Numerofactura", "Fecha", "Proveedor", "Cantidad", "Precio"
            }
        ));
        jScrollPane2.setViewportView(jTable2);

        jLabel3.setFont(new java.awt.Font("Comic Sans MS", 1, 14)); // NOI18N
        jLabel3.setHorizontalAlignment(javax.swing.SwingConstants.CENTER);
        jLabel3.setText("Detalles de Producto");

        jLabel4.setFont(new java.awt.Font("Comic Sans MS", 1, 14)); // NOI18N
        jLabel4.setHorizontalAlignment(javax.swing.SwingConstants.CENTER);
        jLabel4.setText("Entradas ");

        btnRegresar5.setFont(new java.awt.Font("Comic Sans MS", 1, 14)); // NOI18N
        btnRegresar5.setIcon(new javax.swing.ImageIcon(getClass().getResource("/iconos/BACK2.png"))); // NOI18N
        btnRegresar5.setBorderPainted(false);
        btnRegresar5.setContentAreaFilled(false);
        btnRegresar5.setCursor(new java.awt.Cursor(java.awt.Cursor.HAND_CURSOR));
        btnRegresar5.setHorizontalTextPosition(javax.swing.SwingConstants.CENTER);
        btnRegresar5.setPressedIcon(new javax.swing.ImageIcon(getClass().getResource("/iconos/BACK3.png"))); // NOI18N
        btnRegresar5.setRolloverIcon(new javax.swing.ImageIcon(getClass().getResource("/iconos/BACK.png"))); // NOI18N
        btnRegresar5.setVerticalAlignment(javax.swing.SwingConstants.BOTTOM);
        btnRegresar5.setVerticalTextPosition(javax.swing.SwingConstants.BOTTOM);
        btnRegresar5.addMouseListener(new java.awt.event.MouseAdapter() {
            public void mouseClicked(java.awt.event.MouseEvent evt) {
                btnRegresar5MouseClicked(evt);
            }
        });
        btnRegresar5.addActionListener(new java.awt.event.ActionListener() {
            public void actionPerformed(java.awt.event.ActionEvent evt) {
                btnRegresar5ActionPerformed(evt);
            }
        });

        jButton1.setText("Buscar");
        jButton1.addActionListener(new java.awt.event.ActionListener() {
            public void actionPerformed(java.awt.event.ActionEvent evt) {
                jButton1ActionPerformed(evt);
            }
        });

        imprimir.setText("Imprimir Excel");
        imprimir.addActionListener(new java.awt.event.ActionListener() {
            public void actionPerformed(java.awt.event.ActionEvent evt) {
                imprimirActionPerformed(evt);
            }
        });

        nombre.setModel(new javax.swing.DefaultComboBoxModel<>(new String[] { "Item 1", "Item 2", "Item 3", "Item 4" }));
        nombre.addActionListener(new java.awt.event.ActionListener() {
            public void actionPerformed(java.awt.event.ActionEvent evt) {
                nombreActionPerformed(evt);
            }
        });

        javax.swing.GroupLayout layout = new javax.swing.GroupLayout(getContentPane());
        getContentPane().setLayout(layout);
        layout.setHorizontalGroup(
            layout.createParallelGroup(javax.swing.GroupLayout.Alignment.LEADING)
            .addComponent(jScrollPane1, javax.swing.GroupLayout.Alignment.TRAILING)
            .addGroup(layout.createSequentialGroup()
                .addGroup(layout.createParallelGroup(javax.swing.GroupLayout.Alignment.LEADING)
                    .addComponent(jScrollPane2, javax.swing.GroupLayout.Alignment.TRAILING)
                    .addGroup(layout.createSequentialGroup()
                        .addGroup(layout.createParallelGroup(javax.swing.GroupLayout.Alignment.LEADING)
                            .addGroup(layout.createSequentialGroup()
                                .addGap(342, 342, 342)
                                .addComponent(jLabel1))
                            .addGroup(layout.createSequentialGroup()
                                .addGap(372, 372, 372)
                                .addComponent(jLabel4))
                            .addGroup(layout.createSequentialGroup()
                                .addGroup(layout.createParallelGroup(javax.swing.GroupLayout.Alignment.TRAILING)
                                    .addGroup(layout.createSequentialGroup()
                                        .addContainerGap()
                                        .addComponent(jLabel2, javax.swing.GroupLayout.PREFERRED_SIZE, 194, javax.swing.GroupLayout.PREFERRED_SIZE)
                                        .addPreferredGap(javax.swing.LayoutStyle.ComponentPlacement.UNRELATED)
                                        .addComponent(nombre, javax.swing.GroupLayout.PREFERRED_SIZE, 275, javax.swing.GroupLayout.PREFERRED_SIZE))
                                    .addGroup(javax.swing.GroupLayout.Alignment.LEADING, layout.createSequentialGroup()
                                        .addGap(348, 348, 348)
                                        .addComponent(jLabel3)))
                                .addGap(35, 35, 35)
                                .addComponent(jButton1)))
                        .addGap(0, 216, Short.MAX_VALUE)))
                .addContainerGap())
            .addGroup(layout.createSequentialGroup()
                .addGap(45, 45, 45)
                .addComponent(imprimir)
                .addPreferredGap(javax.swing.LayoutStyle.ComponentPlacement.RELATED, javax.swing.GroupLayout.DEFAULT_SIZE, Short.MAX_VALUE)
                .addComponent(btnRegresar5, javax.swing.GroupLayout.PREFERRED_SIZE, 69, javax.swing.GroupLayout.PREFERRED_SIZE)
                .addGap(32, 32, 32))
        );
        layout.setVerticalGroup(
            layout.createParallelGroup(javax.swing.GroupLayout.Alignment.LEADING)
            .addGroup(layout.createSequentialGroup()
                .addComponent(jLabel1)
                .addPreferredGap(javax.swing.LayoutStyle.ComponentPlacement.RELATED)
                .addGroup(layout.createParallelGroup(javax.swing.GroupLayout.Alignment.BASELINE)
                    .addComponent(jLabel2)
                    .addComponent(jButton1)
                    .addComponent(nombre, javax.swing.GroupLayout.PREFERRED_SIZE, javax.swing.GroupLayout.DEFAULT_SIZE, javax.swing.GroupLayout.PREFERRED_SIZE))
                .addGap(12, 12, 12)
                .addComponent(jLabel3)
                .addPreferredGap(javax.swing.LayoutStyle.ComponentPlacement.UNRELATED)
                .addComponent(jScrollPane1, javax.swing.GroupLayout.PREFERRED_SIZE, 52, javax.swing.GroupLayout.PREFERRED_SIZE)
                .addGap(8, 8, 8)
                .addComponent(jLabel4)
                .addGap(18, 18, 18)
                .addComponent(jScrollPane2, javax.swing.GroupLayout.PREFERRED_SIZE, 94, javax.swing.GroupLayout.PREFERRED_SIZE)
                .addGroup(layout.createParallelGroup(javax.swing.GroupLayout.Alignment.LEADING)
                    .addGroup(layout.createSequentialGroup()
                        .addGap(43, 43, 43)
                        .addComponent(imprimir)
                        .addContainerGap())
                    .addGroup(javax.swing.GroupLayout.Alignment.TRAILING, layout.createSequentialGroup()
                        .addPreferredGap(javax.swing.LayoutStyle.ComponentPlacement.RELATED, 33, Short.MAX_VALUE)
                        .addComponent(btnRegresar5))))
        );

        pack();
    }// </editor-fold>//GEN-END:initComponents

    
    
    
    private void btnRegresar5MouseClicked(java.awt.event.MouseEvent evt) {//GEN-FIRST:event_btnRegresar5MouseClicked
        // TODO add your handling code here:
    }//GEN-LAST:event_btnRegresar5MouseClicked

    private void btnRegresar5ActionPerformed(java.awt.event.ActionEvent evt) {//GEN-FIRST:event_btnRegresar5ActionPerformed
        // TODO add your handling code here:

        this.dispose();
    }//GEN-LAST:event_btnRegresar5ActionPerformed

    private void jButton1ActionPerformed(java.awt.event.ActionEvent evt) {//GEN-FIRST:event_jButton1ActionPerformed
        // TODO add your handling code here:
        
        mostrar();
        Entrada();
        
    }//GEN-LAST:event_jButton1ActionPerformed

    

//////////////////////////////////////////////////////////////////////
 
 




  

        
    private void imprimirActionPerformed(java.awt.event.ActionEvent evt) {//GEN-FIRST:event_imprimirActionPerformed
        // TODO add your handling code here:
        
        JFileChooser filechooser = new JFileChooser();
        filechooser.setFileSelectionMode(JFileChooser.FILES_ONLY);
        int resultado=filechooser.showSaveDialog(this);
        if(resultado==JFileChooser.CANCEL_OPTION){
        
        
            return;
        }
        
        File archivo =filechooser.getSelectedFile();
        
try{
    
    PrintWriter salida= new PrintWriter(new FileWriter(archivo+".csv"));
    
    String data[][]=obtnerInformacion();
    int n=0;
    for(int i=0;i<data.length;i++){
    
        
        
        
        for(int j=0;j<data[i].length;j++){
       // salida.print("");
            //salida.print(data[i][0]);
        
            String word=data[i][j];
            
            //salida.print(data[i][n]);
            
            if(word!=null){
                
                
                salida.print(word+";"+"\t");
                //salida.close();
          
                
            }
            else{
            
            salida.print(";");
            }
        
        
        }
        
        salida.println();
        
    }
    
    salida.close();
} catch(IOException io){

}       
        
             
    }//GEN-LAST:event_imprimirActionPerformed

    private void nombreActionPerformed(java.awt.event.ActionEvent evt) {//GEN-FIRST:event_nombreActionPerformed
        // TODO add your handling code here:
        try {

            
            Class.forName("com.mysql.jdbc.Driver");
            Connection miConexion = DriverManager.getConnection("jdbc:mysql://localhost:3306/sipe", "root", "");
            System.out.println("conexion establecidad");
            PreparedStatement miSentencia = miConexion.prepareStatement("Select NombreProductoMarca from productos_marcas");
            //PreparedStatement Sentencia = miConexion.prepareStatement("{CALL llamarCategoria(?)}");
        
         // Sentencia.setString(1,(String)nombre.getSelectedItem());
          //miConexion.createStatement();
            ResultSet rs =  miSentencia.executeQuery();
            //ResultSet llamar=Sentencia.executeQuery();
         
      
         
         if(n==0){
         
         this.nombre.addItem("Selecciona una Opcion");
         
         }
         
          
         
         while(rs.next()&& n==0){
             
             
             this.nombre.addItem(rs.getString(1)); 
         
         }
       
         n=1;
         
        
         
         
         
     
       
       
         
       
            
        } catch (ClassNotFoundException ce) {
            ce.printStackTrace();
        } catch (SQLException ex) {
            Logger.getLogger(Actualizar.class.getName()).log(Level.SEVERE, null, ex);
        }
    }//GEN-LAST:event_nombreActionPerformed


    // Variables declaration - do not modify//GEN-BEGIN:variables
    private javax.swing.JButton btnRegresar5;
    private javax.swing.JButton imprimir;
    private javax.swing.JButton jButton1;
    private javax.swing.JLabel jLabel1;
    private javax.swing.JLabel jLabel2;
    private javax.swing.JLabel jLabel3;
    private javax.swing.JLabel jLabel4;
    private javax.swing.JScrollPane jScrollPane1;
    private javax.swing.JScrollPane jScrollPane2;
    private javax.swing.JTable jTable1;
    private javax.swing.JTable jTable2;
    private javax.swing.JComboBox<String> nombre;
    // End of variables declaration//GEN-END:variables
}
