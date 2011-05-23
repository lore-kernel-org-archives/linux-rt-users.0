From: Frank Rowand <frank.rowand@am.sony.com>
Subject: Re: Disabling lapic timer for a certain core
Date: Mon, 23 May 2011 16:49:29 -0700
Message-ID: <4DDAF289.8090002@am.sony.com>
References: <5A76E600A0235B469F3CC8AD2A6AC17340CCEDDC76@pdxex02.esi.com>
Reply-To: <frank.rowand@am.sony.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"
Content-Transfer-Encoding: 7bit
Cc: "linux-rt-users@vger.kernel.org" <linux-rt-users@vger.kernel.org>
To: Joe Howard <howardj@esi.com>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from va3ehsobe003.messaging.microsoft.com ([216.32.180.13]:49720
	"EHLO VA3EHSOBE003.bigfish.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1757896Ab1EWXug (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Mon, 23 May 2011 19:50:36 -0400
Received: from mail89-va3 (localhost.localdomain [127.0.0.1])	by
 mail89-va3-R.bigfish.com (Postfix) with ESMTP id AD6E714E8267	for
 <linux-rt-users@vger.kernel.org>; Mon, 23 May 2011 23:50:34 +0000 (UTC)
In-Reply-To: <5A76E600A0235B469F3CC8AD2A6AC17340CCEDDC76@pdxex02.esi.com>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

On 05/23/11 14:40, Joe Howard wrote:
> Apologies if this is improper etiquette top-posting and bumping a
> thread that is over 1 year old, but I am curious if any progress has
> been made toward the desire to shield one or more cores from other
> interrupts and processes?  Particularly the lapic timer interrupt.
> 
> It seems the combination of cpusets and irq smp_affinity get 95% of
> the way there, but the "Local timer interrupts" cannot be disabled
> for a given core.  My application runs a polling loop that consumes
> 100% cpu time on a "shielded" core.  The code in the loop takes about
> 500ns to execute and runs once every 5000ns (using "rdtsc"
> instruction to throttle).  I'm seeing an increase of 3000ns duration
> in one cycle out of every 200 (corresponding to the default
> HZ=1000).
> 
> Thanks, -Joe H


At ELC 2011, Thomas Gleixner gave a presentation titled "Status of
Preempt-RT and why there is no roadmap".  The slides are at:

   http://elinux.org/images/c/ca/Elc2011_gleixner.pdf

On slide 12, one of the "Future features" listed is "Full CPU isolation".
So the good news is that the feature is on the radar screen.  The bad
news is that the future is not here yet.

-Frank




