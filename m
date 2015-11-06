From: Thomas Gleixner <tglx@linutronix.de>
Subject: Re: [RFC] e1000e: Add delays after writing to registers
Date: Fri, 6 Nov 2015 18:22:09 +0100 (CET)
Message-ID: <alpine.DEB.2.11.1511061818170.4032@nanos>
References: <1445465268-10347-1-git-send-email-jonathan.david@ni.com> <20151022055909.GA7263@icarus.home.austad.us> <5638F239.1030804@ni.com> <20151103194246.GA19824@sisyphus.home.austad.us> <563930CF.9090800@ni.com> <20151106055349.GA10665@icarus.home.austad.us>
 <alpine.DEB.2.11.1511060929430.4032@nanos> <563CCB4F.90905@steinhoff.de>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Henrik Austad <henrik@austad.us>,
	Jonathan David <jonathan.david@ni.com>,
	linux-rt-users@vger.kernel.org, josh.cartwright@ni.com
To: Armin Steinhoff <armin@steinhoff.de>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from www.linutronix.de ([62.245.132.108]:60885 "EHLO
	Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S933083AbbKFRWx (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Fri, 6 Nov 2015 12:22:53 -0500
In-Reply-To: <563CCB4F.90905@steinhoff.de>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

On Fri, 6 Nov 2015, Armin Steinhoff wrote:
> Thomas Gleixner schrieb:
> > Now that read after a sequence of writes has the effect that the CPU
> > has to wait for the writes to be finished before the read can take
> > place. During that time the CPU just sits there and twiddles
> > thumbs. It's a full stall.
> 
> What means "the CPU" ? Does it mean ALL CPU cores are stalled ??

The CPU means the core on which the write/read sequence happened.

But any other core which is doing a concurrent read over PCI-E even on
an unrelated address space can be affected as well.

Thanks,

	tglx
