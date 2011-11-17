From: Luis Henriques <henrix@camandro.org>
Subject: Re: [PATCH -rt] memcg: use migrate_disable()/migrate_enable( ) in
 memcg_check_events()
Date: Thu, 17 Nov 2011 11:44:51 +0000
Message-ID: <20111117114451.GC3762@hades>
References: <alpine.LFD.2.02.1111150050590.4902@ionos>
 <20111115084059.GA23250@zhy>
 <20111116091653.GA8692@zhy>
 <1321452758.4181.18.camel@frodo>
 <alpine.LFD.2.02.1111161801270.4902@ionos>
 <20111117030332.GA14492@zhy>
 <alpine.LFD.2.02.1111171125020.4902@ionos>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Yong Zhang <yong.zhang0@gmail.com>,
	Steven Rostedt <rostedt@goodmis.org>,
	LKML <linux-kernel@vger.kernel.org>,
	linux-rt-users <linux-rt-users@vger.kernel.org>,
	Peter Zijlstra <peterz@infradead.org>
To: Thomas Gleixner <tglx@linutronix.de>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from haggis.mythic-beasts.com ([93.93.131.52]:56953 "EHLO
	haggis.mythic-beasts.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756594Ab1KQLpi (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Thu, 17 Nov 2011 06:45:38 -0500
Content-Disposition: inline
In-Reply-To: <alpine.LFD.2.02.1111171125020.4902@ionos>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

On Thu, Nov 17, 2011 at 11:25:56AM +0100, Thomas Gleixner wrote:
> Johannes came up with a different solution. Could you please give it a try?

Again, I've run a quick test and it looks like this solves the issue.

Cheers,
--
Luis Henriques
