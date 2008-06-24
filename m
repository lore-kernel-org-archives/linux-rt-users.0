From: "Gregory Haskins" <ghaskins@novell.com>
Subject: Re: [PATCH 0/3] RT: scheduler newidle enhancements
Date: Mon, 23 Jun 2008 19:51:58 -0600
Message-ID: <48601AFE.BA47.005A.0@novell.com>
References: <20080623225645.31515.36393.stgit@lsg.lsg.lab.novell.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 8BIT
Cc: <peterz@infradead.org>, "David Bahi" <DBahi@novell.com>,
	<linux-kernel@vger.kernel.org>, <linux-rt-users@vger.kernel.org>
To: <mingo@elte.hu>, <rostedt@goodmis.org>, <tglx@linutronix.de>,
	"Gregory Haskins" <GHaskins@novell.com>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from sinclair.provo.novell.com ([137.65.248.137]:18506 "EHLO
	sinclair.provo.novell.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751015AbYFXAvy convert rfc822-to-8bit (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Mon, 23 Jun 2008 20:51:54 -0400
In-Reply-To: <20080623225645.31515.36393.stgit@lsg.lsg.lab.novell.com>
Content-Disposition: inline
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

>>> On Mon, Jun 23, 2008 at  7:04 PM, in message
<20080623225645.31515.36393.stgit@lsg.lsg.lab.novell.com>, Gregory Haskins
<ghaskins@novell.com> wrote: 
>
> 
>   I think the patch 1/3 is a good one, but it requires careful review. Patch
>   2/3 is based upon some work I had seen PeterZ submit, so its possible to
>   just pull his work (if it hasnt been already) as opposed to this patch, if
>   desired.  Lastly, Patch 3/3 is a bit controversial so I put it last for
>   easier cherry picking of the first two.  It does help in our testing, but 
> it
>   will have to be reviewed carefully.

Err...in case it wasnt obvious, I had 2/3 and 3/3 inverted in my description.  2/3 is the controversial one, 3/3 is based on Peter's work.  Sorry for the(my) confusion. :)

-Greg

