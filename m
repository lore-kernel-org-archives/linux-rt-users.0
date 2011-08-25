From: Christian Kraus <chk.dax@gmx.de>
Subject: Interrupt Latency 2.6.33.7 rt30
Date: Thu, 25 Aug 2011 23:03:33 +0200
Message-ID: <4E56B8A5.6080306@gmx.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15; format=flowed
Content-Transfer-Encoding: 7bit
To: linux-rt-users <linux-rt-users@vger.kernel.org>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from mailout-de.gmx.net ([213.165.64.23]:38190 "HELO
	mailout-de.gmx.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with SMTP id S1754577Ab1HYVDi (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Thu, 25 Aug 2011 17:03:38 -0400
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

Hello
I have wrote a GPIO-driver, that toggle the value of a GPIO when a 
interrupt is comming from an another GPIO.
When I measure the latency between the interrupt and the toggled Pin 
it's about ten times higher than without the rt-patch.
(without Patch = 8-11 us
  with Patch = 30-110 us)

Can anybody help me please?

I have a Beagleboard with an Omap-Arm running.

Here are the changes in gpio_keys.c:

static irqreturn_t gpio_keys_isr(int irq, void *dev_id)
{
     struct gpio_button_data *bdata = dev_id;
     struct gpio_keys_button *button = bdata->button;

     BUG_ON(irq != gpio_to_irq(button->gpio));

     if (button->debounce_interval)
     {
         mod_timer(&bdata->timer,
             jiffies + msecs_to_jiffies(button->debounce_interval));



     }
     else
     {
     //    schedule_work(&bdata->work);

         if(gpio_get_value(158)==0)
         {
             gpio_set_value(158, 1);
         }
         else
         {
             gpio_set_value(158, 0);
         }


     }

     return IRQ_HANDLED;
}


Thx Christian

