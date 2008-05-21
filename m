From: Mike Galbraith <efault@gmx.de>
Subject: Re: 2.6.24.7-rt8
Date: Wed, 21 May 2008 08:25:04 +0200
Message-ID: <1211351104.5484.13.camel@marge.simson.net>
References: <1211258763.14697.82.camel@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Cc: LKML <linux-kernel@vger.kernel.org>,
	RT <linux-rt-users@vger.kernel.org>, Ingo Molnar <mingo@elte.hu>,
	Thomas Gleixner <tglx@linutronix.de>
To: Steven Rostedt <rostedt@goodmis.org>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from mail.gmx.net ([213.165.64.20]:43638 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1751037AbYEUGZI (ORCPT <rfc822;linux-rt-users@vger.kernel.org>);
	Wed, 21 May 2008 02:25:08 -0400
In-Reply-To: <1211258763.14697.82.camel@localhost.localdomain>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>


Hi Steven,

On Tue, 2008-05-20 at 00:46 -0400, Steven Rostedt wrote:
> We are pleased to announce the 2.6.24.7-rt8 tree, which can be
> downloaded from the location:
> 
>   http://rt.et.redhat.com/download/

I ran mysql+oltp (ro) on 2.6.24.7-rt7 and 2.6.25-rt2 to compare
throughput to their parent trees, and ended up with strange (and
verified) looking performance curves for both trees.  The changes in
2.6.24.7-rt8 and 2.6.25.4-rt3 cured the primary oddities.

(it looks to me like there may be a little load-balancing issue, peak
throughput isn't where it should be for my Q6600 box)

	-Mike

