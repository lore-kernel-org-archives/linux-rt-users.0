From: Peter Zijlstra <peterz@infradead.org>
Subject: Re: rt14: strace ->  migrate_disable_atomic imbalance
Date: Thu, 22 Sep 2011 08:31:37 +0200
Message-ID: <1316673097.27803.0.camel@twins>
References: <alpine.LFD.2.02.1109101052340.2723@ionos>
	 <1315737307.6544.1.camel@marge.simson.net>
	 <1315817948.26517.16.camel@twins>
	 <1315835562.6758.3.camel@marge.simson.net>
	 <1315839187.6758.8.camel@marge.simson.net> <1315926499.5977.19.camel@twins>
	 <1315927699.6445.6.camel@marge.simson.net> <1315930430.5977.21.camel@twins>
	 <1316600230.6628.6.camel@marge.simson.net>
	 <1316631037.24750.39.camel@twins>
	 <1316666782.6184.5.camel@marge.simson.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
Cc: linux-rt-users <linux-rt-users@vger.kernel.org>,
	Thomas Gleixner <tglx@linutronix.de>,
	LKML <linux-kernel@vger.kernel.org>,
	Oleg Nesterov <oleg@redhat.com>,
	Miklos Szeredi <miklos@szeredi.hu>, mingo <mingo@redhat.com>
To: Mike Galbraith <efault@gmx.de>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from merlin.infradead.org ([205.233.59.134]:55259 "EHLO
	merlin.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751927Ab1IVGcR convert rfc822-to-8bit (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Thu, 22 Sep 2011 02:32:17 -0400
In-Reply-To: <1316666782.6184.5.camel@marge.simson.net>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

On Thu, 2011-09-22 at 06:46 +0200, Mike Galbraith wrote:
> 
> ..perturbation (100% userspace hog) measurement proggy and jitter
> measurement proggy pinned to the same cpu makes 100% repeatable boom.
> 
> 
Uh ow... :-) I'd better go have a look then..
