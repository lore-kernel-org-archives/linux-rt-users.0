From: Mauricio =?utf-8?Q?A=2E_Araya_L=F3pez?= <maray@inf.utfsm.cl>
Subject: Parport and Linux-RT
Date: Thu, 24 Apr 2008 12:17:09 -0400
Message-ID: <20080424161709.GA20212@alumnos.inf.utfsm.cl>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
To: linux-rt-users@vger.kernel.org
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from alegre.inf.utfsm.cl ([204.87.169.3]:39712 "EHLO
	alegre.inf.utfsm.cl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756606AbYDXQWg (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Thu, 24 Apr 2008 12:22:36 -0400
Received: from ritoque.inf.utfsm.cl (ssh2.inf.utfsm.cl [204.87.169.5])
	by alegre.inf.utfsm.cl (8.13.8/8.13.8) with ESMTP id m3OGHAT5010088
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO)
	for <linux-rt-users@vger.kernel.org>; Thu, 24 Apr 2008 12:17:10 -0400
Received: from ritoque.inf.utfsm.cl (localhost.localdomain [127.0.0.1])
	by ritoque.inf.utfsm.cl (8.14.2/8.13.8) with ESMTP id m3OGH9Tb022065
	for <linux-rt-users@vger.kernel.org>; Thu, 24 Apr 2008 12:17:09 -0400
Received: (from maray@localhost)
	by ritoque.inf.utfsm.cl (8.14.2/8.14.2/Submit) id m3OGH9rf022064
	for linux-rt-users@vger.kernel.org; Thu, 24 Apr 2008 12:17:09 -0400
Content-Disposition: inline
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

Hi,

I am recieving a 'tick' from an electronic device, through the parallel
port pin-10. This pin generates an interrupt, so I am handling this
using the parport(_pc) generic module. This works flawlessly on a normal
linux, but using the -rt patches, the IRQ is not taken by the module.

Normal linux:
---
# modprobe parport 
# modprobe parport_pc
# cat /proc/interrupts 
        CPU0       
0:    5430087    XT-PIC-XT        timer
1:      13743    XT-PIC-XT        i8042
2:          0    XT-PIC-XT        cascade
7:      48100    XT-PIC-XT        parport0
...
---

Linux-rt:
---
# modprobe parport
# modprobe parport_pc
# cat /proc/interrupts 
        CPU0       
0:     382921    XT-PIC-XT        timer
1:          8    XT-PIC-XT        i8042
2:          0    XT-PIC-XT        cascade
7:          6    XT-PIC-XT      
...
---

In my own module I have tried to enable, request and wake the IRQ but 
with no success.

I've check the linux/drivers/parport/parport_pc.c in both kernels, and
they are identical. Also i've look at linux/kernel/irq/manage.c diffs and maybe
the parport module should ask for a IRQF_NODELAY interrupt?. 

I am not very sure how the interrupts are managed in RT_PREEMPT, so any
comment will be very helpfull.

Bye

-- 
Mauricio Araya L. 
ACS-UTFSM Team Leader, cel: 0-81564903
Est. Magister en Ciencias de la Informatica UTFSM, Valparaiso, Chile
counter.li.org: #249395, http://www.inf.utfsm.cl/~maray 
