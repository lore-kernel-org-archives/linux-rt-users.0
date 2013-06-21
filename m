From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Subject: Re: 3.8.10-rt6: suspend/resume irqs enabled splat
Date: Fri, 21 Jun 2013 19:16:17 +0200
Message-ID: <51C48A61.5070801@linutronix.de>
References: <1367473433.5808.8.camel@marge.simpson.net>  <20130621104940.GB21228@linutronix.de>  <1371819580.5992.2.camel@marge.simpson.net>  <51C460A8.4010800@linutronix.de> <1371834264.5953.39.camel@marge.simpson.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Cc: RT <linux-rt-users@vger.kernel.org>
To: Mike Galbraith <bitbucket@online.de>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from www.linutronix.de ([62.245.132.108]:40699 "EHLO
	Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1422925Ab3FURQT (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Fri, 21 Jun 2013 13:16:19 -0400
In-Reply-To: <1371834264.5953.39.camel@marge.simpson.net>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

On 06/21/2013 07:04 PM, Mike Galbraith wrote:
> As I was examining the trace, your -rt12 announcement landed..
> 
> - added the missing "acpi/rt: Convert acpi_gbl_hardware lock back to a
>   raw_spinlock_t", reported by Steven.
> 
> Adding only that to -rt11 seems to have cured it.

Excellent. Good news to start the weekend :)

Sebastian
