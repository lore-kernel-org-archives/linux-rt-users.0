From: Oleg Nesterov <oleg@tv-sign.ru>
Subject: Re: [PATCH] RT: Add priority-queuing and priority-inheritance to workqueue infrastructure
Date: Thu, 2 Aug 2007 00:25:51 +0400
Message-ID: <20070801202551.GB225@tv-sign.ru>
References: <20070801002407.4973.54778.stgit@novell1.haskins.net> <1185940340.2636.97.camel@imap.mvista.com> <1185987663.12034.99.camel@twins> <1185988243.2636.126.camel@imap.mvista.com> <20070801182658.GB90@tv-sign.ru> <1185993599.2636.150.camel@imap.mvista.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@elte.hu>,
	Gregory Haskins <ghaskins@novell.com>,
	linux-rt-users@vger.kernel.org, linux-kernel@vger.kernel.org
To: Daniel Walker <dwalker@mvista.com>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from mail.screens.ru ([213.234.233.54]:51857 "EHLO mail.screens.ru"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750717AbXHAUZe (ORCPT <rfc822;linux-rt-users@vger.kernel.org>);
	Wed, 1 Aug 2007 16:25:34 -0400
Content-Disposition: inline
In-Reply-To: <1185993599.2636.150.camel@imap.mvista.com>
Sender: linux-rt-users-owner@vger.kernel.org
List-Id: linux-rt-users.vger.kernel.org

On 08/01, Daniel Walker wrote:
>
> On Wed, 2007-08-01 at 22:26 +0400, Oleg Nesterov wrote:
> 
> > No, the "tail" option has nothing to do with prioritize, we can't remove
> > it. Please look at the code.
> 
> So you insert a work struct that executes last which wakes the flushing
> thread?

No, tail == 1 means a "normal" work, tail == 0 means "just after the
->current_work". Yes, the latter is to wake up the flusher at the "right time".

Oleg.
