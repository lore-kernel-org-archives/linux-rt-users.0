From: Frank Rowand <frank.rowand@am.sony.com>
Subject: Re: Linearized 2.6.33.7-rt30 patch set available (with free coffee!)
Date: Mon, 31 Jan 2011 18:15:26 -0800
Message-ID: <4D476CBE.4000407@am.sony.com>
References: <4D47242E.1000508@am.sony.com> <4D4725CF.6060008@windriver.com> <4D473046.8090009@am.sony.com> <4D474736.40703@windriver.com>
Reply-To: <frank.rowand@am.sony.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"
Content-Transfer-Encoding: 7bit
Cc: "Rowand, Frank" <Frank_Rowand@sonyusa.com>,
	"linux-rt-users@vger.kernel.org" <linux-rt-users@vger.kernel.org>
To: Paul Gortmaker <paul.gortmaker@windriver.com>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from am1ehsobe006.messaging.microsoft.com ([213.199.154.209]:8120
	"EHLO AM1EHSOBE006.bigfish.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1754069Ab1BACP5 (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Mon, 31 Jan 2011 21:15:57 -0500
In-Reply-To: <4D474736.40703@windriver.com>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

On 01/31/11 15:35, Paul Gortmaker wrote:

< snip >

> OK, so it is simply a matter of quilt dying while git am is capable
> of doing the right thing (see below for evidence).

< snip >

Yes, when I use git am I get the same result that you show here:

> tip-debare$git checkout quilt-junk 
> Switched to branch 'quilt-junk'
> tip-debare$git am patches/genirq-support-forced-threading-of-interrupts.patch
> Applying: genirq: support forced threading of interrupts
> 
> (git am is happy, 

Yes, git am somehow managed to apply the patch cleanly.

If at this point you do

  git show >junk
  diff junk patches/genirq-support-forced-threading-of-interrupts.patch

you will see that the patch as applied by git am has cleaned up the
problem with the original patch.  Pretty cool magic...

> now rewind/pop that commit and retry with quilt)
> 
> tip-debare$git reset --hard HEAD^
> HEAD is now at fd659fd7 quilt-junk
> tip-debare$quilt push
> Applying patch genirq-support-forced-threading-of-interrupts.patch
> patching file include/linux/interrupt.h
> patching file include/linux/irq.h
> patching file include/linux/sched.h
> patching file kernel/irq/chip.c
> patching file kernel/irq/handle.c
> patching file kernel/irq/manage.c
> Hunk #2 succeeded at 465 (offset 3 lines).
> Hunk #3 succeeded at 633 (offset 3 lines).
> Hunk #4 succeeded at 706 (offset 3 lines).
> Hunk #5 succeeded at 736 (offset 3 lines).
> Hunk #6 succeeded at 804 (offset 3 lines).
> Hunk #7 FAILED at 829.
> 1 out of 7 hunks FAILED -- rejects in file kernel/irq/manage.c
> patching file kernel/irq/migration.c
> patching file kernel/sched.c
> Hunk #1 succeeded at 5147 (offset 3 lines).
> Patch genirq-support-forced-threading-of-interrupts.patch does not apply (enforce with -f)
> tip-debare$

Again, I get the same result.  And I get the same "Hunk #7 FAILED" with

  patch --dry-run -p1 < patches/genirq-support-forced-threading-of-interrupts.patch

-Frank

