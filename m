From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Subject: Re: [PATCH 1/4] migrate_disable pushd down in spin_trylock
Date: Sun, 15 Dec 2013 15:29:00 +0100
Message-ID: <20131215142900.GE31090@linutronix.de>
References: <20131130030628.GB8101@opentech.at>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: linux-rt-users@vger.kernel.org
To: Nicholas Mc Guire <der.herr@hofr.at>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from www.linutronix.de ([62.245.132.108]:55666 "EHLO
	Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750867Ab3LOO3B (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Sun, 15 Dec 2013 09:29:01 -0500
Content-Disposition: inline
In-Reply-To: <20131130030628.GB8101@opentech.at>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

* Nicholas Mc Guire | 2013-11-30 04:06:28 [+0100]:

>>From 7b60d163555d701b88f463d12ba62c6ceb61fb66 Mon Sep 17 00:00:00 2001
>From: Nicholas Mc Guire <der.herr@hofr.at>
>Date: Fri, 29 Nov 2013 00:21:59 -0500
>Subject: [PATCH 4/4] migrate_disable pushd down in rt_write_trylock_irqsave
>
>+++ b/kernel/rt.c
>@@ -196,10 +196,9 @@ int __lockfunc rt_write_trylock_irqsave(rwlock_t *rwlock, unsigned long *flags)

It looks like you loaded the wrong file here. Email's subject line does
not match patch's and it seems be to be really the same one as in 4/4.

Sebastian
