From: Mariusz Kozlowski <m.kozlowski@tuxland.pl>
Subject: Re: 2.6.24-rc7-rt1: macro "put_cpu_var" passed 2 arguments, but takes just 1
Date: Sun, 13 Jan 2008 20:53:21 +0100
Message-ID: <200801132053.22830.m.kozlowski@tuxland.pl>
References: <1200250801.9190.7.camel@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-2"
Content-Transfer-Encoding: 7bit
Cc: LKML <linux-kernel@vger.kernel.org>,
	RT <linux-rt-users@vger.kernel.org>, Ingo Molnar <mingo@elte.hu>,
	Thomas Gleixner <tglx@linutronix.de>
To: Steven Rostedt <rostedt@goodmis.org>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from xdsl-664.zgora.dialog.net.pl ([81.168.226.152]:4737 "EHLO
	tuxland.pl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752881AbYAMTx0 (ORCPT <rfc822;linux-rt-users@vger.kernel.org>);
	Sun, 13 Jan 2008 14:53:26 -0500
In-Reply-To: <1200250801.9190.7.camel@localhost.localdomain>
Content-Disposition: inline
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

Hello,

> We are pleased to announce the 2.6.24-rc7-rt1 tree, which can be
> downloaded from the location:
> 
>   http://rt.et.redhat.com/download/

  CC      arch/x86/mm/init_32.o
In file included from include/asm-generic/tlb.h:17,
                 from include/asm/tlb.h:9,
                 from arch/x86/mm/init_32.c:43:
include/linux/quicklist.h:73:28: error: macro "put_cpu_var" passed 2 arguments, but takes just 1
In file included from include/asm-generic/tlb.h:17,
                 from include/asm/tlb.h:9,
                 from arch/x86/mm/init_32.c:43:
include/linux/quicklist.h: In function '__quicklist_free':
include/linux/quicklist.h:73: error: 'put_cpu_var' undeclared (first use in this function)
include/linux/quicklist.h:73: error: (Each undeclared identifier is reported only once
include/linux/quicklist.h:73: error: for each function it appears in.)
make[1]: *** [arch/x86/mm/init_32.o] Error 1
make: *** [arch/x86/mm] Error 2

--- linux-2.6.24-rc7-rt1.orig/include/linux/quicklist.h 2008-01-11 21:16:22.000000000 -0500
+++ linux-2.6.24-rc7-rt1/include/linux/quicklist.h      2008-01-11 21:18:08.000000000 -0500
@@ -18,7 +18,7 @@ struct quicklist {
        int nr_pages;
 };

[... snip ...]

@@ -56,12 +64,13 @@ static inline void __quicklist_free(int 
        struct page *page)
 {
        struct quicklist *q;
+       int cpu;

-       q = &get_cpu_var(quicklist)[nr];
+       q = &get_cpu_var_locked(quicklist, &cpu)[nr];
        *(void **)p = q->page;
        q->page = p;
        q->nr_pages++;
-       put_cpu_var(quicklist);
+       put_cpu_var(quicklist, cpu); <------------- should that be put_cpu_var_locked()?
 }

Regards,

	Mariusz
