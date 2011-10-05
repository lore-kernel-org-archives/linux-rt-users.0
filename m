From: Thomas Gleixner <tglx@linutronix.de>
Subject: Re: rt patch set and tags on mainline repo
Date: Wed, 5 Oct 2011 21:47:28 +0200 (CEST)
Message-ID: <alpine.LFD.2.02.1110052143420.18778@ionos>
References: <4E8CA60F.3080700@cavium.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: "linux-rt-users@vger.kernel.org" <linux-rt-users@vger.kernel.org>
To: Venkat Subbiah <venkat.subbiah@cavium.com>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from www.linutronix.de ([62.245.132.108]:34461 "EHLO
	Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S933233Ab1JETrb (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Wed, 5 Oct 2011 15:47:31 -0400
In-Reply-To: <4E8CA60F.3080700@cavium.com>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

On Wed, 5 Oct 2011, Venkat Subbiah wrote:

> Hello,
> 
> I am still not able to figure out which of Linus's tag in the mainline repo
> would an rt patch set apply to.
> 
> For example this patch here
> http://web.archive.org/web/20110612145812/http://www.kernel.org/pub/linux/kernel/projects/rt/patch-2.6.33.9-rt31.gz 

2.6.33.9-rt applies to 2.6.33.9 which is a stable release. Stable
kernels are not part of Linus tree. 

http://git.kernel.org/?p=linux/kernel/git/stable/linux-stable.git;a=shortlog;h=refs/heads/linux-2.6.33.y

> Q1) Alsolooks like the https://rt.wiki.kernel.org/index.php/Main_Page is still
> not available. Is there a location where I can get the split patch equivalent
> of "patch-2.6.33.9-rt31.gz".

Not at the moment.
 
> Q2) I am really looking to patch a 2.6.32 kernel. Are there rt patch sets
> available for this version even if they are unofficial?

No. Just my 0,01$: Move your BSP to 2.6.33 or 3.0 instead of
attempting to backport rt to 33. But it's your decision and your time
to waste. :0

Thanks,

	tglx
