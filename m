From: Ingo Molnar <mingo@elte.hu>
Subject: Re: [PATCH] CFS: Mark print_cfs_stats static
Date: Mon, 6 Aug 2007 09:32:58 +0200
Message-ID: <20070806073258.GK5359@elte.hu>
References: <1184957097.2630.17.camel@josh-work.beaverton.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: linux-kernel@vger.kernel.org, akpm@linux-foundation.org,
	linux-rt-users@vger.kernel.org
To: josh@kernel.org, josht@linux.vnet.ibm.com
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from mx3.mail.elte.hu ([157.181.1.138]:58840 "EHLO mx3.mail.elte.hu"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754476AbXHFHdX (ORCPT <rfc822;linux-rt-users@vger.kernel.org>);
	Mon, 6 Aug 2007 03:33:23 -0400
Content-Disposition: inline
In-Reply-To: <1184957097.2630.17.camel@josh-work.beaverton.ibm.com>
Sender: linux-rt-users-owner@vger.kernel.org
List-Id: linux-rt-users.vger.kernel.org


* Josh Triplett <josh@kernel.org> wrote:

> sched_fair.c defines print_cfs_stats, and sched_debug.c uses it, but 
> sched.c includes both sched_fair.c and sched_debug.c, so all the 
> references to print_cfs_stats occur in the same compilation unit.  
> Thus, mark print_cfs_stats static.
> 
> Eliminates a sparse warning: warning: symbol 'print_cfs_stats' was not 
> declared. Should it be static?

thanks, applied.

	Ingo
