From: Sven-Thorsten Dietrich <sdietrich@novell.com>
Subject: Re: 2.6.32 rt patch?
Date: Mon, 12 Apr 2010 12:09:15 -0700
Message-ID: <1271099355.19086.23.camel@sven.thebigcorporation.com>
References: <201004110047.39514@blacky.localdomain>
	 <alpine.LFD.2.00.1004120933100.18009@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Cc: linux-rt-users@vger.kernel.org
To: "Nikita V. Youshchenko" <yoush@cs.msu.su>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from nat.nue.novell.com ([195.135.221.3]:41615 "EHLO
	emea5-mh.id5.novell.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1753754Ab0DLT3X (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Mon, 12 Apr 2010 15:29:23 -0400
In-Reply-To: <alpine.LFD.2.00.1004120933100.18009@localhost.localdomain>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

sOn Mon, 2010-04-12 at 09:43 +0200, Thomas Gleixner wrote:
> On Sun, 11 Apr 2010, Nikita V. Youshchenko wrote:
> 
> > > What's wrong with running a 2.6.NN-rt kernel instead of the distro .32
> > > one ? 
> > 
> > No distro security updates.
> > No distro-specific patches.
> 
> While I can see the point of security updates, I consider the lack of
> distro patches an achievement.
> 

Security fixes do end up in the stable-Kernel series for a while.

After that you might have to look into farming out, or look into
deploying current Kernels with updates.

Regards,

Sven


> Thanks,
> 
> 	tglx
> 
> 
> --
> To unsubscribe from this list: send the line "unsubscribe linux-rt-users" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html


