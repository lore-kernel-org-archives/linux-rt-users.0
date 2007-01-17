From: Thomas Gleixner <tglx@linutronix.de>
Subject: Re: changes to task_blocks_on_rt_mutex between 18-rt6 and
	20-rc5-rt3
Date: Wed, 17 Jan 2007 12:02:29 +0100
Message-ID: <1169031749.2941.220.camel@localhost.localdomain>
References: <Pine.LNX.4.63.0701161642470.16286@pcgl.dsa-ac.de>
	 <1169025704.2941.215.camel@localhost.localdomain>
	 <Pine.LNX.4.63.0701171127030.16286@pcgl.dsa-ac.de>
Reply-To: tglx@linutronix.de
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Cc: linux-rt-users@vger.kernel.org
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from www.osadl.org ([213.239.205.134]:42380 "EHLO mail.tglx.de"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S932293AbXAQK4J (ORCPT <rfc822;linux-rt-users@vger.kernel.org>);
	Wed, 17 Jan 2007 05:56:09 -0500
To: Guennadi Liakhovetski <gl@dsa-ac.de>
In-Reply-To: <Pine.LNX.4.63.0701171127030.16286@pcgl.dsa-ac.de>
Sender: linux-rt-users-owner@vger.kernel.org
List-Id: linux-rt-users.vger.kernel.org

On Wed, 2007-01-17 at 11:46 +0100, Guennadi Liakhovetski wrote:
> Unable to handle kernel paging request at virtual address 00025d87

Memory corruption ?

> PC is at task_blocks_on_rt_mutex+0xb8/0x2a8

Can you decode the exact code line, so we know what it tries to access ?

> (yes, tainted, you know, it's the software that has been written before
>  Linux...)

Sigh....

	tglx
