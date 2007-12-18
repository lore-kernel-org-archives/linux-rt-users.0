From: Ingo Molnar <mingo@elte.hu>
Subject: Re: [PATCH] sched: dynamically update the root-domain span/online
	maps
Date: Tue, 18 Dec 2007 11:55:13 +0100
Message-ID: <20071218105513.GA9002@elte.hu>
References: <20071218023805.4390.19471.stgit@novell1.haskins.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: srostedt@redhat.com, linux-rt-users@vger.kernel.org,
	linux-kernel@vger.kernel.org
To: Gregory Haskins <ghaskins@novell.com>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from mx3.mail.elte.hu ([157.181.1.138]:55108 "EHLO mx3.mail.elte.hu"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752352AbXLRKz1 (ORCPT <rfc822;linux-rt-users@vger.kernel.org>);
	Tue, 18 Dec 2007 05:55:27 -0500
Content-Disposition: inline
In-Reply-To: <20071218023805.4390.19471.stgit@novell1.haskins.net>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>


* Gregory Haskins <ghaskins@novell.com> wrote:

> Hi Steven,
>   I posted a suspend-to-ram fix to sched-devel earlier today:
> 
> http://lkml.org/lkml/2007/12/17/445
> 
> This fix should also be applied to -rt as I introduced the same 
> regression there.  Here is a version of the fix for 23-rt13.  I can 
> submit a version for 24-rc5-rt1 at your request.

well since i reverted the original patch, there's no regression. The 
question is, do we know whether this new patch works fine wrt. s2ram?

	Ingo
