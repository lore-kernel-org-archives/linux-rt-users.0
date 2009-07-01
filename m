From: GeunSik Lim <leemgs1@gmail.com>
Subject: Re: [PATCH 2/3] cyclictest: Fix the same priority method of many
	threads with -h option.
Date: Wed, 1 Jul 2009 22:42:56 +0900
Message-ID: <49b7c2350907010642ga8c261p8c3a7c58937b7d0a@mail.gmail.com>
References: <1246030689.2153.32.camel@centos51>
	 <1246330564.8104.37.camel@sven.thebigcorporation.com>
	 <49b7c2350906300012x3a188622o3f15240199faf901@mail.gmail.com>
	 <1246354219.11056.36.camel@quadrophenia.thebigcorporation.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: williams <williams@redhat.com>, tglx <tglx@linutronix.de>,
	linux-rt-users <linux-rt-users@vger.kernel.org>
To: Sven-Thorsten Dietrich <sven@thebigcorporation.com>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from mail-pz0-f188.google.com ([209.85.222.188]:59213 "EHLO
	mail-pz0-f188.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751046AbZGANmy convert rfc822-to-8bit (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Wed, 1 Jul 2009 09:42:54 -0400
Received: by pzk26 with SMTP id 26so831202pzk.33
        for <linux-rt-users@vger.kernel.org>; Wed, 01 Jul 2009 06:42:56 -0700 (PDT)
In-Reply-To: <1246354219.11056.36.camel@quadrophenia.thebigcorporation.com>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

Sorry I'm late according to going out.

On Tue, Jun 30, 2009 at 6:30 PM, Sven-Thorsten
Dietrich<sven@thebigcorporation.com> wrote:
> I that was a single CPU scenario.
> For testing on SMP, the cyclictest threads need to behave identicalll=
y
> (even in priority) on all CPUs.
Additionally, I want you to consider  both Unicore  and Multicore
when some users  will use  -h option.

> That same argument also applies to this patch, doesn't it?
> In other words, without changing the existing code, you could change =
the
> prios for the histogram mode via a similar script, right?
Yes, It's right.
But. I am talking about output style of prios to avoid confusion
between without -h and with -h.
As you know, Cyclictest  display  result of latencies on the console
without detailed  explanation.
So, When we add -h option to get histogram data,  Most users have to
view source code
because of  the different output style suddenly.

> I don't disagree, but I think the proper fix may be to decouple
> histogram from priority, via another parameter.
>
> Note that the thread interval is also held constant when histogram is
> configured -- not just the priority.
>
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0if (!histogram=
) /* histogram requires same interval on CPUs*/
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0interval +=3D distance;
>
>
> The patch you sent basically reverts a bug-fix for the histogram
> application on SMP, but doesn't change the interval behavior.
>
> So you would also have to decouple the interval code as well.
Thank you for explanation  of  histogram related  patches like
priority and interval.
If you accept  my proposal to avoid confusion of output style,
I want to change  interval code reversely .  -:)

But,
If you and others don't  agree with my opinions,
I think that  We have to append  additional explanation in the "#>
cyclictest --help" to
understand output  using -h option at least like belows.

 before) "-h       --histogram=3DUS    dump a latency histogram to
stdout after the run\n"
 after   ) "-h       --histogram=3DUS    dump a latency histogram to
stdout after the run (with same priority about threads)\n"

How about you think  this my opinions?

> It would be better to be able to explicitly set priorities and interv=
als
> to be the same, when distributed per-CPU on SMP. That is one kind of
> test, which is important.
>
> Inversely relating priority versus interval on UP is another kind of
> test. This seems to be what you are trying to do.
>
> So to have both, means you can to stack threads on SMP and have multi=
ple
> threads on each CPU, operating at increasing intervals. Each thread
> would report data.
>
> But that implies a 3-D table to log the data returned from cyclictest
> threads at lower priorities (lower than the highest priority).
>
> The histogram code is only able to log one set of data for each threa=
d
> as it is today.
>
> And as-is, the histogram assumes threads are distributed per-cpu via
> affinity on SMP. Changing to a 3-D matrix is interesting, but how wou=
ld
> you represent that / store ?
>
> What exactly are you testing / looking for?
I want to test maximum latencies based on background stress conditions =
 on SMP.
And, I  want to get histogram data about worstcase latencies using -h o=
ption.


--=20
Regards,
GeunSik Lim ( Samsung Electronics )
Blog : http://blog.naver.com/invain/
e-Mail: geunsik.lim@samsung.com
           leemgs@gmail.com , leemgs1@gmail.com
--
To unsubscribe from this list: send the line "unsubscribe linux-kernel"=
 in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
Please read the FAQ at  http://www.tux.org/lkml/
--
To unsubscribe from this list: send the line "unsubscribe linux-rt-user=
s" in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
