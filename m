From: Sven-Thorsten Dietrich <sdietrich@novell.com>
Subject: Re: real time interrupts
Date: Wed, 13 Oct 2010 13:32:36 -0400
Message-ID: <1286991156.14081.7.camel@sven>
References: <AANLkTi=PK8LSBTAQexeFbehTtPi8QUqsmP-1hkcX5Bve@mail.gmail.com>
	 <AANLkTink4kxePdLP96qYXPp7yHK-TxT7fr-XxLYZjDob@mail.gmail.com>
	 <AANLkTi=nMAJH3y8aSmRDObgoXg3mmS48-b_wV=XDCjB5@mail.gmail.com>
	 <4CB5A11F.5000503@novell.com>  <4CB5D722.1020701@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Cc: Michael Mueller <ss7box@gmail.com>, linux-rt-users@vger.kernel.org
To: Reagan Thomas <thomasraz@gmail.com>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from charybdis-ext.suse.de ([195.135.221.2]:46317 "EHLO
	nat.nue.novell.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1751440Ab0JMRcm (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Wed, 13 Oct 2010 13:32:42 -0400
In-Reply-To: <4CB5D722.1020701@gmail.com>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

On Wed, 2010-10-13 at 10:58 -0500, Reagan Thomas wrote:
> On 10/13/2010 7:07 AM, Sven-Thorsten Dietrich wrote:
> >  On 10/13/2010 04:50 AM, Michael Mueller wrote:
> >> On Wed, Oct 13, 2010 at 4:37 AM, John Kacur<jkacur@redhat.com>  wrote:
> >>> On Wed, Oct 13, 2010 at 10:10 AM, ratheesh 
> >>> k<ratheesh.ksz@gmail.com>  wrote:
> >>>> I  am using 2.6.18 kernel with rt-linux patch.
> >>> I'm afraid that with such an old kernel, you are unlikely to find any
> >>> support here. If it is at all possible for you, please update to
> >>> something newer.
> >>
> >> i tried dropping a new kernel into a distro using 2.6.18 (centos) and
> >> did not succeed; success came after moving to distro with a recent
> >> kernel and toolchain (fedora)
> >>
> >> mike
> >
> > Can you be more specific about the failure you encountered?
> >
> > And the version of the 'new' Kernel.
> >
> > (Oracle didn't seem to have any trouble updating RHEL 5 from 2.6.18 to 
> > 2.6.32 -- maybe use their .config)
> >
> > Sven
> > -- 
> 
> 
> At a minimum, he should add:
> 
> CONFIG_SYSFS_DEPRECATED=y
> CONFIG_SYSFS_DEPRECATED_V2=y
> 
> I'm pretty sure that's all I had to add to get 2.6.33.7-rt29 to work

Nod.

That's what I was fishing for.  

The same also applies when trying to get Suse / SLES 10 era systems to
work with RT Kernels later than 2.6.20 or so.


Regards,

Sven

