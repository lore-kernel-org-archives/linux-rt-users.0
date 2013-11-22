From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Subject: Re: [PATCH] condition migration_disable on lock acquisition
Date: Fri, 22 Nov 2013 19:39:31 +0100
Message-ID: <20131122183931.GK8698@linutronix.de>
References: <20131120102107.GA12022@opentech.at>
 <20131122044223.GB31849@opentech.at>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: linux-rt-users@vger.kernel.org,
	Peter Zijlstra <peterz@infradead.org>,
	Steven Rostedt <rostedt@goodmis.org>,
	Andreas Platschek <platschek@ict.tuwien.ac.at>
To: Nicholas Mc Guire <der.herr@hofr.at>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from www.linutronix.de ([62.245.132.108]:46670 "EHLO
	Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755431Ab3KVSjc (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Fri, 22 Nov 2013 13:39:32 -0500
Content-Disposition: inline
In-Reply-To: <20131122044223.GB31849@opentech.at>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

* Nicholas Mc Guire | 2013-11-22 05:42:23 [+0100]:

> No need to unconditionally migrate_disable (what is it protecting ?) and
> re-enable on failure to acquire the lock.
> This patch moves the migrate_disable to be conditioned on sucessful lock
> acquisition only.
>
> No change of functionality
applied with out this line^

>Signed-off-by: Nicholas Mc Guire <der.herr@hofr.at>

Sebastian
