From: Darren Hart <dvhltc@us.ibm.com>
Subject: Re: [LTP] realtime run shellscripts suite - question 1
Date: Thu, 15 May 2008 22:33:40 +0000
Message-ID: <1210890820.26549.17.camel@Aeon>
References: <4829A2B7.2010200@bull.net>
	 <1210750236.4747.6.camel@subratamodak.linux.ibm.com>
	 <200805151131.29082.sripathik@in.ibm.com>
	 <1210834102.4738.1.camel@subratamodak.linux.ibm.com>
	 <482BDED7.1050405@bull.net>
	 <1210834847.4738.5.camel@subratamodak.linux.ibm.com>
	 <482C1FC8.3010409@bull.net>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Cc: subrata@linux.vnet.ibm.com, Sripathi Kodi <sripathik@in.ibm.com>,
	dvhltc <dvhltc@linux.vnet.ibm.com>, tinytim <tinytim@us.ibm.com>,
	Nivedita Singhvi <niv@us.ibm.com>,
	Chirag Jog <chirag@linux.vnet.ibm.com>,
	Ankita Garg <ankita@in.ibm.com>,
	dino <dino@linux.vnet.ibm.com>,
	Sebastien Dugue <sebastien.dugue@bull.net>,
	Jean-Pierre Dion <jean-pierre.dion@bull.net>,
	Michael Olbrich <m.olbrich@pengutronix.de>,
	Robert Schwebel <r.schwebel@pengutronix.de>,
	ltp-list <ltp-list@lists.sourceforge.net>,
	linux-rt-users <linux-rt-users@vger.kernel.org>
To: Gilles Carry <Gilles.Carry@bull.net>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from e36.co.us.ibm.com ([32.97.110.154]:38889 "EHLO
	e36.co.us.ibm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754404AbYEOWdr (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Thu, 15 May 2008 18:33:47 -0400
Received: from d03relay02.boulder.ibm.com (d03relay02.boulder.ibm.com [9.17.195.227])
	by e36.co.us.ibm.com (8.13.8/8.13.8) with ESMTP id m4FMXhOC023111
	for <linux-rt-users@vger.kernel.org>; Thu, 15 May 2008 18:33:43 -0400
Received: from d03av03.boulder.ibm.com (d03av03.boulder.ibm.com [9.17.195.169])
	by d03relay02.boulder.ibm.com (8.13.8/8.13.8/NCO v8.7) with ESMTP id m4FMXhGN108292
	for <linux-rt-users@vger.kernel.org>; Thu, 15 May 2008 16:33:43 -0600
Received: from d03av03.boulder.ibm.com (loopback [127.0.0.1])
	by d03av03.boulder.ibm.com (8.12.11.20060308/8.13.3) with ESMTP id m4FMXfji010292
	for <linux-rt-users@vger.kernel.org>; Thu, 15 May 2008 16:33:43 -0600
In-Reply-To: <482C1FC8.3010409@bull.net>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

On Thu, 2008-05-15 at 13:34 +0200, Gilles Carry wrote:
> Here it is:
> 
> perf/latency
> func/hrtimer-prio
> func/measurement
> have a run.sh instead of a run_auto.sh and therefore cannot be reached 
> by ./run.sh -t all
> Is this intentional or shall I rename them as run_auto.sh?
> 

The reason being (iirc) that we didn't want to include those in the
automatic run from the top level.  the individual run.sh must be run
automatically.

> Gilles.
-- 
Darren Hart
Real-Time Linux Team
IBM Linux Technology Center

