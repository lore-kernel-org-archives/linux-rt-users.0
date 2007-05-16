From: Ingo Molnar <mingo@elte.hu>
Subject: Re: v2.6.21-rt2
Date: Wed, 16 May 2007 23:01:04 +0200
Message-ID: <20070516210104.GA17240@elte.hu>
References: <20070516180447.GA17922@elte.hu> <1179348842.20519.20.camel@imap.mvista.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: linux-kernel@vger.kernel.org, linux-rt-users@vger.kernel.org
To: Daniel Walker <dwalker@mvista.com>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from mx3.mail.elte.hu ([157.181.1.138]:59875 "EHLO mx3.mail.elte.hu"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S934377AbXEPVBI (ORCPT <rfc822;linux-rt-users@vger.kernel.org>);
	Wed, 16 May 2007 17:01:08 -0400
Content-Disposition: inline
In-Reply-To: <1179348842.20519.20.camel@imap.mvista.com>
Sender: linux-rt-users-owner@vger.kernel.org
List-Id: linux-rt-users.vger.kernel.org


* Daniel Walker <dwalker@mvista.com> wrote:

> On Wed, 2007-05-16 at 20:04 +0200, Ingo Molnar wrote:
> > i'm pleased to announce the v2.6.20-rt2 kernel, which can be downloaded 
> > from the usual place:
> 
> 2.6.21-rt2 ?

oops, right! :-)

> >   - fixes for various problems by Steven Rostedt and Clark Williams
> 
> I think you missed the fix I submitted for one of Steve's changes.
> 
> http://lkml.org/lkml/2007/5/3/368

hm - trace_hardirqs_on() should never be called with irqs on - lockdep 
could break for example. Could you try to fix the call site instead?

	Ingo
