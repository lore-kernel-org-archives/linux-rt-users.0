From: Remy Bohmer <linux@bohmer.net>
Subject: Re: [ANNOUNCE] 2.6.31.2-rt13
Date: Wed, 7 Oct 2009 09:13:51 +0200
Message-ID: <3efb10970910070013p447fdd99o22699967a9e51070@mail.gmail.com>
References: <alpine.LFD.2.00.0902112332370.415@localhost.localdomain>
	 <alpine.LFD.2.00.0908212319370.1769@localhost.localdomain>
	 <alpine.LFD.2.00.0908261910460.2888@localhost.localdomain>
	 <alpine.LFD.2.00.0908282326460.19335@localhost.localdomain>
	 <alpine.LFD.2.00.0909152257590.8957@localhost.localdomain>
	 <alpine.LFD.2.00.0909190027400.2889@localhost.localdomain>
	 <alpine.LFD.2.00.0910061210400.2646@localhost.localdomain>
	 <3efb10970910061123k2b6826bci11f0f42509173b26@mail.gmail.com>
	 <alpine.LFD.2.00.0910062122230.5950@localhost.localdomain>
	 <alpine.LFD.2.00.0910062202590.5950@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: LKML <linux-kernel@vger.kernel.org>,
	rt-users <linux-rt-users@vger.kernel.org>
To: Thomas Gleixner <tglx@linutronix.de>
Return-path: <linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S1758678AbZJGHO3@vger.kernel.org>
In-Reply-To: <alpine.LFD.2.00.0910062202590.5950@localhost.localdomain>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-rt-users.vger.kernel.org

Hi Thomas,

> 2009/10/6 Thomas Gleixner <tglx@linutronix.de>:
> On Tue, 6 Oct 2009, Thomas Gleixner wrote:
>
>> On Tue, 6 Oct 2009, Remy Bohmer wrote:
>> > But I was wondering if you missed this one:
>> > http://patchwork.kernel.org/patch/50044/
>>
>> Yup, slipped through. Queued for the next release.
>
> Correction. I dropped the patch as it is just a sloppy work around.
> Why creating the thread in the first place ? Real fix below.

Yeah, I thought about that too.

>
> Thanks,
>
> =A0 =A0 =A0 =A0tglx
> ---
> diff --git a/kernel/softirq.c b/kernel/softirq.c
> index aae8d45..3526976 100644
> --- a/kernel/softirq.c
> +++ b/kernel/softirq.c
> @@ -1161,6 +1161,8 @@ static int __cpuinit cpu_callback(struct notifi=
er_block *nfb,
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0per_cpu(ksoftirqd, hot=
cpu)[i].tsk =3D NULL;
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0}
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0for (i =3D 0; i < NR_SOFTIRQS; i++) {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (!softirq_names[i])
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 continu=
e;

But I did not do this because I thought this was sloppy as well, I
guessed you would never accept a patch that only looks at defining the
name, how wrong could I be... ;-)
So, going for the cleaner solution, I was going for not defining the
HRTIMER_SOFTIRQ in the enum in include/linux/interrupt.h in the first
place, but that would touch even more code, and at least that makes
clear how much the code is strangled.

The loop 'for (i =3D 0; i < NR_SOFTIRQS; i++)' is used at many more
places, would this 'if (!softirq_names[i])' not be required at other
places as well?

Remy
