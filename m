From: Ingo Molnar <mingo@elte.hu>
Subject: Re: [PATCH 3/3] Subject: SCHED - Use a 2-d bitmap for searching
	lowest-pri CPU
Date: Wed, 5 Dec 2007 12:44:38 +0100
Message-ID: <20071205114438.GC6143@elte.hu>
References: <20071205025137.4494.18683.stgit@novell1.haskins.net> <20071205025538.4494.52380.stgit@novell1.haskins.net> <20071205093412.GA17911@elte.hu> <475634F8.BA47.005A.0@novell.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: rostedt@goodmis.org, linux-kernel@vger.kernel.org,
	linux-rt-users@vger.kernel.org
To: Gregory Haskins <ghaskins@novell.com>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from mx2.mail.elte.hu ([157.181.151.9]:49748 "EHLO mx2.mail.elte.hu"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751502AbXLELox (ORCPT <rfc822;linux-rt-users@vger.kernel.org>);
	Wed, 5 Dec 2007 06:44:53 -0500
Content-Disposition: inline
In-Reply-To: <475634F8.BA47.005A.0@novell.com>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>


* Gregory Haskins <ghaskins@novell.com> wrote:

> However, that said, Steven's testing work on the mainline port of our 
> series sums it up very nicely, so I will present that in lieu of 
> digging up my -rt numbers unless you specifically want them too.  Here 
> they are:

i'm well aware of Steve's benchmarking efforts, but i dont think he's 
finished with it and i'll let him present the results once he wants to 
announce them. I asked about the effects of the "2-d" patch in isolation 
and i'm not sure the numbers show that individual patch in action.

in any case, you are preaching to the choir, i wrote the first 
rt-overload code and it's been in -rt forever so it's not like you need 
to sell me the concept ;-) But upstream quality requirements are 
different from -rt and we need to examine all aspects of scheduling, not 
just latency. In any case, i'll wait for the rest of Steve's numbers.

	Ingo
