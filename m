From: "Bill Huey (hui)" <bill.huey@gmail.com>
Subject: Re: [PATCH [RT] 11/14] optimize the !printk fastpath through the lock acquisition
Date: Sun, 24 Feb 2008 22:21:07 -0800
Message-ID: <9810cff90802242221x2f16dc79k634cecf2c1cee41e@mail.gmail.com>
References: <20080221152504.4804.8724.stgit@novell1.haskins.net>
	 <20080221152722.4804.77478.stgit@novell1.haskins.net>
	 <20080222191837.GE6060@ucw.cz> <47BF4AC5.7070507@gmail.com>
	 <9810cff90802221643g7d993af4k33f29fb4a4663407@mail.gmail.com>
	 <47C2500E.9080407@gmail.com>
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
Received: from wr-out-0506.google.com ([64.233.184.235]:21659 "EHLO
	wr-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752958AbYBYGVJ (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Mon, 25 Feb 2008 01:21:09 -0500
Received: by wr-out-0506.google.com with SMTP id c48so2194150wra.23
        for <linux-rt-users@vger.kernel.org>; Sun, 24 Feb 2008 22:21:08 -0800 (PST)
In-Reply-To: <47C2500E.9080407@gmail.com>
Content-Disposition: inline
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

[repost with all folks CCed]

On Sun, Feb 24, 2008 at 9:20 PM, Gregory Haskins
<gregory.haskins.ml@gmail.com> wrote:
>  Are you saying that the modified logic that I introduced is broken?  Or
>  that the original use of the might_sleep() annotation inside this
>  function is broken?

It's probably safe to use, but it's not what its original purpose was
and you should use another function/macro. This is an annotation issue
and your use of it is inconsistent with how it's used in voluntary
preempt. I mentioned it before in a previous post. Folks will correct
me if I'm wrong but you should use another macro or function.

bill
