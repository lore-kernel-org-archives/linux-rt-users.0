From: =?UTF-8?Q?Sean_Nyekj=c3=a6r?= <sean.nyekjaer@prevas.dk>
Subject: Re: [PATCH] tty: serial: sc16is7xx: implemented our own oneshot-like
 handling
Date: Mon, 14 Mar 2016 07:21:14 +0100
Message-ID: <56E6585A.3060203@prevas.dk>
References: <1457692476-19082-1-git-send-email-sean.nyekjaer@prevas.dk>
 <alpine.DEB.2.11.1603131103020.3657@nanos>
Mime-Version: 1.0
Content-Type: text/plain; charset="windows-1252"; format=flowed
Content-Transfer-Encoding: 7bit
Cc: <linux-serial@vger.kernel.org>, Josh Cartwright <joshc@ni.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	<linux-rt-users@vger.kernel.org>,
	Jon Ringle <jringle@gridpoint.com>
To: Thomas Gleixner <tglx@linutronix.de>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from mail01.prevas.se ([62.95.78.3]:25716 "EHLO mail01.prevas.se"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750806AbcCNGVg (ORCPT <rfc822;linux-rt-users@vger.kernel.org>);
	Mon, 14 Mar 2016 02:21:36 -0400
In-Reply-To: <alpine.DEB.2.11.1603131103020.3657@nanos>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>



On 2016-03-13 11:25, Thomas Gleixner wrote:
> On Fri, 11 Mar 2016, Sean Nyekjaer wrote:
>
>>   static irqreturn_t sc16is7xx_irq(int irq, void *dev_id)
>>   {
>>   	struct sc16is7xx_port *s = (struct sc16is7xx_port *)dev_id;
>> +	int i;
>> +
>> +	for (i = 0; i < s->devtype->nr_uart; ++i)
>> +		disable_irq_nosync(s->p[i].port.irq);
> Aside of the lack of a changelog. This is completely bogus. You disable the
> same interrupt a gazillion of times.
I can't see why the interrupt is disabled a gazillion times.
When the irq is disabled the function will not be called before it's 
enabled again... Or have i missed something?
>>   	queue_kthread_work(&s->kworker, &s->irq_work);
> This driver should use a threaded interrupt instead of trying to emulate it
> via dis/enable_irq and a worker thread.
I agree, I and "Sebastian Andrzej Siewior" have proposed this fix, but 
it was turned down. :-)
>
> Then you simply call c16is7xx_port_irq() right from the interrupt routine and
> the core code deals with the interrupt mask/unmask automatically.
>
> Thanks,
>
> 	tglx
>
/Sean
