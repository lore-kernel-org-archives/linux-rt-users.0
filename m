From: Mike Galbraith <mgalbraith@suse.de>
Subject: Re: jitter test scalability problem - my theory
Date: Fri, 29 Jul 2011 16:47:19 +0200
Message-ID: <1311950839.30862.54.camel@marge.simson.net>
References: <1311949869.30862.45.camel@marge.simson.net>
	 <1311950140.5890.365.camel@twins>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Cc: RT <linux-rt-users@vger.kernel.org>, rostedt <rostedt@goodmis.org>
To: Peter Zijlstra <a.p.zijlstra@chello.nl>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from cantor2.suse.de ([195.135.220.15]:40086 "EHLO mx2.suse.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751145Ab1G2OrW (ORCPT <rfc822;linux-rt-users@vger.kernel.org>);
	Fri, 29 Jul 2011 10:47:22 -0400
In-Reply-To: <1311950140.5890.365.camel@twins>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

On Fri, 2011-07-29 at 16:35 +0200, Peter Zijlstra wrote:
> On Fri, 2011-07-29 at 16:31 +0200, Mike Galbraith wrote:
> > So it seems push/pull logic _may_ be my scalability problem.  Even
> > though there's nothing that can be pushed/pulled, it's hammering a few
> > locks from many cores, so cores perturb each other enough despite
> > isolation, to fail once enough cores are active.
> > 
> > Does that look like a reasonable explanation for my jitter increase? 
> 
> It is, Steve actually had patches for that..

Thanks for confirming. 

I know a guy (me) who would _love_ to test them :)  Diagnosing is one
thing, figuring out how to fix such an issue is quite another matter.

	-Mike

