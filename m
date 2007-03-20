From: joel silvestre <j.silvestre@wanadoo.fr>
Subject: 2.6.20-rt8  APIC error
Date: Tue, 20 Mar 2007 12:18:18 +0100
Message-ID: <1174389498.3792.95.camel@zordi>
References: <Pine.LNX.4.63.0703161653400.534@pcgl.dsa-ac.de>
	 <20070316161653.GC9413@elte.hu>
	 <Pine.LNX.4.63.0703161722280.534@pcgl.dsa-ac.de>
	 <20070316.121539.78711178.davem@davemloft.net>
	 <Pine.LNX.4.63.0703191617250.534@pcgl.dsa-ac.de>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
To: linux-rt-users@vger.kernel.org
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from smtp20.orange.fr ([80.12.242.26]:34223 "EHLO smtp20.orange.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753576AbXCTLSV (ORCPT <rfc822;linux-rt-users@vger.kernel.org>);
	Tue, 20 Mar 2007 07:18:21 -0400
Received: from me-wanadoo.net (localhost [127.0.0.1])
	by mwinf2002.orange.fr (SMTP Server) with ESMTP id 1E0E11C000EA
	for <linux-rt-users@vger.kernel.org>; Tue, 20 Mar 2007 12:18:19 +0100 (CET)
Received: from [192.168.0.3] (AAnnecy-157-1-173-39.w90-27.abo.wanadoo.fr [90.27.244.39])
	by mwinf2002.orange.fr (SMTP Server) with ESMTP id E245B1C000F0
	for <linux-rt-users@vger.kernel.org>; Tue, 20 Mar 2007 12:18:18 +0100 (CET)
In-Reply-To: <Pine.LNX.4.63.0703191617250.534@pcgl.dsa-ac.de>
Sender: linux-rt-users-owner@vger.kernel.org
List-Id: linux-rt-users.vger.kernel.org


Hello, 

found this for the first and only time this morning:


Mar 20 11:42:32 localhost powersaved: Loading acpi_cpufreq
Mar 20 11:42:32 localhost kernel:  [<c0104f7a>] dump_trace+0x63/0x1e5
Mar 20 11:42:32 localhost kernel:  [<c0105116>] show_trace_log_lvl
+0x1a/0x2f
Mar 20 11:42:32 localhost kernel:  [<c0105731>] show_trace+0x12/0x14
Mar 20 11:42:32 localhost kernel:  [<c01057c4>] dump_stack+0x16/0x18
Mar 20 11:42:32 localhost kernel:  [<c010ef6e>] smp_error_interrupt
+0x55/0x5c
Mar 20 11:42:32 localhost kernel:  [<c01049d0>] error_interrupt
+0x28/0x30
Mar 20 11:42:32 localhost kernel:  [<c01751cf>] shrink_dcache_parent
+0x3c/0xdc
Mar 20 11:42:32 localhost kernel:  [<c016b997>] dentry_unhash+0x1e/0x72
Mar 20 11:42:32 localhost kernel:  [<c016cb2e>] vfs_rmdir+0x79/0xf4
Mar 20 11:42:32 localhost kernel:  [<c016e634>] do_rmdir+0x89/0xbb
Mar 20 11:42:32 localhost kernel:  [<c016e6a5>] sys_rmdir+0x10/0x12
Mar 20 11:42:32 localhost kernel:  [<c0103f40>] syscall_call+0x7/0xb
Mar 20 11:42:32 localhost kernel:  [<b7f322ed>] 0xb7f322ed
Mar 20 11:42:32 localhost kernel:  =======================
Mar 20 11:42:32 localhost powersaved: enter 'acpi_cpufreq' into
CPUFREQD_MODULE in /etc/powersave/cpufreq.

joel
