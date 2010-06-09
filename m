From: Xianghua Xiao <xiaoxianghua@gmail.com>
Subject: Re: At a loss: Kernel 2.6.19-rt15 with ixp425
Date: Wed, 9 Jun 2010 13:50:50 -0500
Message-ID: <AANLkTindPmnb9Ct6G36drF-FrV8OmU9T5WIjJTHOAo3a@mail.gmail.com>
References: <20100608181752.GA19521@colorado.edu>
	<1276022232.9420.17.camel@sven.thebigcorporation.com>
	<20100608193204.GA13883@colorado.edu>
	<1276102964.8203.7.camel@sven.thebigcorporation.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Eric W Anderson <Eric.Anderson@colorado.edu>,
	linux-rt-users@vger.kernel.org
To: Sven-Thorsten Dietrich <thebigcorporation@gmail.com>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from mail-vw0-f46.google.com ([209.85.212.46]:64303 "EHLO
	mail-vw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758085Ab0FISuw convert rfc822-to-8bit (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Wed, 9 Jun 2010 14:50:52 -0400
Received: by vws17 with SMTP id 17so2834965vws.19
        for <linux-rt-users@vger.kernel.org>; Wed, 09 Jun 2010 11:50:51 -0700 (PDT)
In-Reply-To: <1276102964.8203.7.camel@sven.thebigcorporation.com>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

On Wed, Jun 9, 2010 at 12:02 PM, Sven-Thorsten Dietrich
<thebigcorporation@gmail.com> wrote:
> On Tue, 2010-06-08 at 13:32 -0600, Eric W Anderson wrote:
>> Hi Sven,
>>
>> The device manufacturer has made some kernel modifications to suppor=
t their
>> board, and those are specific to 2.6.19. =C2=A0(In fact, they're spe=
cific to
>> 2.6.19.2 OpenWRT patches). =C2=A0There's also a large driver which i=
s appropriate
>> for an old kernel but would need some re-engineering to deal with AP=
I changes
>> in 2.6.20 or 2.6.21, I believe.
>>
>> So, if getting high-resolution timing with this kernel is going to b=
e a
>> nightmare, I can try taking on a newer kernel. =C2=A0But it'll be an=
 ordeal.
>>
>
> Don't know really what to say.
>
> With the device manufacturer not pushing / maintaining code upstream,
> that sounds like a non-starter already.
>
> The ixp425 is supported by folks like MontaVista, maybe Wind River ii=
rc.
>
> The former has had some sort of HRT support for a long time, it might
> get you the functionality you need.
>
> But in any case, I'd try and walk the drivers forward, rather than tr=
y
> to back-port HRT.
>
> You're unlikely to get much support for such an old Kernel if you run
> into other issues, so the more up to date you can get, the better.
>
> Good luck.
>
> Sven
>
>> -Eric
>>
>>
>> Thus spake Sven-Thorsten Dietrich (thebigcorporation@gmail.com):
>>
>> > On Tue, 2010-06-08 at 12:17 -0600, Eric W Anderson wrote:
>> > > Hello All,
>> >
>> > Hi Eric,
>> >
>> > 2.6.19 is very very old.
>> >
>> > What is preventing you from a Kernel upgrade?
>> >
>> > Sven
>> >
>> >
>> > >
>> > > I can't figure out (or haven't figured out) how to get actual hi=
gh-resolution
>> > > timers on the above platform. =C2=A0I'm kind of stuck with 2.6.1=
9, unfortunately.
>> > > I've applied the -rt patch to stock 2.6.19, merged in some rando=
m patches to
>> > > support my hardware, and gotten it to boot. But, here's what con=
fuses me: =C2=A0I
>> > > have the hrtimer API, but my actual clock resolution is still sh=
own as =C2=A010ms.
>> > >
>> > > =C2=A0 root@patty:/# cat /proc/timer_list
>> > > =C2=A0 Timer List Version: v0.1
>> > > =C2=A0 HRTIMER_MAX_CLOCK_BASES: 2
>> > > =C2=A0 now at 2766685920305 nsecs
>> > >
>> > > =C2=A0 cpu: 0
>> > > =C2=A0 =C2=A0clock 0:
>> > > =C2=A0 =C2=A0 .index: =C2=A0 =C2=A0 =C2=A00
>> > > =C2=A0 =C2=A0 .resolution: 10000000 nsecs
>> > > =C2=A0 =C2=A0 .get_time: =C2=A0 ktime_get_real
>> > > =C2=A0 active timers:
>> > > =C2=A0 =C2=A0clock 1:
>> > > =C2=A0 =C2=A0 .index: =C2=A0 =C2=A0 =C2=A01
>> > > =C2=A0 =C2=A0 .resolution: 10000000 nsecs
>> > > =C2=A0 =C2=A0 .get_time: =C2=A0 ktime_get
>> > > =C2=A0 active timers:
>> > > =C2=A0 =C2=A0#0: <c4615ec8>, hrtimer_wakeup
>> > > =C2=A0 =C2=A0# expires at 2766802147358 nsecs [in 116227053 nsec=
s]
>> > > =C2=A0 =C2=A0#1: <c4615ec8>, it_real_fn
>> > > =C2=A0 =C2=A0# expires at 2767494816966 nsecs [in 808896661 nsec=
s]
>> > > =C2=A0 =C2=A0#2: <c4615ec8>, it_real_fn
>> > > =C2=A0 =C2=A0# expires at 3642163204498 nsecs [in 875477284193 n=
secs]
>> > > =C2=A0 =C2=A0#3: <c4615ec8>, it_real_fn
>> > > =C2=A0 =C2=A0# expires at 3643403169278 nsecs [in 876717248973 n=
secs]
>> > >
>> > > Additionally, I don't see CONFIG_HIGH_RES_TIMERS anywhere in my =
kernel
>> > > menuconfig. =C2=A0I've added a patch from Kevin Hilman and Milan=
 Svoboda
>> > > (http://lkml.indiana.edu/hypermail/linux/kernel/0607.1/2343.html=
) which
>> > > purports to enable a high-resolution clock event source for this=
 board, but
>> > > that doesn't seem to change anything.
>> > >
>> > > I think I don't properly understand the preempt_rt / hrtimers /
>> > > board-specific-bits ecosystem here. =C2=A0What are the bits and =
pieces I need in
>> > > order to have high-resolution timers on this platform?
>> > >
>> > > Many, many thanks,
>> > > Eric Anderson
>> > >
>> > >
>> >
>> >
>>
>
>
> --
> To unsubscribe from this list: send the line "unsubscribe linux-rt-us=
ers" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at =C2=A0http://vger.kernel.org/majordomo-info.ht=
ml
>
while upgrading to newer kernel sounds great, which I just did(from
2.6.18rt to 2.6.33rt), the newer kernel sometimes does not perform as
well as older ones(plus it's also bloated), esp in embedded products.
In my case, we got a slower product with the newer kernel, the 'worse'
performance happened immediately when CFS was added. Even after a long
time debugging and tweaking, it's still there.

xianghua
--
To unsubscribe from this list: send the line "unsubscribe linux-rt-user=
s" in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
