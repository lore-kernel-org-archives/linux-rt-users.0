From: Iratxo Pichel Ortiz <ipichel@albentia.com>
Subject: Re: NOHZ: local_softirq_pending
Date: Thu, 18 Jun 2009 00:35:36 +0200
Message-ID: <4A396FB8.3020807@albentia.com>
References: <4A35171C.9090800@albentia.com>  <8e6b7a710906141250m2a991ca9r5949e502b9976e39@mail.gmail.com>  <alpine.LFD.2.00.0906151501200.2800@localhost.localdomain>  <4A365CCF.2020707@albentia.com> <8e6b7a710906160101x6a8ae9d5qa7638627f513278@mail.gmail.com> <4A376450.5020209@albentia.com> <4A376559.5060604@albentia.com> <4A37B014.4040104@albentia.com> <4A37E6D1.5010207@albentia.com> <alpine.LFD.2.00.0906180001210.2800@localhost.localdomain>
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
Received: from llsc092-a04.servidoresdns.net ([82.223.190.44]:53269 "EHLO
	llsc092-a04.servidoresdns.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751835AbZFQWfl (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Wed, 17 Jun 2009 18:35:41 -0400
In-Reply-To: <alpine.LFD.2.00.0906180001210.2800@localhost.localdomain>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

Thomas Gleixner wrote:
> On Tue, 16 Jun 2009, Iratxo Pichel Ortiz wrote:
>  =20
>> I have tried disabling the CONFIG_NOHZ kernel option. Of course the =
trace is
>> gone, but the weird behavior is still there. When I run my software =
without
>> load from the network, the main task of the system experiences runti=
mes of
>> about 700us. When I load the system, there are latencies of 50700us,=
 so the
>> 50ms delay is again there, and again the time when the task finishes=
 is always
>> X.296, 1 jiffy after the "NOHZ: pending..." was shown with CONFIG_NO=
HZ
>> enabled.
>>    =20
>
> What kind of system is this ?=20
>  =20
It is an IXP425 custom board, mainly equivalent to the Intel's IXDP425=20
development board, so it is ARM (xscale) architecture.

The problem is perfectly repeatable without the need to have other code=
=20
loaded in the system than the standard kernel, but I first detected it=20
with a custom development I am working on, that run a RT task (prio 98)=
=20
every 2.5ms to schedule a radio link.

To detect the problem, with my attached .config, I just need to=20
massively ping the ethernet interface and I start to see "NOHZ:=20
pending..." every second or couple of seconds from jiffie XXX950 to=20
XXX999 (HZ 1000). The SOFTIRQ pendings that I have seen pending are=20
almost all of them: RCU, NETTX, NETRX, TIMER...

Having tested this I first thought that it could be related with=20
ixp4xx_eth driver but I used a different interface and driver and the=20
problem is also there. I have also, at least apparently, discarded the=20
bridging code and vlan code, that I was using at first.
> Can you please check whether you can reproduce with NOHZ=3Dy and func=
tion
> tracer enabled ?
>
>  =20
I have already tested with NOHZ, and the behavior is exactly the same,=20
there is a delay of about 50ms that always finishes at trace  with=20
timestamp XXX.296 seconds buf, of course, the "NOHZ: ..." trace is not=20
shown.

I have not tried this with the function tracer enabled, I will build th=
e=20
kernel again and enable this tracer. Which function should I trace? Any=
=20
hint about this? I have a couple of systems running so I can make any=20
trace you would like. I will try to figure out something and give=20
feedback later.

I have also tested the system with the latest 2.29.5-rt21 kernel and RT=
=20
patch.

Thanks a lot,

    Iratxo.
> That would be great.
>
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
