From: Lars Segerlund <lars.segerlund@gmail.com>
Subject: Re: Hard real time in user space with preempt_rt patch
Date: Tue, 24 Apr 2012 21:20:30 +0200
Message-ID: <CAF-VNapqGkH62v6xh_KUcjQkpiaGu79-D10=1Ah5pbhuO+COuw@mail.gmail.com>
References: <CAM1yFZ_MLVNK8xPGg5Ad3suQh_AR18k6coyDqX9EurCkh9j9pg@mail.gmail.com>
	<4F966AFC.7070803@cfl.rr.com>
	<CAF-VNaq3bkC=LCB-Emsx20xTm-Vm1v3kduC5MpyXQA_GS6SOhg@mail.gmail.com>
	<4F967574.8030104@cfl.rr.com>
	<BA425197-1889-4161-8726-860E30EC943A@thebigcorporation.com>
	<4F96E220.6010506@compro.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
To: markh@compro.net, linux-rt-users@vger.kernel.org
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from mail-lpp01m010-f46.google.com ([209.85.215.46]:51784 "EHLO
	mail-lpp01m010-f46.google.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1756746Ab2DXTUc convert rfc822-to-8bit
	(ORCPT <rfc822;linux-rt-users@vger.kernel.org>);
	Tue, 24 Apr 2012 15:20:32 -0400
Received: by lahj13 with SMTP id j13so922319lah.19
        for <linux-rt-users@vger.kernel.org>; Tue, 24 Apr 2012 12:20:31 -0700 (PDT)
In-Reply-To: <4F96E220.6010506@compro.net>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

 Hi , I'm the nasty person that pointed out that the rt-preempt
patches DOES provide and strive to provide deterministic HARD realtime
for the linux kernel.

 Hard realtime is as you pointed out bounded by being deterministic,
so all talk about microseconds and relative latencies are not really
relevant per your own definition.

 On a good system worst case latencies of around 10-20 usec is on par
with RTAI or RT-Linux, they have lower averages, but more jitter so
about the same worst cases, and since worst case is what limits the
system they are somewhat comparable, hardware makes a bigger
difference.

 Now if were talking hardware, no regular PC with virtual memory,
superscalar execution and multitasking will ever provide much less
than some usec's ... due to hardware latencies.

 You said that preempt-rt doesn't provide hard realtime and never
will, to and I pointed out in an email that that was your opinion and
that I considered that FUD, and sent a link to the osadl.org site wich
have a test rack to track worst case latencies on systems run under
long time and high load, if that is not deterministic I don't know
what is, as far as discussing a common PC.

 I also pointed out that is was quite rude to make such a statement on
the linux-rt list, since most people here are working on getting
rt-preempt as good as possible with the goal of exactly hard realtime.

 So difference of opinion is totally acceptable, but stating that
opinions are the truth is something else, now statements like
lala-land is just degoratory and are clearly meant to be insulting.

 I do consider you misinformed and wrong in opinion based on your
statement that the definition of hard realtime is if it has a
deterministic worst case behaviour or not, but I do hope that I
haven't been rude.

 / regards, Lars Segerlund.


2012/4/24 Mark Hounschell <markh@compro.net>:
> On 04/24/2012 12:26 PM, Sven-Thorsten Dietrich wrote:
>>>
>>>
>>> Your in lala land. The Linux kernel, even with the RT patch has so =
much
>>> "per CPU" crap in it, there is no way to prevent it from steeling u=
secs from
>>> your application. The per CPU timer interrupt alone takes a few use=
cs away
>>> from your application every HZ. A hard RT env is one in which you c=
an
>>> always, every time, do a predefined work in the same amount of time=
=2E Fast or
>>> slow isn't the key. It's determinism. The timer interrupt alone pre=
vents
>>> that. And it's not the only thing. I've got 8 cpus on my machine bu=
t the
>>> kernel has to have a piece of every one of them. Until there is iso=
lation
>>> from the kernel, there cannot be "Hard RT". This is fact.
>>>
>>
>>
>> Mark,
>>
>> there is a big difference between real-time processing and bare-meta=
l
>> processing.
>>
>> In bare metal, we do care about individual cycles, but not all real-=
time
>> is bare-metal.
>>
>> Determinism , or "RT requirements" is defined by the application.
>>
>> Many applications, with critical functionality, that we an define as=
 hard
>> real-time,
>> can exist fine using the Linux kernel as infrastructure and meet dea=
dlines
>> in a time-critical manner.
>>
>> The OS meets deterministic hard-real-time requirements, if the appli=
cation
>> is not late to execute.
>>
>> Generally, hard real-time is defined as the value of the computation=
 being
>> at most 0 when executed late.
>>
>> Soft real time implies a diminished value.
>>
>> Bare metal today, since you bring up counting cycles, is a bit hard =
to
>> reach with all the caching layers, pipelining, memory and bus archit=
ecture
>> and so on, all aimed at throughput.
>>
>> You will be hard pressed to find predictable behavior in anything bu=
t the
>> simplest loops, bare-bones CPUs, and even then, pressure to differen=
tiate in
>> the market ends up with odd designs making CPUs do funky things.
>>
>> Please do refrain from making such broad and sweeping statements, su=
ch as
>> calling people in lala land (I have been there and its quite nice bt=
w).
>>
>
> Yea, I've been there too. But go back to the OP. I then was simply in=
forming
> him of what Hard RT (you may call it bare-bones if you like) was and =
still
> is in my opinion. I was then accused of spreading FUD by someone name=
d Lars.
> The response you quoted above was my response to being accused of spr=
eading
> FUD when I gave my opinion of what Hard-RT and the RT patch set is.
>
> I've been in the Hard and Soft RT business since the 70s and understa=
nd what
> it is, why it is, how programmers in the past have done things consid=
ered
> wrong now, simply because they could then, and that there really isn'=
t any
> hardware designed for it these days. But even if there was, what you =
quoted
> above would still be true.
>
> I will have to admit though that processing speed has certainly helpe=
d in
> recent years. We are able to replace _some_ of these old "designed fo=
r HRT"
> machines with modern boxes simply because they are so fast. Maybe whe=
n they
> are fast enough to handle timer interrupts in less than a usec or so,=
 I'll
> be able to replace more of them.
>
> But, as my original response to the original OP was, the RT kernel pa=
tch is
> NOT making the kernel capable of HARD RT but certainly gives good Sof=
t RT
> results. If ya lower the bar, you'll never get to the top of the pole=
=2E
>
> Regards
>
> Mark
> --
> To unsubscribe from this list: send the line "unsubscribe linux-rt-us=
ers" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at =A0http://vger.kernel.org/majordomo-info.html
--
To unsubscribe from this list: send the line "unsubscribe linux-rt-user=
s" in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
