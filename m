From: Steven Rostedt <rostedt@goodmis.org>
Subject: Re: 2.6.25.4-rt2
Date: Mon, 19 May 2008 19:55:27 -0400 (EDT)
Message-ID: <Pine.LNX.4.58.0805191954100.4125@gandalf.stny.rr.com>
References: <1211237032.14697.76.camel@localhost.localdomain> <4832105C.4030101@gmx.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: RT <linux-rt-users@vger.kernel.org>
To: Dragan Noveski <perodog@gmx.net>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from hrndva-omtalb.mail.rr.com ([71.74.56.123]:43978 "EHLO
	hrndva-omtalb.mail.rr.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1759117AbYESXz2 (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Mon, 19 May 2008 19:55:28 -0400
In-Reply-To: <4832105C.4030101@gmx.net>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>


On Tue, 20 May 2008, Dragan Noveski wrote:
> Steven Rostedt wrote:
> > We are pleased to announce the 2.6.25.4-rt2 tree, which can be
> > downloaded from the location:
> >
> >   http://rt.et.redhat.com/download/
> >
> hallo, when compiling of the source is finished i get this warning:
>
> .....
>   Building modules, stage 2.
>   MODPOST 268 modules
> WARNING: modpost: Found 5 section mismatch(es).
> To see full details build your kernel with:
> 'make CONFIG_DEBUG_SECTION_MISMATCH=y'
>
>
>
> i would be very thankful if someone could explain what this warning is
> about.
> should i expect any special troubles with this kernel?


I get that same warning. Perhaps I should turn on that config option and
see what's the trouble ;-)

So far I haven't had any problems, but that doesn't mean that there isn't
any. I'll start looking at what's causing that.

Thanks,

-- Steve

