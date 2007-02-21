From: Thomas Gleixner <tglx@linutronix.de>
Subject: Re: patch-2.6.20-rt5: time warp detected!
Date: Wed, 21 Feb 2007 20:24:02 +0100
Message-ID: <1172085842.25076.121.camel@localhost.localdomain>
References: <45D9D7B5.9020404@grandegger.com>
	 <1171966493.30834.225.camel@localhost.localdomain>
	 <45DB38D1.4000204@grandegger.com>  <45DB39A2.5050106@bostondynamics.com>
	 <1172070012.25076.60.camel@localhost.localdomain>
	 <45DC9253.4090200@grandegger.com>
Reply-To: tglx@linutronix.de
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Cc: Alex Khripin <akhripin@bostondynamics.com>,
	linux-rt-users@vger.kernel.org
To: Wolfgang Grandegger <wg@grandegger.com>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from www.osadl.org ([213.239.205.134]:56244 "EHLO mail.tglx.de"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1422820AbXBUTS4 (ORCPT <rfc822;linux-rt-users@vger.kernel.org>);
	Wed, 21 Feb 2007 14:18:56 -0500
In-Reply-To: <45DC9253.4090200@grandegger.com>
Sender: linux-rt-users-owner@vger.kernel.org
List-Id: linux-rt-users.vger.kernel.org

On Wed, 2007-02-21 at 19:41 +0100, Wolfgang Grandegger wrote:
> Thomas Gleixner wrote:
> > On Tue, 2007-02-20 at 13:10 -0500, Alex Khripin wrote:
> >> I have seen a similar event as well on -rt5; SMP kernel but on a P4 with 
> >> hyperthreading disabled.
> > 
> > Alex, Wolfgang,
> > 
> > does this happen with -rt9 too ?
> 
> Where can I find -rt9? At least it's not yet available on 
> http://people.redhat.com/mingo/realtime-preempt/.

oops. -rt8 is the latest.

	tglx
