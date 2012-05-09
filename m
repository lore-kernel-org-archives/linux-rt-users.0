From: Grant Edwards <grant.b.edwards@gmail.com>
Subject: Re: Using patch-2.6.33.7.2-rt30 increases latency and CPU usage?
Date: Wed, 9 May 2012 22:00:00 +0000 (UTC)
Message-ID: <joepd0$e4f$1@dough.gmane.org>
References: <joemui$6v0$1@dough.gmane.org>
To: linux-rt-users@vger.kernel.org
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from plane.gmane.org ([80.91.229.3]:47887 "EHLO plane.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1759747Ab2EIWAP (ORCPT <rfc822;linux-rt-users@vger.kernel.org>);
	Wed, 9 May 2012 18:00:15 -0400
Received: from list by plane.gmane.org with local (Exim 4.69)
	(envelope-from <glru-linux-rt-users@m.gmane.org>)
	id 1SSEvd-0007Xm-JB
	for linux-rt-users@vger.kernel.org; Thu, 10 May 2012 00:00:13 +0200
Received: from dsl.comtrol.com ([64.122.56.22])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <linux-rt-users@vger.kernel.org>; Thu, 10 May 2012 00:00:13 +0200
Received: from grant.b.edwards by dsl.comtrol.com with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <linux-rt-users@vger.kernel.org>; Thu, 10 May 2012 00:00:13 +0200
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

On 2012-05-09, Grant Edwards <grant.b.edwards@gmail.com> wrote:

> IOW: the real-time patch for 2.6.33.7 makes both the typical interrupt
> latency and the CPU usage significantly worse.
>
> Typical latency without the RT patch is 5-15us.
>
> Typical latency with is 15-50us (I've never seen latency below 15us
> with the RT patch).
>
> Is this the expected behavior?

I've been loaned a clue by somebody on the OSADL mailing list: the RT
patches are for improving _user_space_ reponse, and may do so at the
expense of both CPU usage and interrupt latency.

As a result, I'm better off without the RT patch if what I care about
is interrupt latency.

Am right I correct in the following conclusions?

  * In 2.6.33.7, ISRs are really ISRs

  * In 2.6.33.7-rt30, ISRs are kernel threads.

  
-- 
Grant Edwards               grant.b.edwards        Yow! Don't hit me!!  I'm in
                                  at               the Twilight Zone!!!
                              gmail.com            

