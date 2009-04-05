From: Remy Bohmer <linux@bohmer.net>
Subject: Re: System deadlock on 2.6.24-rt20 (-rt27 panics on
	locking-api-selftests)
Date: Sun, 5 Apr 2009 20:39:11 +0200
Message-ID: <3efb10970904051139ue3802b1ib33487418188e4bc@mail.gmail.com>
References: <3efb10970904030502q1068731fl5b92f93d5341b43e@mail.gmail.com>
	 <alpine.LFD.2.00.0904051257470.747@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: Steven Rostedt <rostedt@goodmis.org>, Ingo Molnar <mingo@elte.hu>,
	LKML <linux-kernel@vger.kernel.org>,
	linux-rt-users <linux-rt-users@vger.kernel.org>
To: Thomas Gleixner <tglx@linutronix.de>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from rv-out-0506.google.com ([209.85.198.233]:27836 "EHLO
	rv-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751941AbZDESjO (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Sun, 5 Apr 2009 14:39:14 -0400
In-Reply-To: <alpine.LFD.2.00.0904051257470.747@localhost.localdomain>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

Hello Thomas,

>> I integrated -rt27, but this one fails on the locking api-selftests.
>> Is this a bug in the selftest? Or is there a real locking bug behind
>> it?
>
> Don't think so. The rw locks fixups which we did between -rt20 and
> -rt27 might have screwed the lockdep selftests where we create
> deadlock situations.

This is what I hoped for ;-)  (A bug in the testtooling...)

> What happens if you disable the self tests ?

The system boots and seems to run properly. We did not yet test for a
longer period of time, but the first looks are that the hangups we had
are gone now. But it would be good for the peace of mind if the
locking-selftest was working properly.

Thanks.

Kind Regards,

Remy
