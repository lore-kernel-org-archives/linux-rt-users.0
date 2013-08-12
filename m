From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Subject: Re: 3.8.10-rt1 not compiling
Date: Mon, 12 Aug 2013 13:44:47 +0200
Message-ID: <20130812114447.GE23040@linutronix.de>
References: <loom.20130809T204344-6@post.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: linux-rt-users@vger.kernel.org
To: matthew henschel <henschel@capaccess.org>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from www.linutronix.de ([62.245.132.108]:43896 "EHLO
	Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755160Ab3HLLos (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Mon, 12 Aug 2013 07:44:48 -0400
Content-Disposition: inline
In-Reply-To: <loom.20130809T204344-6@post.gmane.org>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

* matthew henschel | 2013-08-09 18:46:15 [+0000]:

>probably a simple fix:
>[output snipped]
>  LD      vmlinux.o
>  MODPOST vmlinux.o
>  GEN     .version
>  CHK     include/generated/compile.h
>  UPD     include/generated/compile.h
>  CC      init/version.o
>  LD      init/built-in.o
>kernel/built-in.o: In function `__tick_nohz_idle_enter':
>tick-sched.c:(.text+0x40db8): undefined reference to
>`softirq_check_pending_idle'
>make: *** [vmlinux] Error 1
>Exit 2

Can you clean your tree and recompile? There seems to be something out
of sync. Both __tick_nohz_idle_enter() and softirq_check_pending_idle()
are behind CONFIG_NO_HZ_COMMON so it is unlikely that in a normal
build you have one symbol but not the other.
I took your config file, removed radeon/R200_cp.bin from it and it built
without a problem.

Sebastian
