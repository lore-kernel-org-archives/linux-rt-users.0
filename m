From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Subject: Re: [PATCH]Fix the Compiling failed problem with the default
 arch/x86/configs/x86_64_defconfig(3.14-rt1)
Date: Fri, 9 May 2014 16:57:45 +0200
Message-ID: <20140509145745.GI29014@linutronix.de>
References: <20140411185739.GA6644@linutronix.de>
 <5362AF65.50202@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: linux-rt-users <linux-rt-users@vger.kernel.org>,
	Nicholas Mc Guire <der.herr@hofr.at>
To: "eagle.rtlinux" <eagle.rtlinux@gmail.com>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from www.linutronix.de ([62.245.132.108]:36851 "EHLO
	Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755156AbaEIO5r convert rfc822-to-8bit (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Fri, 9 May 2014 10:57:47 -0400
Content-Disposition: inline
In-Reply-To: <5362AF65.50202@gmail.com>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

* eagle.rtlinux | 2014-05-02 04:32:37 [+0800]:

>Hello,
Hi,

>linux-3.14/kernel/softirq.c: In function =E2=80=98__local_bh_enable_ip=
=E2=80=99:
>linux-3.14/kernel/softirq.c:328:2: error: implicit declaration of fu
>nction =E2=80=98preempt_check_resched=E2=80=99
>[-Werror=3Dimplicit-function-declaration]
=E2=80=A6
>diff --git a/include/linux/preempt.h b/include/linux/preempt.h
>index 116af6a..7d4f557 100644
>--- a/include/linux/preempt.h
>+++ b/include/linux/preempt.h
>@@ -155,6 +155,7 @@ do { \
> #define preempt_enable_no_resched_notrace()    barrier()
> #define preempt_enable_notrace()        barrier()
> #define preempt_check_resched_rt()        barrier()
>+#define preempt_check_resched()  barrier()
>

I fixed it differently. Somehow I removed preempt_check_resched() in th=
e
preempt-lazy-support.patch for no obvious reason. Upstream has this
defined as "do while { }" and now I keep this as is instead of removing
this define.
Thanks for reporting.

Sebastian
--
To unsubscribe from this list: send the line "unsubscribe linux-rt-user=
s" in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
