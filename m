From: Andi Kleen <ak@suse.de>
Subject: Re: [PATCH] Don't sleep in oops_begin()
Date: Tue, 18 Sep 2007 10:05:49 +0200
Message-ID: <200709181005.49542.ak@suse.de>
References: <200709172012.21102.ak@suse.de> <200709172220.43871.ak@suse.de> <1190074235.3253.135.camel@imap.mvista.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: 7bit
Cc: Sven-Thorsten Dietrich <thebigcorporation@gmail.com>,
	mingo@elte.hu, Thomas Gleixner <tglx@linutronix.de>,
	linux-rt-users@vger.kernel.org
To: Daniel Walker <dwalker@mvista.com>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from mx2.suse.de ([195.135.220.15]:41394 "EHLO mx2.suse.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751832AbXIRIHZ (ORCPT <rfc822;linux-rt-users@vger.kernel.org>);
	Tue, 18 Sep 2007 04:07:25 -0400
In-Reply-To: <1190074235.3253.135.camel@imap.mvista.com>
Content-Disposition: inline
Sender: linux-rt-users-owner@vger.kernel.org
List-Id: linux-rt-users.vger.kernel.org


> > I disagree for the oops case.  You want the simplest possible code
> > here.
>
> If that's true for real time , should be true for mainline right?

You mean it shouldn't use lockdep etc. there? Yes good point. I can change 
that

-Andi
