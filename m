From: Steven Rostedt <rostedt@goodmis.org>
Subject: Re: locking_selftest triggers WARN_ON by exceeding MAX_RWLOCK_DEPTH
Date: Fri, 20 Jun 2008 21:28:06 -0400 (EDT)
Message-ID: <Pine.LNX.4.58.0806202126020.28978@gandalf.stny.rr.com>
References: <1214005359.10102.26.camel@josh-work.beaverton.ibm.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: linux-rt-users@vger.kernel.org, Ingo Molnar <mingo@elte.hu>
To: Josh Triplett <josht@linux.vnet.ibm.com>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from hrndva-omtalb.mail.rr.com ([71.74.56.123]:47141 "EHLO
	hrndva-omtalb.mail.rr.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751083AbYFUB2J convert rfc822-to-8bit (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Fri, 20 Jun 2008 21:28:09 -0400
In-Reply-To: <1214005359.10102.26.camel@josh-work.beaverton.ibm.com>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>



On Fri, 20 Jun 2008, Josh Triplett wrote:
>
> However, CONFIG_DEBUG_LOCKING_API_SELFTESTS includes tests which
> intentionally use locks incorrectly, and in particular it locks witho=
ut
> unlocking.  This quickly reaches the 5 lock limit.  AA_rlock locks tw=
ice
> without unlocking, AA_rsem locks twice more without unlocking, and
> ABBA_rlock locks twice more before it unlocks; this nests read locks =
six
> deep, triggering the WARN_ON.
>
> Given that =EF=BB=BF=EF=BB=BFCONFIG_DEBUG_LOCKING_API_SELFTESTS exist=
s to use locks
> incorrectly, I don't think this necessarily needs fixing.  However,
> perhaps locking_selftest should print a big warning in advance if run
> without lockdep turned on, saying to expect locking-related
> warnings/bugs/panics?

Hmm, perhaps we should shoot up the limit if
CONFIG_DEBUG_LOCKING_API_SELFTESTS is turned on, otherwise it can do ba=
d
things. I hit the warn on, but I don't know how robust it is once a rea=
der
locking is above that limit. OTW, it may make the system unstable and i=
t
is not recommend to keep the box running.

-- Steve

--
To unsubscribe from this list: send the line "unsubscribe linux-rt-user=
s" in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
