From: Thomas Gleixner <tglx@linutronix.de>
Subject: Re: [PATCH v2 1/2] rtmutex Real-Time Linux: Fixing kernel BUG at
 kernel/locking/rtmutex.c:997!
Date: Tue, 7 Apr 2015 13:23:25 +0200 (CEST)
Message-ID: <alpine.DEB.2.11.1504071255410.3845@nanos>
References: <1424395866-81589-1-git-send-email-tmac@hp.com> <1428369962-74723-1-git-send-email-tmac@hp.com> <1428369962-74723-2-git-send-email-tmac@hp.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Steven Rostedt <rostedt@goodmis.org>,
	LKML <linux-kernel@vger.kernel.org>, mingo@redhat.com,
	linux-rt-users <linux-rt-users@vger.kernel.org>,
	umgwanakikbuti@gmail.com, Peter Zijlstra <peterz@infradead.org>
To: Thavatchai Makphaibulchoke <tmac@hp.com>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from www.linutronix.de ([62.245.132.108]:37513 "EHLO
	Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752870AbbDGLXJ (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Tue, 7 Apr 2015 07:23:09 -0400
In-Reply-To: <1428369962-74723-2-git-send-email-tmac@hp.com>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

On Mon, 6 Apr 2015, Thavatchai Makphaibulchoke wrote:

> This patch fixes the problem that the ownership of a mutex acquired
> by an interrupt handler(IH) gets incorrectly attributed to the
> interrupted thread.

An hard interrupt handler is not allowed to take a mutex. End of
story, nothing to fix here.

Thanks,

	tglx
