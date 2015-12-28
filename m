From: Grygorii Strashko <grygorii.strashko@ti.com>
Subject: [4.4-rc6-rt1 PATCH 2/2] kernel/time/timer.c: UP: fix undefined reference to `del_timer_sync'
Date: Mon, 28 Dec 2015 20:00:11 +0200
Message-ID: <1451325611-21678-3-git-send-email-grygorii.strashko@ti.com>
References: <1451325611-21678-1-git-send-email-grygorii.strashko@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: <linux-kernel@vger.kernel.org>, Sekhar Nori <nsekhar@ti.com>,
	Grygorii Strashko <grygorii.strashko@ti.com>
To: <bigeasy@linutronix.de>, <linux-rt-users@vger.kernel.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1451325611-21678-1-git-send-email-grygorii.strashko@ti.com>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-rt-users.vger.kernel.org

This patch fixes below build errors in case SMP=n:

drivers/built-in.o: In function `fbcon_del_cursor_timer':
/home/x0174654/kernel.org/linux-master/linux/drivers/video/console/fbcon.c:433: undefined reference to `del_timer_sync'
drivers/built-in.o: In function `sysrq_disconnect':
/home/x0174654/kernel.org/linux-master/linux/drivers/tty/sysrq.c:928: undefined reference to `del_timer_sync'
drivers/built-in.o: In function `kd_mksound':
/home/x0174654/kernel.org/linux-master/linux/drivers/tty/vt/keyboard.c:256: undefined reference to `del_timer_sync'
drivers/built-in.o: In function `do_blank_screen':
/home/x0174654/kernel.org/linux-master/linux/drivers/tty/vt/vt.c:3842: undefined reference to `del_timer_sync'
drivers/built-in.o: In function `univ8250_release_irq':
/home/x0174654/kernel.org/linux-master/linux/drivers/tty/serial/8250/8250_core.c:365: undefined reference to `del_timer_sync'
drivers/built-in.o:/home/x0174654/kernel.org/linux-master/linux/drivers/base/power/wakeup.c:114: more undefined references to `del_timer_sync' follow

Signed-off-by: Grygorii Strashko <grygorii.strashko@ti.com>
---
 kernel/time/timer.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/kernel/time/timer.c b/kernel/time/timer.c
index c3314fc..a460cbb 100644
--- a/kernel/time/timer.c
+++ b/kernel/time/timer.c
@@ -1118,7 +1118,7 @@ int try_to_del_timer_sync(struct timer_list *timer)
 }
 EXPORT_SYMBOL(try_to_del_timer_sync);
 
-#ifdef CONFIG_SMP
+#if defined(CONFIG_SMP) || defined(CONFIG_PREEMPT_RT_FULL)
 /**
  * del_timer_sync - deactivate a timer and wait for the handler to finish.
  * @timer: the timer to be deactivated
-- 
2.6.4
