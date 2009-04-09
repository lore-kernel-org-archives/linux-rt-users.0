From: Thomas Gleixner <tglx@linutronix.de>
Subject: Re: Fedora 10 as basis for RT?
Date: Thu, 9 Apr 2009 16:33:35 +0200 (CEST)
Message-ID: <alpine.LFD.2.00.0904091629430.21577@localhost.localdomain>
References: <loom.20090409T134400-381@post.gmane.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: linux-rt-users@vger.kernel.org
To: Al Dorrington <albert.dorrington@lmco.com>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from www.tglx.de ([62.245.132.106]:51685 "EHLO www.tglx.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752628AbZDIOdv (ORCPT <rfc822;linux-rt-users@vger.kernel.org>);
	Thu, 9 Apr 2009 10:33:51 -0400
In-Reply-To: <loom.20090409T134400-381@post.gmane.org>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

Al,

On Thu, 9 Apr 2009, Al Dorrington wrote:

> Hi,
> 
> I am working on a proof of concept project where we are going to try moving an
> application that runs on VxWorks to Linux. I believe with what I've read on this
> mailing list, and the RTwiki site that Linux is definitely up to the task with
> these kernel patches.
> 
> However, I am not really sure which distribution of Linux we should use as the
> base, nor am I sure if it would be better to stick with the 'i386' distribution
> or go with the x86_64 variant.
> 
> I am considering Fedora 10, either i386 or x86_64. 
> 
> Does anyone have any comments or recommendations for which might be better to
> use, or if we would be better off using another distribution?

We have the preempt-rt kernels running on various distros and I can't
tell a difference. It's up to your personal preference.

32 vs. 64bit: if your cpu has 64 bit then using a 64bit distro is the
natural choice, but it works with 32bit equally well.

Thanks,

	tglx
