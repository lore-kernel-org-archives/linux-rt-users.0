From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Subject: Re: [PATCH -rt] kvm,rt: change async pagefault code locking for
 rt-preempt
Date: Tue, 29 Mar 2016 18:13:46 +0200
Message-ID: <20160329161346.GE13334@linutronix.de>
References: <20160318142052.0605524d@annuminas.surriel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: linux-rt-users@vger.kernel.org, williams@redhat.com,
	srostedt@redhat.com
To: Rik van Riel <riel@redhat.com>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from www.linutronix.de ([62.245.132.108]:60952 "EHLO
	Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752082AbcC2QNs (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Tue, 29 Mar 2016 12:13:48 -0400
Content-Disposition: inline
In-Reply-To: <20160318142052.0605524d@annuminas.surriel.com>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

* Rik van Riel | 2016-03-18 14:20:52 [-0400]:

>--- a/arch/x86/kernel/kvm.c
>+++ b/arch/x86/kernel/kvm.c
>@@ -36,6 +36,7 @@
> #include <linux/kprobes.h>
> #include <linux/debugfs.h>
> #include <linux/nmi.h>
>+#include <linux/wait-simple.h>

This does not work since v4.4.4-rt11:

|arch/x86/kernel/kvm.c:39:31: fatal error: linux/wait-simple.h: No such file or directory

In -rt11 I pulled in the swait queue which was in the -tip tree and is
now part of v4.6-rc1. So if you could please refresh the patch and
resend it then I will be able pick it up for the next -RT release and
the KVM maintainer will be able to pick it up, too. 

Sebastian
