From: ratheesh k <ratheesh.ksz@gmail.com>
Subject: raw interrupts disabled
Date: Mon, 30 Aug 2010 18:17:10 +0530
Message-ID: <AANLkTimD4sWgi3mVmTtCqcGcVo_NG+Yv6ndPNU1W3YzD@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
To: linux-rt-users@vger.kernel.org
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from mail-iw0-f174.google.com ([209.85.214.174]:62945 "EHLO
	mail-iw0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751676Ab0H3MrZ (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Mon, 30 Aug 2010 08:47:25 -0400
Received: by iwn5 with SMTP id 5so4906989iwn.19
        for <linux-rt-users@vger.kernel.org>; Mon, 30 Aug 2010 05:47:24 -0700 (PDT)
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

linux 2.6.18 with linux-rt patch. I am getting following error message
very often.

ripd/2650[CPU#0]: BUG in qdisc_restart at net/sched/sch_generic.c:144
network driver disabled raw interrupts:
fox_start_xmit+0x0/0x190 [rubini_cn]


any clue is really appreciated
