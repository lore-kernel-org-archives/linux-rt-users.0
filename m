From: Frank Rowand <frank.rowand@am.sony.com>
Subject: Re: [ANNOUNCE] 3.2-rc4-rt6
Date: Wed, 7 Dec 2011 17:01:05 -0800
Message-ID: <4EE00C51.5080509@am.sony.com>
References: <alpine.LFD.2.02.1112052205350.2735@ionos>
Reply-To: <frank.rowand@am.sony.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"
Content-Transfer-Encoding: 7bit
Cc: LKML <linux-kernel@vger.kernel.org>,
	linux-rt-users <linux-rt-users@vger.kernel.org>
To: Thomas Gleixner <tglx@linutronix.de>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from tx2ehsobe002.messaging.microsoft.com ([65.55.88.12]:25801 "EHLO
	TX2EHSOBE003.bigfish.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756946Ab1LHBB1 (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Wed, 7 Dec 2011 20:01:27 -0500
In-Reply-To: <alpine.LFD.2.02.1112052205350.2735@ionos>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

On 12/05/11 13:09, Thomas Gleixner wrote:
> Dear RT Folks,
> 
> I'm pleased to announce the 3.2-rc4-rt6 release.

Builds and boots on some ARM boards (PandaBoard, Realview) for:

  - SMP, PREEMPT_RT_FULL
  - SMP, PREEMPT_NONE
  - UP, PREEMPT_RT_FULL
  - UP, PREEMPT_NONE

I'm still fighting with my out of mainline ARM board to move it
to 3.2-rc and boot SMP.

-Frank

