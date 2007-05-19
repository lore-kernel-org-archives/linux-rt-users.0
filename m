From: Darren Hart <dvhltc@us.ibm.com>
Subject: Re: v2.6.21-rt3
Date: Fri, 18 May 2007 23:27:24 -0700
Message-ID: <200705182327.25384.dvhltc@us.ibm.com>
References: <20070517194143.GA25394@elte.hu>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Cc: linux-rt-users@vger.kernel.org
To: Ingo Molnar <mingo@elte.hu>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from e32.co.us.ibm.com ([32.97.110.150]:54695 "EHLO
	e32.co.us.ibm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753643AbXESG1k (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Sat, 19 May 2007 02:27:40 -0400
Received: from d03relay04.boulder.ibm.com (d03relay04.boulder.ibm.com [9.17.195.106])
	by e32.co.us.ibm.com (8.12.11.20060308/8.13.8) with ESMTP id l4J6NpFC025870
	for <linux-rt-users@vger.kernel.org>; Sat, 19 May 2007 02:23:51 -0400
Received: from d03av01.boulder.ibm.com (d03av01.boulder.ibm.com [9.17.195.167])
	by d03relay04.boulder.ibm.com (8.13.8/8.13.8/NCO v8.3) with ESMTP id l4J6RXb2216276
	for <linux-rt-users@vger.kernel.org>; Sat, 19 May 2007 00:27:33 -0600
Received: from d03av01.boulder.ibm.com (loopback [127.0.0.1])
	by d03av01.boulder.ibm.com (8.12.11.20060308/8.13.3) with ESMTP id l4J6RX5M011848
	for <linux-rt-users@vger.kernel.org>; Sat, 19 May 2007 00:27:33 -0600
In-Reply-To: <20070517194143.GA25394@elte.hu>
Content-Disposition: inline
Sender: linux-rt-users-owner@vger.kernel.org
List-Id: linux-rt-users.vger.kernel.org

On Thursday 17 May 2007 12:41:43 you wrote:
> i'm pleased to announce the v2.6.21-rt3 kernel, which can be downloaded
> from the usual place:
> ...
> to build a 2.6.21-rt3 tree, the following patches should be applied:
>
>   http://kernel.org/pub/linux/kernel/v2.6/linux-2.6.21.tar.bz2
>   http://redhat.com/~mingo/realtime-preempt/patch-2.6.21-rt3

Ingo, 

I have found that dealing with the current and older patches to be problematic 
for scripts that also deal with other trees that typically don't keep the 
current patch in a separate location.  Would you be agreeable to using a 
symlink at the top level to the latest patch so that all the patches are in 
the same directory?  Or possibly just uploading the latest patch to both the 
top level directory and older at the same time?  Would greatly simplify some 
scripting...

Thanks,

-- 
Darren Hart
IBM Linux Technology Center
Realtime Linux Team
