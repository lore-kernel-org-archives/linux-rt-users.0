From: Thomas Gleixner <tglx@linutronix.de>
Subject: Re: [PATCH] condition migration_disable on lock acquisition
Date: Wed, 27 Nov 2013 01:26:05 +0100 (CET)
Message-ID: <alpine.DEB.2.02.1311270124480.30673@ionos.tec.linutronix.de>
References: <20131120102107.GA12022@opentech.at> <20131122044223.GB31849@opentech.at>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: linux-rt-users@vger.kernel.org,
	Peter Zijlstra <peterz@infradead.org>,
	Steven Rostedt <rostedt@goodmis.org>,
	Andreas Platschek <platschek@ict.tuwien.ac.at>
To: Nicholas Mc Guire <der.herr@hofr.at>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from www.linutronix.de ([62.245.132.108]:37376 "EHLO
	Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750802Ab3K0A0N (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Tue, 26 Nov 2013 19:26:13 -0500
In-Reply-To: <20131122044223.GB31849@opentech.at>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>



On Fri, 22 Nov 2013, Nicholas Mc Guire wrote:

> >From a73aed45d686f800871ba0342cd223bf23e70302 Mon Sep 17 00:00:00 2001
> From: Nicholas Mc Guire <der.herr@hofr.at>
> Date: Thu, 21 Nov 2013 22:52:30 -0500
> Subject: [PATCH] condition migration_disable on lock acquisition
> 
>  No need to unconditionally migrate_disable (what is it protecting ?) and
>  re-enable on failure to acquire the lock.
>  This patch moves the migrate_disable to be conditioned on sucessful lock
>  acquisition only.
> 
>  No change of functionality

Well it is a change of functionality, but it has no functional impact.

Acked-by: Thomas Gleixner <tglx@linutronix.de>
