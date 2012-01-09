From: Arnaldo Carvalho de Melo <acme@infradead.org>
Subject: Re: Minor page faults from pthread_create()
Date: Mon, 9 Jan 2012 17:00:52 -0200
Message-ID: <20120109190052.GD32530@infradead.org>
References: <4F075DA5.1070307@drcomp.erfurt.thur.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: "linux-rt-users@vger.kernel.org" <linux-rt-users@vger.kernel.org>
To: Adrian Knoth <adi@drcomp.erfurt.thur.de>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from casper.infradead.org ([85.118.1.10]:45485 "EHLO
	casper.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932546Ab2AITA4 (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Mon, 9 Jan 2012 14:00:56 -0500
Content-Disposition: inline
In-Reply-To: <4F075DA5.1070307@drcomp.erfurt.thur.de>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

Em Fri, Jan 06, 2012 at 09:46:29PM +0100, Adrian Knoth escreveu:
> While playing with
> 
> https://rt.wiki.kernel.org/articles/t/h/r/Threaded_RT-application_with_memory_locking_and_stack_handling_example_f48b.html
> 
> I was wondering why pthread_create() should cause minor page faults when
> there is a pre-allocated pre-faulted 100MB memory pool.
> 
> Simply running the example causes roughly 30 minor page faults. When I
> manually allocate stack memory for the stack (after mlockall() and
> mallopt have been called) and use pthread_attr_setstack() before calling
> pthread_create(), minor page faults drop to 2.
> 
> Does anybody happen to know what is causing these remaining two page
> faults? My only guess so far is kernel memory to hold some
> organizational data for the new thread after clone() has been invoked,
> but this could also be completely wrong.
> 
> Note that I don't need to get page faults down to 0, I'm only looking
> for an explanation to understand the issue at hand to confirm that
> pthread_create() must not be used from an RT context.

Try:

$ perf record --event minor-faults --call-graph your-program
$ perf report

Should answer that question if running on a -fno-omit-frame-pointer
binary world. Or at least provide the callchains for the kernel part of
the call chains.

32-bit distros should be OK in that respect.

- Arnaldo
