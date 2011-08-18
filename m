From: Nivedita Singhvi <niv@us.ibm.com>
Subject: Re: proposed change to cyclictest -b <n> behavior
Date: Thu, 18 Aug 2011 11:37:19 -0700
Message-ID: <4E4D5BDF.2040605@us.ibm.com>
References: <20110818123717.2ff10c06@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Cc: RT <linux-rt-users@vger.kernel.org>,
	Steven Rostedt <srostedt@redhat.com>
To: Clark Williams <williams@redhat.com>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from e33.co.us.ibm.com ([32.97.110.151]:58152 "EHLO
	e33.co.us.ibm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750950Ab1HRSh3 (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Thu, 18 Aug 2011 14:37:29 -0400
Received: from d03relay02.boulder.ibm.com (d03relay02.boulder.ibm.com [9.17.195.227])
	by e33.co.us.ibm.com (8.14.4/8.13.1) with ESMTP id p7IITV1l006040
	for <linux-rt-users@vger.kernel.org>; Thu, 18 Aug 2011 12:29:31 -0600
Received: from d03av04.boulder.ibm.com (d03av04.boulder.ibm.com [9.17.195.170])
	by d03relay02.boulder.ibm.com (8.13.8/8.13.8/NCO v9.1) with ESMTP id p7IIbLEt152222
	for <linux-rt-users@vger.kernel.org>; Thu, 18 Aug 2011 12:37:24 -0600
Received: from d03av04.boulder.ibm.com (loopback [127.0.0.1])
	by d03av04.boulder.ibm.com (8.14.4/8.13.1/NCO v10.0 AVout) with ESMTP id p7ICbLNB022556
	for <linux-rt-users@vger.kernel.org>; Thu, 18 Aug 2011 06:37:21 -0600
In-Reply-To: <20110818123717.2ff10c06@redhat.com>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

Clark Williams wrote:
> All,
> 
> I was updating cyclictest in the rt-tests package to handle the 3.0-rt
> kernel changes and was talking to Steven Rostedt about ftrace options
> and he suggested this change to the -b (breaktrace) option: use event
> tracing rather than function tracing by default. 
> 
> The default for -b is to enable the function tracer. What Steven is
> suggesting is to trace using the already installed tracepoints to get
> an idea of where a latency occurs, rather than incurring the function
> tracer (mcount) overhead by default. This is equivalent to doing:
> 
> # cyclictest -b 1000 --event --tracer=nop
> 
> I like the idea, but wanted to ask the cyclictest users if this would
> break anything. I actually think that the whole ftrace interface for
> cyclictest needs to be overhauled, since it was done very ad hoc and is
> not all that well thought out, but I'm not quite ready to take that on
> now. 
> 
> So, anyone object to me making this change?


This sounds good to me. I'd prefer not to incur the extra
unnecessary overhead, too.

thanks,
Nivedita




