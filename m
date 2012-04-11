From: Frank Rowand <frank.rowand@am.sony.com>
Subject: Re: [ANNOUNCE] 3.4-rc2-rt1
Date: Tue, 10 Apr 2012 19:23:37 -0700
Message-ID: <4F84EB29.6030002@am.sony.com>
References: <alpine.LFD.2.02.1204101642050.2542@ionos>
Reply-To: <frank.rowand@am.sony.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"
Content-Transfer-Encoding: 7bit
Cc: LKML <linux-kernel@vger.kernel.org>,
	linux-rt-users <linux-rt-users@vger.kernel.org>
To: Thomas Gleixner <tglx@linutronix.de>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from va3ehsobe002.messaging.microsoft.com ([216.32.180.12]:37479
	"EHLO va3outboundpool.messaging.microsoft.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1759956Ab2DKCYA (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Tue, 10 Apr 2012 22:24:00 -0400
In-Reply-To: <alpine.LFD.2.02.1204101642050.2542@ionos>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

On 04/10/12 07:46, Thomas Gleixner wrote:
> Dear RT Folks,
> 
> I'm pleased to announce the 3.4-rc2-rt1 release.
> 
> This is a straight forward update of the 3.2 series to 3.4-rc2. It's
> slightly smaller than the 3.2 series. I hope to stabilize it fast so I
> can concentrate on shuffling more parts of RT into 3.5.


3.4-rc2-rt1 builds and boots on some ARM boards (PandaBoard, Realview) for:

  - SMP, PREEMPT_RT_FULL
  - SMP, PREEMPT_NONE
  - UP, PREEMPT_RT_FULL
  - UP, PREEMPT_NONE

Patch was required to compile (see earlier in this email thread).

Second patch required to resolve NULL pointer dereference on boot
of Realview.  Patch sent to lkml (https://lkml.org/lkml/2012/4/10/518).

PandaBoard SMP, PREEMPT_RT_FULL has a lock warning on boot (reported
earlier in this thread).

-Frank

