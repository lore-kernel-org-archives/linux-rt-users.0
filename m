From: Mike Galbraith <efault@gmx.de>
Subject: Re: [ANNOUNCE] 3.0.4-rt13
Date: Tue, 13 Sep 2011 17:28:19 +0200
Message-ID: <1315927699.6445.6.camel@marge.simson.net>
References: <alpine.LFD.2.02.1109101052340.2723@ionos>
	 <1315737307.6544.1.camel@marge.simson.net>
	 <1315817948.26517.16.camel@twins>
	 <1315835562.6758.3.camel@marge.simson.net>
	 <1315839187.6758.8.camel@marge.simson.net> <1315926499.5977.19.camel@twins>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Cc: Thomas Gleixner <tglx@linutronix.de>,
	LKML <linux-kernel@vger.kernel.org>,
	linux-rt-users <linux-rt-users@vger.kernel.org>
To: Peter Zijlstra <peterz@infradead.org>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from mailout-de.gmx.net ([213.165.64.22]:50515 "HELO
	mailout-de.gmx.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with SMTP id S1755006Ab1IMP2Y (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Tue, 13 Sep 2011 11:28:24 -0400
In-Reply-To: <1315926499.5977.19.camel@twins>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

On Tue, 2011-09-13 at 17:08 +0200, Peter Zijlstra wrote:
> On Tue, 2011-09-13 at 15:36 +0200, Peter Zijlstra wrote:
> > Does the below cure things? It breaks !rt builds, but we can cure that
> > if it works..
> 
> n/m its broken like hell..

Since this seems to be a legitimate need for a non-preemptive wakeup,
how about we [re]create one to get rid of abuse?  (otoh, that would add
a branch everywhere.. btdt a couple times, always ended up tossing it)

	-Mike

