From: Frank Rowand <frank.rowand@am.sony.com>
Subject: Re: [ANNOUNCE] 3.4-rc2-rt2
Date: Wed, 11 Apr 2012 13:54:02 -0700
Message-ID: <4F85EF6A.8040301@am.sony.com>
References: <alpine.LFD.2.02.1204111212440.2542@ionos>
Reply-To: <frank.rowand@am.sony.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"
Content-Transfer-Encoding: 7bit
Cc: LKML <linux-kernel@vger.kernel.org>,
	linux-rt-users <linux-rt-users@vger.kernel.org>
To: Thomas Gleixner <tglx@linutronix.de>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from va3ehsobe006.messaging.microsoft.com ([216.32.180.16]:43765
	"EHLO va3outboundpool.messaging.microsoft.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1760165Ab2DKUy3 (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Wed, 11 Apr 2012 16:54:29 -0400
In-Reply-To: <alpine.LFD.2.02.1204111212440.2542@ionos>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

On 04/11/12 03:17, Thomas Gleixner wrote:
> Dear RT Folks,
> 
> I'm pleased to announce the 3.4-rc2-rt2 release.

< snip >

3.4-rc2-rt2 builds and boots on some ARM boards (PandaBoard, Realview) for:

  - SMP, PREEMPT_RT_FULL
  - SMP, PREEMPT_NONE
  - UP, PREEMPT_RT_FULL
  - UP, PREEMPT_NONE


A patch is required to resolve a mainline NULL pointer dereference on boot
of Realview.  The patch is in linux-next and should make it to Linus by the
end of this week.

The patch is available at http://marc.info/?l=linux-serial&m=133235774423240&w=2

-Frank



