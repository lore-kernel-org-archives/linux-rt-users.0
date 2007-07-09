From: Matthieu CASTET <matthieu.castet@parrot.com>
Subject: Re: PI mutex support on ARM
Date: Mon, 9 Jul 2007 07:20:40 +0000 (UTC)
Message-ID: <loom.20070709T091457-860@post.gmane.org>
References: <3efb10970707080124i7a9323c5o9257b4adcb2ac493@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
To: linux-rt-users@vger.kernel.org
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from main.gmane.org ([80.91.229.2]:57162 "EHLO ciao.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751176AbXGIHZG (ORCPT <rfc822;linux-rt-users@vger.kernel.org>);
	Mon, 9 Jul 2007 03:25:06 -0400
Received: from root by ciao.gmane.org with local (Exim 4.43)
	id 1I7ncE-000870-8h
	for linux-rt-users@vger.kernel.org; Mon, 09 Jul 2007 09:25:02 +0200
Received: from ASt-Lambert-152-1-73-132.w86-217.abo.wanadoo.fr ([86.217.67.132])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <linux-rt-users@vger.kernel.org>; Mon, 09 Jul 2007 09:25:02 +0200
Received: from matthieu.castet by ASt-Lambert-152-1-73-132.w86-217.abo.wanadoo.fr with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <linux-rt-users@vger.kernel.org>; Mon, 09 Jul 2007 09:25:02 +0200
Sender: linux-rt-users-owner@vger.kernel.org
List-Id: linux-rt-users.vger.kernel.org

Hi,

Remy Bohmer <l.pinguin <at> gmail.com> writes:

> 
> Hello Thomas,
> 
> I have build an implementation for the routine
> futex_atomic_cmpxchg_inatomic() to make PTHREAD_PRIO_INHERIT mutex
> work on ARM.
> Compared to other architectures where CPU specific assembler is used,
> it is probably not the most optimal implementation possible, but I
> tested it successfully on a Atmel AT91RM9200 core, and it could work
> on other (UP) architectures as well.
> 
> What do you think of it?
> Or do you know a better solution?

May be you could have a look at __kuser_cmpxchg (arch/arm/kernel/entry-armv.S).
There stuff for smp for armv6 and newer.
For armv5 and older, maybe masking interrupt is the best solution.


But I believe you should CC arm linux mailling list. You should find more arm
expert :)


Matthieu
