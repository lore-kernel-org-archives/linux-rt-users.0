From: Rolando Martins <rolando.martins@gmail.com>
Subject: Re: [ANNOUNCE] 3.0-rt1
Date: Fri, 22 Jul 2011 23:51:21 +0100
Message-ID: <CABcS5h01jpOSKcKtrJ65AqNNQDCAOutQADAE_pcRp-MPBoO-VA@mail.gmail.com>
References: <alpine.LFD.2.02.1107222203400.2702@ionos>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: LKML <linux-kernel@vger.kernel.org>,
	linux-rt-users <linux-rt-users@vger.kernel.org>
To: Thomas Gleixner <tglx@linutronix.de>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <alpine.LFD.2.02.1107222203400.2702@ionos>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-rt-users.vger.kernel.org

Thanks for the great work!

Is it possible to have RT_GROUP_SCHED and PREEMPT_RT_FULL?

Thanks.
Rolando Martins


On Fri, Jul 22, 2011 at 9:37 PM, Thomas Gleixner <tglx@linutronix.de> w=
rote:
> Dear RT Folks,
>
> I'm pleased to announce the 3.0-rt1 release.
>
> Changes versus 3.0-rc7-rt0:
>
> =A0* Update to Linus final 3.0 release
>
> =A0* RTC bugfixes (scheduled for mainline/stable)
>
> =A0* Long standing (rt only) timer_list bug (see
> =A0 =A0timers-avoid-the-base-null-otptimization-on-rt.patch in the sp=
lit
> =A0 =A0out quilt queue)
>
> =A0* Minor non exciting fixes all over the place
>
> Known issues:
>
> =A0* Some weird "console=3D..." commandline + config dependent
> =A0 =A0interactions which have been not yet investigated down to thei=
r
> =A0 =A0root cause. Result in a boot hang. YMMV
>
> Patch against 3.0 can be found here:
>
> =A0http://www.kernel.org/pub/linux/kernel/projects/rt/patch-3.0-rt1.p=
atch.bz2
>
> The split quilt queue is available at:
>
> =A0http://www.kernel.org/pub/linux/kernel/projects/rt/patches-3.0-rt1=
=2Etar.bz2
>
> Thanks,
>
> =A0 =A0 =A0 =A0tglx
> --
> To unsubscribe from this list: send the line "unsubscribe linux-rt-us=
ers" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at =A0http://vger.kernel.org/majordomo-info.html
>
