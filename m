From: Frank Rowand <frank.rowand@am.sony.com>
Subject: Re: [ANNOUNCE] 3.0.6-rt17
Date: Thu, 6 Oct 2011 21:13:19 -0700
Message-ID: <4E8E7C5F.4090902@am.sony.com>
References: <alpine.LFD.2.02.1110070046270.3240@ionos>
Reply-To: <frank.rowand@am.sony.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"
Content-Transfer-Encoding: 7bit
Cc: LKML <linux-kernel@vger.kernel.org>,
	linux-rt-users <linux-rt-users@vger.kernel.org>
To: Thomas Gleixner <tglx@linutronix.de>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from am1ehsobe002.messaging.microsoft.com ([213.199.154.205]:8082
	"EHLO AM1EHSOBE002.bigfish.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1750809Ab1JGENl (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Fri, 7 Oct 2011 00:13:41 -0400
In-Reply-To: <alpine.LFD.2.02.1110070046270.3240@ionos>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

On 10/06/11 18:15, Thomas Gleixner wrote:
> Dear RT Folks,
> 
> I'm pleased to announce the 3.0.6-rt17 release.

Builds and boots on my usual array of ARM boards for:

  - SMP, PREEMPT_RT_FULL
  - SMP, PREEMPT_NONE
  - UP, PREEMPT_RT_FULL
  - UP, PREEMPT_NONE

-Frank


