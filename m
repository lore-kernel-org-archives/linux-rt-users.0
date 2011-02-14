From: Peter LaDow <petela@gocougs.wsu.edu>
Subject: Re: Interrupt Bottom Half Scheduling
Date: Mon, 14 Feb 2011 15:08:58 -0800
Message-ID: <AANLkTi=V0Uth=30v4M2g=eJ6utLWFPO4XCeqTJWBSMLL@mail.gmail.com>
References: <AANLkTimGobdGMgnc8bVJTvYtH4Tjn2ZVmroeFA2s06WD@mail.gmail.com>
	<1297724643.10271.16.camel@quadrophenia>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: linux-rt-users@vger.kernel.org
To: Sven-Thorsten Dietrich <thebigcorporation@gmail.com>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from mail-yx0-f174.google.com ([209.85.213.174]:46080 "EHLO
	mail-yx0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751882Ab1BNXI7 convert rfc822-to-8bit (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Mon, 14 Feb 2011 18:08:59 -0500
Received: by yxt3 with SMTP id 3so2296604yxt.19
        for <linux-rt-users@vger.kernel.org>; Mon, 14 Feb 2011 15:08:58 -0800 (PST)
In-Reply-To: <1297724643.10271.16.camel@quadrophenia>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

Note sure how that is possible.  This is related to my earlier posting
about timing jitter.  Our code is basically this:

while(1)
{
  t1 =3D clock_gettime()
  for(i=3D0; i < 10000; i++)
  t2 =3D clock_gettime()

  diff =3D t2 - 1
}

This task is pending on nothing.  Unless clock_gettime() causes some
sort of priority inversion, I don't see the problem.  We see
significant jitter on the for-loop when there are a significant number
of other kernel timers.  Now, as we understand it, the hrtimers run in
the softirq.  But if the softirq is priority 50, and this for-loop is
priority 99, it shouldn't be affected by the softirq thread.

Pete

On Mon, Feb 14, 2011 at 3:04 PM, Sven-Thorsten Dietrich
<thebigcorporation@gmail.com> wrote:
> On Mon, 2011-02-14 at 14:31 -0800, Peter LaDow wrote:
>> How is the scheduling of the hrtimers softirq thread handled?
>>
>> When querying the RT priority of the hrtimer softirq, I get a priori=
ty
>> of 50. =A0But when running a priority 99 thread, we still seem to be
>> getting interrupted. =A0Shouldn't the hrtimer softirq be put off unt=
il
>> the CPU is idle or a lower priority task is running?
>
> Does your prio 99 thread perhaps encounter a prio inversion dependenc=
y
> on one of the softriq threads?
>
>>
>> Thanks,
>> Pete
>> --
>> To unsubscribe from this list: send the line "unsubscribe linux-rt-u=
sers" in
>> the body of a message to majordomo@vger.kernel.org
>> More majordomo info at =A0http://vger.kernel.org/majordomo-info.html
>
>
>
--
To unsubscribe from this list: send the line "unsubscribe linux-rt-user=
s" in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
