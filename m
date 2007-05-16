From: Daniel Walker <dwalker@mvista.com>
Subject: Re: v2.6.21-rt2
Date: Wed, 16 May 2007 14:20:48 -0700
Message-ID: <1179350448.20519.25.camel@imap.mvista.com>
References: <20070516180447.GA17922@elte.hu>
	 <1179348842.20519.20.camel@imap.mvista.com>
	 <20070516210104.GA17240@elte.hu>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Cc: linux-kernel@vger.kernel.org, linux-rt-users@vger.kernel.org
To: Ingo Molnar <mingo@elte.hu>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from gateway-1237.mvista.com ([63.81.120.158]:28693 "EHLO
	gateway-1237.mvista.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1759984AbXEPVXD (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Wed, 16 May 2007 17:23:03 -0400
In-Reply-To: <20070516210104.GA17240@elte.hu>
Sender: linux-rt-users-owner@vger.kernel.org
List-Id: linux-rt-users.vger.kernel.org

On Wed, 2007-05-16 at 23:01 +0200, Ingo Molnar wrote:
> * Daniel Walker <dwalker@mvista.com> wrote:
> 
> > On Wed, 2007-05-16 at 20:04 +0200, Ingo Molnar wrote:
> > > i'm pleased to announce the v2.6.20-rt2 kernel, which can be downloaded 
> > > from the usual place:
> > 
> > 2.6.21-rt2 ?
> 
> oops, right! :-)
> 
> > >   - fixes for various problems by Steven Rostedt and Clark Williams
> > 
> > I think you missed the fix I submitted for one of Steve's changes.
> > 
> > http://lkml.org/lkml/2007/5/3/368
> 
> hm - trace_hardirqs_on() should never be called with irqs on - lockdep 
> could break for example. Could you try to fix the call site instead?

If that's the case why check if they're enabled inside
trace_hardirqs_on() ? If that check fails you still still get the
warning in my original release ..

Daniel
