From: Thomas Gleixner <tglx@linutronix.de>
Subject: Re: [ANNOUNCE] 3.6.4-rt11
Date: Wed, 31 Oct 2012 11:22:37 +0100 (CET)
Message-ID: <alpine.LFD.2.02.1210311118300.2756@ionos>
References: <alpine.LFD.2.02.1210310144210.2756@ionos> <20121031053708.GD25658@windriver.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: LKML <linux-kernel@vger.kernel.org>,
	linux-rt-users <linux-rt-users@vger.kernel.org>
To: Paul Gortmaker <paul.gortmaker@windriver.com>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from www.linutronix.de ([62.245.132.108]:55276 "EHLO
	Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S933180Ab2JaKWl (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Wed, 31 Oct 2012 06:22:41 -0400
In-Reply-To: <20121031053708.GD25658@windriver.com>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

On Wed, 31 Oct 2012, Paul Gortmaker wrote:

> [[ANNOUNCE] 3.6.4-rt11] On 31/10/2012 (Wed 02:19) Thomas Gleixner wrote:
> 
> > Dear RT Folks,
> > 
> > I'm pleased to announce the 3.6.4-rt11 release.
> 
> The rt11 content is present on master in the 3.6-rt patch repo:
>   http://git.kernel.org/?p=linux/kernel/git/paulg/3.6-rt-patches.git
> 
> I've also created a v3.6.4-rt11-fixes branch, which contains a fix for
> the preempt-lazy TIF test on x86_32 (please check this; I really should
> not be left unattended, mucking around in .S files while on vacation).
> It is queued in the series right after the preempt-lazy-support.patch.

Duh. My tired brain saw the warning fly by without actually grasping
it. Will fold it back for the next release.

> [ quick link to TIF patch @kernel.org: http://goo.gl/7Gbtg ]

Good catch. Thanks,

     tglx
