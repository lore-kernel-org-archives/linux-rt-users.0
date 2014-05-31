From: Pavel Vasilyev <pavel@pavlinux.ru>
Subject: Mainline patch-3.14.4-5.xz
Date: Sun, 01 Jun 2014 03:27:14 +0400
Message-ID: <538A6552.3050501@pavlinux.ru>
Reply-To: pavel@pavlinux.ru
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
To: RT <linux-rt-users@vger.kernel.org>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from imp02.mtu.ru ([62.5.255.19]:57633 "EHLO imp02.mtu.ru"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753046AbaEaX2I (ORCPT <rfc822;linux-rt-users@vger.kernel.org>);
	Sat, 31 May 2014 19:28:08 -0400
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

Vanila patch:

--- a/include/linux/thread_info.h
+++ b/include/linux/thread_info.h
@@ -118,8 +118,6 @@ static inline __deprecated void set_need_resched(void)
           */
  }

-#define tif_need_resched() test_thread_flag(TIF_NEED_RESCHED)
-
  #if defined TIF_RESTORE_SIGMASK && !defined HAVE_SET_RESTORE_SIGMASK
  /*
   * An arch can define its own version of set_restore_sigmask() to get the

RT Code (same file):


#ifdef CONFIG_PREEMPT_LAZY
#define tif_need_resched() (test_thread_flag(TIF_NEED_RESCHED) || \
                 test_thread_flag(TIF_NEED_RESCHED_LAZY))
#define tif_need_resched_now() (test_thread_flag(TIF_NEED_RESCHED))
#define tif_need_resched_lazy() (test_thread_flag(TIF_NEED_RESCHED_LAZY))

#else
#define tif_need_resched() (test_thread_flag(TIF_NEED_RESCHED))
#define tif_need_resched_now() (test_thread_flag(TIF_NEED_RESCHED))
#define tif_need_resched_lazy() (0)

#endif

1 out of 1 hunk ignored -- saving rejects to file include/linux/thread_info.h.rej


What to do? :)

-- 

                                                          Pavel.
