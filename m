From: Sven-Thorsten Dietrich <sven@thebigcorporation.com>
Subject: Re: [PATCH -rt 6/6] Compile fix for PREEMPT_TIMING on and
	IRQSOFF_TIMING off
Date: Fri, 13 Jul 2007 14:11:46 -0700
Message-ID: <1184361106.14224.37.camel@sx.thebigcorporation.com>
References: <20070713175214.336577416@mvista.com>
	 <20070713175229.239602308@mvista.com>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Cc: tglx@linutronix.de, mingo@elte.hu, linux-rt-users@vger.kernel.org,
	linux-kernel@vger.kernel.org
To: Kevin Hilman <khilman@mvista.com>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from alnrmhc14.comcast.net ([204.127.225.94]:60521 "EHLO
	alnrmhc14.comcast.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756949AbXGMVLu (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Fri, 13 Jul 2007 17:11:50 -0400
In-Reply-To: <20070713175229.239602308@mvista.com>
Sender: linux-rt-users-owner@vger.kernel.org
List-Id: linux-rt-users.vger.kernel.org

On Fri, 2007-07-13 at 10:52 -0700, Kevin Hilman wrote:
> plain text document attachment (trace-cpu-idle.patch)
> 
> The per-cpu trace_cpu_idle variable is used when timing *either*
> IRQs-off or preempt sections.
> 

This also applies to 2.6.22-rt*

Acked-by: Sven-Thorsten Dietrich <sven@thebigcorporation.com>
