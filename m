From: Frank Rowand <frank.rowand@am.sony.com>
Subject: Re: [PATCH RT 2/2] fix printk flush of messages
Date: Wed, 16 May 2012 18:17:26 -0700
Message-ID: <4FB451A6.4030306@am.sony.com>
References: <4FB44EF1.9050809@am.sony.com> <4FB44FD0.4090800@am.sony.com>
Reply-To: <frank.rowand@am.sony.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"
Content-Transfer-Encoding: 7bit
To: "tglx@linutronix.de" <tglx@linutronix.de>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"linux-rt-users@vger.kernel.org" <linux-rt-users@vger.kernel.org>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from tx2ehsobe002.messaging.microsoft.com ([65.55.88.12]:20880 "EHLO
	tx2outboundpool.messaging.microsoft.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752442Ab2EQBRs (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Wed, 16 May 2012 21:17:48 -0400
In-Reply-To: <4FB44FD0.4090800@am.sony.com>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

The patches were tested on an ARM panda board for linux-3.4-rc5-rt6.

The panda board has a compile error in linux-3.4-rc5, which is fixed
by commit 13176a89e1c4a0011bd9f576730b0338ecb619ff in linux-3.4-rc6.

Without the patch, the printk() output from the following commands
does not appear on the console, until flushed by 'echo >/dev/console'

   echo h >/proc/sysrq-trigger
   echo p >/proc/sysrq-trigger
   echo m >/proc/sysrq-trigger

With the patch, the output flushes to the console immediately.

-Frank

