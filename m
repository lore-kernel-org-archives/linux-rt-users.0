From: Frank Rowand <frank.rowand@am.sony.com>
Subject: 3.2.12-rt22 on ARM
Date: Thu, 29 Mar 2012 17:11:27 -0700
Message-ID: <4F74FA2F.9080406@am.sony.com>
Reply-To: <frank.rowand@am.sony.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"
Content-Transfer-Encoding: 7bit
Cc: <linux-rt-users@vger.kernel.org>, <tglx@linutronix.de>
To: LKML <linux-kernel@vger.kernel.org>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from tx2ehsobe003.messaging.microsoft.com ([65.55.88.13]:56982 "EHLO
	tx2outboundpool.messaging.microsoft.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S933371Ab2C3ALv (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Thu, 29 Mar 2012 20:11:51 -0400
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

3.2.12-rt22 builds and boots on some ARM boards (PandaBoard, Realview) for:

  - SMP, PREEMPT_RT_FULL
  - SMP, PREEMPT_NONE
  - UP, PREEMPT_RT_FULL
  - UP, PREEMPT_NONE

I'm still fighting with my out of mainline ARM board to move it
to 3.2 and boot SMP.

-Frank

