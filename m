From: Thomas Gleixner <tglx@linutronix.de>
Subject: Re: changes to task_blocks_on_rt_mutex between 18-rt6 and
	20-rc5-rt3
Date: Wed, 17 Jan 2007 10:21:43 +0100
Message-ID: <1169025704.2941.215.camel@localhost.localdomain>
References: <Pine.LNX.4.63.0701161642470.16286@pcgl.dsa-ac.de>
Reply-To: tglx@linutronix.de
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Cc: linux-rt-users@vger.kernel.org
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from www.osadl.org ([213.239.205.134]:43219 "EHLO mail.tglx.de"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S932153AbXAQJPX (ORCPT <rfc822;linux-rt-users@vger.kernel.org>);
	Wed, 17 Jan 2007 04:15:23 -0500
To: Guennadi Liakhovetski <gl@dsa-ac.de>
In-Reply-To: <Pine.LNX.4.63.0701161642470.16286@pcgl.dsa-ac.de>
Sender: linux-rt-users-owner@vger.kernel.org
List-Id: linux-rt-users.vger.kernel.org

Guennadi,

On Tue, 2007-01-16 at 16:46 +0100, Guennadi Liakhovetski wrote:
> I noticed that the above function in kernel/rtmutex.c has changed a lot, 
> and I do have a problem in that function under some realtime load. 

Which problem do you have ? Can you describe it a bit more detailed ? Do
you have a testcase to reproduce it ?

> Is 
> there a way to check why and when it has been changed? Like git or 
> something? Detailed Changelogs?

No.

	tglx
