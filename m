From: Rolando Martins <rolando.martins@gmail.com>
Subject: Re: Question regarding pthread_cond_wait/pthread_cond_signal latencies
Date: Sat, 21 May 2011 22:40:27 +0100
Message-ID: <BANLkTimKKohnaUU8fEp+kaB9Trpu8JBvTg@mail.gmail.com>
References: <1305886116.10494.30.camel@laika>
	<4DD82514.3070407@cfl.rr.com>
	<1306011102.10494.34.camel@laika>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: dmarkh@cfl.rr.com, linux-rt-users@vger.kernel.org
To: Pedro Gonnet <gonnet@maths.ox.ac.uk>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from mail-fx0-f46.google.com ([209.85.161.46]:40813 "EHLO
	mail-fx0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753527Ab1EUVk2 convert rfc822-to-8bit (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Sat, 21 May 2011 17:40:28 -0400
Received: by fxm17 with SMTP id 17so3272244fxm.19
        for <linux-rt-users@vger.kernel.org>; Sat, 21 May 2011 14:40:27 -0700 (PDT)
In-Reply-To: <1306011102.10494.34.camel@laika>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

Hi guys,
I am building a real-time middleware and have also struggled with
similar behavior, at this point I reduced to the bare minimum the use
of condition variables.
(using 33-rt)

Rolando


On Sat, May 21, 2011 at 9:51 PM, Pedro Gonnet <gonnet@maths.ox.ac.uk> w=
rote:
> On Sat, 2011-05-21 at 16:48 -0400, Mark Hounschell wrote:
>> On 05/20/2011 06:08 AM, Pedro Gonnet wrote:
>> >
>> > Hi guys,
>> >
>> > I'm currently working on a shared-memory parallel Molecular Dynami=
cs
>> > simulation library (http://mdcore.sourceforge.net/) geared towards
>> > multi-core systems.
>> >
>> > The library uses pthreads (plus some OpenMP for some simple loops)=
 and
>> > uses pthread_cond_wait and pthread_cond_signal to coordinate a gro=
up of
>> > worker threads.
>> >
>> > I've been profiling the library on different machines and kernels =
and
>> > have noticed that in many cases there are significant (several ms,
>> > measured with Intel's Vtune-thing) lags between calls to
>> > pthread_cond_signal and the waiting thread actually getting back t=
o
>> > work.
>> >
>> > I've tried the Ubuntu -rt and -preempt kernels, and the whole simu=
lation
>> > runs twice as slowly, despite following the advice given here:
>> >
>> > =A0 =A0 =A0 =A0 =A0https://rt.wiki.kernel.org/index.php/HOWTO:_Bui=
ld_an_RT-application
>> >
>> > My question is the following: which kernel (or set of configuratio=
n
>> > options) will minimize these latencies? And if linux-rt is the ans=
wer,
>> > in what ways do I have to be careful when porting the simulation f=
or
>> > this kernel?
>> >
>>
>> Are you saying several ms latency from pthread_cond_signal to waking=
 up a
>> thread in pthread_cond_wait?
>>
>
> Yes. Or at least, this is what Vtune says. It could also be a fluke i=
n
> Vtune, but I would still be interested in knowing what kernel or what
> kernel options can make these operations as fast as possible.
>
> Cheers, Pedro
>
>
>
>
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
