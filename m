From: Grygorii Strashko <grygorii.strashko@ti.com>
Subject: Common clock framework API vs RT patchset
Date: Tue, 4 Aug 2015 15:00:47 +0300
Message-ID: <55C0A96F.80307@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Transfer-Encoding: 7bit
Cc: "Menon, Nishanth" <nm@ti.com>, Felipe Balbi <balbi@ti.com>,
	Sekhar Nori <nsekhar@ti.com>
To: <linux-rt-users@vger.kernel.org>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from comal.ext.ti.com ([198.47.26.152]:33615 "EHLO comal.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S933719AbbHDMAv (ORCPT <rfc822;linux-rt-users@vger.kernel.org>);
	Tue, 4 Aug 2015 08:00:51 -0400
Received: from dflxv15.itg.ti.com ([128.247.5.124])
	by comal.ext.ti.com (8.13.7/8.13.7) with ESMTP id t74C0om2030322
	for <linux-rt-users@vger.kernel.org>; Tue, 4 Aug 2015 07:00:50 -0500
Received: from DFLE72.ent.ti.com (dfle72.ent.ti.com [128.247.5.109])
	by dflxv15.itg.ti.com (8.14.3/8.13.8) with ESMTP id t74C0oZH019607
	for <linux-rt-users@vger.kernel.org>; Tue, 4 Aug 2015 07:00:50 -0500
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

Hi All,

I'd very appreciated if someone can clarify one point for me.

Is allowed/expected/prohibited to use CLK API like clk_enable/disable
in atomic context now on RT-Kernel (HW IRQ or under RAW spinlocks)?

How safe is it to allow CLK API to be preemptive?

-- 
regards,
-grygorii
