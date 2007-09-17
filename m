From: Andi Kleen <ak@suse.de>
Subject: Re: [PATCH] Fix compilation of 2.6.23rc4-rt1 without CONFIG_PREEMPT_RT
Date: Mon, 17 Sep 2007 18:27:25 +0200
Message-ID: <200709171827.25378.ak@suse.de>
References: <200709171752.37772.ak@suse.de> <1190044974.4374.80.camel@sven.thebigcorporation.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-15"
Content-Transfer-Encoding: 7bit
Cc: mingo@elte.hu, Thomas Gleixner <tglx@linutronix.de>,
	linux-rt-users@vger.kernel.org
To: Sven-Thorsten Dietrich <sdietrich@novell.com>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from ns1.suse.de ([195.135.220.2]:38411 "EHLO mx1.suse.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756522AbXIQQ13 (ORCPT <rfc822;linux-rt-users@vger.kernel.org>);
	Mon, 17 Sep 2007 12:27:29 -0400
In-Reply-To: <1190044974.4374.80.camel@sven.thebigcorporation.com>
Content-Disposition: inline
Sender: linux-rt-users-owner@vger.kernel.org
List-Id: linux-rt-users.vger.kernel.org

On Monday 17 September 2007 18:02:54 Sven-Thorsten Dietrich wrote:
> On Mon, 2007-09-17 at 17:52 +0200, Andi Kleen wrote:
> > count_active_rt_tasks() is undefined otherwise.
> > 
> 
> This does fix the compile issue, but RT tasks can exist in !PREEMPT_RT
> as well.

That might be, but neither rt_nr_running nor rt_nr_uninterruptible
exist in a !PREEMPT_RT kernel. So they are presumably managed in a different way.

-Andi
