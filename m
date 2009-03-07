From: Peter Zijlstra <peterz@infradead.org>
Subject: Re: [Announce] 2.6.29-rc6-rt3
Date: Sat, 07 Mar 2009 11:20:37 +0100
Message-ID: <1236421237.6376.114.camel@laptop>
References: <alpine.LFD.2.00.0902112332370.415@localhost.localdomain>
	 <alpine.LFD.2.00.0902122353050.16972@localhost.localdomain>
	 <alpine.LFD.2.00.0902231854360.3523@localhost.localdomain>
	 <alpine.LFD.2.00.0902241849230.3523@localhost.localdomain>
	 <alpine.LFD.2.00.0902241856480.9135@localhost.localdomain>
	 <f96d234e0903061423j4820acefie0cd7d7bf9089b16@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Cc: Thomas Gleixner <tglx@linutronix.de>,
	rt-users <linux-rt-users@vger.kernel.org>,
	Ingo Molnar <mingo@elte.hu>,
	Steven Rostedt <rostedt@goodmis.org>,
	Carsten Emde <ce@ceag.ch>, Clark Williams <williams@redhat.com>
To: Cliff Brake <cliff.brake@gmail.com>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from casper.infradead.org ([85.118.1.10]:34633 "EHLO
	casper.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751443AbZCGKUs (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Sat, 7 Mar 2009 05:20:48 -0500
In-Reply-To: <f96d234e0903061423j4820acefie0cd7d7bf9089b16@mail.gmail.com>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

On Fri, 2009-03-06 at 17:23 -0500, Cliff Brake wrote:
> On Tue, Feb 24, 2009 at 12:57 PM, Thomas Gleixner <tglx@linutronix.de> wrote:
> > We are pleased to announce the next update to our new preempt-rt
> 
> What is the issues with JFFS2?
> 
> --- linux-2.6-tip.orig/fs/jffs2/Kconfig
> +++ linux-2.6-tip/fs/jffs2/Kconfig
> @@ -2,6 +2,8 @@ config JFFS2_FS
>  	tristate "Journalling Flash File System v2 (JFFS2) support"
>  	select CRC32
>  	depends on MTD
> +	# build breakage
> +	depends on 0
>  	help
>  	  JFFS2 is the second generation of the Journalling Flash File System
>  	  for use on diskless embedded devices. It provides improved wear

Comment implies build breakage, remove this and try to compile the thing
seems like the easiest way to answer your question.

I'm sure Thomas will appreciate any patches to fix the resulting
borkage.

