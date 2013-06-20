void desplazar_display(int posiciones, boolean sentido)
       {
// Primer parámetro: Numero de desplazamientos
// Segundo parámetro: Sentido del desplazamiento (TRUE=Derecha, FALSE=Izquierda)
    int i,aux;
      if (sentido)
          {
             aux=0b00011000;       // Desplazamiento a la derecha
                   }else {
                       aux=0b00011100;
                           }
                             for (i=1; i<=posiciones; i++)
                                   {
                                       lcd_send_byte(0,aux);
                                            }
                                            }
