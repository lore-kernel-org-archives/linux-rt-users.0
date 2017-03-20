From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Subject: Re: Radeon driver hang with 4.9.0-rt
Date: Mon, 20 Mar 2017 22:18:16 +0100
Message-ID: <20170320211815.qjvrty7mtmof343w@linutronix.de>
References: <CAObZbXS1AsJ7MPfNacZLnCvzCzmFcpyHDNge9sOd-AhyB1CbvQ@mail.gmail.com>
 <20170302211013.GC2723@jcartwri.amer.corp.natinst.com>
 <c5ac6b81-6b61-2923-afc7-c594a5ab34bb@lebib.org>
 <20170306173353.GJ29100@jcartwri.amer.corp.natinst.com>
 <26d68eb9-746d-26ae-cbfe-28a8b4e5a3e6@lebib.org>
 <20170306190707.GL29100@jcartwri.amer.corp.natinst.com>
 <e1193ceb-af77-b561-5b84-c08915e7859e@lebib.org>
 <fb9e1287-7042-9b46-1730-1e622eac99cc@lebib.org>
 <20170317181219.5vr4obmtiod7euuk@linutronix.de>
 <06ee1435-7fb6-3cf5-c305-96a020665c01@lebib.org>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="ry2nmsdelq4guhqp"
Cc: Julia Cartwright <julia@ni.com>,
        Daniel Vidal <danielvidalchornet@gmail.com>,
        Pankaj Gupta <pagupta@redhat.com>,
        linux-rt-users@vger.kernel.org
To: Wargreen <wargreen@lebib.org>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from Galois.linutronix.de ([146.0.238.70]:40429 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1755799AbdCTVS1 (ORCPT
        <rfc822;linux-rt-users@vger.kernel.org>);
        Mon, 20 Mar 2017 17:18:27 -0400
Content-Disposition: inline
In-Reply-To: <06ee1435-7fb6-3cf5-c305-96a020665c01@lebib.org>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>


--ry2nmsdelq4guhqp
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On 2017-03-19 15:29:17 [+0100], Wargreen wrote:
> Hello, thanks for your interest !
Hi,

> On 17/03/2017 19:12, Sebastian Andrzej Siewior wrote:
> > Wargreen, how long does it take to trigger this issue for you?
> > What is it, that you do to trigger this? What is _exactly_ the thing you
> > do?
> The common point each time it's an action with the GUI, for exemple
> trigger the gnome's hot corner or launch a 3D game. This time just
> log-in into my gnome session, and it hang when the fade of the desktop
> should happen. (sorry for my english)

So I have one body where it triggers from time to time and it triggers
less likely with debug. You on the other hand have something to trigger
it, good. Maybe I should try the 3D Game thing because gnome is working
fine here=E2=80=A6

> > Could you please additionally also do
> > 	echo t > /proc/sysrq-trigger
> >
> > once this happens? And please make sure your dmesg buffer big enough to
> > handle the output (and if not, please increase CONFIG_LOG_BUF_SHIFT).
> Attached, the log with sysrq "d", "t" and the /proc/PID/stack output.

there d but I kind of miss t.

> > It seems that the first logs you uploaded kalaj.darktech.org had to
> > frame pointers enabled but in the recent logs you included here in this
> > thread you had them enabled. Good. Please keep them enabled.
> If needed for debuging, i can re-build the kernel with others options.

|1 lock held by gnome-shell/1993:
| #0:  (&rdev->exclusive_lock){++++.+}, at: [<ffffffffa6ef3710>] rt_down_re=
ad+0x10/0x20
|2 locks held by Xorg/2230:
| #0:  (&rdev->exclusive_lock){++++.+}, at: [<ffffffffa6ef3710>] rt_down_re=
ad+0x10/0x20
| #1:  (&rdev->pm.mclk_lock){++++++}, at: [<ffffffffa6ef3710>] rt_down_read=
+0x10/0x20
|2 locks held by gnome-shell/2448:
| #0:  (&rdev->pm.mclk_lock){++++++}, at: [<ffffffffa6ef3710>] rt_down_read=
+0x10/0x20
| #1:  (reservation_ww_class_mutex){+.+.+.}, at: [<ffffffffc08b47b0>] ttm_b=
o_vm_fault+0x60/0x530 [ttm]

1993 wants exclusive_lock and blocks on it.
2230 has exclusive_lock and blocks on mclk_lock.
2448 has mclk_lock nad reservation_ww_class_mutex. I *think* that one
waits for an IRQ from the GPU which is not coming. My guess is, that it
sits somewhere in ttm_bo_vm_fault_idle() and waits for wakeup.
If this triggers so easy, could you please check if the interrupt
counter for radeon in /proc/interrupts increases after the accident?

Could you please recompile the kernel with CONFIG_ENABLE_DEFAULT_TRACERS
enable and the patch attached? The patch should fix one trace event for
RT, add the flags argument to the trace and disable the trace once the
first "hung" is sent by the kernel.
After boot please enable the following trace events:

  echo 1 > /sys/kernel/debug/tracing/events/fence/enable
  echo 1 > /sys/kernel/debug/tracing/events/radeon/enable
  echo 1 > /sys/kernel/debug/tracing/events/sched/sched_switch/enable=20
  echo 1 > /sys/kernel/debug/tracing/events/sched/sched_wakeup/enable=20
 =20
  echo 16384 > /sys/kernel/debug/tracing/buffer_size_kb=20
  echo 60 > /proc/sys/kernel/hung_task_timeout_secs

The last two are for tuning. I decreased the hung-task-time out from 120
to 60 secs and increased the tracing buffer to 16MiB. I hope that is
enough. One this triggers, please send the dmesg output with
sysrq-trigger t (the syslog file is just fine) and the output of
/sys/kernel/debug/tracing/trace. That fine will be huge so please
compress it first and it might be best to leave it for download and send
it to the list.

Sebastian

--ry2nmsdelq4guhqp
Content-Type: text/x-diff; charset=utf-8
Content-Disposition: attachment; filename="radeon_debug.patch"

diff --git a/drivers/gpu/drm/radeon/radeon.h b/drivers/gpu/drm/radeon/radeon.h
index 1b0dcad916b0..1e0623a93dce 100644
--- a/drivers/gpu/drm/radeon/radeon.h
+++ b/drivers/gpu/drm/radeon/radeon.h
@@ -395,6 +395,7 @@ int radeon_fence_wait_any(struct radeon_device *rdev,
 struct radeon_fence *radeon_fence_ref(struct radeon_fence *fence);
 void radeon_fence_unref(struct radeon_fence **fence);
 unsigned radeon_fence_count_emitted(struct radeon_device *rdev, int ring);
+unsigned radeon_fence_count_emitted_trace(struct radeon_device *rdev, int ring);
 bool radeon_fence_need_sync(struct radeon_fence *fence, int ring);
 void radeon_fence_note_sync(struct radeon_fence *fence, int ring);
 static inline struct radeon_fence *radeon_fence_later(struct radeon_fence *a,
diff --git a/drivers/gpu/drm/radeon/radeon_fence.c b/drivers/gpu/drm/radeon/radeon_fence.c
index 7ef075acde9c..4da354eb6ed6 100644
--- a/drivers/gpu/drm/radeon/radeon_fence.c
+++ b/drivers/gpu/drm/radeon/radeon_fence.c
@@ -745,6 +745,23 @@ unsigned radeon_fence_count_emitted(struct radeon_device *rdev, int ring)
 	return (unsigned)emitted;
 }
 
+unsigned radeon_fence_count_emitted_trace(struct radeon_device *rdev, int ring)
+{
+	uint64_t emitted;
+
+	/* We are not protected by ring lock when reading the last sequence
+	 * but it's ok to report slightly wrong fence count here.
+	 */
+	emitted = rdev->fence_drv[ring].sync_seq[ring]
+		- atomic64_read(&rdev->fence_drv[ring].last_seq);
+	/* to avoid 32bits warp around */
+	if (emitted > 0x10000000) {
+		emitted = 0x10000000;
+	}
+	return (unsigned)emitted;
+}
+
+
 /**
  * radeon_fence_need_sync - do we need a semaphore
  *
diff --git a/drivers/gpu/drm/radeon/radeon_trace.h b/drivers/gpu/drm/radeon/radeon_trace.h
index fdce4062901f..1a063ef3b309 100644
--- a/drivers/gpu/drm/radeon/radeon_trace.h
+++ b/drivers/gpu/drm/radeon/radeon_trace.h
@@ -38,7 +38,7 @@ TRACE_EVENT(radeon_cs,
 	    TP_fast_assign(
 			   __entry->ring = p->ring;
 			   __entry->dw = p->chunk_ib->length_dw;
-			   __entry->fences = radeon_fence_count_emitted(
+			   __entry->fences = radeon_fence_count_emitted_trace(
 				p->rdev, p->ring);
 			   ),
 	    TP_printk("ring=%u, dw=%u, fences=%u",
diff --git a/include/trace/events/fence.h b/include/trace/events/fence.h
index d6dfa05ba322..ed1be87c9834 100644
--- a/include/trace/events/fence.h
+++ b/include/trace/events/fence.h
@@ -59,6 +59,7 @@ DECLARE_EVENT_CLASS(fence,
 		__string(timeline, fence->ops->get_timeline_name(fence))
 		__field(unsigned int, context)
 		__field(unsigned int, seqno)
+		__field(unsigned long, flags)
 	),
 
 	TP_fast_assign(
@@ -66,11 +67,12 @@ DECLARE_EVENT_CLASS(fence,
 		__assign_str(timeline, fence->ops->get_timeline_name(fence))
 		__entry->context = fence->context;
 		__entry->seqno = fence->seqno;
+		__entry->flags = fence->flags;
 	),
 
-	TP_printk("driver=%s timeline=%s context=%u seqno=%u",
+	TP_printk("driver=%s timeline=%s context=%u seqno=%u fl=%lx",
 		  __get_str(driver), __get_str(timeline), __entry->context,
-		  __entry->seqno)
+		  __entry->seqno, __entry->flags)
 );
 
 DEFINE_EVENT(fence, fence_emit,
diff --git a/kernel/hung_task.c b/kernel/hung_task.c
index 2b59c82cc3e1..6798bf80852a 100644
--- a/kernel/hung_task.c
+++ b/kernel/hung_task.c
@@ -97,6 +97,7 @@ static void check_hung_task(struct task_struct *t, unsigned long timeout)
 	}
 
 	trace_sched_process_hang(t);
+	tracing_off();
 
 	if (!sysctl_hung_task_warnings && !sysctl_hung_task_panic)
 		return;

--ry2nmsdelq4guhqp--
