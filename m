From: Paul Gortmaker <paul.gortmaker@windriver.com>
Subject: Re: Linearized 2.6.33.7-rt30 patch set available (with free coffee!)
Date: Mon, 31 Jan 2011 16:12:47 -0500
Message-ID: <4D4725CF.6060008@windriver.com>
References: <4D47242E.1000508@am.sony.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: linux-rt-users@vger.kernel.org
To: frank.rowand@am.sony.com
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from mail.windriver.com ([147.11.1.11]:50828 "EHLO
	mail.windriver.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753978Ab1AaVMv (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Mon, 31 Jan 2011 16:12:51 -0500
In-Reply-To: <4D47242E.1000508@am.sony.com>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

On 11-01-31 04:05 PM, Frank Rowand wrote:
> Hi Paul,
> 
> Thanks for the patch set!  I had started down the path of doing
> the same work, and truly appreciate the effort you put into this.
> 
> One of the patches had a chunk that failed to apply:
> 
> genirq-support-forced-threading-of-interrupts.patch

Interesting.  I was using "git am" to apply them, and I can assure
you that they all applied with that (which is quite strict in its
checking.)

What were you applying them with?

I'll go re-export the patch and look at the diff of the patch
later when I get a chance, but I suspect something else.

Were you using master branch of the patch repo, or the v2.6.33-rt
branch?   I've already started moving the master branch ahead towards
2.6.34, so you will definitely get patch failures if you are trying
it against a v2.6.33.7 baseline.

Paul.

> 
> patching file kernel/irq/manage.c
> Hunk #2 succeeded at 465 (offset 3 lines).
> Hunk #3 succeeded at 633 (offset 3 lines).
> Hunk #4 succeeded at 706 (offset 3 lines).
> Hunk #5 succeeded at 736 (offset 3 lines).
> Hunk #6 succeeded at 804 (offset 3 lines).
> Hunk #7 FAILED at 829.
> 1 out of 7 hunks FAILED -- rejects in file kernel/irq/manage.c
> 
> 
> I fixed it up and I am attaching the new version of the patch.
> 
> With the fixed patch, the kernel source tree with your patches
> applied matches the kernel source tree with the monolithic
> 2.6.33.7-rt30 patch applied.
> 
> -Frank Rowand
