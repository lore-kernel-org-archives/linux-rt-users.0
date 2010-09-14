From: David Kastrup <dak@gnu.org>
Subject: Re: preempt rt in commercial use
Date: Tue, 14 Sep 2010 13:00:22 +0200
Message-ID: <87tylslhdl.fsf@lola.goethe.zz>
References: <AANLkTinUYXDM_pGoJTd3veNNfYzWVu3Obv8v4RAL0urq@mail.gmail.com>
	<201009141317.13439@zigzag.lvk.cs.msu.su>
	<201009141206.32587.klaas.van.gend@mvista.com>
Mime-Version: 1.0
Content-Type: text/plain
To: linux-rt-users@vger.kernel.org
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from lo.gmane.org ([80.91.229.12]:46452 "EHLO lo.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751499Ab0INLZF (ORCPT <rfc822;linux-rt-users@vger.kernel.org>);
	Tue, 14 Sep 2010 07:25:05 -0400
Received: from list by lo.gmane.org with local (Exim 4.69)
	(envelope-from <glru-linux-rt-users@m.gmane.org>)
	id 1OvTdH-00020j-Vo
	for linux-rt-users@vger.kernel.org; Tue, 14 Sep 2010 13:25:03 +0200
Received: from p508edcbc.dip.t-dialin.net ([80.142.220.188])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <linux-rt-users@vger.kernel.org>; Tue, 14 Sep 2010 13:25:03 +0200
Received: from dak by p508edcbc.dip.t-dialin.net with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <linux-rt-users@vger.kernel.org>; Tue, 14 Sep 2010 13:25:03 +0200
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

Klaas van Gend <klaas.van.gend@mvista.com> writes:

> On Tuesday 14 September 2010 11:17:12 Nikita V. Youshchenko wrote:
>> > Hello
>> > some companies asked me to show that premmpt rt is comercially used.
>> > are you using it ?
>> 
>> MontaVista has long supplied preempt-rt to lots of it's customers.
>
> Let me elaborate on that a little.
>
> Yes, we have a *lot* of customers using PREEMPT_RT. 
> In my experience they fall into a few different categories:
>
> 1) using it because "it is faster". Well, I've tried to squash that
> idea at every customer I've been, but it's not easy to get out of
> their heads.  In most cases, these customers have no clue why they
> enabled it.
>
> 2) using it because Linux was too slow otherwise.
> Unfortunately something I've run across a few times now - that the embedded 
> boards are too slow to reliably grab all bytes from a serial port. 
> Of course this has something to do with system load and bad design of serial 
> data streams... In many cases, missing a byte can cause serious trouble, like 
> having to do a whole sample analysis again (lab equipment).

This is rather important for audio applications.  You can't afford a
single missed sample in hour-long sessions.

> 3) using it to work around system limitations, e.g. reducing priority on less 
> relevant interrupts and/or threads.
> This is the best use case. For example, if you design data acquisition or 
> control loops, they better run reliably, with low jitter. So you want to 
> reduce priority of everything not that relevant.

I don't call that "working around".  A computer is supposed to do what
it is told to do.  When there are priorities, you need to tell them to
the computer rather than expect that it should somehow figure them out
itself.

-- 
David Kastrup

