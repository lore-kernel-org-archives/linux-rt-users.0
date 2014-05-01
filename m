From: "eagle.rtlinux" <eagle.rtlinux@gmail.com>
Subject: [PATCH]Fix the Compiling failed problem with the default arch/x86/configs/x86_64_defconfig(3.14-rt1)
Date: Fri, 02 May 2014 04:32:37 +0800
Message-ID: <5362AF65.50202@gmail.com>
References: <20140411185739.GA6644@linutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8;
	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
	Nicholas Mc Guire <der.herr@hofr.at>
To: linux-rt-users <linux-rt-users@vger.kernel.org>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from mail-yk0-f178.google.com ([209.85.160.178]:47211 "EHLO
	mail-yk0-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750845AbaEAMjJ (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Thu, 1 May 2014 08:39:09 -0400
Received: by mail-yk0-f178.google.com with SMTP id 200so2615831ykr.23
        for <linux-rt-users@vger.kernel.org>; Thu, 01 May 2014 05:39:08 -0700 (PDT)
In-Reply-To: <20140411185739.GA6644@linutronix.de>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>


Hello,

After applied the 3.14-rt1 patch set, one compiling error occurred.

Compile failed with the default arch/x86/configs/x86_64_defconfig on my=
=20
laptop(Intel(R) Core(TM) i5-3230M CPU).
The configure command is 'make defconfig'.
Error messages:
linux-3.14/kernel/softirq.c: In function =E2=80=98__local_bh_enable_ip=E2=
=80=99:
linux-3.14/kernel/softirq.c:328:2: error: implicit declaration of fu   =
=20
nction =E2=80=98preempt_check_resched=E2=80=99 [-Werror=3Dimplicit-func=
tion-declaration]
cc1: some warnings being treated as errors

The reason is when configured with 'CONFIG_PREEMPT_VOLUNTARY', the=20
compiler can not find the definiation of function preempt_check_resched=
=2E
This  patch is supplied to fix this problem.

Signed-off-by: Yang Honggang <eagle.rtlinux@gmail.com>
---
  include/linux/preempt.h |    1 +
  1 file changed, 1 insertion(+)

diff --git a/include/linux/preempt.h b/include/linux/preempt.h
index 116af6a..7d4f557 100644
--- a/include/linux/preempt.h
+++ b/include/linux/preempt.h
@@ -155,6 +155,7 @@ do { \
  #define preempt_enable_no_resched_notrace()    barrier()
  #define preempt_enable_notrace()        barrier()
  #define preempt_check_resched_rt()        barrier()
+#define preempt_check_resched()  barrier()

  #endif /* CONFIG_PREEMPT_COUNT */

--=20
1.7.10.4


Best regards,

Yang Honggang
--
To unsubscribe from this list: send the line "unsubscribe linux-rt-user=
s" in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
