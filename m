From: Subrata Modak <subrata@linux.vnet.ibm.com>
Subject: Re: [LTP] realtime run shellscripts suite - anyone using it?
Date: Wed, 14 May 2008 13:00:36 +0530
Message-ID: <1210750236.4747.6.camel@subratamodak.linux.ibm.com>
References: <4829A2B7.2010200@bull.net>
Reply-To: subrata@linux.vnet.ibm.com
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Cc: ltp-list <ltp-list@lists.sourceforge.net>,
	Gilles Carry <Gilles.Carry@bull.net>,
	linux-rt-users <linux-rt-users@vger.kernel.org>
To: dvhltc <dvhltc@linux.vnet.ibm.com>, tinytim <tinytim@us.ibm.com>,
	Nivedita Singhvi <niv@us.ibm.com>,
	Chirag Jog <chirag@linux.vnet.ibm.com>,
	Ankita Garg <ankita@in.ibm.com>,
	Sripathi
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from e2.ny.us.ibm.com ([32.97.182.142]:37785 "EHLO e2.ny.us.ibm.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752168AbYENHan (ORCPT <rfc822;linux-rt-users@vger.kernel.org>);
	Wed, 14 May 2008 03:30:43 -0400
Received: from d01relay04.pok.ibm.com (d01relay04.pok.ibm.com [9.56.227.236])
	by e2.ny.us.ibm.com (8.13.8/8.13.8) with ESMTP id m4E7UgwY018422
	for <linux-rt-users@vger.kernel.org>; Wed, 14 May 2008 03:30:42 -0400
Received: from d01av02.pok.ibm.com (d01av02.pok.ibm.com [9.56.224.216])
	by d01relay04.pok.ibm.com (8.13.8/8.13.8/NCO v8.7) with ESMTP id m4E7UgxL150060
	for <linux-rt-users@vger.kernel.org>; Wed, 14 May 2008 03:30:42 -0400
Received: from d01av02.pok.ibm.com (loopback [127.0.0.1])
	by d01av02.pok.ibm.com (8.12.11.20060308/8.13.3) with ESMTP id m4E7UfBs017442
	for <linux-rt-users@vger.kernel.org>; Wed, 14 May 2008 03:30:42 -0400
In-Reply-To: <4829A2B7.2010200@bull.net>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

Forwarding Gilles query to other RT developers.

Regards--
Subrata

On Tue, 2008-05-13 at 16:16 +0200, Gilles Carry wrote:
> Hello,
> 
> I am investigating on how to run profiled tests for realtime systems.
> I would like to do something integrated in the existing system.
> 
> After having roughly analyzed the existing scripts:
> - run.sh looks for run_auto.sh files in tests dirs and run them
> - run_auto.sh runs scripts/run_c_files.sh
> 
> It turns out that the value added of these scripts is merely to set some 
> env vars and log stdout/err of tests. (am I missing something?)
> 
> Also, this cascade of scripts must deal with args which are defined, 
> analyzed and passed again to subsequent scripts. Tere are also other 
> tricks that make the whole thing heavy and uneasy.
> 
> I want to write a simple script that runs command lines read from a test 
> profile choosed by the user (having each different arguments - ie. pass 
> criteria)
> 
> Does anyone minds my simplifying the existing script suite?
> 
> 
> Gilles.
> 
> -------------------------------------------------------------------------
> This SF.net email is sponsored by: Microsoft 
> Defy all challenges. Microsoft(R) Visual Studio 2008. 
> http://clk.atdmt.com/MRT/go/vse0120000070mrt/direct/01/
> _______________________________________________
> Ltp-list mailing list
> Ltp-list@lists.sourceforge.net
> https://lists.sourceforge.net/lists/listinfo/ltp-list

