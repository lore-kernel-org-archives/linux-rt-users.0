From: Peter Zijlstra <a.p.zijlstra@chello.nl>
Subject: Re: jitter test scalability problem - my theory
Date: Fri, 29 Jul 2011 16:35:40 +0200
Message-ID: <1311950140.5890.365.camel@twins>
References: <1311949869.30862.45.camel@marge.simson.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
Cc: RT <linux-rt-users@vger.kernel.org>, rostedt <rostedt@goodmis.org>
To: Mike Galbraith <mgalbraith@suse.de>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from merlin.infradead.org ([205.233.59.134]:32815 "EHLO
	merlin.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751187Ab1G2OgH convert rfc822-to-8bit (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Fri, 29 Jul 2011 10:36:07 -0400
In-Reply-To: <1311949869.30862.45.camel@marge.simson.net>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

On Fri, 2011-07-29 at 16:31 +0200, Mike Galbraith wrote:
> So it seems push/pull logic _may_ be my scalability problem.  Even
> though there's nothing that can be pushed/pulled, it's hammering a few
> locks from many cores, so cores perturb each other enough despite
> isolation, to fail once enough cores are active.
> 
> Does that look like a reasonable explanation for my jitter increase? 

It is, Steve actually had patches for that.. 
