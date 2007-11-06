From: Sven-Thorsten Dietrich <sven@thebigcorporation.com>
Subject: Re: How to use latency trace
Date: Tue, 06 Nov 2007 13:13:48 -0800
Message-ID: <1194383628.19313.22.camel@sx.thebigcorporation.com>
References: <30746519.1640811193957606209.JavaMail.www@wwinf6101>
	 <1985e0f60711020453o1e8d11e9m4de693d466d5ea57@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Cc: gerritbinnenmars@wanadoo.nl, linux-rt-users@vger.kernel.org
To: Jaswinder Singh <jaswinderlinuxrt@gmail.com>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from qmta05.emeryville.ca.mail.comcast.net ([76.96.30.48]:36235 "EHLO
	QMTA05.emeryville.ca.mail.comcast.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1754468AbXKFVUx (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Tue, 6 Nov 2007 16:20:53 -0500
In-Reply-To: <1985e0f60711020453o1e8d11e9m4de693d466d5ea57@mail.gmail.com>
Sender: linux-rt-users-owner@vger.kernel.org
List-Id: linux-rt-users.vger.kernel.org

On Fri, 2007-11-02 at 17:23 +0530, Jaswinder Singh wrote:
> hello Gerrit Binnenmars,
> 
> 
> On 11/2/07, Gerrit Binnenmars <gerritbinnenmars@wanadoo.nl> wrote:
> >
> > Another question: can you ever guarantee a max. latency if a user has access
> > to the system?
> >
> 

The user could trip over the power chord!

Seriously, users cannot use the high priorities, so apps running above
the user's MAX_PRIO should be safe from whatever the user does.

> I do not think so. this shows this is soft real time.
> 

> It best example is :
> 
> http://rt.wiki.kernel.org/index.php/Cyclictest
> 
> you can request for interval for 1000 so it should come 1000 all the
> time, but it is not.

Its should come CLOSE to 1000. What errors have you seen?

Have you run latency trace on your workload to identify any long
code-paths that need to be cleaned up?

Sven
