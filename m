From: Andi Kleen <ak@linux.intel.com>
Subject: Re: [RFC] high preempt off latency in vfree path
Date: Tue, 22 Mar 2016 19:44:02 -0700
Message-ID: <20160323024402.GA27856@tassilo.jf.intel.com>
References: <56F1F4A6.2060400@lab126.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: linux-mm@kvack.org, linux-kernel@vger.kernel.org, tj@kernel.org,
	linux-rt-users@vger.kernel.org, Nick Piggin <npiggin@suse.de>
To: Joel Fernandes <joelaf@lab126.com>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from mga03.intel.com ([134.134.136.65]:6740 "EHLO mga03.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753525AbcCWCoF (ORCPT <rfc822;linux-rt-users@vger.kernel.org>);
	Tue, 22 Mar 2016 22:44:05 -0400
Content-Disposition: inline
In-Reply-To: <56F1F4A6.2060400@lab126.com>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

> (1)
> One is we reduce the number of lazy_max_pages (right now its around 32MB per core worth of pages).
> 
> diff --git a/mm/vmalloc.c b/mm/vmalloc.c
> index aa3891e..2720f4f 100644
> --- a/mm/vmalloc.c
> +++ b/mm/vmalloc.c
> @@ -564,7 +564,7 @@ static unsigned long lazy_max_pages(void)
> 
>         log = fls(num_online_cpus());
> 
> -       return log * (32UL * 1024 * 1024 / PAGE_SIZE);
> +       return log * (8UL * 1024 * 1024 / PAGE_SIZE);
>  }

This seems like the right fix to me.  Perhaps even make it somewhat smaller.

Even on larger systems it's probably fine because they have a lot more
cores/threads these days, so it will be still sufficiently large.

-Andi
