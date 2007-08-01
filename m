From: Daniel Walker <dwalker@mvista.com>
Subject: Re: [PATCH] RT: Add priority-queuing and priority-inheritance to
	workqueue infrastructure
Date: Wed, 01 Aug 2007 11:39:59 -0700
Message-ID: <1185993599.2636.150.camel@imap.mvista.com>
References: <20070801002407.4973.54778.stgit@novell1.haskins.net>
	 <1185940340.2636.97.camel@imap.mvista.com>
	 <1185987663.12034.99.camel@twins>
	 <1185988243.2636.126.camel@imap.mvista.com>
	 <20070801182658.GB90@tv-sign.ru>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Cc: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@elte.hu>,
	Gregory Haskins <ghaskins@novell.com>,
	linux-rt-users@vger.kernel.org, linux-kernel@vger.kernel.org
To: Oleg Nesterov <oleg@tv-sign.ru>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from gateway-1237.mvista.com ([63.81.120.158]:63905 "EHLO
	gateway-1237.mvista.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1760587AbXHASlp (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Wed, 1 Aug 2007 14:41:45 -0400
In-Reply-To: <20070801182658.GB90@tv-sign.ru>
Sender: linux-rt-users-owner@vger.kernel.org
List-Id: linux-rt-users.vger.kernel.org

On Wed, 2007-08-01 at 22:26 +0400, Oleg Nesterov wrote:

> No, the "tail" option has nothing to do with prioritize, we can't remove
> it. Please look at the code.

So you insert a work struct that executes last which wakes the flushing
thread?

> Also, flush_workqueue() must not be delayed by the new incoming work_struct's,
> the change like this breaks this assumption.

True ..

Daniel
