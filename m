From: Ingo Molnar <mingo@elte.hu>
Subject: Re: [PATCH 0/2] sched: refreshes
Date: Mon, 21 Apr 2008 21:33:26 +0200
Message-ID: <20080421193326.GC8770@elte.hu>
References: <20080421180747.4560.67794.stgit@novell1.haskins.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: suresh.b.siddha@intel.com, rostedt@goodmis.org,
	chinang.ma@intel.com, arjan@linux.intel.com, willy@linux.intel.com,
	linux-kernel@vger.kernel.org, linux-rt-users@vger.kernel.org
To: Gregory Haskins <ghaskins@novell.com>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from mx3.mail.elte.hu ([157.181.1.138]:52667 "EHLO mx3.mail.elte.hu"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755958AbYDUTdn (ORCPT <rfc822;linux-rt-users@vger.kernel.org>);
	Mon, 21 Apr 2008 15:33:43 -0400
Content-Disposition: inline
In-Reply-To: <20080421180747.4560.67794.stgit@novell1.haskins.net>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>


* Gregory Haskins <ghaskins@novell.com> wrote:

> Hi Ingo,
>   Here is a refresh of the two patches you asked for:
> 
> #1 is "v3" of the "pushed" patch which fixes the compilation issue on
>  !CONFIG_SMP
> 
> #2 is a resend of the 2-d bitmap, which includes a fix for that typo I
>  mentioned.

thanks Gregory, applied. We'll see whether they'll make v2.6.26. (but 
given that they existed for a longer time i'd lean towards including 
them - barring some unexpected test failure.)

	Ingo
