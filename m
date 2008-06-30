From: Ingo Molnar <mingo@elte.hu>
Subject: Re: [PATCH 0/3] sched: newidle and RT wake-buddy fixes
Date: Mon, 30 Jun 2008 20:10:01 +0200
Message-ID: <20080630181001.GE23739@elte.hu>
References: <20080627202444.3829.21595.stgit@lsg.lsg.lab.novell.com> <20080630131511.GA7506@elte.hu> <4868DCC7.BA47.005A.0@novell.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: rostedt@goodmis.org, peterz@infradead.org, npiggin@suse.de,
	linux-kernel@vger.kernel.org, linux-rt-users@vger.kernel.org
To: Gregory Haskins <ghaskins@novell.com>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from mx3.mail.elte.hu ([157.181.1.138]:54690 "EHLO mx3.mail.elte.hu"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753300AbYF3SKP (ORCPT <rfc822;linux-rt-users@vger.kernel.org>);
	Mon, 30 Jun 2008 14:10:15 -0400
Content-Disposition: inline
In-Reply-To: <4868DCC7.BA47.005A.0@novell.com>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>


* Gregory Haskins <ghaskins@novell.com> wrote:

> > -tip testing found this boot hang:
> 
> I may have found the issue: It looks like the hunk that initially 
> disables interrupts in load_balance_newidle() was inadvertently 
> applied to load_balance() instead during the merge to linux-tip.  If 
> you fold the following patch into my original patch, it should set 
> things right again.

ah, that might have indeed happened. Good catch, i'll test it tomorrow.

	Ingo
