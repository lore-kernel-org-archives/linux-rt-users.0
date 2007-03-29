From: Chirag Jog <chirag@linux.vnet.ibm.com>
Subject: Re: autotoolize tests
Date: Thu, 29 Mar 2007 22:10:27 +0530
Message-ID: <20070329164027.GA16331@linux.vnet.ibm.com>
References: <20070328152625.GA2470@linux.vnet.ibm.com> <20070329130830.GH32369@pengutronix.de> <20070329153654.GC4300@linux.vnet.ibm.com> <20070329154418.GK32369@pengutronix.de>
Reply-To: Chirag Jog <chirag@linux.vnet.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: linux-rt-users@vger.kernel.org
To: Robert Schwebel <r.schwebel@pengutronix.de>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from e1.ny.us.ibm.com ([32.97.182.141]:56093 "EHLO e1.ny.us.ibm.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1030376AbXC2Qkb (ORCPT <rfc822;linux-rt-users@vger.kernel.org>);
	Thu, 29 Mar 2007 12:40:31 -0400
Received: from d01relay04.pok.ibm.com (d01relay04.pok.ibm.com [9.56.227.236])
	by e1.ny.us.ibm.com (8.13.8/8.13.8) with ESMTP id l2TGeSAG029110
	for <linux-rt-users@vger.kernel.org>; Thu, 29 Mar 2007 12:40:28 -0400
Received: from d01av02.pok.ibm.com (d01av02.pok.ibm.com [9.56.224.216])
	by d01relay04.pok.ibm.com (8.13.8/8.13.8/NCO v8.3) with ESMTP id l2TGeSCI306692
	for <linux-rt-users@vger.kernel.org>; Thu, 29 Mar 2007 12:40:28 -0400
Received: from d01av02.pok.ibm.com (loopback [127.0.0.1])
	by d01av02.pok.ibm.com (8.12.11.20060308/8.13.3) with ESMTP id l2TGeS1g010109
	for <linux-rt-users@vger.kernel.org>; Thu, 29 Mar 2007 12:40:28 -0400
Content-Disposition: inline
In-Reply-To: <20070329154418.GK32369@pengutronix.de>
Sender: linux-rt-users-owner@vger.kernel.org
List-Id: linux-rt-users.vger.kernel.org

On Thu, Mar 29, 2007 at 05:44:18PM +0200, Robert Schwebel wrote:
> On Thu, Mar 29, 2007 at 09:06:54PM +0530, Chirag Jog wrote:
> > > Hmm, which autoreconf version are you using? It works here, with automake 1.9
> > 
> > > and autoconf 2.61:
> > 
> > I was using autoconf 2.59
> > I have upgraded to 2.61
> > It works now!!
> 
> They seem to have fixed autoreconf; are you ok with using 2.61, or shall
> I send a patch that adds a manual autogen.sh which works without
> autoreconf?
I am good. Not a problem.
I will add a README indicating which versions of automake and autoconf should be there.
> 
> Robert
> -- 
>  Dipl.-Ing. Robert Schwebel | http://www.pengutronix.de
>  Pengutronix - Linux Solutions for Science and Industry
>    Handelsregister:  Amtsgericht Hildesheim, HRA 2686
>      Hannoversche Str. 2, 31134 Hildesheim, Germany
>    Phone: +49-5121-206917-0 |  Fax: +49-5121-206917-9
> 
> -
> To unsubscribe from this list: send the line "unsubscribe linux-rt-users" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html

-- 
Cheers,
Chirag Jog
Real Time Linux Team,
Linux Technology Centre,
Bangalore, India

"Never agree with an Idiot, They will bring you down to their level and beat you with experience"
