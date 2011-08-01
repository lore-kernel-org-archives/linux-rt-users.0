From: Rolando Martins <rolando.martins@gmail.com>
Subject: Re: [ANNOUNCE] 3.0-rt6
Date: Mon, 1 Aug 2011 11:45:12 +0100
Message-ID: <CABcS5h0tyDjmFSg+sUeJ14m8KsTxNhwo=qLHFLDX8J-tCpdDOw@mail.gmail.com>
References: <alpine.LFD.2.02.1107282213000.31246@ionos>
	<CABcS5h0m10aWDuK5fK4C-mzMMwLyXJ_cehoTgWFutvPPrv30HQ@mail.gmail.com>
	<1312194842.8233.88.camel@marge.simson.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Peter Zijlstra <peterz@infradead.org>,
	Thomas Gleixner <tglx@linutronix.de>,
	LKML <linux-kernel@vger.kernel.org>,
	linux-rt-users <linux-rt-users@vger.kernel.org>,
	"Paul E. McKenney" <paulmck@linux.vnet.ibm.com>
To: Mike Galbraith <efault@gmx.de>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from mail-fx0-f46.google.com ([209.85.161.46]:48290 "EHLO
	mail-fx0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754041Ab1HAKpO convert rfc822-to-8bit (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Mon, 1 Aug 2011 06:45:14 -0400
In-Reply-To: <1312194842.8233.88.camel@marge.simson.net>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

On Mon, Aug 1, 2011 at 11:34 AM, Mike Galbraith <efault@gmx.de> wrote:
> On Mon, 2011-08-01 at 09:42 +0100, Rolando Martins wrote:
>> Hi Peter,
>> is there any progress on the CONFIG_RT_GROUP_SCHED front?
>
> Out of curiosity, why would you want that in a -rt kernel?

I am building a rt middleware that uses cgroups to reserve cpu
bandwidth for a set of tasks.
But I also interested in minimization latencies...

>
> (I haven't done any PI testing with that, but I can imagine the throt=
tle
> causing heartburn)
>
> =A0 =A0 =A0 =A0-Mike
>
>> I don't know if this is related, but in 33-rt if I used a low (=3D10=
0)
>> cpu_runtime_us and cpu_period_us then I would get some freezes
>> (something that does not happen in 2.6.39).
>
> (providing a realtime budget of 100 whole microseconds to a kernel wh=
ere
> everything and it's brother is realtime is unlikely to go well)
I empirically tested values until I reached this one. Anything above
this would result in a huge amount of jitter
(to all tasks under a control group), at least on my boxes (corei7
920, and AMD phenom x4 950).

Rolando

>
>
--
To unsubscribe from this list: send the line "unsubscribe linux-rt-user=
s" in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
