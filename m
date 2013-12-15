From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Subject: Re: [PATCH] migrate_disable pushd down in rt_read_trylock
Date: Sun, 15 Dec 2013 16:06:19 +0100
Message-ID: <52ADC56B.6070406@linutronix.de>
References: <20131123005158.GA16338@opentech.at> <20131129151401.GD31099@linutronix.de> <20131129154425.GE31099@linutronix.de> <20131130023026.GB8114@opentech.at> <20131130064755.GA12036@opentech.at> <20131215131643.GC31090@linutronix.de> <20131215141522.GA15532@opentech.at>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: linux-rt-users@vger.kernel.org,
	Peter Zijlstra <peterz@infradead.org>,
	Steven Rostedt <rostedt@goodmis.org>,
	Andreas Platschek <platschek@ict.tuwien.ac.at>
To: Nicholas Mc Guire <der.herr@hofr.at>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from www.linutronix.de ([62.245.132.108]:55738 "EHLO
	Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750834Ab3LOPGY (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Sun, 15 Dec 2013 10:06:24 -0500
In-Reply-To: <20131215141522.GA15532@opentech.at>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

On 12/15/2013 03:15 PM, Nicholas Mc Guire wrote:
> no - as David Miller stated clearly that he sees these
> split-api locks as a valid idiom and there were clear
> worries that this would break in the future I see no point
> in pushing this. The alternative of removing the recursive
> migrate_disable/enable in local_bh_* directly is good
> enough I guess - see: 
> 0001-make-migrate-disable-enable-conditioned-on-softirq_n.patch

okay.

> 
> thx!
> hofrat

Sebastian

