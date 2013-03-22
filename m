From: Thomas Gleixner <tglx@linutronix.de>
Subject: Re: Page faults with 3.6.11-rt30 but not with 3.6.11-rt25
Date: Fri, 22 Mar 2013 21:48:49 +0100 (CET)
Message-ID: <alpine.LFD.2.02.1303222148140.22263@ionos>
References: <F9467A784CC48947B1D879F07370839E0EBD79BD@fe20099s.ecn.etasgroup.com> <1363963600.6345.102.camel@gandalf.local.home>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: "Koehrer Mathias (ETAS/ESS2)" <mathias.koehrer@etas.com>,
	"linux-rt-users@vger.kernel.org" <linux-rt-users@vger.kernel.org>
To: Steven Rostedt <rostedt@goodmis.org>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from www.linutronix.de ([62.245.132.108]:38748 "EHLO
	Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1422911Ab3CVUsw (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Fri, 22 Mar 2013 16:48:52 -0400
In-Reply-To: <1363963600.6345.102.camel@gandalf.local.home>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

On Fri, 22 Mar 2013, Steven Rostedt wrote:
> On Fri, 2013-03-22 at 09:46 +0000, Koehrer Mathias (ETAS/ESS2) wrote:
> Doing a diff between the two kernels, it looks like there was a bit of
> work on highmem (the stuff that lets you use more than 1 Gig of memory
> on a 32 bit system). I haven't looked too deep at the bug, but if you
> apply the following patch, do you get a stable system again?
> 
> (this is a revert of "highmem: Store ptes right away in the task
> struct")

I'm about to release an 3.6 update which fixes that.
