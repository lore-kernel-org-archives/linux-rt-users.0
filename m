From: Daniel Walker <dwalker@mvista.com>
Subject: Re: nmi_watchdog in latest 22 and 23-rc -rt series
Date: Tue, 11 Sep 2007 11:06:51 -0700
Message-ID: <1189534011.20371.1.camel@imap.mvista.com>
References: <46E67E6F0200006C000182F4@sinclair.provo.novell.com>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Cc: linux-rt-users@vger.kernel.org
To: David Bahi <dbahi@novell.com>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from gateway-1237.mvista.com ([63.81.120.158]:21914 "EHLO
	gateway-1237.mvista.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753460AbXIKSG5 (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Tue, 11 Sep 2007 14:06:57 -0400
In-Reply-To: <46E67E6F0200006C000182F4@sinclair.provo.novell.com>
Sender: linux-rt-users-owner@vger.kernel.org
List-Id: linux-rt-users.vger.kernel.org

On Tue, 2007-09-11 at 11:39 -0600, David Bahi wrote:
> On Tue, 2007-09-11 at 02:10 +0000, David Bahi wrote:
> > trying to get a crashdump in a clean -rt series kernel which hardlocks
> > on the ltp openposix conformance interfaces sched_yield 1-1.test ...
> > 
> > i was trying with nmi_watchdog = 1 (x86_64 machine, dual cpu, quad core,
> > HT enabled) and it would report NMI LOCKUP on presentation of the login
> > prompt - no chance to run the test.
> > 
> >                            linux-2.6.22.1-rt9   linux-2.6.23-rc4-rt1
> > lockup on openposix 
> > sched_yield test occurs            yes                  yes
> > 
> > crash on login prompt
> > with nmi_watchdog=1                yes*                 yes*
> > 
> >   (*) console logs attached
> > 
> > 
> 
> fyi 2.6.23-rc4 w/o -rt passes the LTP openposix sched_yeild test and
> does *not* crash (NMI LOCKUP) if nmi_watchdog=1 is a boot arg.
> 
> so these don't seem to be related to what i'm seeing at least:
> 
>   http://thread.gmane.org/gmane.linux.kernel/577449

The patches above are related to nmi_watchdog=2 . Is the same lock up
detected with nmi_watchdog=2 ?

Daniel
