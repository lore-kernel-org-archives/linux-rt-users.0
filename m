From: Wolfgang Grandegger <wg@grandegger.com>
Subject: patch-2.6.20-rt5: time warp detected!
Date: Mon, 19 Feb 2007 18:00:37 +0100
Message-ID: <45D9D7B5.9020404@grandegger.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
To: linux-rt-users@vger.kernel.org
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from mail-out.m-online.net ([212.18.0.9]:39818 "EHLO
	mail-out.m-online.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932410AbXBSQ7l (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Mon, 19 Feb 2007 11:59:41 -0500
Received: from mail01.m-online.net (svr21.m-online.net [192.168.3.149])
	by mail-out.m-online.net (Postfix) with ESMTP id 57F7C9984C
	for <linux-rt-users@vger.kernel.org>; Mon, 19 Feb 2007 17:59:40 +0100 (CET)
Received: from [172.16.0.100] (p5497FB93.dip.t-dialin.net [84.151.251.147])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by smtp-auth.mnet-online.de (Postfix) with ESMTP id 0AB61918D0
	for <linux-rt-users@vger.kernel.org>; Mon, 19 Feb 2007 17:59:39 +0100 (CET)
Sender: linux-rt-users-owner@vger.kernel.org
List-Id: linux-rt-users.vger.kernel.org

Hello,

sometimes I get the following message when calling ktime_get_real() from 
my interrupt handler:

BUG: time warp detected!
prev > now, 104357354c79dfed > 1043573435312fb2:
= 4685606971 delta, on CPU#0
  [<c0103d51>] dump_trace+0x68/0x1d9
  [<c0103edd>] show_trace_log_lvl+0x1b/0x36
  [<c01044dd>] show_trace+0xf/0x11
  [<c010455e>] dump_stack+0x12/0x14
  [<c012f1b2>] ktime_get_real+0x10/0x2c
  [<e09c03ad>] rtcan_rcv+0x12/0x99 [xeno_can]
  [<e09c951d>] rtcan_sja_interrupt+0x220/0x43e [xeno_can_sja1000]
  [<e0992018>] _rtdm_irq_trampoline+0x15/0x34 [xeno_rtdm]
  [<c0145eb7>] handle_IRQ_event+0x41/0xb7
  [<c0146334>] thread_simple_irq+0x31/0x5f
  [<c01468f8>] do_irqd+0xbd/0x249
  [<c012c531>] kthread+0xa0/0xcb
  [<c010397b>] kernel_thread_helper+0x7/0x10
  =======================
---------------------------
| preempt count: 00000000 ]
| 0-level deep critical section nesting:
----------------------------------------

Any idea how this can happen?

Thanks.

Wolfgang.
