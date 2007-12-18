From: Steven Rostedt <srostedt@redhat.com>
Subject: Re: [PATCH] sched: dynamically update the root-domain span/online
 maps
Date: Tue, 18 Dec 2007 06:39:00 -0500
Message-ID: <4767B154.7010507@redhat.com>
References: <20071218023805.4390.19471.stgit@novell1.haskins.net> <20071218105513.GA9002@elte.hu>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Cc: Gregory Haskins <ghaskins@novell.com>,
	linux-rt-users@vger.kernel.org, linux-kernel@vger.kernel.org
To: Ingo Molnar <mingo@elte.hu>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from mx1.redhat.com ([66.187.233.31]:51275 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752661AbXLRLja (ORCPT <rfc822;linux-rt-users@vger.kernel.org>);
	Tue, 18 Dec 2007 06:39:30 -0500
In-Reply-To: <20071218105513.GA9002@elte.hu>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

Ingo Molnar wrote:

> well since i reverted the original patch, there's no regression. The 
> question is, do we know whether this new patch works fine wrt. s2ram?
> 

Hi Ingo,

I included the same patches into 2.6.23.9-rt13 and someone reported s2r 
failed for them. I've included Greg's updates into a pre release of 
-rt14 and sent that to the reporter. I'm waiting on a response before 
releasing -rt14.

Although I did just get a response from Andrew Morton saying that the 
updated patch fixed his box.

-- Steve
