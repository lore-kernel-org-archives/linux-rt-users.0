From: maray@alumnos.inf.utfsm.cl
Subject: Re: Parport and RT_PREEMPT
Date: Tue, 6 May 2008 16:53:42 -0400 (CLT)
Message-ID: <59303.200.1.19.97.1210107222.squirrel@wmalm.inf.utfsm.cl>
References: <20080503210605.GA16610@alumnos.inf.utfsm.cl>
Mime-Version: 1.0
Content-Type: text/plain;charset=utf-8
Content-Transfer-Encoding: 8bit
Cc: linux-rt-users@vger.kernel.org
To: "Mauricio A. Araya L?pez" <maray@inf.utfsm.cl>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from placeres.inf.utfsm.cl ([204.87.169.2]:55375 "EHLO
	placeres.inf.utfsm.cl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932749AbYEFVBW (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Tue, 6 May 2008 17:01:22 -0400
In-Reply-To: <20080503210605.GA16610@alumnos.inf.utfsm.cl>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

> Hi,
>
> I am trying to use the parport interrupt (pin 10) on a RT_PREEMPT Linux
> Kernel. I am using the parport_pc module to register a custom driver
> that synchronize the clocks using an external clock generator, by
> sending a signal to the parport interrupt pin 10 (ACK). With kernel
> 2.4.24 i have no problems on using the interface that the parport_pc
> driver offers me.  But, as my userspace applications needs RT, i've
> installed the RT_PREEMPT patches, and my driver is not working now. The
> attach function of my driver is:
[...]
>
> This should be enough to register my driver with the parint_handler
> function as the "callback" when the IRQ (7) ocurrs.  In summary, i am
> registering the device, the callback, enabling the IRQ at the control
> register (0x10), and enabling the IRQ in the parport_driver.

Ok. It seems to work for very limnited time quantums. Maybe the interrupt
handler thread IRQ7 should have a higher priority, but i dont know how to
do this... :S

> I've change the IRQ flags to IRQF_NODElAY in the parport driver,
> and I've write also a module without using the parport_pc,
> and still the interrupt denies to works.

