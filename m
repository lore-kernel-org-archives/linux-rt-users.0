From: =?iso-8859-1?q?Lu=EDs_Henriques?= <lhenriques@netvisao.pt>
Subject: Re: Priority Ceiling for SMP?
Date: Thu, 8 Nov 2007 18:00:35 +0000
Message-ID: <200711081800.35937.lhenriques@netvisao.pt>
References: <473346DF.3080108@l1nuxh4ck3r.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: linux-rt-users@vger.kernel.org
To: Bernhard Kuhn <kuhn@l1nuxh4ck3r.de>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from front2.netvisao.pt ([213.228.128.57]:52275 "HELO
	front2.netvisao.pt" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with SMTP id S1758224AbXKHSHT convert rfc822-to-8bit (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Thu, 8 Nov 2007 13:07:19 -0500
In-Reply-To: <473346DF.3080108@l1nuxh4ck3r.de>
Content-Disposition: inline
Sender: linux-rt-users-owner@vger.kernel.org
List-Id: linux-rt-users.vger.kernel.org

Hi!
On Thursday 08 November 2007, you wrote:
> Hi!
>
> I'm thinking about adding the priority ceiling protocol to -rt
> (implemented in a way so that you can select between priority
> inheritance and priority ceiling with the kernel configurator).
>
> Since this mechanism inherently avoids dead-locks, it could be
> helpful for applications that need high safety integrity levels!?
>
> The priority ceiling protocol is basically no rocket science
> and implemented for other OSes for a while, so it should be
> a no-brainer get it going with Linux. However. I'm struggling
> at the point where it comes to SMP: it seems like when a task
> acquires a lock, it is necessary to un-schedule any active
> tasks on other cores sharing the same lock. This would be
> very inefficient, of course, because tasks sharing a lock
> couldn't run in parallel on different CPUs.
>
> Does anybody know of any other priority inversion and
> dead-lock avoidance mechanism that would efficiently work
> on SMP?
>
> Feedback is highly appreciated!
>
> regards
>
> Bernhard

Maybe I didn't completely understood your question, but... if there is =
a=20
problem with SMP efficiency (I do not really know, but believe you :) )=
 with=20
priority ceiling (PC) implementation, this problem should have been alr=
eady=20
identified (and possibly solved) in the current PI implementation, righ=
t?

As far as I know (and I might be wrong), the PC is very similar to the =
PI. =20
Main difference is that for the PC, the priority burst is to the lock c=
eiling=20
value instead of the higher priority task that accesses the lock.

(BTW, what do you think that should be the kernel behaviour when the ce=
iling=20
value is violated?  Typical solution in RTOS is to have a fatal error)

Best regards
--=20
Lu=EDs Henriques
