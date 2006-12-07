From: Ingo Molnar <mingo@elte.hu>
Subject: Re: v2.6.19-rt6, yum/rpm
Date: Thu, 7 Dec 2006 17:57:51 +0100
Message-ID: <20061207165751.GA2720@elte.hu>
References: <20061205171114.GA25926@elte.hu> <4577FC21.1080407@cybsft.com> <20061207121344.GA19749@elte.hu> <4578391E.40001@cybsft.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: linux-kernel@vger.kernel.org, linux-rt-users@vger.kernel.org,
	Mike Galbraith <efault@gmx.de>,
	Clark Williams <williams@redhat.com>,
	Sergei Shtylyov <sshtylyov@ru.mvista.com>,
	Thomas Gleixner <tglx@linutronix.de>,
	Fernando Lopez-Lezcano <nando@ccrma.Stanford.EDU>,
	Giandomenico De Tullio <ghisha@email.it>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from mx2.mail.elte.hu ([157.181.151.9]:47299 "EHLO mx2.mail.elte.hu"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1032473AbWLGQ7j (ORCPT <rfc822;linux-rt-users@vger.kernel.org>);
	Thu, 7 Dec 2006 11:59:39 -0500
To: "K.R. Foley" <kr@cybsft.com>
Content-Disposition: inline
In-Reply-To: <4578391E.40001@cybsft.com>
Sender: linux-rt-users-owner@vger.kernel.org
List-Id: linux-rt-users.vger.kernel.org


* K.R. Foley <kr@cybsft.com> wrote:

> Ingo Molnar wrote:
> 
> The attached patch is necessary to build 2.6.19-rt8 without KEXEC 
> enabled. Without KEXEC enabled crash.c doesn't get included. I believe 
> this is correct.

ah, indeed. I went for a slightly different approach - see the patch 
below. Sending an NMI to all CPUs is not something that is tied to 
KEXEC, it belongs into nmi.c.

	Ingo

Index: linux/arch/i386/kernel/crash.c
===================================================================
--- linux.orig/arch/i386/kernel/crash.c
+++ linux/arch/i386/kernel/crash.c
@@ -132,14 +132,6 @@ static int crash_nmi_callback(struct not
 	return 1;
 }
 
-void smp_send_nmi_allbutself(void)
-{
-	cpumask_t mask = cpu_online_map;
-	cpu_clear(safe_smp_processor_id(), mask);
-	if (!cpus_empty(mask))
-		send_IPI_mask(mask, NMI_VECTOR);
-}
-
 static struct notifier_block crash_nmi_nb = {
 	.notifier_call = crash_nmi_callback,
 };
Index: linux/arch/i386/kernel/nmi.c
===================================================================
--- linux.orig/arch/i386/kernel/nmi.c
+++ linux/arch/i386/kernel/nmi.c
@@ -1133,6 +1133,14 @@ int proc_nmi_enabled(struct ctl_table *t
 
 #endif
 
+void smp_send_nmi_allbutself(void)
+{
+	cpumask_t mask = cpu_online_map;
+	cpu_clear(safe_smp_processor_id(), mask);
+	if (!cpus_empty(mask))
+		send_IPI_mask(mask, NMI_VECTOR);
+}
+
 EXPORT_SYMBOL(nmi_active);
 EXPORT_SYMBOL(nmi_watchdog);
 EXPORT_SYMBOL(avail_to_resrv_perfctr_nmi);
Index: linux/arch/x86_64/kernel/crash.c
===================================================================
--- linux.orig/arch/x86_64/kernel/crash.c
+++ linux/arch/x86_64/kernel/crash.c
@@ -127,11 +127,6 @@ static int crash_nmi_callback(struct not
 	return 1;
 }
 
-void smp_send_nmi_allbutself(void)
-{
-	send_IPI_allbutself(NMI_VECTOR);
-}
-
 /*
  * This code is a best effort heuristic to get the
  * other cpus to stop executing. So races with
Index: linux/arch/x86_64/kernel/nmi.c
===================================================================
--- linux.orig/arch/x86_64/kernel/nmi.c
+++ linux/arch/x86_64/kernel/nmi.c
@@ -1015,6 +1015,11 @@ int proc_nmi_enabled(struct ctl_table *t
 
 #endif
 
+void smp_send_nmi_allbutself(void)
+{
+	send_IPI_allbutself(NMI_VECTOR);
+}
+
 EXPORT_SYMBOL(nmi_active);
 EXPORT_SYMBOL(nmi_watchdog);
 EXPORT_SYMBOL(avail_to_resrv_perfctr_nmi);
