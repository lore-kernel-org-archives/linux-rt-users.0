From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Subject: Re: [PATCH] consolidate spin_lock/unlock waiting with
 spin_unlock_wait
Date: Sun, 15 Dec 2013 14:44:22 +0100
Message-ID: <20131215134422.GD31090@linutronix.de>
References: <20131202044126.GA18399@opentech.at>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: linux-rt-users@vger.kernel.org,
	Thomas Gleixner <tglx@linutronix.de>
To: Nicholas Mc Guire <der.herr@hofr.at>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from www.linutronix.de ([62.245.132.108]:55577 "EHLO
	Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754085Ab3LONoX (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Sun, 15 Dec 2013 08:44:23 -0500
Content-Disposition: inline
In-Reply-To: <20131202044126.GA18399@opentech.at>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

* Nicholas Mc Guire | 2013-12-02 05:41:26 [+0100]:

>>From 19ac7e10b38947dbd8d731a13243fb28490f5ab4 Mon Sep 17 00:00:00 2001
>From: Nicholas Mc Guire <der.herr@hofr.at>
>Date: Sun, 1 Dec 2013 23:03:52 -0500
>Subject: [PATCH] consolidate spin_lock/unlock waiting with spin_unlock_wait
>
> since:
> commit c2f21ce2e31286a0a32f8da0a7856e9ca1122ef3
> Author: Thomas Gleixner <tglx@linutronix.de>
> Date:   Wed Dec 2 20:02:59 2009 +0100
>
> include/linux/spinlock.h includes spin_unlock_wait() to wait for a concurrent
> holder of a lock. this patch just moves over to that API. spin_unlock_wait
> covers both raw_spinlock_t and spinlock_t so it should be safe here as well.
> the added rt-variant of read_seqbegin in include/linux/seqlock.h that is being
> modified, was introduced by patch:
>   seqlock-prevent-rt-starvation.patch
>
> patch is on top of 3.12.1-rt4
>
> behavior should be unchanged.

Applied. One note: you indented the comment by one space. It looked to
me like cited to complete commit. Please do commit-id ("one line
description) and avoid the one line space at the begin of everyline if
possible.

Sebastian
