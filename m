From: Robin Gareus <robin@gareus.org>
Subject: Re: future of -rt kernels for realtime audio
Date: Tue, 06 Jul 2010 13:49:31 +0200
Message-ID: <4C33184B.1090209@gareus.org>
References: <AANLkTikZNjYJnDM6iKgrT1230FP8DSMgHUrZz2lYL4ll@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: linux-rt-users@vger.kernel.org
To: Pedro Ribeiro <pedrib@gmail.com>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from mo-p00-ob.rzone.de ([81.169.146.160]:53195 "EHLO
	mo-p00-ob.rzone.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755047Ab0GFLtf (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Tue, 6 Jul 2010 07:49:35 -0400
In-Reply-To: <AANLkTikZNjYJnDM6iKgrT1230FP8DSMgHUrZz2lYL4ll@mail.gmail.com>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

On 07/06/2010 01:19 PM, Pedro Ribeiro wrote:
> Hi,
> 
> I've been using -rt kernels since 2.6.29 because I do realtime audio
> on my laptop.
> 
> The audio stability has been steadily improving since, and now I find
> that I can use 2.6.34 without the -rt patch and achieve the same
> stability as 2.6.33-rt - well, my latency requirements aren't that
> high, I just need to maintain 8.9ms completely stable, however before
> .34 it would be impossible without the -rt patch.

It's been possible to achieve low-latency for audio (using JACK) with
the vanilla kernel for a while now.
The -rt patch still has two major advantages:
 - it guarantees low latency.
   (pretty much a requirement for live-performance on stage)
 - it allows to assign scheduling priorities to IRQ handlers.
   (comes in handy for crappy machines that share the soundcard's IRQ)

As for your questions: I don't know the details, hopefully someone else
here can enlighten us. I'd be interested in that as well.

> So out of curiosity, what changed for .34? According to [1], on .33
> Raw Spinlock Annotation was introduced in the mainline kernel.
> However, as said above, I can't get the same performance than with
> .34.
> 
> I remember that I read somewhere that the one the biggest problems
> with latency requirements was the use of the BKL. Do you think there
> will be a significant improvement of latency (in specific cases of
> course) with the scheduled removal of BKL for 2.6.36?
> 
> Thanks for the help,
> Pedro
> 
> [1] http://www.osadl.org/Realtime-Linux.projects-realtime-linux.0.html

-- 
Robin Gareus                           mail: robin@gareus.org
site: http://gareus.org/               chat: xmpp:rgareus@ik.nu
blog: http://rg42.org/                 lab : http://citu.fr/

Public Key at http://pgp.mit.edu/
Fingerprint : 7107 840B 4DC9 C948 076D 6359 7955 24F1 4F95 2B42
