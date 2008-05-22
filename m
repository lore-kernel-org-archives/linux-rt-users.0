From: Subrata Modak <subrata@linux.vnet.ibm.com>
Subject: Re: [LTP] [Fwd: [PATCH 1/1] [REALTIME] Profiled tests.]
Date: Thu, 22 May 2008 17:41:16 +0530
Message-ID: <1211458276.5064.15.camel@subratamodak.linux.ibm.com>
References: <1211213941.4871.2.camel@subratamodak.linux.ibm.com>
	 <20080521124450.GA11320@in.ibm.com>  <483420BD.3010406@bull.net>
Reply-To: subrata@linux.vnet.ibm.com
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Cc: ltp-list <ltp-list@lists.sourceforge.net>,
	dino <dino@linux.vnet.ibm.com>,
	Sripathi Kodi <sripathik@in.ibm.com>,
	Chirag Jog <chirag@linux.vnet.ibm.com>,
	sudhanshu Singh <sudh@linux.vnet.ibm.com>,
	dvhltc <dvhltc@linux.vnet.ibm.com>, tinytim <tinytim@us.ibm.com>,
	John Stultz <johnstul@us.ibm.com>,
	Sebastien Dugue <sebastien.dugue@bull.net>,
	Jean-Pierre Dion <jean-pierre.dion@bull.net>,
	Michael Olbrich <m.olbrich@pengutronix.de>,
	Robert Schwebel <r.schwebel@pengutronix.de>,
	linux-rt-users <linux-rt-users@vger.kernel.org>
To: Gilles Carry <Gilles.Carry@bull.net>,
	Ankita Garg <ankita@in.ibm.com>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from e32.co.us.ibm.com ([32.97.110.150]:35849 "EHLO
	e32.co.us.ibm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758961AbYEVMLn (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Thu, 22 May 2008 08:11:43 -0400
Received: from d03relay04.boulder.ibm.com (d03relay04.boulder.ibm.com [9.17.195.106])
	by e32.co.us.ibm.com (8.13.8/8.13.8) with ESMTP id m4MC8Aql005959
	for <linux-rt-users@vger.kernel.org>; Thu, 22 May 2008 08:08:10 -0400
Received: from d03av04.boulder.ibm.com (d03av04.boulder.ibm.com [9.17.195.170])
	by d03relay04.boulder.ibm.com (8.13.8/8.13.8/NCO v8.7) with ESMTP id m4MCBcwK096834
	for <linux-rt-users@vger.kernel.org>; Thu, 22 May 2008 06:11:39 -0600
Received: from d03av04.boulder.ibm.com (loopback [127.0.0.1])
	by d03av04.boulder.ibm.com (8.12.11.20060308/8.13.3) with ESMTP id m4MCBVkg027461
	for <linux-rt-users@vger.kernel.org>; Thu, 22 May 2008 06:11:38 -0600
In-Reply-To: <483420BD.3010406@bull.net>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

Thanks Gilles for the Patch and thanks Ankita or reviewing the same. The
same has been merged to LTP.

Regards--
Subrata

On Wed, 2008-05-21 at 15:16 +0200, Gilles Carry wrote:
> Hello Ankita,
> 
> Ankita Garg wrote:
> > I like the idea. It helps making testing infrastructure to be generic
> > and easy to extend.
> > 
> > I might be missing something, or it could be that it is a TO-DO item,
> > but the patch looks incomplete...the testcases dont yet support the '-c'
> > option. Also, the parsers do not take the profiles into account. As I
> > said before, this could just be your first step towards completing the
> > entire infrastructure and you might have the rest in your To-Do..
> 
> Actually, the '-c' option is not mandatory for this patch to work since
> the profiles can take any command line.
> Arguments are not interpreted by the scripts which run the command lines
> as found in the profile.
> 
> In a previous patch, I added that '-c' argument only to tests that feature
> pass/fail criteria. Some tests don't feature it. This is why you don't
> find this option everywhere.
> 
> Does this answer your question?
> 
> Which parser are you refering to?
> 
> > Otherwise, the patch looks fine to me. Applied it and seems to be
> > working fine.
> 
> Thanks for your feedback.
> 
> Gilles.

