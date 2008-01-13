From: Steven Rostedt <rostedt@goodmis.org>
Subject: Re: 2.6.24-rc7-rt1: macro "put_cpu_var" passed 2 arguments, but
 takes just 1
Date: Sun, 13 Jan 2008 15:37:33 -0500 (EST)
Message-ID: <Pine.LNX.4.58.0801131519410.9934@gandalf.stny.rr.com>
References: <1200250801.9190.7.camel@localhost.localdomain>
 <200801132053.22830.m.kozlowski@tuxland.pl>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: LKML <linux-kernel@vger.kernel.org>,
	RT <linux-rt-users@vger.kernel.org>, Ingo Molnar <mingo@elte.hu>,
	Thomas Gleixner <tglx@linutronix.de>
To: Mariusz Kozlowski <m.kozlowski@tuxland.pl>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from ms-smtp-04.nyroc.rr.com ([24.24.2.58]:40001 "EHLO
	ms-smtp-04.nyroc.rr.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753456AbYAMUh6 (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Sun, 13 Jan 2008 15:37:58 -0500
In-Reply-To: <200801132053.22830.m.kozlowski@tuxland.pl>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>



On Sun, 13 Jan 2008, Mariusz Kozlowski wrote:

> [... snip ...]
>
> @@ -56,12 +64,13 @@ static inline void __quicklist_free(int
>         struct page *page)
>  {
>         struct quicklist *q;
> +       int cpu;
>
> -       q = &get_cpu_var(quicklist)[nr];
> +       q = &get_cpu_var_locked(quicklist, &cpu)[nr];
>         *(void **)p = q->page;
>         q->page = p;
>         q->nr_pages++;
> -       put_cpu_var(quicklist);
> +       put_cpu_var(quicklist, cpu); <------------- should that be put_cpu_var_locked()?
>  }
>

Ouch! <looks at rejs>

*************** static inline void __quicklist_free(int
*** 76,86 ****
  		return;
  	}

- 	q = &get_cpu_var(quicklist)[nr];
  	*(void **)p = q->page;
  	q->page = p;
  	q->nr_pages++;
- 	put_cpu_var(quicklist);
  }

  static inline void quicklist_free(int nr, void (*dtor)(void *), void *pp)
--- 73,83 ----
  		return;
  	}

+ 	q = &get_cpu_var_locked(quicklist, &cpu)[nr];
  	*(void **)p = q->page;
  	q->page = p;
  	q->nr_pages++;
+ 	put_cpu_var_locked(quicklist, cpu);
  }

  static inline void quicklist_free(int nr, void (*dtor)(void *), void *pp)
************

Darn, that was my fault. OK, will release a -rt2 soon.

Thanks,

-- Steve
