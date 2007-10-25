From: Daniel Walker <dwalker@mvista.com>
Subject: Re: 2.6.23.rt3 fails to boot on 8 way opteron
Date: Thu, 25 Oct 2007 12:21:01 -0700
Message-ID: <1193340061.16906.9.camel@imap.mvista.com>
References: <200710251215.18172.dvhltc@us.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Cc: Steven Rostedt <rostedt@goodmis.org>,
	RT <linux-rt-users@vger.kernel.org>
To: Darren Hart <dvhltc@us.ibm.com>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from gateway-1237.mvista.com ([63.81.120.158]:50240 "EHLO
	gateway-1237.mvista.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753468AbXJYTZU (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Thu, 25 Oct 2007 15:25:20 -0400
In-Reply-To: <200710251215.18172.dvhltc@us.ibm.com>
Sender: linux-rt-users-owner@vger.kernel.org
List-Id: linux-rt-users.vger.kernel.org

On Thu, 2007-10-25 at 12:15 -0700, Darren Hart wrote:
> Steven, 
> 
> Per our discussion on irc, here is more context surrounding the crash.  The 
> system boots fine with rt1 and the same .config.
> 

Not sure what the IRC context is, but if you use the broken out set you
can likely bisect through last 15-20 patches to see which one is the
culprit (if it was something added recently).. 

Daniel
