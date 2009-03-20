From: Thomas Gleixner <tglx@linutronix.de>
Subject: Re: [Announce] 2.6.29-rc78rt1
Date: Fri, 20 Mar 2009 16:48:08 +0100 (CET)
Message-ID: <alpine.LFD.2.00.0903201645400.29264@localhost.localdomain>
References: <alpine.LFD.2.00.0902112332370.415@localhost.localdomain> <alpine.LFD.2.00.0902122353050.16972@localhost.localdomain> <alpine.LFD.2.00.0902231854360.3523@localhost.localdomain> <alpine.LFD.2.00.0902241849230.3523@localhost.localdomain> <alpine
 <49C2F37B.3030909@am.sony.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: rt-users <linux-rt-users@vger.kernel.org>
To: Frank Rowand <frank.rowand@am.sony.com>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from www.tglx.de ([62.245.132.106]:55860 "EHLO www.tglx.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754225AbZCTPsY (ORCPT <rfc822;linux-rt-users@vger.kernel.org>);
	Fri, 20 Mar 2009 11:48:24 -0400
In-Reply-To: <49C2F37B.3030909@am.sony.com>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

On Thu, 19 Mar 2009, Frank Rowand wrote:
> 
> >    - lots of tracer updates from -tip (check the tip git logs)
> 
> I have been trying to reverse engineer which git commits
> comprise origin.patch, but my git-foo is not up to the
> task.  For any single file in origin.patch, I can work
> backwards to find the git commit associated with it, but I
> don't know how to easily create a list of all of the git commits
> that are associated with origin.patch.  Do you have any quick
> hints that would assist me in my quest?

  git log v.2.6.29-rc8..

I'm going to add a log to the broken out tarball next time.

Thanks,

	tglx

