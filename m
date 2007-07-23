From: Ingo Molnar <mingo@elte.hu>
Subject: Re: [PATCH] release quicklist before free_page
Date: Mon, 23 Jul 2007 20:23:01 +0200
Message-ID: <20070723182301.GA27789@elte.hu>
References: <20070723152129.036573829@mvista.com> <1185208378.8197.20.camel@twins> <1185207979.2573.55.camel@imap.mvista.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Peter Zijlstra <peterz@infradead.org>, paulmck@linux.vnet.ibm.com,
	linux-kernel@vger.kernel.org, linux-rt-users@vger.kernel.org
To: Daniel Walker <dwalker@mvista.com>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from mx3.mail.elte.hu ([157.181.1.138]:48516 "EHLO mx3.mail.elte.hu"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753878AbXGWSX3 (ORCPT <rfc822;linux-rt-users@vger.kernel.org>);
	Mon, 23 Jul 2007 14:23:29 -0400
Content-Disposition: inline
In-Reply-To: <1185207979.2573.55.camel@imap.mvista.com>
Sender: linux-rt-users-owner@vger.kernel.org
List-Id: linux-rt-users.vger.kernel.org


* Daniel Walker <dwalker@mvista.com> wrote:

> > Not quite, it uses preempt_disable() to avoid migration and stick to 
> > a cpu. Without that it might end up freeing pages from another 
> > quicklist.

i.e. the patch hides a debug warning and there's possibly silent data 
corruption - not good.

> > How about this - compile tested only
> 
> How about a comment to go with it ?  Which says something like what's 
> above, notes on how the locking is getting used..

how about: "if you've got some time then please also add a few comments, 
because the code was quite non-obvious to me and I misunderstood it when 
I tried to fix it. Thanks."

ok?

	Ingo
