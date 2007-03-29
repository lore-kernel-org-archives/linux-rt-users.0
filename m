From: Chirag Jog <chirag@linux.vnet.ibm.com>
Subject: Re: autotoolize tests
Date: Thu, 29 Mar 2007 21:06:54 +0530
Message-ID: <20070329153654.GC4300@linux.vnet.ibm.com>
References: <20070328152625.GA2470@linux.vnet.ibm.com> <20070329130830.GH32369@pengutronix.de>
Reply-To: Chirag Jog <chirag@linux.vnet.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: linux-rt-users@vger.kernel.org
To: Robert Schwebel <r.schwebel@pengutronix.de>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from e4.ny.us.ibm.com ([32.97.182.144]:41446 "EHLO e4.ny.us.ibm.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753780AbXC2Pg5 (ORCPT <rfc822;linux-rt-users@vger.kernel.org>);
	Thu, 29 Mar 2007 11:36:57 -0400
Received: from d01relay04.pok.ibm.com (d01relay04.pok.ibm.com [9.56.227.236])
	by e4.ny.us.ibm.com (8.13.8/8.13.8) with ESMTP id l2TFatLJ009427
	for <linux-rt-users@vger.kernel.org>; Thu, 29 Mar 2007 11:36:55 -0400
Received: from d01av02.pok.ibm.com (d01av02.pok.ibm.com [9.56.224.216])
	by d01relay04.pok.ibm.com (8.13.8/8.13.8/NCO v8.3) with ESMTP id l2TFatLo249586
	for <linux-rt-users@vger.kernel.org>; Thu, 29 Mar 2007 11:36:55 -0400
Received: from d01av02.pok.ibm.com (loopback [127.0.0.1])
	by d01av02.pok.ibm.com (8.12.11.20060308/8.13.3) with ESMTP id l2TFasOl014470
	for <linux-rt-users@vger.kernel.org>; Thu, 29 Mar 2007 11:36:54 -0400
Content-Disposition: inline
In-Reply-To: <20070329130830.GH32369@pengutronix.de>
Sender: linux-rt-users-owner@vger.kernel.org
List-Id: linux-rt-users.vger.kernel.org

On Thu, Mar 29, 2007 at 03:08:30PM +0200, Robert Schwebel wrote:
> On Wed, Mar 28, 2007 at 08:56:25PM +0530, Chirag Jog wrote:
> > I applied the patches you gave out and applied them to the test tree.
> > After running the autogen.sh script, the configure script is created
> > as expected. But the configure script on running, gives an error as
> > it expects a install-sh script in the config directory which is
> > missing. So I think maybe it got missed out or something.
> 
> Hmm, which autoreconf version are you using? It works here, with automake 1.9

> and autoconf 2.61:

I was using autoconf 2.59
I have upgraded to 2.61
It works now!!

> 
> ----------8<----------
> 
> rsc@isonoe:~/tmp/rtpreempt/dvhart/tests-ptx1$ ls config/autoconf/
> rsc@isonoe:~/tmp/rtpreempt/dvhart/tests-ptx1$ sh autogen.sh 
> 
> ----------
> autoreconf
> ----------
> 
> configure.ac:17: warning: The macro `AC_FOREACH' is obsolete.
> configure.ac:17: You should run autoupdate.
> ../../lib/autoconf/general.m4:196: AC_FOREACH is expanded from...
> aclocal.m4:695: _AM_SET_OPTIONS is expanded from...
> aclocal.m4:368: AM_INIT_AUTOMAKE is expanded from...
> configure.ac:17: the top level
> configure.ac:17: warning: The macro `AC_FOREACH' is obsolete.
> configure.ac:17: You should run autoupdate.
> ../../lib/autoconf/general.m4:196: AC_FOREACH is expanded from...
> aclocal.m4:695: _AM_SET_OPTIONS is expanded from...
> aclocal.m4:368: AM_INIT_AUTOMAKE is expanded from...
> configure.ac:17: the top level
> configure.ac: installing `config/autoconf/install-sh'
> configure.ac: installing `config/autoconf/missing'
> examples/GNUmakefile.am: installing `config/autoconf/compile'
> examples/GNUmakefile.am: installing `config/autoconf/depcomp'
> configure.ac:11: installing `config/autoconf/config.guess'
> configure.ac:11: installing `config/autoconf/config.sub'
> 
> --------
> Finished
> --------
> 
> rsc@isonoe:~/tmp/rtpreempt/dvhart/tests-ptx1$ ls -l config/autoconf/
> total 0
> lrwxrwxrwx 1 rsc ptx 31 Mar 29 15:06 compile -> /usr/share/automake-1.9/compile
> lrwxrwxrwx 1 rsc ptx 36 Mar 29 15:06 config.guess -> /usr/share/automake-1.9/config.guess
> lrwxrwxrwx 1 rsc ptx 34 Mar 29 15:06 config.sub -> /usr/share/automake-1.9/config.sub
> lrwxrwxrwx 1 rsc ptx 31 Mar 29 15:06 depcomp -> /usr/share/automake-1.9/depcomp
> lrwxrwxrwx 1 rsc ptx 34 Mar 29 15:06 install-sh -> /usr/share/automake-1.9/install-sh
> lrwxrwxrwx 1 rsc ptx 31 Mar 29 15:06 missing -> /usr/share/automake-1.9/missing
> 
> ----------8<----------
> 
> Robert
> -- 
>  Dipl.-Ing. Robert Schwebel | http://www.pengutronix.de
>  Pengutronix - Linux Solutions for Science and Industry
>    Handelsregister:  Amtsgericht Hildesheim, HRA 2686
>      Hannoversche Str. 2, 31134 Hildesheim, Germany
>    Phone: +49-5121-206917-0 |  Fax: +49-5121-206917-9

-- 
Cheers,
Chirag Jog
Real Time Linux Team,
Linux Technology Centre,
Bangalore, India

"Never agree with an Idiot, They will bring you down to their level and beat you with experience"
