From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Subject: Re: [4.1.2-rt1 PATCH] include/linux/pid.h: fix build error
Date: Wed, 22 Jul 2015 13:32:03 +0200
Message-ID: <20150722113203.GA8704@linutronix.de>
References: <1437497036-26111-1-git-send-email-grygorii.strashko@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: linux-rt-users@vger.kernel.org, Sekhar Nori <nsekhar@ti.com>,
	Grygorii Strashko <Grygorii.Strashko@linaro.org>
To: Grygorii Strashko <grygorii.strashko@ti.com>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from www.linutronix.de ([62.245.132.108]:38116 "EHLO
	Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S933788AbbGVLcF (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Wed, 22 Jul 2015 07:32:05 -0400
Content-Disposition: inline
In-Reply-To: <1437497036-26111-1-git-send-email-grygorii.strashko@ti.com>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

* Grygorii Strashko | 2015-07-21 19:43:56 [+0300]:

>From: Grygorii Strashko <Grygorii.Strashko@linaro.org>
>
>This patch fixes build error:
>  CC      kernel/pid_namespace.o
>In file included from kernel/pid_namespace.c:11:0:
>include/linux/pid.h: In function 'get_pid':
>include/linux/pid.h:78:3: error: implicit declaration of function 'atomic_inc' [-Werror=implicit-function-declaration]
>   atomic_inc(&pid->count);
>   ^
>which happens when
> CONFIG_PROVE_LOCKING=n
> CONFIG_DEBUG_SPINLOCK=n
> CONFIG_DEBUG_MUTEXES=n
> CONFIG_DEBUG_LOCK_ALLOC=n
>
>Signed-off-by: Grygorii Strashko <Grygorii.Strashko@linaro.org>

Applied, thanks

Sebastian
