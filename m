From: Sripathi Kodi <sripathik@in.ibm.com>
Subject: Re: [LTP] realtime run shellscripts suite - anyone using it?
Date: Thu, 15 May 2008 11:31:28 +0530
Message-ID: <200805151131.29082.sripathik@in.ibm.com>
References: <4829A2B7.2010200@bull.net> <1210750236.4747.6.camel@subratamodak.linux.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: 7bit
Cc: dvhltc <dvhltc@linux.vnet.ibm.com>, tinytim <tinytim@us.ibm.com>,
	Nivedita Singhvi <niv@us.ibm.com>,
	Chirag Jog <chirag@linux.vnet.ibm.com>,
	Ankita Garg <ankita@in.ibm.com>,
	dino <dino@linux.vnet.ibm.com>,
	Sebastien Dugue <sebastien.dugue@bull.net>,
	Jean-Pierre Dion <jean-pierre.dion@bull.net>,
	Michael Olbrich <m.olbrich@pengutronix.de>,
	Robert Schwebel <r.schwebel@pengutronix.de>,
	ltp-list <ltp-list@lists.sourceforge.net>,
	Gilles Carry <Gilles.Carry@bull.net>,
	linux-rt-users <linux-rt-users@vger.kernel.org>
To: subrata@linux.vnet.ibm.com
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from e28smtp04.in.ibm.com ([59.145.155.4]:40031 "EHLO
	e28smtp04.in.ibm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751962AbYEOGBq (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Thu, 15 May 2008 02:01:46 -0400
Received: from d28relay04.in.ibm.com (d28relay04.in.ibm.com [9.184.220.61])
	by e28smtp04.in.ibm.com (8.13.1/8.13.1) with ESMTP id m4F61Uo7008856
	for <linux-rt-users@vger.kernel.org>; Thu, 15 May 2008 11:31:30 +0530
Received: from d28av04.in.ibm.com (d28av04.in.ibm.com [9.184.220.66])
	by d28relay04.in.ibm.com (8.13.8/8.13.8/NCO v8.7) with ESMTP id m4F61K6Z688168
	for <linux-rt-users@vger.kernel.org>; Thu, 15 May 2008 11:31:20 +0530
Received: from d28av04.in.ibm.com (loopback [127.0.0.1])
	by d28av04.in.ibm.com (8.13.1/8.13.3) with ESMTP id m4F61Tx1026927
	for <linux-rt-users@vger.kernel.org>; Thu, 15 May 2008 11:31:30 +0530
In-Reply-To: <1210750236.4747.6.camel@subratamodak.linux.ibm.com>
Content-Disposition: inline
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

On Wednesday 14 May 2008 13:00, Subrata Modak wrote:
> Forwarding Gilles query to other RT developers.
>
> Regards--
> Subrata
>
> On Tue, 2008-05-13 at 16:16 +0200, Gilles Carry wrote:
> > Hello,
> >
> > I am investigating on how to run profiled tests for realtime
> > systems. I would like to do something integrated in the existing
> > system.
> >
> > After having roughly analyzed the existing scripts:
> > - run.sh looks for run_auto.sh files in tests dirs and run them
> > - run_auto.sh runs scripts/run_c_files.sh
> >
> > It turns out that the value added of these scripts is merely to set
> > some env vars and log stdout/err of tests. (am I missing
> > something?)
> >
> > Also, this cascade of scripts must deal with args which are
> > defined, analyzed and passed again to subsequent scripts. Tere are
> > also other tricks that make the whole thing heavy and uneasy.
> >
> > I want to write a simple script that runs command lines read from a
> > test profile choosed by the user (having each different arguments -
> > ie. pass criteria)
> >
> > Does anyone minds my simplifying the existing script suite?

Hi Gilles, Subrata,

In our project, we use the these scripts to run all or a selected bunch 
of tests under realtime directory. Please have a look at the output 
of "run.sh -h" under testcases/realtime. We also use the log files 
extensively. As far as existing  functionality is provided, we have no 
problems with doing improvements to the scripts.

Thanks,
Sripathi.


> >
> >
> > Gilles.
> >
> > -------------------------------------------------------------------
> >------ This SF.net email is sponsored by: Microsoft
> > Defy all challenges. Microsoft(R) Visual Studio 2008.
> > http://clk.atdmt.com/MRT/go/vse0120000070mrt/direct/01/
> > _______________________________________________
> > Ltp-list mailing list
> > Ltp-list@lists.sourceforge.net
> > https://lists.sourceforge.net/lists/listinfo/ltp-list
>
> --
> To unsubscribe from this list: send the line "unsubscribe
> linux-rt-users" in the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
