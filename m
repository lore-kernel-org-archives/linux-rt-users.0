From: Thomas Gleixner <tglx@linutronix.de>
Subject: Re: [patch 2/3] cyclictest: Convert the offset of the alignment
 option to microseconds
Date: Tue, 2 Jun 2015 23:01:06 +0200 (CEST)
Message-ID: <alpine.DEB.2.11.1506022247320.20347@nanos>
References: <20150526190333.510838769@glx-um.de> <20150526190443.640221319@glx-um.de> <alpine.LFD.2.10.1505272324180.13094@riemann> <47e6a4612898bdcbcf3073f27ab93708@tglx.de> <alpine.LFD.2.10.1506021458180.13306@riemann>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Anna-Maria Gleixner <anna-maria@glx-um.de>,
	linux-rt-users@vger.kernel.org,
	Clark Williams <williams@redhat.com>
To: John Kacur <jkacur@redhat.com>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from www.linutronix.de ([62.245.132.108]:53130 "EHLO
	Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751424AbbFBVBD (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Tue, 2 Jun 2015 17:01:03 -0400
In-Reply-To: <alpine.LFD.2.10.1506021458180.13306@riemann>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

On Tue, 2 Jun 2015, John Kacur wrote:
> > ===================================================================
> > --- rt-tests.orig/src/cyclictest/cyclictest.c
> > +++ rt-tests/src/cyclictest/cyclictest.c
> > @@ -1289,9 +1289,9 @@ static void process_options (int argc, c
> 
> 
> I fixed your patch manually, but you are doing something wrong generating 
> it, see how the function header get's cut off above there?

No. This is entirely correct. diff cuts off the function declaration
at some random column and it's completely irrelevant to the
correctness of the patch. That line is merily an extra for navigation
purpose and not at all relevant to the patch itself. 
 
@@ -1289,9 +1289,9 @@

would be a completly sufficient header for the hunk.

The reason why this patch did not apply is, that it is a complete
replacement of the original patch and not a delta patch.

Anna-Maria should have sent a new series(PATCH V2) instead of patches
which can be mistaken as delta fixes.


Thanks,

	tglx
