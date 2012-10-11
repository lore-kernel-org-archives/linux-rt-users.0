From: Thomas Gleixner <tglx@linutronix.de>
Subject: Re: [RT-3.6] trivial fixes for git-am and fix for !RT_FULL
Date: Thu, 11 Oct 2012 22:14:43 +0200 (CEST)
Message-ID: <alpine.LFD.2.02.1210112210320.2779@ionos>
References: <20121010164719.GA14314@windriver.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: linux-rt-users <linux-rt-users@vger.kernel.org>
To: Paul Gortmaker <paul.gortmaker@windriver.com>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from www.linutronix.de ([62.245.132.108]:51564 "EHLO
	Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752648Ab2JKUOr (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Thu, 11 Oct 2012 16:14:47 -0400
In-Reply-To: <20121010164719.GA14314@windriver.com>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

Paul,

On Wed, 10 Oct 2012, Paul Gortmaker wrote:

> I've used the 3.6 RT patches as a baseline for a git repo of patches
> (identical to how stable kernels are managed) since I like how it gives
> visibility into how each patch evolves and adds tracking to the series.
> 
> On that baseline I've layered on some trivial fixes (bad ordering in the
> From/Subject line, missing subjects etc) that trip up git-am and would
> need fixing anyway before considering them for mainlining.  Aside from
> two whitespace things, these changes don't alter the final source at all.
> 
> There is one build fix which I've added for the !RT_FULL case; trivial
> missing ifdef usage.
> 
> I'll keep the master branch in this repo to track directly the exact
> content released by Thomas in his tarballs.  The fixes I've done are on
> the v3.6.1-rt1-fixes branch that can be browsed here:

Nice service. I grabbed it and replaced my own series with it, so we
all can enjoy the fixed patch files in the next release.

Thanks,

	tglx
