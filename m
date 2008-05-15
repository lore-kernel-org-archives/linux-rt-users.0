From: Gilles Carry <Gilles.Carry@bull.net>
Subject: Re: [LTP] realtime run shellscripts suite - question 1
Date: Thu, 15 May 2008 13:34:32 +0200
Message-ID: <482C1FC8.3010409@bull.net>
References: <4829A2B7.2010200@bull.net>	 <1210750236.4747.6.camel@subratamodak.linux.ibm.com>	 <200805151131.29082.sripathik@in.ibm.com>	 <1210834102.4738.1.camel@subratamodak.linux.ibm.com>	 <482BDED7.1050405@bull.net> <1210834847.4738.5.camel@subratamodak.linux.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Cc: Sripathi Kodi <sripathik@in.ibm.com>,
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
To: subrata@linux.vnet.ibm.com
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from ecfrec.frec.bull.fr ([129.183.4.8]:54978 "EHLO
	ecfrec.frec.bull.fr" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754378AbYEOLeJ (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Thu, 15 May 2008 07:34:09 -0400
In-Reply-To: <1210834847.4738.5.camel@subratamodak.linux.ibm.com>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

Here it is:

perf/latency
func/hrtimer-prio
func/measurement
have a run.sh instead of a run_auto.sh and therefore cannot be reached 
by ./run.sh -t all
Is this intentional or shall I rename them as run_auto.sh?

Gilles.
