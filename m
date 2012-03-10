From: Thomas Gleixner <tglx@linutronix.de>
Subject: Re: timer signal loss on RT
Date: Sat, 10 Mar 2012 12:34:00 +0100 (CET)
Message-ID: <alpine.LFD.2.02.1203101231230.2742@ionos>
References: <4F5B2C50.2090907@cfl.rr.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: linux-kernel-rt <linux-rt-users@vger.kernel.org>,
	Mark Hounschell <markh@compro.net>
To: Mark Hounschell <dmarkh@cfl.rr.com>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from www.linutronix.de ([62.245.132.108]:48748 "EHLO
	Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752049Ab2CJLeC (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Sat, 10 Mar 2012 06:34:02 -0500
In-Reply-To: <4F5B2C50.2090907@cfl.rr.com>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

On Sat, 10 Mar 2012, Mark Hounschell wrote:
> I'm sure you can find many things wrong with this test case but I'm not
> sending it for discussion on the merits, or certainly the lack of, an
> application that contains a cpu hog, but only to show what I think is a
> problem with RT kernels.

Nope, PEBKAC.

Timer signals are delivered via ksoftirqd, so your cpu hog prevents
ksoftirqd frum running.

Thanks,

	tglx
