From: =?iso-8859-1?Q?Ralf_M=FCller?= <ralf@bj-ig.de>
Subject: Re: Random 3 to 4.5 second blocks of RT thread
Date: Tue, 12 Feb 2013 15:01:34 +0100
Message-ID: <5C14B626-F917-4E08-B3A0-0C9DADC7EA53@bj-ig.de>
References: <8426D3F6-9553-4B6A-B318-4983625ACC8E@bj-ig.de> <51193EB9.2060409@meduna.org>
Mime-Version: 1.0 (Apple Message framework v1283)
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Realtime Mailinglist <linux-rt-users@vger.kernel.org>,
	Thomas Weisser <thomas@bj-ig.de>
To: Stanislav Meduna <stano@meduna.org>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from smtpgate.bj-ig.de ([194.127.182.6]:55768 "EHLO smtp.bj-ig.de"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1759581Ab3BLOBt convert rfc822-to-8bit (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Tue, 12 Feb 2013 09:01:49 -0500
In-Reply-To: <51193EB9.2060409@meduna.org>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>


Am 11.02.2013 um 19:55 schrieb Stanislav Meduna:

> On 11.02.2013 16:54, Ralf M=FCller wrote:
>=20
>> It basically is a loop that wakes up every milli second, increments =
a
>> generation counter, does some statistics and goes to sleep for
>> another millisecond.
>=20
> 3-4.5 seconds is heavy so this is not very probable, but seeing
> that you have a thread with prio 99 and have timer wakeup
> problems, depending on what the other realtime threads do maybe
> the following could be (part of) the issue:
>=20
> http://www.spinics.net/lists/linux-rt-users/msg08745.html
> http://www.spinics.net/lists/linux-rt-users/msg07804.html

Thanks for the links.

> Shortly said: you aren't going to have low latency timers
> if the ksoftirqd can be preempted by your threads.
>=20
> Disclaimer: I have never used RT with 2.6, so I don't know
> whether it applies at all.

It is not called ksoftirqd on that kernel - it's sirq-timer, sirq-hrtim=
er, sirq-rtc there. But yes - looking for the priorities once again I f=
ound there is one thread, which is not completely trusted to never ever=
 run wild, which had a higher priority than the timer interrupt threads=
=2E So I will adjust the interrupt threads first and see if something c=
hanges. Maybe you already made my day :)

So far - thanks a lot. I will keep you informed if this adjustment help=
s - but it will take at least two days to install and test.

Best regards
Ralf--
To unsubscribe from this list: send the line "unsubscribe linux-rt-user=
s" in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
