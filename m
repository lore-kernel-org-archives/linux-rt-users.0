From: GeunSik Lim <leemgs1@gmail.com>
Subject: Re: [PATCH]sched: fix typo in sched-rt-group.txt file
Date: Tue, 12 May 2009 20:05:06 +0900
Message-ID: <49b7c2350905120405w3591a92bj265dff000929a928@mail.gmail.com>
References: <1242117459.31161.11.camel@centos51>
	 <1242119738.11251.322.camel@twins> <20090512094210.GD32292@elte.hu>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Peter Zijlstra <a.p.zijlstra@chello.nl>,
	linux-kernel <linux-kernel@vger.kernel.org>,
	linux-rt-users <linux-rt-users@vger.kernel.org>,
	tglx <tglx@linutronix.de>, williams <williams@redhat.com>
To: Ingo Molnar <mingo@elte.hu>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from yw-out-2324.google.com ([74.125.46.28]:32124 "EHLO
	yw-out-2324.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751174AbZELLFF convert rfc822-to-8bit (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Tue, 12 May 2009 07:05:05 -0400
In-Reply-To: <20090512094210.GD32292@elte.hu>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

2009/5/12 Ingo Molnar <mingo@elte.hu>:
>
> * Peter Zijlstra <a.p.zijlstra@chello.nl> wrote:
>
>> On Tue, 2009-05-12 at 17:37 +0900, GeunSik Lim wrote:
>> >
>> >
>> > Dear Ingo,
>> >
>> > I found typo about the range of static priority ( =3D realtime pri=
ority )
>> > in "./Documentation/scheduler/sched-rt-group.txt" file.
>> >
>> > If I don't understand static priority levels, Correct me.
>>
>> Right, that 'confusion' stems from the fact that our in-kernel prior=
ity
>> lists do consider all 140 priorities.
>>
>> The patch looks good though.
>>
>> > commit d6af702008117ca489a2f5476239d1688a517e98
>> > Author: GeunSik,Lim <leemgs1@gmail.com>
>> > Date: =C2=A0 Tue May 12 17:20:32 2009 +0900
>> >
>> > =C2=A0 =C2=A0 sched: fix typo in sched-rt-group.txt file
>> >
>> > =C2=A0 =C2=A0 Fix typo about static priority's range.
>> > =C2=A0 =C2=A0 =C2=A0Kernel Space priority: 0 =C2=A0 to 99 =C2=A0 -=
-> User Space RT priority 99 to 0
>> > =C2=A0 =C2=A0 =C2=A0Kernel Space priority: 100 to 139 =C2=A0--> Us=
er Space nice -20 to 19
>> >
>> > =C2=A0 =C2=A0 Signed-off-by: GeunSik Lim <geunsik.lim@samsung.com>
>> >
>> > diff --git a/Documentation/scheduler/sched-rt-group.txt b/Document=
ation/scheduler/sched-rt-group.txt
>> > index 5ba4d3f..1537146 100644
>> > --- a/Documentation/scheduler/sched-rt-group.txt
>> > +++ b/Documentation/scheduler/sched-rt-group.txt
>> > @@ -169,7 +169,7 @@ get their allocated time.
>> >
>> > =C2=A0Implementing SCHED_EDF might take a while to complete. Prior=
ity Inheritance is
>> > =C2=A0the biggest challenge as the current linux PI infrastructure=
 is geared towards
>> > -the limited static priority levels 0-139. With deadline schedulin=
g you need to
>> > +the limited static priority levels 0-99. With deadline scheduling=
 you need to
>
> SCHED_FIFO goes from 1 to 99. So it's either 0-98 or 1-99. From
> sched_setscheduler(2):
>
> =C2=A0 =C2=A0 =C2=A0 Processes scheduled under one of =C2=A0the =C2=A0=
real-time =C2=A0policies =C2=A0(SCHED_FIFO,
> =C2=A0 =C2=A0 =C2=A0 SCHED_RR) have a sched_priority value in the ran=
ge 1 (low) to 99 (high).
>
> =C2=A0 =C2=A0 =C2=A0 =C2=A0Ingo
>

Thank you for explanation about userspace rt priority's range like
sched_setscheduler(2).

Processes scheduled with SCHED_OTHER (or SCHED_BATCH) must be assigned
the static priority 0.  Processes scheduled under SCHED_FIFO (or
SCHED_RR) can have a static priority in the range 1 to 99.

So, I think that the below summary is right.
* Kernel Space priority: 0(high) to 99(low) --> User Space RT priority
99(high) to 0(low)

Is it incorrect?


--=20
Regards,
GeunSik Lim
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
