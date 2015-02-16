From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Subject: Re: w1-gpio: sleeping function called from invalid context
Date: Mon, 16 Feb 2015 14:29:36 +0100
Message-ID: <20150216132936.GC21649@linutronix.de>
References: <534E97C8.5090407@meduna.org>
 <534ED833.6020303@windriver.com>
 <534FE2A8.2030203@meduna.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Paul Gortmaker <paul.gortmaker@windriver.com>, zbr@ioremap.net,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"linux-rt-users@vger.kernel.org" <linux-rt-users@vger.kernel.org>
To: Stanislav Meduna <stano@meduna.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <534FE2A8.2030203@meduna.org>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-rt-users.vger.kernel.org

* Stanislav Meduna | 2014-04-17 16:18:16 [+0200]:

>diff --git a/drivers/w1/w1_io.c b/drivers/w1/w1_io.c
>index e10acc2..7065486 100644
>--- a/drivers/w1/w1_io.c
>+++ b/drivers/w1/w1_io.c
>@@ -170,14 +170,14 @@ static u8 w1_read_bit(struct w1_master *dev)
>        unsigned long flags = 0;
>
>        /* sample timing is critical here */
>-       local_irq_save(flags);
>+       if(w1_disable_irqs) local_irq_save(flags);
>        dev->bus_master->write_bit(dev->bus_master->data, 0);
>        w1_delay(6);
>        dev->bus_master->write_bit(dev->bus_master->data, 1);
>        w1_delay(9);
>
>        result = dev->bus_master->read_bit(dev->bus_master->data);
>-       local_irq_restore(flags);
>+       if(w1_disable_irqs) local_irq_restore(flags);
>
>        w1_delay(55);
>

there is local_irq_save_nort() and its friends.

Sebastian
