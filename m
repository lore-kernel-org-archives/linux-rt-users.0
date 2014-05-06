From: Mike Galbraith <umgwanakikbuti@gmail.com>
Subject: Re: [patch 1/6] preempt_lazy: remove redundant test_thread_flag()
 call
Date: Tue, 06 May 2014 07:33:51 +0200
Message-ID: <1399354431.5192.67.camel@marge.simpson.net>
References: <1399020080.5233.96.camel@marge.simpson.net>
	 <1399029166.5233.125.camel@marge.simpson.net>
	 <20140505223728.5a07e6e1@gandalf.local.home>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Cc: RT <linux-rt-users@vger.kernel.org>,
	Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
	Thomas Gleixner <tglx@linutronix.de>
To: Steven Rostedt <rostedt@goodmis.org>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from mail-ee0-f44.google.com ([74.125.83.44]:33055 "EHLO
	mail-ee0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751224AbaEFFeF (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Tue, 6 May 2014 01:34:05 -0400
Received: by mail-ee0-f44.google.com with SMTP id c41so5912974eek.17
        for <linux-rt-users@vger.kernel.org>; Mon, 05 May 2014 22:34:03 -0700 (PDT)
In-Reply-To: <20140505223728.5a07e6e1@gandalf.local.home>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

On Mon, 2014-05-05 at 22:37 -0400, Steven Rostedt wrote: 
> On Fri, 02 May 2014 13:12:46 +0200
> Mike Galbraith <umgwanakikbuti@gmail.com> wrote:
> 
> > __preempt_count_dec_and_test() already does it.
> 
> Already does what? :-)

Poo.. yeah that.

> Hmm, do all archs check? Perhaps we need to also update
> include/asm-generic/preempt.h?

Per cpu preempt_count is x86, and tif_need_resched() handles laziness,
so all should be well.  Did I just manage to overlook the obvious for
the second time?

-Mike

