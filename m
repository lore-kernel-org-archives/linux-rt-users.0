From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Subject: Re: RT, what to do about up/down_read_non_owner()
Date: Mon, 6 Jun 2016 09:49:41 +0200
Message-ID: <c3b6168e-dde1-fb3b-36e6-5ff4c75e7355@linutronix.de>
References: <1465109869.4263.23.camel@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Cc: Thomas Gleixner <tglx@linutronix.de>,
	Peter Zijlstra <peterz@infradead.org>,
	Ingo Molnar <mingo@redhat.com>
To: Mike Galbraith <umgwanakikbuti@gmail.com>,
	linux-rt-users <linux-rt-users@vger.kernel.org>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from www.linutronix.de ([62.245.132.108]:59314 "EHLO
	Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751164AbcFFHtr (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Mon, 6 Jun 2016 03:49:47 -0400
In-Reply-To: <1465109869.4263.23.camel@gmail.com>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

On 06/05/2016 08:57 AM, Mike Galbraith wrote:
> Greetings,
> 
> In v4.7, Al added those buggers to NFS.  BCACHE is disabled in RT
> because of same.. but that's a somewhat suboptimal solution for
> something as widely used as NFS.
> 
> Suggestions?  I reverted the offending commit to get 4.7-rt up and
> running, but that's not gonna fly long term.

This API should be avoided according to the comment and completions
should be used. I am for removal of those. Were the locking people okay
with this change in the first place or did this just sneak in?

> 
> 	-Mike
> 
Sebastian
