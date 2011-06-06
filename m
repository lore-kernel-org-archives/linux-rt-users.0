From: Armin Steinhoff <armin@steinhoff.de>
Subject: Re: Changing Kernel thread priorities
Date: Mon, 06 Jun 2011 20:20:54 +0200
Message-ID: <4DED1A86.9030502@steinhoff.de>
References: <4DEA1BA9.7020303@unican.es> <4DEA1F22.6000603@unican.es> 	<4DEA255B.2050503@unican.es> <4DECBE44.2070803@unican.es>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1;
	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: linux-rt-users@vger.kernel.org, linux-kernel@vger.kernel.org
To: Monica Puig-Pey <puigpeym@unican.es>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from moutng.kundenserver.de ([212.227.17.9]:60473 "EHLO
	moutng.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751655Ab1FFSLO (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Mon, 6 Jun 2011 14:11:14 -0400
In-Reply-To: <4DECBE44.2070803@unican.es>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

Monica Puig-Pey wrote:
> I am writing a driver which has one kernel thread associated with it.
> I want to change the priority of this thread, so that I can specify=20
> the order in which it is scheduled following an interrupt.
> I'm using:
>
>  sched_setscheduler(struct task_struct *, int, struct sched_param *);=
 =20
> -> sys_sched_setscheduler

http://ftp.au.debian.org/linux-mandocs/2.6.0-test7-full/sys_sched_setsc=
heduler.html

Hope this helps ..

--Armin

>
> but it doesn't work. I tried to change the priority from the=20
> init_module, and also from the Kernel Thread, but there is no way.
>
> Kernel version is 2.6.31-11-rt
>
> What do I call to change a kernel thread priority?
>
> Thanks you very much
>
> M=F3nica
>
> --=20
> To unsubscribe from this list: send the line "unsubscribe=20
> linux-rt-users" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>

--
To unsubscribe from this list: send the line "unsubscribe linux-rt-user=
s" in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
