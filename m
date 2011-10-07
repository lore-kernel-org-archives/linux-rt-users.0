From: Fernando Lopez-Lezcano <nando@ccrma.Stanford.EDU>
Subject: Re: [ANNOUNCE] 3.0.6-rt17
Date: Fri, 07 Oct 2011 10:25:25 -0700
Message-ID: <4E8F3605.6060104@localhost>
References: <alpine.LFD.2.02.1110070046270.3240@ionos>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Cc: LKML <linux-kernel@vger.kernel.org>,
	linux-rt-users <linux-rt-users@vger.kernel.org>,
	Fernando Lopez-Lezcano <nando@ccrma.Stanford.EDU>
To: Thomas Gleixner <tglx@linutronix.de>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from smtp2.Stanford.EDU ([171.67.219.82]:53224 "EHLO
	smtp.stanford.edu" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1750753Ab1JGRZd (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Fri, 7 Oct 2011 13:25:33 -0400
In-Reply-To: <alpine.LFD.2.02.1110070046270.3240@ionos>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

On 10/06/2011 06:15 PM, Thomas Gleixner wrote:
> Dear RT Folks,
>
> I'm pleased to announce the 3.0.6-rt17 release.

Hi and thanks again. So far this one is not hanging which is very good 
news. But I still see the hrtimer_fixup_activate warnings I reported for 
rt16...

-- Fernando


> After chasing weird RCU stalls and hung task messages for quite some
> time a massive collaborative effort was able to track down and fix
> this showstopper. Explanation from the changelog:
...
