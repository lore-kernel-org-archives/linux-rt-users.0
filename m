From: Iratxo Pichel Ortiz <ipichel@albentia.com>
Subject: Re: NOHZ: local_softirq_pending
Date: Thu, 18 Jun 2009 18:52:09 +0200
Message-ID: <4A3A70B9.4070702@albentia.com>
References: <4A35171C.9090800@albentia.com>  <8e6b7a710906141250m2a991ca9r5949e502b9976e39@mail.gmail.com>  <alpine.LFD.2.00.0906151501200.2800@localhost.localdomain>  <4A365CCF.2020707@albentia.com> <8e6b7a710906160101x6a8ae9d5qa7638627f513278@mail.gmail.com> <4A376450.5020209@albentia.com> <4A376559.5060604@albentia.com> <4A37B014.4040104@albentia.com> <4A37E6D1.5010207@albentia.com> <alpine.LFD.2.00.0906180001210.2800@localhost.localdomain> <4A396FB8.3020807@albentia.com> <alpine.LFD.2.00.0906180133220.2800@localhost.localdomain> <4A398B4F.6080702@albentia.com> <alpine.LFD.2.00.0906181048500.2800@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1;
	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: linux-rt-users <linux-rt-users@vger.kernel.org>,
	=?ISO-8859-1?Q?Noeli?= =?ISO-8859-1?Q?a_Mor=F3n?=
	<nmoron@albentia.com>,
	'Rodrigo Partearroyo' <rpartearroyo@albentia.com>
To: Thomas Gleixner <tglx@linutronix.de>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from llsc497-a04.servidoresdns.net ([82.223.190.48]:43579 "EHLO
	llsc497-a04.servidoresdns.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1750794AbZFRQwR (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Thu, 18 Jun 2009 12:52:17 -0400
In-Reply-To: <alpine.LFD.2.00.0906181048500.2800@localhost.localdomain>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

Thomas,

Thomas Gleixner wrote:
> No, what happens is that the -RT starvation protector kicks in. That'=
s
> a mechanism which checks whether the CPU is monopolized by rt tasks
> for longer than 950ms. It then blocks execution of rt tasks for
> 50ms. The silly thing is that it goes idle, but that's a different
> problem.
>  =20
> It's default on and can be disabled via:
>
> echo 0 > /proc/sys/kernel/rt_runtime_us
>
> Sorry that I did not notice that earlier, but when that triggers, the=
n
> something is really wrong. There should never be a situation where -r=
t
> tasks (neither irq threads nor softirqs) should monopolize the CPU.
>  =20
No problem at all! Please let me know if the following assumption is=20
right: This protection mechanism is dependent on the available CPU=20
power. I mean, if the system has low CPU power, and if, for example, th=
e=20
network has very very high load, the total time taken to process all th=
e=20
data will be long. Generally much longer than in more powerful systems,=
=20
so this protection arises. Is this right or it should not happen by=20
design of the softirqs/RT tasks?

Anyway, seems to be correctly working. I still have to check why with =20
HZ=3D100 it was periodically happening this events even with low load, =
but=20
that could be very probably related to my software.

Again, thank you very much.

Best regards,

    Iratxo.
> Thanks,
>
> 	tglx
>
>  =20


--=20
Iratxo Pichel Ortiz
Software Development Manager

Albentia Systems S.A.
http://www.albentia.com

Tel: +34 914400567
Cel: +34 663808405
=46ax: +34 914400569

C\Margarita Salas 22
Parque Tecnol=F3gico de Legan=E9s
Legan=E9s (28918)
Madrid
Spain


--
To unsubscribe from this list: send the line "unsubscribe linux-rt-user=
s" in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
