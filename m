From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Subject: Re: [4.1.2-rt1] build failure
Date: Mon, 20 Jul 2015 17:38:03 +0200
Message-ID: <20150720153803.GB9559@linutronix.de>
References: <55A931A2.9040807@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: linux-rt-users@vger.kernel.org, Sekhar Nori <nsekhar@ti.com>
To: Grygorii Strashko <grygorii.strashko@ti.com>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from www.linutronix.de ([62.245.132.108]:56373 "EHLO
	Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752940AbbGTPiF (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Mon, 20 Jul 2015 11:38:05 -0400
Content-Disposition: inline
In-Reply-To: <55A931A2.9040807@ti.com>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

* Grygorii Strashko | 2015-07-17 19:47:30 [+0300]:

>  CC      kernel/pid_namespace.o
>In file included from kernel/pid_namespace.c:11:0:
>include/linux/pid.h: In function 'get_pid':
>include/linux/pid.h:78:3: error: implicit declaration of function 'atomic_inc' [-Werror=implicit-function-declaration]
>   atomic_inc(&pid->count);
>   ^
this is one of the patches I've thrown away because it looked not
needed. On vanilla this header gets sucked in via
include/linux/spinlock.h but on -RT we don't need it and we get this.

>The below diff fixes an issue for me:
>diff --git a/include/linux/pid.h b/include/linux/pid.h
>index 23705a53..2cc64b7 100644
>--- a/include/linux/pid.h
>+++ b/include/linux/pid.h
>@@ -2,6 +2,7 @@
> #define _LINUX_PID_H
> 
> #include <linux/rcupdate.h>
>+#include <linux/atomic.h>
> 
> enum pid_type
> {

If you manage so send me this as  a proper patch then I could include it
into the patchset.

Sebastian
