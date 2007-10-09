From: Peter Zijlstra <peterz@infradead.org>
Subject: Re: [PATCH 0/5] RT: scheduler fixes and rt_overload enhancements
Date: Tue, 09 Oct 2007 17:39:19 +0200
Message-ID: <1191944359.6848.18.camel@twins>
References: <20071009142044.4941.65189.stgit@novell1.haskins.net>
	 <Pine.LNX.4.58.0710091054430.21404@gandalf.stny.rr.com>
	 <1191944024.4281.72.camel@ghaskins-t60p.haskins.net>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Cc: Steven Rostedt <rostedt@goodmis.org>, Ingo Molnar <mingo@elte.hu>,
	linux-rt-users <linux-rt-users@vger.kernel.org>,
	kravetz@us.ibm.com, LKML <linux-kernel@vger.kernel.org>,
	pmorreale@novell.com, sdietrich@novell.com
To: Gregory Haskins <ghaskins@novell.com>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from pentafluge.infradead.org ([213.146.154.40]:36649 "EHLO
	pentafluge.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753145AbXJIPjf (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Tue, 9 Oct 2007 11:39:35 -0400
In-Reply-To: <1191944024.4281.72.camel@ghaskins-t60p.haskins.net>
Sender: linux-rt-users-owner@vger.kernel.org
List-Id: linux-rt-users.vger.kernel.org

On Tue, 2007-10-09 at 11:33 -0400, Gregory Haskins wrote:

> On the flip side:  Perhaps sending a reschedule-ipi that doesn't
> reschedule is simply misused, and the misuse should be cleaned up
> instead? 

It basically does TIF_WORK_MASK and TIF_NEED_RESCHED is one of the most
frequently used of those. Using it for any other bit in that mask is
IMHO not abuse.
