From: Bernardo Barros <bernardobarros2@gmail.com>
Subject: Re: "yum install ...." based instruction on building a RT kernel.
Date: Sun, 19 Sep 2010 16:20:15 -0300
Message-ID: <AANLkTi=VV+OMfbi1tvwET9DZcG7p_a=4R6kPWSfuqrMK@mail.gmail.com>
References: <4C92A00C.6050401@atl.lmco.com>
	<AANLkTi=eaPvCZmecBKT_d0C8YunJr7L6M8A7Y9pEiQK_@mail.gmail.com>
	<AANLkTi=GbDU7fKh9LvCEpjhSSMFF0syCqJVuqUERVBEJ@mail.gmail.com>
	<4C936152.5000505@64studio.com>
	<AANLkTint6iHc6DPeEVpKd0ER0XsYMDK=0yiekHGkWtWF@mail.gmail.com>
	<20100919104916.63967cc4@riff>
	<AANLkTimgte_c6rC=okyH9Oo-NSOERqAPeOHyyd1BoWvG@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Clark Williams <williams@redhat.com>,
	Daniel James <daniel@64studio.com>,
	John Kacur <jkacur@redhat.com>,
	Gautam Thaker <gautam.h.thaker@lmco.com>,
	linux-rt-users@vger.kernel.org
To: jordan <triplesquarednine@gmail.com>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from mail-vw0-f46.google.com ([209.85.212.46]:35626 "EHLO
	mail-vw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753132Ab0ISTUR convert rfc822-to-8bit (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Sun, 19 Sep 2010 15:20:17 -0400
Received: by vws3 with SMTP id 3so2774961vws.19
        for <linux-rt-users@vger.kernel.org>; Sun, 19 Sep 2010 12:20:16 -0700 (PDT)
In-Reply-To: <AANLkTimgte_c6rC=okyH9Oo-NSOERqAPeOHyyd1BoWvG@mail.gmail.com>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

Hey jordan,

Could you share your optimizations with us? I'm also runnins 2.6.34
here (2.6.34.6-54.fc13.x86_64),
I have problems with my rt-kernel, it freezes my system (thinkpad
w510). Maybe something with video card or whatever, but I don't have
the time to really investigate what is happening, so I must get the
best from the generic kernel for now :-)


2010/9/19 jordan <triplesquarednine@gmail.com>:
> Hi Clark,
>
>> I'll second this sentiment. We were going to to release a new realti=
me
>> kernel with the .31 series, but testing showed that it had some
>> significant regressions in terms of event response time and in overa=
ll
>> throughput, so we held off. The .33 series is much better in those
>> regards and that's what we'll be going out with in our next release.
>
> Ya, i liked .33 - it would be a great choice. There were a lot of
> perfromance gains in that kernel... Recently, i have changed laptops
> (my good one died). Unfortunately, this laptop i am using now has
> buggy hardware. But i am stuck with it, until my next machine is
> built...
>
> I actually, am having to use BFS and BFQ and avoid rtirq, etc. =C2=A0=
I've
> had to take a totally different method to get smooth, reliable audio
> performance (at low latency). But all my work has paid, and my system
> is quite robust. im using 2.6.34 optimized like crazy. I've been
> impressed though, as the system never has problems, even with it's
> inherent issues, and under significant CPU-load. Even, though my
> method seems to work perfect, and is actually simple to use. I am
> looking forward to when i can finish building my new rackmount, and
> get back to the standard way of doing things.
>
>> Heh. I haven't actually compiled a kernel on stage, but a friend of
>> mine reworked a play's audio track 20 minutes before curtain when th=
e
>> Windows box ate it's disk; he booted up his Linux laptop and ran the
>> sound sequencer program in a QEMU instance. I think I'd rather rebui=
ld
>> a kernel under the gun :).
>
> That's why i use linux live, Windows is scary for that purpose. * I
> would much rather compile the kernel under pressure. it only takes
> 10minutes! *
> Using =C2=A0Linux, I am still able to use lots of windows VSTi (NI
> Komplete) coupled with linux apps. It works perfectly.
> Even on a junker dell inspiron 6400 (e1505), coreduo 1.6ghz, 1gig ram=
=2E
> =C2=A0I am able to run somewhere around 8-12 Vst instruments (big one=
s
> too), sooperlooper, FX chains, live audio-inputs (mic and guitar),
> all @ 128 frames in jack, and i never have issues. When i did try to
> use Windows live, i ran into problems. High latency, crashing, etc.
> Even with my Macbook that died, i'd run into the similar issues. (whe=
n
> using Mac OS anyway).
>
> Linux seems to work nicely, even on junk "craptops" =C2=A0 It'll be f=
unny
> to see how the new rack will perform!
>
> jordan
> --
> To unsubscribe from this list: send the line "unsubscribe linux-rt-us=
ers" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at =C2=A0http://vger.kernel.org/majordomo-info.ht=
ml
>
--
To unsubscribe from this list: send the line "unsubscribe linux-rt-user=
s" in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
