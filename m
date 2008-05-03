From: Mauricio =?utf-8?Q?A=2E_Araya_L=F3pez?= <maray@inf.utfsm.cl>
Subject: Parport and RT_PREEMPT
Date: Sat, 3 May 2008 17:06:05 -0400
Message-ID: <20080503210605.GA16610@alumnos.inf.utfsm.cl>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
To: linux-rt-users@vger.kernel.org
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from alegre.inf.utfsm.cl ([204.87.169.3]:58386 "EHLO
	alegre.inf.utfsm.cl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753012AbYECVGN (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Sat, 3 May 2008 17:06:13 -0400
Received: from ritoque.inf.utfsm.cl (ssh2.inf.utfsm.cl [204.87.169.5])
	by alegre.inf.utfsm.cl (8.13.8/8.13.8) with ESMTP id m43L67Qm022466
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO)
	for <linux-rt-users@vger.kernel.org>; Sat, 3 May 2008 17:06:07 -0400
Received: from rodriguez.inf.utfsm.cl (localhost.localdomain [127.0.0.1])
	by ritoque.inf.utfsm.cl (8.14.2/8.13.8) with ESMTP id m43L67L5016990
	for <linux-rt-users@vger.kernel.org>; Sat, 3 May 2008 17:06:07 -0400
Received: (from maray@localhost)
	by rodriguez.inf.utfsm.cl (8.14.2/8.14.2/Submit) id m43L65vQ016988
	for linux-rt-users@vger.kernel.org; Sat, 3 May 2008 17:06:05 -0400
Content-Disposition: inline
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

Hi,

I am trying to use the parport interrupt (pin 10) on a RT_PREEMPT Linux
Kernel. I am using the parport_pc module to register a custom driver
that synchronize the clocks using an external clock generator, by
sending a signal to the parport interrupt pin 10 (ACK). With kernel
2.4.24 i have no problems on using the interface that the parport_pc
driver offers me.  But, as my userspace applications needs RT, i've
installed the RT_PREEMPT patches, and my driver is not working now. The
attach function of my driver is:

void parint_attach(struct parport *par){
        par->ops->write_data(par,0);
        ev=parport_register_device(par,"parint",NULL,NULL,parint_handler,0,NULL);
        par->ops->write_control(par,0x10);
        par->ops->enable_irq(par);
        parport_claim(dev);
}

This should be enough to register my driver with the parint_handler
function as the "callback" when the IRQ (7) ocurrs.  In summary, i am
registering the device, the callback, enabling the IRQ at the control
register (0x10), and enabling the IRQ in the parport_driver.

I've change the IRQ flags to IRQF_NODElAY in the parport driver,
and I've write also a module without using the parport_pc, 
and still the interrupt denies to works.

Any ideas of where could be the problem will be very welcome...

Thanks!



-- 
Mauricio Araya L. 
ACS-UTFSM Team Leader, cel: 0-81564903
Est. Magister en Ciencias de la Informatica UTFSM, Valparaiso, Chile
counter.li.org: #249395, http://www.inf.utfsm.cl/~maray 
