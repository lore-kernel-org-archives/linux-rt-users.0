From: Pedro Ribeiro <pedrib@gmail.com>
Subject: Re: future of -rt kernels for realtime audio
Date: Tue, 6 Jul 2010 21:44:55 +0100
Message-ID: <AANLkTimtA6c1bnfTjEja173CCzYe6g7slVYCpUjsguan@mail.gmail.com>
References: <AANLkTikZNjYJnDM6iKgrT1230FP8DSMgHUrZz2lYL4ll@mail.gmail.com>
	<1278444945-sup-9886@eris>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: linux-rt-users <linux-rt-users@vger.kernel.org>
To: =?ISO-8859-1?Q?Philipp_=DCberbacher?= <hollunder@lavabit.com>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from mail-wy0-f174.google.com ([74.125.82.174]:38536 "EHLO
	mail-wy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755011Ab0GFUo5 convert rfc822-to-8bit (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Tue, 6 Jul 2010 16:44:57 -0400
Received: by wyf23 with SMTP id 23so2755270wyf.19
        for <linux-rt-users@vger.kernel.org>; Tue, 06 Jul 2010 13:44:56 -0700 (PDT)
In-Reply-To: <1278444945-sup-9886@eris>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

On 6 July 2010 20:53, Philipp =DCberbacher <hollunder@lavabit.com> wrot=
e:
> Excerpts from Pedro Ribeiro's message of 2010-07-06 13:19:31 +0200:
>> Hi,
>>
>> I've been using -rt kernels since 2.6.29 because I do realtime audio
>> on my laptop.
>>
>> The audio stability has been steadily improving since, and now I fin=
d
>> that I can use 2.6.34 without the -rt patch and achieve the same
>> stability as 2.6.33-rt - well, my latency requirements aren't that
>> high, I just need to maintain 8.9ms completely stable, however befor=
e
>> .34 it would be impossible without the -rt patch.
>>
>> So out of curiosity, what changed for .34? According to [1], on .33
>> Raw Spinlock Annotation was introduced in the mainline kernel.
>> However, as said above, I can't get the same performance than with
>> .34.
>>
>> I remember that I read somewhere that the one the biggest problems
>> with latency requirements was the use of the BKL. Do you think there
>> will be a significant improvement of latency (in specific cases of
>> course) with the scheduled removal of BKL for 2.6.36?
>>
>> Thanks for the help,
>> Pedro
>>
>> [1] http://www.osadl.org/Realtime-Linux.projects-realtime-linux.0.ht=
ml
>
> Ah, nice to hear that the BKL removal is scheduled. Pretty much all I
> know is that Linus set the BKL removal as precondition for preempt-rt=
 to
> be merged with mainline.
> I guess this means that preempt-rt could disappear in some post-.36
> version. I won't hold my breath.
> Anyway, the stock kernel has been good for a while, but there are som=
e
> cases where I still experience big differences. Some, mostly audio
> unrelated, actions or kinds of load cause lots of xruns with the stoc=
k
> kernel and none with -rt. Prime example for me is xrandr, enable an
> external monitor -> xruns, not so with -rt. There are a couple of oth=
er
> cases. It's mostly about this kind of stuff, the achievable latency i=
s
> pretty much the same in my experience (which is only with an USB
> interface).
> --
> Regards,
> Philipp
>
> --

I agree with you that there are some corner cases where you can
trigger xruns. However, I noticed a very big difference with 2.6.34.

It was easy to trigger xruns, even with .33-rt in the following situati=
ons:
- physical memory full, swap at 20%
- change virtual desktop (yes strange but it always triggered it)
- running cpu intensive apps
- lots of disk i/o happening

With vanilla .34, ALL of the above disappeared except the disk i/o
thing. I can safely say that .34 is more stable than .33-rt with the
latency I need (6 to 8 ms).

I'm using USB audio snd-usb-caiaq, and barely anything changed between
the two kernel versions. I still would not use it for live
performance, but then again, I don't do them :)

Regards,
Pedro
--
To unsubscribe from this list: send the line "unsubscribe linux-rt-user=
s" in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
