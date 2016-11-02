From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Subject: Re: Making rcu_normal=1 in RT
Date: Wed, 2 Nov 2016 17:05:47 +0100
Message-ID: <20161102160547.uscnkzhw7we3hucn@linutronix.de>
References: <20161014092050.GW29518@linux.vnet.ibm.com>
 <20161016044420-mutt-send-email-mst@kernel.org>
 <20161016112846.GR29518@linux.vnet.ibm.com>
 <20161031173852.a3ji7hhgjis5l3u4@linutronix.de>
 <20161031181543.GN3716@linux.vnet.ibm.com>
 <20161101003510-mutt-send-email-mst@kernel.org>
 <20161101021941.GP3716@linux.vnet.ibm.com>
 <20161101043508-mutt-send-email-mst@kernel.org>
 <20161101025240.GR3716@linux.vnet.ibm.com>
 <20161101051400-mutt-send-email-mst@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>,
        Julia Cartwright <julia@ni.com>,
        Luiz Capitulino <lcapitulino@redhat.com>,
        linux-rt-users@vger.kernel.org
To: "Michael S. Tsirkin" <mst@redhat.com>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from Galois.linutronix.de ([146.0.238.70]:59949 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752844AbcKBQFz (ORCPT
        <rfc822;linux-rt-users@vger.kernel.org>);
        Wed, 2 Nov 2016 12:05:55 -0400
Content-Disposition: inline
In-Reply-To: <20161101051400-mutt-send-email-mst@kernel.org>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

On 2016-11-01 05:31:56 [+0200], Michael S. Tsirkin wrote:
> > > > > > 
> > > > > > > - optionally it has been requested to make synchronize_rcu() behave like
> > > > > > >   synchronize_rcu_expedited() on shutdown and kexec().
> 
> I was trying to say that the fact net core calls expedited sync
> implies that many people care about boot time.
> 
> Should rcu_normal_after_boot override rcu_expedited?
> I'm not sure what happens if you specify both ATM.

I think what you asked for is something like this:

diff --git a/kernel/reboot.c b/kernel/reboot.c
--- a/kernel/reboot.c
+++ b/kernel/reboot.c
@@ -283,6 +283,7 @@ SYSCALL_DEFINE4(reboot, int, magic1, int, magic2, unsigned int, cmd,
 	struct pid_namespace *pid_ns = task_active_pid_ns(current);
 	char buffer[256];
 	int ret = 0;
+	bool force_rcu_exp = false;
 
 	/* We only trust the superuser with rebooting the system. */
 	if (!ns_capable(pid_ns->user_ns, CAP_SYS_BOOT))
@@ -311,7 +312,19 @@ SYSCALL_DEFINE4(reboot, int, magic1, int, magic2, unsigned int, cmd,
 	if ((cmd == LINUX_REBOOT_CMD_POWER_OFF) && !pm_power_off)
 		cmd = LINUX_REBOOT_CMD_HALT;
 
+	switch (cmd) {
+	case LINUX_REBOOT_CMD_RESTART:
+	case LINUX_REBOOT_CMD_HALT:
+	case LINUX_REBOOT_CMD_POWER_OFF:
+	case LINUX_REBOOT_CMD_RESTART2:
+	case LINUX_REBOOT_CMD_KEXEC:
+		force_rcu_exp = true;
+	}
+
 	mutex_lock(&reboot_mutex);
+	if (force_rcu_exp)
+		rcu_expedite_gp();
+
 	switch (cmd) {
 	case LINUX_REBOOT_CMD_RESTART:
 		kernel_restart(NULL);
@@ -362,6 +375,8 @@ SYSCALL_DEFINE4(reboot, int, magic1, int, magic2, unsigned int, cmd,
 		ret = -EINVAL;
 		break;
 	}
+	if (force_rcu_exp)
+		rcu_unexpedite_gp();
 	mutex_unlock(&reboot_mutex);
 	return ret;
 }

and problem that this patch is pointless because it is too late. This
RESTART, POWER_OFF, KEXEC hooks here called once the `shutdown' binary
is done doing sync & cleanup and invokes the kernel for the final
operation.
So to achieve what you ask for, we would need a
LINUX_REBOOT_CMD_RCU_FAST option which is invoked by the `shutdown'
binary as the first thing - long before it gets to
LINUX_REBOOT_CMD_RESTART (or KEXEC).

Sebastian
