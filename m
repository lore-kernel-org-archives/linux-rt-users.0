From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Subject: Re: [PATCH v3.14-rt] mips: rt: Replace pagefault_* to raw version
Date: Tue, 17 Feb 2015 14:54:04 +0100
Message-ID: <20150217135404.GM26177@linutronix.de>
References: <1415317527-15266-1-git-send-email-yang.shi@windriver.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: tglx@linutronix.de, rostedt@goodmis.org,
	linux-rt-users@vger.kernel.org, paul.gortmaker@windriver.com
To: Yang Shi <yang.shi@windriver.com>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from www.linutronix.de ([62.245.132.108]:43796 "EHLO
	Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932982AbbBQNyI (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Tue, 17 Feb 2015 08:54:08 -0500
Content-Disposition: inline
In-Reply-To: <1415317527-15266-1-git-send-email-yang.shi@windriver.com>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

* Yang Shi | 2014-11-06 15:45:27 [-0800]:

>In k{un}map_coherent, pagefault_disable and pagefault_enable are called
>respectively, but k{un}map_coherent needs preempt disabled according to
>commit f8829caee311207afbc882794bdc5aa0db5caf33 ("[MIPS] Fix aliasing bug
>in copy_to_user_page / copy_from_user_page") to avoid dcache alias on COW.
>
>k{un}map_coherent are just called when cpu_has_dc_aliases == 1 with VIPT cache.
>However, actually, the most modern MIPS processors have PIPT dcache without
>dcache alias issue. In such case, k{un}map_atomic will be called with preempt
>enabled.
>
>To fix this, we replace pagefault_* to raw version in k{un}map_coherent, which
>disables preempt, otherwise the following kernel panic may be caught:

And this works? One thing that confuses me is that you talk about kmap()
while there is no HIGHMEM support in MIPS. The other thing is that I had
a longson a while ago and I don't remember this. But it could have no
dcache alias problem :)

Your registers look 64bit wide so this highpage thingy is probably
just to deal with the dcache alias. So if this is the only problem you
have I would be happy to take your patch. Could you please rebase it
against v3.18? The code changed slightly and I would not want to touch
and break it :)

Sebastian
