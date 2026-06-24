using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Drawing;
using System.Web.UI.WebControls;
namespace MovieTicketBooking
{
    public class Item
    {
        Button btn;
        int val;
        Color colorBtn;
        bool isBooked;

        public Item(Button btn, int val, Color colorBtn,bool isBooked)
        {
            this.btn = btn;
            this.val = val;
            this.colorBtn = colorBtn;
            this.isBooked = isBooked;
        }
        public Button getButton()
        {
            return this.btn;
        }

        public void setColor(Color color)
        {
            this.colorBtn = color;
        }
        public void setBooked()
        {
            this.isBooked = true;
        }
        public Color getColor()
        {
            return this.colorBtn;
        }
        public int getVal()
        {
            return val;
        }

    }
}


