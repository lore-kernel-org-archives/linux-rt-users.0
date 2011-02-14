From: Frank Rowand <frank.rowand@gmail.com>
Subject: Re: Interrupt Bottom Half Scheduling
Date: Mon, 14 Feb 2011 15:30:19 -0800
Message-ID: <AANLkTimGvJWgeEXHFdVBJCidL8ctbAxKJZ8V9KeMxRUX@mail.gmail.com>
References: <AANLkTimGobdGMgnc8bVJTvYtH4Tjn2ZVmroeFA2s06WD@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: linux-rt-users@vger.kernel.org
To: Peter LaDow <petela@gocougs.wsu.edu>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from mail-qy0-f181.google.com ([209.85.216.181]:64461 "EHLO
	mail-qy0-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751456Ab1BNXaU convert rfc822-to-8bit (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Mon, 14 Feb 2011 18:30:20 -0500
Received: by qyk12 with SMTP id 12so4330809qyk.19
        for <linux-rt-users@vger.kernel.org>; Mon, 14 Feb 2011 15:30:19 -0800 (PST)
In-Reply-To: <AANLkTimGobdGMgnc8bVJTvYtH4Tjn2ZVmroeFA2s06WD@mail.gmail.com>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

On Mon, Feb 14, 2011 at 2:31 PM, Peter LaDow <petela@gocougs.wsu.edu> w=
rote:
> How is the scheduling of the hrtimers softirq thread handled?
>
> When querying the RT priority of the hrtimer softirq, I get a priorit=
y
> of 50. =A0But when running a priority 99 thread, we still seem to be
> getting interrupted. =A0Shouldn't the hrtimer softirq be put off unti=
l
> the CPU is idle or a lower priority task is running?

Is the hrtimer softirq executing when the priority 99 thread is spinnin=
g
in it's for loop?  Your "jitter Due to Large Number of Timers" email
said that the lower priority tasks don't seem to be interrupting the
priority 99 thread.

The hardware timer interupts will interrupt the priority 99 thread.  Th=
e
cost of these interrupts and the resultant calls to try_to_wake_up()
of the hrtimer softirq might be quite large considering the rate of
timer expires you mentioned in your first email.

Out of curiosity, is the system UP or SMP?

-Frank
--
To unsubscribe from this list: send the line "unsubscribe linux-rt-user=
s" in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
