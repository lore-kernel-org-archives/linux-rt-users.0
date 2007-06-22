From: Thomas Gleixner <tglx@linutronix.de>
Subject: Re: [PATCH -rt] irq nobody cared workaround for i386
Date: Fri, 22 Jun 2007 09:14:16 +0200
Message-ID: <1182496456.20203.35.camel@chaos>
References: <4676CF81.2000205@redhat.com> <4677D7AF.7040700@redhat.com>
	 <467932B4.6030800@redhat.com> <467936FE.8050704@redhat.com>
	 <467A61A3.7060804@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Cc: Steven Rostedt <rostedt@goodmis.org>,
	Ingo Molnar <mingo@redhat.com>, linux-rt-users@vger.kernel.org,
	linux-kernel@vger.kernel.org
To: Michal Schmidt <mschmidt@redhat.com>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from www.osadl.org ([213.239.205.134]:46275 "EHLO mail.tglx.de"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1751806AbXFVHOU (ORCPT <rfc822;linux-rt-users@vger.kernel.org>);
	Fri, 22 Jun 2007 03:14:20 -0400
In-Reply-To: <467A61A3.7060804@redhat.com>
Sender: linux-rt-users-owner@vger.kernel.org
List-Id: linux-rt-users.vger.kernel.org

On Thu, 2007-06-21 at 13:31 +0200, Michal Schmidt wrote:
> OK, I fixed the spacing in both occurences.
> 
> Signed-off-by: Michal Schmidt <mschmidt@redhat.com>
> 
> --- arch/i386/kernel/io_apic.c.orig	2007-06-19 08:40:05.000000000 -0400
> +++ arch/i386/kernel/io_apic.c	2007-06-21 06:51:16.000000000 -0400

Please create -p1 patches next time.

Applied. Thanks,

	tglx
