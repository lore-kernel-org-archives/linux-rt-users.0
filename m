From: "David L. Craig" <dlc.usa@gmail.com>
Subject: Re: linux rt 3.4.8-rt16 and nv 302.17, and system freezes, does
 nvidia strike again?
Date: Thu, 23 Aug 2012 18:50:44 -0400
Message-ID: <20120823225044.GA14991@dlc-dt.home>
References: <CAOLSsAw3QG40xSokZ8spMa1_J81n2L9fb2g68jEo-r0iCMP8gA@mail.gmail.com>
 <1345264436.8439.15.camel@marge.simpson.net>
 <20120818070110.GA26476@dlc-dt.home>
 <CAOLSsAwG-KNdOwWxGSQmRA8mrA+mTvCgDLS4oneYOsguk8mzDQ@mail.gmail.com>
 <20120818110637.GA30911@dlc-dt.home>
 <CAOLSsAx3z9CY1Y8H6TqfFMJ49OS0E2XrE6LXKp5MZn-JF-86uw@mail.gmail.com>
Reply-To: "David L. Craig" <dlc@radix.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: "David L. Craig" <dlc@radix.net>, Mike Galbraith <efault@gmx.de>,
	RT <linux-rt-users@vger.kernel.org>
To: Javier Sanz <jsanza@gmail.com>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from mail-qc0-f180.google.com ([209.85.216.180]:41357 "EHLO
	mail-qc0-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751905Ab2HWWuw (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Thu, 23 Aug 2012 18:50:52 -0400
Received: by qcmv28 with SMTP id v28so835992qcm.11
        for <linux-rt-users@vger.kernel.org>; Thu, 23 Aug 2012 15:50:51 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <CAOLSsAx3z9CY1Y8H6TqfFMJ49OS0E2XrE6LXKp5MZn-JF-86uw@mail.gmail.com>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

On 12Aug23:1047+0200, Javier Sanz wrote:
> 
> You say that there is a message,
> [6.993495] Disabling lock debugging due to kernel taint
> 
> how do you get it ?

This and other pertinent messages are logged (under
Debian) in /var/log/kern.log and are crucial for
understanding what is going on.  Compare yours to the
one I attached to the Debian bug report.

> have you sent this information any nvidia  forums?
> no answer?  how can we fix it ?
> 
> Yesterday, testing with kernel 3.4.9-rt17 with nvidia
> 304.37 drivers ... nvidia gt 240 ...  all blocked ..
> i am at same point ...
> 
> So, what is the next step? mails? forums?
> 
> What do you suggest?

The nvidia driver, not being libre source, "taints"
the kernel environment, and policy mandates disabling
spin lock debugging logic as a consequence.  Some
interaction between nvidia and the rt kernel is the
most likely cause of the blocking encountered since
it doesn't manifest with comparable non-rt kernels.
Also, the problem has been introduced since the code
levels in the Linux Mint environment I documented in
the Debian bug report.  This is an area programmed
and debugged by well-studied kernel developers.
Mere mortals are not equipped to tackle such matters.

I have already done what I suggested in my previous
messages.  If an rt and/or nvidia developer does
not take an interest in this behaviour, it must be
hoped the misbehavior induces other problems they are
motivated to investigate.  I have asked for suggestions
on this list and in the Debian bug report about
next steps but thus far have received no responses.
While I do think I could learn enough to expertly
dig into this in a couple man-months, I do not think
I will be compelled to actually make it a priority
unless my circumstances significantly change; e.g.,
somebody offers me some financial incentive to do so.

I'll ask this list again: should this become an rt
kernel or nvidia bug report somewhere or should I
just let it percolate up from Debian?

In the meantime I don't use nvidia with the rt kernel
except with my Linux Mint partition, and that only to
run FlightGear (not very often anymore).
-- 
May the LORD God bless you exceedingly abundantly!

Dave_Craig______________________________________________
"So the universe is not quite as you thought it was.
 You'd better rearrange your beliefs, then.
 Because you certainly can't rearrange the universe."
__--from_Nightfall_by_Asimov/Silverberg_________________
