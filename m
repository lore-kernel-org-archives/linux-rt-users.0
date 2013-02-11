From: Stanislav Meduna <stano@meduna.org>
Subject: Re: Random 3 to 4.5 second blocks of RT thread
Date: Mon, 11 Feb 2013 19:55:53 +0100
Message-ID: <51193EB9.2060409@meduna.org>
References: <8426D3F6-9553-4B6A-B318-4983625ACC8E@bj-ig.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Realtime Mailinglist <linux-rt-users@vger.kernel.org>,
	Thomas Weisser <thomas@bj-ig.de>
To: =?ISO-8859-1?Q?Ralf_M=FCller?= <ralf@bj-ig.de>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from www.meduna.org ([92.240.244.38]:60377 "EHLO meduna.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1759371Ab3BKS4D (ORCPT <rfc822;linux-rt-users@vger.kernel.org>);
	Mon, 11 Feb 2013 13:56:03 -0500
In-Reply-To: <8426D3F6-9553-4B6A-B318-4983625ACC8E@bj-ig.de>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

On 11.02.2013 16:54, Ralf M=FCller wrote:

> It basically is a loop that wakes up every milli second, increments a
> generation counter, does some statistics and goes to sleep for
> another millisecond.

3-4.5 seconds is heavy so this is not very probable, but seeing
that you have a thread with prio 99 and have timer wakeup
problems, depending on what the other realtime threads do maybe
the following could be (part of) the issue:

http://www.spinics.net/lists/linux-rt-users/msg08745.html
http://www.spinics.net/lists/linux-rt-users/msg07804.html

Shortly said: you aren't going to have low latency timers
if the ksoftirqd can be preempted by your threads.

Disclaimer: I have never used RT with 2.6, so I don't know
whether it applies at all.

Regards
--=20
                                         Stano

--
To unsubscribe from this list: send the line "unsubscribe linux-rt-user=
s" in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
