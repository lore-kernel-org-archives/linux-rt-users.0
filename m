From: Frank Rowand <frank.rowand@am.sony.com>
Subject: Re: real-time priority
Date: Thu, 19 Mar 2009 16:13:36 -0700
Message-ID: <49C2D1A0.9080005@am.sony.com>
References: <49C2CAFB.5030702@lavabit.com>
Reply-To: frank.rowand@am.sony.com
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"
Content-Transfer-Encoding: 7bit
Cc: linux-rt-users@vger.kernel.org
To: Rodrigo Amestica <ramestica@lavabit.com>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from tx2ehsobe004.messaging.microsoft.com ([65.55.88.14]:11191 "EHLO
	TX2EHSOBE008.bigfish.com" rhost-flags-OK-OK-OK-FAIL)
	by vger.kernel.org with ESMTP id S1756806AbZCSX3G (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Thu, 19 Mar 2009 19:29:06 -0400
In-Reply-To: <49C2CAFB.5030702@lavabit.com>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

Rodrigo Amestica wrote:
> Hi,
> 
> general questions from somebody who's just starting to look into the
> preempt patch.
> 
> the article linked below makes direct reference to the behavior of the

The link is missing.


> preempt rt patch. The article was written in 2007. How much of that
> still holds true in the current version of the patch?
> 
> I'm basically wondering about the first sentences in the abstract of
> that article. The big picture seems to be rather simple: calls to
> specific linux services could break the performance of a real time task
> by depending on lower priority tasks to complete that service.
> 
> Does this mean that one must always be alert to which system services
> are invoked during the execution of a real time task? Does the vanilla
> kernel or the preempt-rt patch tries to somehow detect this condition
> and alert somehow?
> 
> thanks,
> Rodrigo
> 
> -- 
> To unsubscribe from this list: send the line "unsubscribe
> linux-rt-users" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> 
> 


