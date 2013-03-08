From: Frank Rowand <frank.rowand@am.sony.com>
Subject: linux-3.4.33-rt47 smoke test on ARM
Date: Thu, 7 Mar 2013 19:54:47 -0800
Message-ID: <51396107.3010003@am.sony.com>
Reply-To: <frank.rowand@am.sony.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"
Content-Transfer-Encoding: 7bit
To: Thomas Gleixner <tglx@linutronix.de>,
	<linux-kernel@vger.kernel.org>, <linux-rt-users@vger.kernel.org>,
	<rostedt@goodmis.org>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from co1ehsobe001.messaging.microsoft.com ([216.32.180.184]:57900
	"EHLO co1outboundpool.messaging.microsoft.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1760306Ab3CHDyy (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Thu, 7 Mar 2013 22:54:54 -0500
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

linux-3.4.33-rt47 builds and boots on some ARM boards (PandaBoard, Realview) for:

  - SMP, PREEMPT_RT_FULL
  - SMP, PREEMPT_NONE
  - UP, PREEMPT_RT_FULL
  - UP, PREEMPT_NONE

-Frank

