From: John Kacur <jkacur@redhat.com>
Subject: Re: [patch 2/3] cyclictest: Convert the offset of the alignment
 option to microseconds
Date: Tue, 2 Jun 2015 23:17:53 +0200 (CEST)
Message-ID: <alpine.LFD.2.10.1506022307210.13306@riemann>
References: <20150526190333.510838769@glx-um.de> <20150526190443.640221319@glx-um.de> <alpine.LFD.2.10.1505272324180.13094@riemann> <47e6a4612898bdcbcf3073f27ab93708@tglx.de> <alpine.LFD.2.10.1506021458180.13306@riemann>
 <alpine.DEB.2.11.1506022247320.20347@nanos>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: John Kacur <jkacur@redhat.com>,
	Anna-Maria Gleixner <anna-maria@glx-um.de>,
	linux-rt-users@vger.kernel.org,
	Clark Williams <williams@redhat.com>
To: Thomas Gleixner <tglx@linutronix.de>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from mail-wi0-f173.google.com ([209.85.212.173]:35446 "EHLO
	mail-wi0-f173.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752406AbbFBVR5 (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Tue, 2 Jun 2015 17:17:57 -0400
Received: by wikd7 with SMTP id d7so25982574wik.0
        for <linux-rt-users@vger.kernel.org>; Tue, 02 Jun 2015 14:17:56 -0700 (PDT)
In-Reply-To: <alpine.DEB.2.11.1506022247320.20347@nanos>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>



On Tue, 2 Jun 2015, Thomas Gleixner wrote:

> On Tue, 2 Jun 2015, John Kacur wrote:
> > > ===================================================================
> > > --- rt-tests.orig/src/cyclictest/cyclictest.c
> > > +++ rt-tests/src/cyclictest/cyclictest.c
> > > @@ -1289,9 +1289,9 @@ static void process_options (int argc, c
> > 
> > 
> > I fixed your patch manually, but you are doing something wrong generating 
> > it, see how the function header get's cut off above there?
> 
> No. This is entirely correct. diff cuts off the function declaration
> at some random column and it's completely irrelevant to the
> correctness of the patch. That line is merily an extra for navigation
> purpose and not at all relevant to the patch itself. 
>  
> @@ -1289,9 +1289,9 @@
> 
> would be a completly sufficient header for the hunk.
> 
> The reason why this patch did not apply is, that it is a complete
> replacement of the original patch and not a delta patch.
> 
> Anna-Maria should have sent a new series(PATCH V2) instead of patches
> which can be mistaken as delta fixes.
> 
> 
> Thanks,
> 
> 	tglx

Yeah, my guess as to why her patches are failing was wrong, but they are 
failing. Maybe it's a wordwrap problem. When I try with patch -p1 < 
annas-patch, I get this.

 patch -p1 < ~/patches/anna/align_measurement_threads.patch 
patching file src/cyclictest/cyclictest.c
Hunk #1 FAILED at 185.
patch: **** malformed patch at line 64: par->prio);

Thanks

John
