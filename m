From: Darren Hart <dvhltc@us.ibm.com>
Subject: Re: 2.6.23.rt3 fails to boot on 8 way opteron
Date: Thu, 25 Oct 2007 13:23:48 -0700
Message-ID: <200710251323.48751.dvhltc@us.ibm.com>
References: <200710251215.18172.dvhltc@us.ibm.com> <1193340061.16906.9.camel@imap.mvista.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-15"
Content-Transfer-Encoding: 7bit
Cc: Steven Rostedt <rostedt@goodmis.org>,
	RT <linux-rt-users@vger.kernel.org>
To: Daniel Walker <dwalker@mvista.com>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from e1.ny.us.ibm.com ([32.97.182.141]:40334 "EHLO e1.ny.us.ibm.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752972AbXJYUYN (ORCPT <rfc822;linux-rt-users@vger.kernel.org>);
	Thu, 25 Oct 2007 16:24:13 -0400
Received: from d01relay02.pok.ibm.com (d01relay02.pok.ibm.com [9.56.227.234])
	by e1.ny.us.ibm.com (8.13.8/8.13.8) with ESMTP id l9PKOCOK030305
	for <linux-rt-users@vger.kernel.org>; Thu, 25 Oct 2007 16:24:12 -0400
Received: from d01av03.pok.ibm.com (d01av03.pok.ibm.com [9.56.224.217])
	by d01relay02.pok.ibm.com (8.13.8/8.13.8/NCO v8.5) with ESMTP id l9PKOC0G136532
	for <linux-rt-users@vger.kernel.org>; Thu, 25 Oct 2007 16:24:12 -0400
Received: from d01av03.pok.ibm.com (loopback [127.0.0.1])
	by d01av03.pok.ibm.com (8.12.11.20060308/8.13.3) with ESMTP id l9PKOCh8005609
	for <linux-rt-users@vger.kernel.org>; Thu, 25 Oct 2007 16:24:12 -0400
In-Reply-To: <1193340061.16906.9.camel@imap.mvista.com>
Content-Disposition: inline
Sender: linux-rt-users-owner@vger.kernel.org
List-Id: linux-rt-users.vger.kernel.org

On Thursday 25 October 2007 12:21:01 Daniel Walker wrote:
> On Thu, 2007-10-25 at 12:15 -0700, Darren Hart wrote:
> > Steven,
> >
> > Per our discussion on irc, here is more context surrounding the crash. 
> > The system boots fine with rt1 and the same .config.
>
> Not sure what the IRC context is, but if you use the broken out set you
> can likely bisect through last 15-20 patches to see which one is the
> culprit (if it was something added recently)..

Sorry, the irc reference wasn't particularly relevant since I just mentioned 
it was broken and provided a subset of output I sent to this list.  And yes, 
I am basically now doing what you suggest above with the broken out patch 
set.

Thanks,

-- 
Darren Hart
IBM Linux Technology Center
Realtime Linux Team
