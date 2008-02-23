From: "Bill Huey (hui)" <bill.huey@gmail.com>
Subject: Re: [PATCH [RT] 11/14] optimize the !printk fastpath through the lock acquisition
Date: Fri, 22 Feb 2008 16:43:40 -0800
Message-ID: <9810cff90802221643g7d993af4k33f29fb4a4663407@mail.gmail.com>
References: <20080221152504.4804.8724.stgit@novell1.haskins.net>
	 <20080221152722.4804.77478.stgit@novell1.haskins.net>
	 <20080222191837.GE6060@ucw.cz> <47BF4AC5.7070507@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: "Pavel Machek" <pavel@ucw.cz>,
	"Gregory Haskins" <ghaskins@novell.com>, mingo@elte.hu,
	a.p.zijlstra@chello.nl, tglx@linutronix.de, rostedt@goodmis.org,
	linux-rt-users@vger.kernel.org, linux-kernel@vger.kernel.org,
	kevin@hilman.org, cminyard@mvista.com, dsingleton@mvista.com,
	dwalker@mvista.com, npiggin@suse.de, dsaxena@plexity.net,
	ak@suse.de, gregkh@suse.de, sdietrich@novell.com,
	pmorreale@novell.com, mkohari@novell.com
To: gregory.haskins@gmail.com
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from el-out-1112.google.com ([209.85.162.176]:34538 "EHLO
	el-out-1112.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S936898AbYBWAnm (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Fri, 22 Feb 2008 19:43:42 -0500
Received: by el-out-1112.google.com with SMTP id v27so577905ele.23
        for <linux-rt-users@vger.kernel.org>; Fri, 22 Feb 2008 16:43:41 -0800 (PST)
In-Reply-To: <47BF4AC5.7070507@gmail.com>
Content-Disposition: inline
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

On Fri, Feb 22, 2008 at 2:20 PM, Gregory Haskins
<gregory.haskins.ml@gmail.com> wrote:
>  Agreed, but it's still correct afaict.  I added an extra might_sleep()
>  to a path that really might sleep.  I should have mentioned that in the
>  header.
>
>  In any case, its moot.  Andi indicated this patch is probably a no-op so
>  I was considering dropping it on the v2 pass.

The might_sleep is annotation and well as a conditional preemption
point for the regular kernel. You might want to do a schedule check
there, but it's the wrong function if memory serves me correctly. It's
reserved for things that actually are design to sleep. The rt_spin*()
function are really a method of preserving BKL semantics across real
schedule() calls. You'd have to use something else instead for that
purpose like cond_reschedule() instead.

bill
