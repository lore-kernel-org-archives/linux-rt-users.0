From: Thomas Gleixner <tglx@linutronix.de>
Subject: Re: v2.6.21.4-rt11
Date: Sun, 17 Jun 2007 18:43:25 +0200
Message-ID: <1182098605.8176.422.camel@chaos>
References: <20070609210507.GA29194@elte.hu>
	 <2accc2ff0706170915h7cc0ce97ofc16bc33f1714567@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Cc: Ingo Molnar <mingo@elte.hu>, linux-kernel@vger.kernel.org,
	linux-rt-users@vger.kernel.org
To: Nelson Castillo <nelsoneci@gmail.com>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from www.osadl.org ([213.239.205.134]:40151 "EHLO mail.tglx.de"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1753244AbXFQQnc (ORCPT <rfc822;linux-rt-users@vger.kernel.org>);
	Sun, 17 Jun 2007 12:43:32 -0400
In-Reply-To: <2accc2ff0706170915h7cc0ce97ofc16bc33f1714567@mail.gmail.com>
Sender: linux-rt-users-owner@vger.kernel.org
List-Id: linux-rt-users.vger.kernel.org

On Sun, 2007-06-17 at 11:15 -0500, Nelson Castillo wrote:
> >      http://rt.wiki.kernel.org
> 
> Not for ARM yet :(
> 
> What should I try for the ARM architecture? 

ARM has a lot of sub architectures and not all of them are supported
yet.

> There are many choices and
> I don't know what is the more friendly. By friendly I mean the one that
> is likely to be merged and that cooperate with you.

Which choices do you mean ?

>   http://people.redhat.com/mingo/realtime-preempt/patch-2.6.21.4-rt14
> 
> : undefined reference to `usecs_to_cycles'
> make: *** [.tmp_vmlinux1] Error 1

Which ARM sub arch ?

	tglx
