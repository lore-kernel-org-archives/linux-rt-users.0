From: Gilles Carry <Gilles.Carry@bull.net>
Subject: Re: [LTP] realtime run shellscripts suite - question 1
Date: Fri, 16 May 2008 08:18:04 +0200
Message-ID: <482D271C.2040108@bull.net>
References: <4829A2B7.2010200@bull.net>	 <1210750236.4747.6.camel@subratamodak.linux.ibm.com>	 <200805151131.29082.sripathik@in.ibm.com>	 <1210834102.4738.1.camel@subratamodak.linux.ibm.com>	 <482BDED7.1050405@bull.net>	 <1210834847.4738.5.camel@subratamodak.linux.ibm.com>	 <482C1FC8.3010409@bull.net> <1210890820.26549.17.camel@Aeon>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
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
To: Darren Hart <dvhltc@us.ibm.com>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from ecfrec.frec.bull.fr ([129.183.4.8]:42222 "EHLO
	ecfrec.frec.bull.fr" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751017AbYEPGUw (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Fri, 16 May 2008 02:20:52 -0400
In-Reply-To: <1210890820.26549.17.camel@Aeon>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

Darren Hart wrote:
> On Thu, 2008-05-15 at 13:34 +0200, Gilles Carry wrote:
> 
>>Here it is:
>>
>>perf/latency
>>func/hrtimer-prio
>>func/measurement
>>have a run.sh instead of a run_auto.sh and therefore cannot be reached 
>>by ./run.sh -t all
>>Is this intentional or shall I rename them as run_auto.sh?
>>
> 
> 
> The reason being (iirc) that we didn't want to include those in the
> automatic run from the top level.  the individual run.sh must be run
> automatically.

OK. I'll make a separate patch for moving these to run_auto.sh.

Gilles.
