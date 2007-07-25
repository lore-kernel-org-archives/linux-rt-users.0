From: Ingo Molnar <mingo@elte.hu>
Subject: Re: [PATCH] Display -rt related stats in /proc/schedstat
Date: Wed, 25 Jul 2007 13:35:15 +0200
Message-ID: <20070725113515.GA25794@elte.hu>
References: <20070723125925.GE8055@in.ibm.com> <20070725080504.GD5125@elte.hu> <20070725112924.GC7745@in.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: linux-rt-users <linux-rt-users@vger.kernel.org>,
	Dinakar Guniguntala <dino@in.ibm.com>
To: Ankita Garg <ankita@in.ibm.com>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from mx2.mail.elte.hu ([157.181.151.9]:41512 "EHLO mx2.mail.elte.hu"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1759788AbXGYLfW (ORCPT <rfc822;linux-rt-users@vger.kernel.org>);
	Wed, 25 Jul 2007 07:35:22 -0400
Content-Disposition: inline
In-Reply-To: <20070725112924.GC7745@in.ibm.com>
Sender: linux-rt-users-owner@vger.kernel.org
List-Id: linux-rt-users.vger.kernel.org


* Ankita Garg <ankita@in.ibm.com> wrote:

> > > This patch adds support to display captured -rt stats under 
> > > /proc/schedstat.
> > 
> > hm, could you add it to /proc/sched_debug instead? That's where all 
> > the runqueue values are showing up normally. I'm also a bit wary 
> > about introducing a new schedstats version for -rt.
> 
> So, I have merged my previous patch (to display rt_nr_running info in 
> sched_debug.c) with this one.

thanks, applied.

	Ingo
