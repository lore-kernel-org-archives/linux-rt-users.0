From: Monica Puig-Pey <puigpeym@unican.es>
Subject: kernel threads in drivers using the RT patch
Date: Sat, 4 Jun 2011 14:30:19 +0200
Message-ID: <4DEA255B.2050503@unican.es>
References: <4DEA1BA9.7020303@unican.es> <4DEA1F22.6000603@unican.es>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252;
	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
To: <linux-rt-users@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from ccserver2.unican.es ([130.206.5.101]:41947 "EHLO
	ccserver2.unican.es" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756351Ab1FDM3w (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Sat, 4 Jun 2011 08:29:52 -0400
In-Reply-To: <4DEA1F22.6000603@unican.es>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

Hello,

I'm studying how to develop drivers in a real time OS and how do they=20
work. I'm using  Ubuntu 10.04 with the 2.6.31-11-rt patch installed.
I'm trying to run a kernel thread from my driver (kernel context). I=20
create the kthread in the module_init, I change its real time priority=20
and then make it run .
Code shown below:

thread_handler=3D*(struct task_struct *)kthread_create(my_tasklet_handl=
er,=20
(void*)&datos,"thread_handler");
   if (IS_ERR(&thread_handler)){
      return PTR_ERR(&thread_handler);
      printk(KERN_WARNING "<pci> (init_module)  Error creating Thread=20
handler\n");
   }
params->sched_priority=3D20;
result =3D sched_setscheduler(&thread_handler, SCHED_FIFO, params);
result=3Dwake_up_process(&thread_handler);

Params is global struct sched_param * and struct thread_handler  a=20
global task_struct.

I stop the Kthread in the module_exit using=20
res=3Dkthread_stop(&thread_handler);

The kthread "thread_handler" has a while (1) loop and it is stopped in =
a=20
semaphore, waiting for the interrupt handler. When it wakes up each tim=
e=20
it calls kthread_should_stop() and depending on that break out of the=20
loop or run.

My problem is, when trying to establish the rtprio kthread, the whole=20
computer get blocked and I only can restart it. If I delete this part,=20
then kthread runs, and works well. With the ps command I can see it has=
=20
a 24 NON real time priority. Then the problem come when uninstalling my=
=20
module with rmmod. In the  kthread_stop function, everything gets block=
ed.

Could someone tell what am I doing wrong? Or just give me some help=20
about kernel threads in the RT Patch?

Thanks a lot

M=F3nica
--
To unsubscribe from this list: send the line "unsubscribe linux-rt-user=
s" in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
