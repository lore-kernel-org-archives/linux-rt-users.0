From: Thomas Gleixner <tglx@linutronix.de>
Subject: Re: RT-linux on MIPS..
Date: Wed, 10 Jun 2009 18:33:36 +0200 (CEST)
Message-ID: <alpine.LFD.2.00.0906101828100.3367@localhost.localdomain>
References: <74848fb40906090018m267594f7u6225cf77388f8b4c@mail.gmail.com>  <9f1ddb481cf54eb91d48d76457d8f134@walsimou.com>  <fae6a9700906090505m4386dc0clde443ec8f1f857ec@mail.gmail.com>  <alpine.LFD.2.00.0906092313230.3351@localhost.localdomain>
 <fae6a9700906100740q4c32a01fjb08b04b9ecd4496f@mail.gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: walsimou@walsimou.com, Tom Desouza <desouza.tom@gmail.com>,
	linux-rt-users <linux-rt-users@vger.kernel.org>
To: Vivek Satpute <vivek@linsyssoft.com>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from www.tglx.de ([62.245.132.106]:37440 "EHLO www.tglx.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754952AbZFJQdl (ORCPT <rfc822;linux-rt-users@vger.kernel.org>);
	Wed, 10 Jun 2009 12:33:41 -0400
In-Reply-To: <fae6a9700906100740q4c32a01fjb08b04b9ecd4496f@mail.gmail.com>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

On Wed, 10 Jun 2009, Vivek Satpute wrote:
>
> doubts, could you please help me out ?
> 
> 1) Currently, I am using rt-patches
> patch-2.6.29.1-rt9-broken-out.tar.bz2, picked up from
>     http://www.kernel.org/pub/linux/kernel/projects/rt/ . It has
> patches for MIPS arch also.
>     Are all those patches specific to MIPS are tested and working ? I
> mean does those
>     have any unsolved issues ? Or do I have to test them ?
> 2) Could I know how many patches posted on mailing list, have been
> released so far ?

The MIPS support in 2.6.29-rt is known to be broken. We have been to
busy to fix it. There has been work done by the folks at lemote, but
it needs testing ...

See http://marc.info/?l=linux-rt-users&m=124103397124285&w=2

The 2.6.24-rt and the 2.6.26-rt series contain stable and known to
work MIPS support.

Thanks,

	tglx
