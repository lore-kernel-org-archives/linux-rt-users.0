From: Frank Rowand <frank.rowand@am.sony.com>
Subject: linux-3.0.66-rt93 smoke test on ARM
Date: Thu, 7 Mar 2013 19:54:30 -0800
Message-ID: <513960F6.9050908@am.sony.com>
Reply-To: <frank.rowand@am.sony.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"
Content-Transfer-Encoding: 7bit
To: Thomas Gleixner <tglx@linutronix.de>,
	<linux-kernel@vger.kernel.org>, <linux-rt-users@vger.kernel.org>,
	<rostedt@goodmis.org>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from co1ehsobe004.messaging.microsoft.com ([216.32.180.187]:34729
	"EHLO co1outboundpool.messaging.microsoft.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1754294Ab3CHDyl (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Thu, 7 Mar 2013 22:54:41 -0500
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

linux-3.0.66-rt93 builds and boots on some ARM boards (PandaBoard, Realview) for:

  - SMP, PREEMPT_RT_FULL
  - SMP, PREEMPT_NONE
  - UP, PREEMPT_RT_FULL
  - UP, PREEMPT_NONE

-Frank

