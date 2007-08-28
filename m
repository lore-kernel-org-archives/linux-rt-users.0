Return-Path: <linux-rt-users-owner@vger.kernel.org>
Received: from victor.provo.novell.com ([137.65.250.26]:57001 "EHLO
	victor.provo.novell.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1762692AbXH1TSk (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Tue, 28 Aug 2007 15:18:40 -0400
Subject: Re: XFS forgets usrquota
From: Sven-Thorsten Dietrich <sdietrich@novell.com>
In-Reply-To: <Pine.LNX.4.64.0708281949130.3018@fbirervta.pbzchgretzou.qr>
References: <Pine.LNX.4.64.0708281717530.3018@fbirervta.pbzchgretzou.qr>
	 <1188315641.26298.1.camel@sven.thebigcorporation.com>
	 <Pine.LNX.4.64.0708281949130.3018@fbirervta.pbzchgretzou.qr>
Content-Type: text/plain
Date: Tue, 28 Aug 2007 12:18:32 -0700
Message-Id: <1188328712.26500.2.camel@sx.thebigcorporation.com>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-rt-users-owner@vger.kernel.org
To: Jan Engelhardt <jengelh@computergmbh.de>
Cc: linux-rt-users@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

On Tue, 2007-08-28 at 19:50 +0200, Jan Engelhardt wrote:
> On Aug 28 2007 08:40, Sven-Thorsten Dietrich wrote:
> >> I was recently testing 2.6.22.3-16.1-rt from SUSE (seems to be an 
> >> 2.6.22.1-rt9 as base), and I noticed that XFS does not know about the 
> >> 'usrquota' mount option anymore, causing all mounts to fail (since I 
> >> have it set on by default). Any idea what's going on?
> >
> >You mean vs. the SUSE default Kernel?
> >
> >The RT Kernel had some config options out of sync with the default 10.3
> >Kernel's configuration.
> 
> Ah now that you mention .config I see it, XFS_QUOTA=n. Thanks for the pointer
> ;-)
> >
> >Should be fixed in the next update.
> 
> I notice that there are quite a lot of unsynced options, especially in the
> netfilter area. CONFIG_NF_CONNTRACK_H323 has often jumped at me, for exampl

Indeed - initially I had just a few options on, but now it matches the
default config perfectly. The next push will have all those features.

The one major deviation is that I am carrying SYSFS_DEPRECATED, which
allows running on Suse 10.1 as well.

I have also added a PPC config, so hopefully after a few iterations that
will start going as well.

Sven

