From: Daniel Walker <dwalker@mvista.com>
Subject: Re: v2.6.21-rt3
Date: Mon, 21 May 2007 13:41:12 -0700
Message-ID: <1179780072.15427.51.camel@imap.mvista.com>
References: <20070517194143.GA25394@elte.hu>
	 <1179778266.15427.38.camel@imap.mvista.com>
	 <1179779053.12708.45.camel@chaos>
	 <1179779142.15427.44.camel@imap.mvista.com>
	 <1179779765.12708.50.camel@chaos>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Cc: Ingo Molnar <mingo@elte.hu>, linux-kernel@vger.kernel.org,
	linux-rt-users@vger.kernel.org
To: Thomas Gleixner <tglx@linutronix.de>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from h155.mvista.com ([63.81.120.158]:5061 "EHLO
	gateway-1237.mvista.com" rhost-flags-OK-FAIL-OK-OK) by vger.kernel.org
	with ESMTP id S1755038AbXEUUnd (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Mon, 21 May 2007 16:43:33 -0400
In-Reply-To: <1179779765.12708.50.camel@chaos>
Sender: linux-rt-users-owner@vger.kernel.org
List-Id: linux-rt-users.vger.kernel.org

On Mon, 2007-05-21 at 22:36 +0200, Thomas Gleixner wrote:
> On Mon, 2007-05-21 at 13:25 -0700, Daniel Walker wrote:
> > On Mon, 2007-05-21 at 22:24 +0200, Thomas Gleixner wrote:
> > > On Mon, 2007-05-21 at 13:11 -0700, Daniel Walker wrote:
> > > > Where did the arm ep93xx changes come from? 
> > > 
> > > Grown out of my nose probably.
> > > 
> > > > It looks like patch below
> > > > came in with them in 2.6.21-rt6 ..
> > > 
> > > So what ?
> > 
> > It's silencing a WARN_ON() with no real reason why it's happening, or
> > why/if it's safe to silence it .. Why is that there?
> 
> Care to look at the code ? 

I copied the patch into the first email, I did look at it which is why
you got an email. Your introducing the patch , it's for you to explain
why it needs to be there.. considering that the comment says "hack" in
it, I have to wonder what the non-hack version is ..

Daniel
