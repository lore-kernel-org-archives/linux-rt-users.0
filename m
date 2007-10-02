From: Zach Brown <zach.brown@oracle.com>
Subject: Re: [HACK] convert i_alloc_sem for direct_io.c craziness!
Date: Tue, 2 Oct 2007 11:18:16 -0700
Message-ID: <A29B0F5C-522C-4A6D-83B4-1F6EB419C7C2@oracle.com>
References: <Pine.LNX.4.58.0709241700290.13164@gandalf.stny.rr.com> <20071001195256.GB7718@mami.zabbo.net> <1191271156.5574.9.camel@lappy> <AE007B59-E6EB-4E4F-BAC4-7D49D61D1932@oracle.com> <Pine.LNX.4.58.0710021407200.7829@gandalf.stny.rr.com>
Mime-Version: 1.0 (Apple Message framework v752.3)
Content-Type: text/plain; charset=US-ASCII; delsp=yes; format=flowed
Content-Transfer-Encoding: 7bit
Cc: Peter Zijlstra <a.p.zijlstra@chello.nl>,
	LKML <linux-kernel@vger.kernel.org>,
	linux-rt-users <linux-rt-users@vger.kernel.org>,
	mingo@goodmis.org, Thomas Gleixner <tglx@linutronix.de>
To: Steven Rostedt <rostedt@goodmis.org>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from agminet01.oracle.com ([141.146.126.228]:58810 "EHLO
	agminet01.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756000AbXJBSSw (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Tue, 2 Oct 2007 14:18:52 -0400
In-Reply-To: <Pine.LNX.4.58.0710021407200.7829@gandalf.stny.rr.com>
Sender: linux-rt-users-owner@vger.kernel.org
List-Id: linux-rt-users.vger.kernel.org

> This looks more like a completion. Actually, completions don't have PI
> either, but they are usually OK.

Yeah, true.

> When more info becomes available, I will definitely CC the linux- 
> fsdevel
> list. Thanks for letting me know about it. (I usually get confused  
> by all
> the different lists that are out there).

OK, thanks.  (Yeah, it's not a great situation.)

- z
