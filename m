From: Grant Edwards <grant.b.edwards@gmail.com>
Subject: Re: Using patch-2.6.33.7.2-rt30 increases latency and CPU usage?
Date: Wed, 9 May 2012 23:18:07 +0000 (UTC)
Message-ID: <joetve$hm5$1@dough.gmane.org>
References: <joemui$6v0$1@dough.gmane.org> <joepd0$e4f$1@dough.gmane.org>
 <4FAAEBF3.10907@netacquire.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
To: linux-rt-users@vger.kernel.org
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from plane.gmane.org ([80.91.229.3]:60265 "EHLO plane.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1758285Ab2EIXST (ORCPT <rfc822;linux-rt-users@vger.kernel.org>);
	Wed, 9 May 2012 19:18:19 -0400
Received: from list by plane.gmane.org with local (Exim 4.69)
	(envelope-from <glru-linux-rt-users@m.gmane.org>)
	id 1SSG9B-0008E0-EN
	for linux-rt-users@vger.kernel.org; Thu, 10 May 2012 01:18:17 +0200
Received: from c-24-118-110-103.hsd1.mn.comcast.net ([24.118.110.103])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <linux-rt-users@vger.kernel.org>; Thu, 10 May 2012 01:18:17 +0200
Received: from grant.b.edwards by c-24-118-110-103.hsd1.mn.comcast.net with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <linux-rt-users@vger.kernel.org>; Thu, 10 May 2012 01:18:17 +0200
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

On 2012-05-09, Joachim Achtzehnter <joachima@netacquire.com> wrote:
> Grant Edwards wrote:
>
>> I've been loaned a clue by somebody on the OSADL mailing list: the RT
>> patches are for improving _user_space_ reponse, and may do so at the
>> expense of both CPU usage and interrupt latency.
>
> The RT patches improve *worst case* latency. They are primarily
> intended for applications that must *always* meet their deadlines,
> not merely most of the time. In return you tend to get increased
> average latency as well as reduced throughput.

Good point.

I eventually figured out that my increased interrupt latency is due to
my ISR being run in a kernel thread instead of as a real ISR.  Adding
the IRQF_NODELAY flag gets me the same average latency I had without
the RT patch.  [It looks like that flag has a different name in 2.6.39
and later?]

>> As a result, I'm better off without the RT patch if what I care
>> about is interrupt latency.
>
> Yes, if you only care about *typical* interrupt latency but don't
> mind the occasional long delay.

Unfortunately, the requirements are a bit fuzzy -- I've got an ISR
deadline of about 20us that I'm trying to meet [I wouldn't mind a
little chat with the person who designed _that_ requirement into the
hardware].  What I don't know is how hard that deadline is.  With the
RT patch (and without IRQF_NODELAY), I miss the deadline most of the
time (I'd guess about 80% of the time).

Without RT or with RT and IRQF_NODELAY, it looks like I meet the
deadline maybe 98% of the time (under test conditions).  What I don't
know is if once the deadline is missed it matters weather it's missed
by 50us or by 250us [or if 98% is going to be anywhere close to
acceptible, for that matter].

-- 
Grant

