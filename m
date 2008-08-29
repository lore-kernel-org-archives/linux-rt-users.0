From: Andi Kleen <andi@firstfloor.org>
Subject: Re: [PATCH] seqlock: serialize against writers
Date: Fri, 29 Aug 2008 19:08:51 +0200
Message-ID: <20080829170851.GZ26610@one.firstfloor.org>
References: <20080829154237.1196.66825.stgit@dev.haskins.net> <87abevpzv7.fsf@basil.nowhere.org> <48B81F60.3080409@gmail.com> <20080829162216.GW26610@one.firstfloor.org> <48B823F6.1010509@novell.com> <20080829163749.GX26610@one.firstfloor.org> <48B826BD.9000308@novell.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Andi Kleen <andi@firstfloor.org>,
	Gregory Haskins <gregory.haskins@gmail.com>, mingo@elte.hu,
	rostedt@goodmis.org, tglx@linutronix.de,
	linux-kernel@vger.kernel.org, linux-rt-users@vger.kernel.org
To: Gregory Haskins <ghaskins@novell.com>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from one.firstfloor.org ([213.235.205.2]:54892 "EHLO
	one.firstfloor.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757519AbYH2RGK (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Fri, 29 Aug 2008 13:06:10 -0400
Content-Disposition: inline
In-Reply-To: <48B826BD.9000308@novell.com>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>


No idea on the problem itself because I don't understand it, just:

> Given that, we either need to address the const requirement
> for userspace, alter userspace's usage, or find another way to address
> the deadlock.  Any ideas?

In the worst case you can always disable the vsyscall gtod() and
thus the need for a user space safe seqlock_t, but it will
hurt some workloads significantly. 

-Andi

