From: David Kastrup <dak@gnu.org>
Subject: Re: TinxCore and PREEMPT_RT
Date: Thu, 16 Sep 2010 12:18:02 +0200
Message-ID: <8762y6dmat.fsf@lola.goethe.zz>
References: <AANLkTinUYXDM_pGoJTd3veNNfYzWVu3Obv8v4RAL0urq@mail.gmail.com>
	<AANLkTi=v_vgk=QwCZPDZWVp+z57_jaPc5=CCnA0Wfmr_@mail.gmail.com>
	<201009151059.23039.klaas.van.gend@mvista.com>
	<4C90A814.8020605@steinhoff.de> <4C91E59E.5010203@steinhoff.de>
Mime-Version: 1.0
Content-Type: text/plain
To: linux-rt-users@vger.kernel.org
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from lo.gmane.org ([80.91.229.12]:50437 "EHLO lo.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751818Ab0IPKSQ (ORCPT <rfc822;linux-rt-users@vger.kernel.org>);
	Thu, 16 Sep 2010 06:18:16 -0400
Received: from list by lo.gmane.org with local (Exim 4.69)
	(envelope-from <glru-linux-rt-users@m.gmane.org>)
	id 1OwBXf-0000LN-SK
	for linux-rt-users@vger.kernel.org; Thu, 16 Sep 2010 12:18:11 +0200
Received: from p508edda0.dip.t-dialin.net ([80.142.221.160])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <linux-rt-users@vger.kernel.org>; Thu, 16 Sep 2010 12:18:11 +0200
Received: from dak by p508edda0.dip.t-dialin.net with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <linux-rt-users@vger.kernel.org>; Thu, 16 Sep 2010 12:18:11 +0200
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

Armin Steinhoff <armin@steinhoff.de> writes:

> Hi all,
>
> yes, it's running !
>
> TinyCore is very small (10MB) , works with the PREEMPT_RT patch (at
> least version 2.6.29.6), full SMP support and boots in few seconds!
> The MicroCore version needs only 6MB ...

Anybody else nostalgic about the times where it took around 10kB to host
a realtime multi-tasking operating system including self-hosting target
compiler?

And the challenge was to fit bootstrap loader and operating system on
one track of the floppy disk?

Heck, the first UNIXes I used regularly were quite workable with 4MB of
main memory.

I'll go back hide under my rock again.  Thanks for listening.

-- 
David Kastrup

