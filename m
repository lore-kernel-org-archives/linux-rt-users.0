From: Sripathi Kodi <sripathik@in.ibm.com>
Subject: 2.6.26-rt1 : trying to register non-static key.
Date: Wed, 13 Aug 2008 12:22:33 +0530
Message-ID: <200808131222.33990.sripathik@in.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-rt-users@vger.kernel.org
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from e28smtp03.in.ibm.com ([59.145.155.3]:35759 "EHLO
	e28esmtp03.in.ibm.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1751900AbYHMGxM (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Wed, 13 Aug 2008 02:53:12 -0400
Received: from d28relay04.in.ibm.com (d28relay04.in.ibm.com [9.184.220.61])
	by e28esmtp03.in.ibm.com (8.13.1/8.13.1) with ESMTP id m7D6qsJW013026
	for <linux-rt-users@vger.kernel.org>; Wed, 13 Aug 2008 12:22:55 +0530
Received: from d28av03.in.ibm.com (d28av03.in.ibm.com [9.184.220.65])
	by d28relay04.in.ibm.com (8.13.8/8.13.8/NCO v9.0) with ESMTP id m7D6qmBW1822894
	for <linux-rt-users@vger.kernel.org>; Wed, 13 Aug 2008 12:22:48 +0530
Received: from d28av03.in.ibm.com (loopback [127.0.0.1])
	by d28av03.in.ibm.com (8.13.1/8.13.3) with ESMTP id m7D6qmnR025478
	for <linux-rt-users@vger.kernel.org>; Wed, 13 Aug 2008 12:22:48 +0530
Received: from [9.124.31.58] ([9.124.31.58])
	by d28av03.in.ibm.com (8.13.1/8.12.11) with ESMTP id m7D6qmVd025329
	for <linux-rt-users@vger.kernel.org>; Wed, 13 Aug 2008 12:22:48 +0530
Content-Disposition: inline
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

Hi,

I have seen the following message while booting 2.6.26-rt1 kernel on 
x86_64. I have enabled CONFIG_DEBUG_LOCK_ALLOC, CONFIG_PROVE_LOCKING, 
CONFIG_LOCKDEP. CONFIG_LOCK_STAT, CONFIG_DEBUG_LOCKDEP in the config.

INFO: trying to register non-static key.
the code is fine but needs lockdep annotation.
turning off the locking correctness validator.
Pid: 0, comm: swapper Not tainted 2.6.26-rt1 #1

Call Trace:
 [<ffffffff81055365>] ? static_obj+0x74/0x80
 [<ffffffff810582d1>] __lock_acquire+0x911/0xc4c
 [<ffffffff81056eb8>] ? mark_lock+0x85/0x41d
 [<ffffffff8105e129>] ? rt_mutex_slowtrylock+0x18/0x85
 [<ffffffff8105869a>] lock_acquire+0x8e/0xb2
 [<ffffffff8105e129>] ? rt_mutex_slowtrylock+0x18/0x85
 [<ffffffff812b630f>] __spin_lock_irqsave+0x40/0x73
 [<ffffffff8105e129>] rt_mutex_slowtrylock+0x18/0x85
 [<ffffffff812b4175>] rt_mutex_trylock+0x9/0xb
 [<ffffffff812b57ed>] rt_spin_lock+0x31/0x56
 [<ffffffff8104e99d>] compat_down_timeout+0x12/0x47
 [<ffffffff8117815e>] acpi_os_wait_semaphore+0x9b/0x12e
 [<ffffffff81057480>] ? trace_hardirqs_on+0xd/0xf
 [<ffffffff811975ca>] acpi_ut_acquire_mutex+0x86/0x114
 [<ffffffff8118b610>] acpi_ns_root_initialize+0x21/0x2d9
 [<ffffffff815c13a1>] acpi_initialize_subsystem+0x66/0x8e
 [<ffffffff815c165f>] acpi_early_init+0x54/0xfc
 [<ffffffff815a3b5b>] start_kernel+0x357/0x37f
 [<ffffffff815a3428>] x86_64_start_kernel+0x237/0x242

INFO: lockdep is turned off.
---------------------------
| preempt count: 00000002 ]
| 2-level deep critical section nesting:
----------------------------------------
.. [<ffffffff815a3961>] .... start_kernel+0x15d/0x37f
.....[<ffffffff815a3428>] ..   ( <= x86_64_start_kernel+0x237/0x242)
.. [<ffffffff812b62f2>] .... __spin_lock_irqsave+0x23/0x73
.....[<ffffffff8105e129>] ..   ( <= rt_mutex_slowtrylock+0x18/0x85)

Parsing all Control Methods:
Table [DSDT](id 0001) - 933 Objects with 49 Devices 142 Methods 11 
Regions
 tbxface-0598 [00] tb_load_namespace     : ACPI Tables successfully 
acquired
evxfevnt-0091 [00] enable                : Transition to ACPI mode 
successful
CPU0: Dual-Core AMD Opteron(tm) Processor 2218 stepping 02
Using local APIC timer interrupts.
APIC timer calibration result 12500428

Thanks,
Sripathi.
