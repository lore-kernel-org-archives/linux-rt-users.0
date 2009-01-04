From: Adam Sampson <ats-G+91BasbrijYtjvyW6yDsg@public.gmane.org>
Subject: [LAU] [PATCH] [RT] tasklets: fix typo in tasklet_hi_action
Date: Sun, 4 Jan 2009 15:20:58 +0000
Message-ID: <20090104152053.GA4867@cartman.at.offog.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Cc: linux-audio-user-cunTk1MwBs/CEJeg2xFRV2D2FQJk+8+b@public.gmane.org
To: linux-rt-users-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
Return-path: <linux-audio-user-bounces-cunTk1MwBs/CEJeg2xFRV2D2FQJk+8+b@public.gmane.org>
Content-Disposition: inline
List-Unsubscribe: <http://lists.linuxaudio.org/mailman/listinfo/linux-audio-user>,
	<mailto:linux-audio-user-request-cunTk1MwBs/CEJeg2xFRV2D2FQJk+8+b@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.linuxaudio.org/pipermail/linux-audio-user>
List-Post: <mailto:linux-audio-user-cunTk1MwBs/CEJeg2xFRV2D2FQJk+8+b@public.gmane.org>
List-Help: <mailto:linux-audio-user-request-cunTk1MwBs/CEJeg2xFRV2D2FQJk+8+b@public.gmane.org?subject=help>
List-Subscribe: <http://lists.linuxaudio.org/mailman/listinfo/linux-audio-user>,
	<mailto:linux-audio-user-request-cunTk1MwBs/CEJeg2xFRV2D2FQJk+8+b@public.gmane.org?subject=subscribe>
Sender: linux-audio-user-bounces-cunTk1MwBs/CEJeg2xFRV2D2FQJk+8+b@public.gmane.org
Errors-To: linux-audio-user-bounces-cunTk1MwBs/CEJeg2xFRV2D2FQJk+8+b@public.gmane.org
List-Id: linux-rt-users.vger.kernel.org

[l-a-u CCed because we've been talking about this problem there
recently, and that's what prodded me to do the bisection to track it
down... fortunately the -rt8 to -rt9 interdiff was pretty small!]

Subject: [PATCH] [RT] tasklets: fix typo in tasklet_hi_action

Fix a typo in tasklet_hi_action -- using the wrong tasklet list when removing
actions.

This appears to be what was causing the ALSA sequencer device not to work in
2.6.26 with the RT patch: the sequencer was flaky in -rt1 to -rt8, and just
hung in -rt9 and later, after tasklets-fix-tasklet_hi_schedule.patch which
fixed the same typo when adding to the list. I guess that's because before -rt9
the actions were going onto the wrong list, whereas after -rt9 they were being
lost entirely once the first one had been performed. It seems happy now,
anyway.

Signed-off-by: Adam Sampson <ats-G+91BasbrijYtjvyW6yDsg@public.gmane.org>

--- linux-2.6.26/kernel/softirq.c_orig	2009-01-04 14:41:06.000000000 +0000
+++ linux-2.6.26/kernel/softirq.c	2009-01-04 14:41:49.000000000 +0000
@@ -657,7 +657,7 @@
 	local_irq_disable();
 	list = __get_cpu_var(tasklet_hi_vec).head;
 	__get_cpu_var(tasklet_hi_vec).head = NULL;
-	__get_cpu_var(tasklet_hi_vec).tail = &__get_cpu_var(tasklet_vec).head;
+	__get_cpu_var(tasklet_hi_vec).tail = &__get_cpu_var(tasklet_hi_vec).head;
 	local_irq_enable();
 
 	__tasklet_action(a, list);

-- 
Adam Sampson <ats-G+91BasbrijYtjvyW6yDsg@public.gmane.org>                         <http://offog.org/>
