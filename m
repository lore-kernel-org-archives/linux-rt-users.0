From: Nathan Sullivan <nathan.sullivan@ni.com>
Subject: softirq behavior during a UDP flood
Date: Fri, 1 May 2015 10:04:12 -0500
Message-ID: <20150501150412.GA15483@nathan3500-linux-VM>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
To: linux-rt-users@vger.kernel.org
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from skprod3.natinst.com ([130.164.80.24]:48135 "EHLO ni.com"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1751311AbbEAPEO (ORCPT <rfc822;linux-rt-users@vger.kernel.org>);
	Fri, 1 May 2015 11:04:14 -0400
Received: from us-aus-mgwout2.amer.corp.natinst.com (nb-snip2-1338.natinst.com [130.164.19.135])
	by us-aus-skprod3.natinst.com (8.15.0.59/8.15.0.59) with ESMTP id t41F4Bcr008042
	for <linux-rt-users@vger.kernel.org>; Fri, 1 May 2015 10:04:12 -0500
Content-Disposition: inline
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

Hello all,

We are running 3.14.37-rt on a Xilinx Zynq based board, and have noticed some
unfortunate behavior with NAPI polling during heavy incoming traffic.  Since,
as I understand it, softirqs are scheduled on the thread that caused them in
rt, the netowrk RX softirq simply runs over and over on one CPU of the system.
The network device never re-enables interupts, basically NAPI polling runs
forever and weight/budget are irrelevant with preempt-rt on.

Since we set IRQ affinity to CPU 0 for everything, this leads to the system
live-locking and becoming unusable.  With full RT preemption off, things are
fine.  In addition, 3.2 kernels with RT are fine as well under heavy net load.
Is this behavior due to a design tradeoff, or is it a bug?
