From: Daniel Walker <dwalker@mvista.com>
Subject: Re: v2.6.21-rt2
Date: Wed, 16 May 2007 13:54:02 -0700
Message-ID: <1179348842.20519.20.camel@imap.mvista.com>
References: <20070516180447.GA17922@elte.hu>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Cc: linux-kernel@vger.kernel.org, linux-rt-users@vger.kernel.org
To: Ingo Molnar <mingo@elte.hu>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from gateway-1237.mvista.com ([63.81.120.158]:18674 "EHLO
	gateway-1237.mvista.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1759473AbXEPU4S (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Wed, 16 May 2007 16:56:18 -0400
In-Reply-To: <20070516180447.GA17922@elte.hu>
Sender: linux-rt-users-owner@vger.kernel.org
List-Id: linux-rt-users.vger.kernel.org

On Wed, 2007-05-16 at 20:04 +0200, Ingo Molnar wrote:
> i'm pleased to announce the v2.6.20-rt2 kernel, which can be downloaded 
> from the usual place:

2.6.21-rt2 ?

>     http://redhat.com/~mingo/realtime-preempt/
>                                    
> more info about the -rt patchset can be found in the RT wiki:
>  
>     http://rt.wiki.kernel.org
> 
> This is a fixes-mostly release and has been assembled by Thomas 
> Gleixner. Thanks Thomas! Here are the various changes:
> 
>   - ppc fixes from Tsutomu OWA
> 
>   - new sh -rt port from Paul Mundt & Co
> 
>   - fixes for various problems by Steven Rostedt and Clark Williams

I think you missed the fix I submitted for one of Steve's changes.

http://lkml.org/lkml/2007/5/3/368

Daniel
