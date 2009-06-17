From: GeunSik Lim <leemgs1@gmail.com>
Subject: Re: Setting the priority of an IRQ thread
Date: Wed, 17 Jun 2009 22:32:35 +0900
Message-ID: <49b7c2350906170632t4ea086f3tb0269d5948885568@mail.gmail.com>
References: <loom.20090615T222836-377@post.gmane.org>
	 <000001c9ee36$218cf3a0$a852c70a@dlh.st.com>
	 <loom.20090616T074347-549@post.gmane.org>
	 <20090616182734.GD13048@pengutronix.de>
	 <alpine.LFD.2.00.0906170025080.2800@localhost.localdomain>
	 <alpine.LFD.2.00.0906171114560.2800@localhost.localdomain>
	 <3efb10970906170421r1f4b8556h26a3c08a3cb9ee5e@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Cc: Thomas Gleixner <tglx@linutronix.de>,
	=?UTF-8?Q?Uwe_Kleine=2DK=C3=B6nig?=
	<u.kleine-koenig@pengutronix.de>,
	Martin Shepherd <mcs@astro.caltech.edu>,
	linux-rt-users@vger.kernel.org
To: Remy Bohmer <linux@bohmer.net>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from yw-out-2324.google.com ([74.125.46.29]:35296 "EHLO
	yw-out-2324.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752613AbZFQNcd (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Wed, 17 Jun 2009 09:32:33 -0400
Received: by yw-out-2324.google.com with SMTP id 5so167296ywb.1
        for <linux-rt-users@vger.kernel.org>; Wed, 17 Jun 2009 06:32:35 -0700 (PDT)
In-Reply-To: <3efb10970906170421r1f4b8556h26a3c08a3cb9ee5e@mail.gmail.com>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

On Wed, Jun 17, 2009 at 8:21 PM, Remy Bohmer<linux@bohmer.net> wrote:
> Hello Thomas,
> Or some kernel developer change the name of the interrupt handler? All
> different implementations in userspace has to follow as well... And
> why is 50 the right default to use, and not 30 or 60?
> For a realtime embedded device this could all be the case, and it is
> not that strange.
Um..., I also don't know exact reason that seted irq priority with 50.
I think that  the value is irq priotiry  is promise in Realtime system.
In my case, When I have to change( or set) RT priority about RT Kernel thread or
Userspace RT applications in a realtime embedded device,
I  change( or set ) priority of  RT Process(or thread) after consider
that irq priority is 50.

-- 
Regards,
GeunSik Lim ( Samsung Electronics )
Blog : http://blog.naver.com/invain/
e-Mail: geunsik.lim@samsung.com
           leemgs@gmail.com , leemgs1@gmail.com
--
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
Please read the FAQ at  http://www.tux.org/lkml/
