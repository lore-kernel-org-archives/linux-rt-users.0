From: Ingo Molnar <mingo@elte.hu>
Subject: Re: Poor UDP performance using 2.6.21-rc5-rt5
Date: Tue, 3 Apr 2007 08:43:04 +0200
Message-ID: <20070403064304.GA17938@elte.hu>
References: <20070402190445.GB2081@elte.hu> <001d01c77584$6a92ffe0$7901a8c0@dad>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: "'dave_sperry@ieee.org'" <dasperry@comcast.net>,
	linux-rt-users@vger.kernel.org, linux-kernel@vger.kernel.org
To: David Sperry <dave_sperry@ieee.org>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from mx2.mail.elte.hu ([157.181.151.9]:50735 "EHLO mx2.mail.elte.hu"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753309AbXDCGnM (ORCPT <rfc822;linux-rt-users@vger.kernel.org>);
	Tue, 3 Apr 2007 02:43:12 -0400
Content-Disposition: inline
In-Reply-To: <001d01c77584$6a92ffe0$7901a8c0@dad>
Sender: linux-rt-users-owner@vger.kernel.org
List-Id: linux-rt-users.vger.kernel.org


* David Sperry <dave_sperry@ieee.org> wrote:

> > > I think there is some kind of bad behavior happening in the Nvidia 
> > > driver with respect to softirq-net-tx and IRQ-8406.
> > 
> > yes. Part of the problem is that the forcedeth.c driver does not 
> > fully support NAPI - today i've implemented those bits (see them 
> > below), based on your testcase. The other part is that the Intel NIC 
> > uses MSI, while foredeth uses fasteoi, correct? [you can see this in 
> > /proc/interrupts]
> 
> In my case forcedeth seems to be picking up MSI for eth2 & eth3

> Could this be part of my problem?

i dont think it should be a problem.

	Ingo
