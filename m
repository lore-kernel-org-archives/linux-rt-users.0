From: Rolando Martins <rolando.martins@gmail.com>
Subject: Re: Changing Kernel thread priorities
Date: Mon, 6 Jun 2011 12:54:20 +0100
Message-ID: <BANLkTi=xSJOgY735PE44YtkQmrdhgetGdQ@mail.gmail.com>
References: <4DEA1BA9.7020303@unican.es>
	<4DEA1F22.6000603@unican.es>
	<4DEA255B.2050503@unican.es>
	<4DECBE44.2070803@unican.es>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: linux-rt-users@vger.kernel.org, linux-kernel@vger.kernel.org
To: Monica Puig-Pey <puigpeym@unican.es>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from mail-fx0-f46.google.com ([209.85.161.46]:45913 "EHLO
	mail-fx0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753105Ab1FFLyV convert rfc822-to-8bit (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Mon, 6 Jun 2011 07:54:21 -0400
In-Reply-To: <4DECBE44.2070803@unican.es>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

Hi,
I use the following:

PIDs=3D$(ps -eLo pid,cls,rtprio,pri,nice,cmd | grep -i "irq" | awk '{
print $1; }' | xargs echo)
for i in $PIDs
do
    ret=3D$(chrt -f -p 99 $i)
done

This will change the kernel thread associated with an irq handler to
RT FIFO prio 99.
Just change the script to your specific interrupt.

Hope it helps,
Rolando

On Mon, Jun 6, 2011 at 12:47 PM, Monica Puig-Pey <puigpeym@unican.es> w=
rote:
> I am writing a driver which has one kernel thread associated with it.
> I want to change the priority of this thread, so that I can specify t=
he
> order in which it is scheduled following an interrupt.
> I'm using:
>
> =A0sched_setscheduler(struct task_struct *, int, struct sched_param *=
);
>
> but it doesn't work. I tried to change the priority from the init_mod=
ule,
> and also from the Kernel Thread, but there is no way.
>
> Kernel version is 2.6.31-11-rt
>
> What do I call to change a kernel thread priority?
>
> Thanks you very much
>
> M=F3nica
>
> --
> To unsubscribe from this list: send the line "unsubscribe linux-rt-us=
ers" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at =A0http://vger.kernel.org/majordomo-info.html
>
--
To unsubscribe from this list: send the line "unsubscribe linux-rt-user=
s" in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
