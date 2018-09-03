/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */

/**
 *
 * @author FAMILIA ROMA
 */
public class bloquearVentana extends javax.swing.JInternalFrame {
    
    private boolean locked ;
    
    /**
     * Creates new form VentanaCrearProveedor
     */
    @Override
    public void reshape(int x, int y, int width, int height) 
    {
        if (!locked) {                                      //Este metodo me permite bloquear la VentanaCrearProveedor
        super.reshape(x, y, width, height);
        }
    }

    public boolean getLocked()
    {                                              
        return locked;
    }
                                                     //se crean los metodos para modificar el bloquea de VentanaCrearProveedor
    public void setLocked(boolean locked) 
    {
        this.locked = locked;
    }
    
}
