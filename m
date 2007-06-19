From: Manfred Gruber <m.gruber@tirol.com>
Subject: 2.6.21-rt17 arm compile error
Date: Tue, 19 Jun 2007 16:34:48 +0200
Message-ID: <200706191634.49079.m.gruber@tirol.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-rt-users@vger.kernel.org
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from 85-126-107-146.static.sdsl-line.inode.at ([85.126.107.146]:4394
	"EHLO mail.contec.at" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752990AbXFSPCF (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Tue, 19 Jun 2007 11:02:05 -0400
Received: from comixs.contec-int.at (unknown [192.168.1.250])
	by mail.contec.at (Firewall Mailer Daemon) with ESMTP id 25A12C086E
	for <linux-rt-users@vger.kernel.org>; Tue, 19 Jun 2007 16:34:49 +0200 (CEST)
Content-Disposition: inline
Sender: linux-rt-users-owner@vger.kernel.org
List-Id: linux-rt-users.vger.kernel.org

hi !

i get foillowing compile error on arm:

In file included from kernel/sched.c:752:
kernel/sched_debug.c: In function 'print_cpu':
kernel/sched_debug.c:107: error: 'cpu_khz' undeclared (first use in this 
function)
kernel/sched_debug.c:107: error: (Each undeclared identifier is reported only 
once
kernel/sched_debug.c:107: error: for each function it appears in.)
make[1]: *** [kernel/sched.o] Fehler 1

someone any idea ?

i don't think this fix is correct, but it helps to compile:

Index: linux-2.6/kernel/sched_debug.c
===================================================================
--- linux-2.6.orig/kernel/sched_debug.c
+++ linux-2.6/kernel/sched_debug.c
@@ -104,7 +104,11 @@ static void print_rq_runtime_sum(struct 
 static void print_cpu(struct seq_file *m, int cpu, u64 now)
 {
        struct rq *rq = &per_cpu(runqueues, cpu);
+#ifdef CONFIG_X86
        unsigned int freq = cpu_khz ? : 1;
+#else
+       unsigned int freq = 1;
+#endif
 
        SEQ_printf(m, "\ncpu#%d, %u.%03u MHz\n",
                   cpu, freq / 1000, (freq % 1000));


regards manfred
