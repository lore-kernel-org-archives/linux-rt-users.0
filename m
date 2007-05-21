From: Thomas Gleixner <tglx@linutronix.de>
Subject: Re: v2.6.21-rt3
Date: Mon, 21 May 2007 22:36:05 +0200
Message-ID: <1179779765.12708.50.camel@chaos>
References: <20070517194143.GA25394@elte.hu>
	 <1179778266.15427.38.camel@imap.mvista.com>
	 <1179779053.12708.45.camel@chaos>
	 <1179779142.15427.44.camel@imap.mvista.com>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Cc: Ingo Molnar <mingo@elte.hu>, linux-kernel@vger.kernel.org,
	linux-rt-users@vger.kernel.org
To: Daniel Walker <dwalker@mvista.com>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from www.osadl.org ([213.239.205.134]:56091 "EHLO mail.tglx.de"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1752100AbXEUUgH (ORCPT <rfc822;linux-rt-users@vger.kernel.org>);
	Mon, 21 May 2007 16:36:07 -0400
In-Reply-To: <1179779142.15427.44.camel@imap.mvista.com>
Sender: linux-rt-users-owner@vger.kernel.org
List-Id: linux-rt-users.vger.kernel.org

On Mon, 2007-05-21 at 13:25 -0700, Daniel Walker wrote:
> On Mon, 2007-05-21 at 22:24 +0200, Thomas Gleixner wrote:
> > On Mon, 2007-05-21 at 13:11 -0700, Daniel Walker wrote:
> > > Where did the arm ep93xx changes come from? 
> > 
> > Grown out of my nose probably.
> > 
> > > It looks like patch below
> > > came in with them in 2.6.21-rt6 ..
> > 
> > So what ?
> 
> It's silencing a WARN_ON() with no real reason why it's happening, or
> why/if it's safe to silence it .. Why is that there?

Care to look at the code ? 

	tglx
