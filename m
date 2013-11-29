From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Subject: Re: [PATCH 1/2] remove recursive call to migrate_disable in
 read_lock_bh
Date: Fri, 29 Nov 2013 15:54:43 +0100
Message-ID: <20131129145443.GC31099@linutronix.de>
References: <20131120102107.GA12022@opentech.at>
 <20131122161234.GG8698@linutronix.de>
 <20131122233925.GA25921@opentech.at>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: linux-rt-users@vger.kernel.org,
	Peter Zijlstra <peterz@infradead.org>,
	Steven Rostedt <rostedt@goodmis.org>,
	Andreas Platschek <platschek@ict.tuwien.ac.at>
To: Nicholas Mc Guire <der.herr@hofr.at>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from www.linutronix.de ([62.245.132.108]:34642 "EHLO
	Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756491Ab3K2Oyo (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Fri, 29 Nov 2013 09:54:44 -0500
Content-Disposition: inline
In-Reply-To: <20131122233925.GA25921@opentech.at>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

* Nicholas Mc Guire | 2013-11-23 00:39:25 [+0100]:

>hmmm. am I looking at the wrong code path ?
No, it was me, sorry for the confusion.
So this patch should work. What I am concerned is what Peter mentioned.
It seems that we have no user of this "alternative" unlock path right
now but it could become a ticking time bomb.

>hofrat 

Sebastian
