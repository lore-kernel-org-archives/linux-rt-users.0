From: Ingo Molnar <mingo@elte.hu>
Subject: Re: [PATCH 0/3] sched: newidle and RT wake-buddy fixes
Date: Thu, 3 Jul 2008 16:41:24 +0200
Message-ID: <20080703144124.GA653@elte.hu>
References: <20080627202444.3829.21595.stgit@lsg.lsg.lab.novell.com> <20080630131511.GA7506@elte.hu> <4868DCC7.BA47.005A.0@novell.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: rostedt@goodmis.org, peterz@infradead.org, npiggin@suse.de,
	linux-kernel@vger.kernel.org, linux-rt-users@vger.kernel.org
To: Gregory Haskins <ghaskins@novell.com>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from mx2.mail.elte.hu ([157.181.151.9]:56341 "EHLO mx2.mail.elte.hu"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751242AbYGCOlj (ORCPT <rfc822;linux-rt-users@vger.kernel.org>);
	Thu, 3 Jul 2008 10:41:39 -0400
Content-Disposition: inline
In-Reply-To: <4868DCC7.BA47.005A.0@novell.com>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>


* Gregory Haskins <ghaskins@novell.com> wrote:

> I may have found the issue: It looks like the hunk that initially 
> disables interrupts in load_balance_newidle() was inadvertently 
> applied to load_balance() instead during the merge to linux-tip.  If 
> you fold the following patch into my original patch, it should set 
> things right again.

ah, sorry - indeed! I've reactivated your patch and i'm testing it now.

	Ingo
