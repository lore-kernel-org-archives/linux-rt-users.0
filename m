From: Chirag Jog <chirag@linux.vnet.ibm.com>
Subject: Re: 2.6.26.5-rt8
Date: Wed, 10 Sep 2008 12:25:20 +0530
Message-ID: <20080910065520.GC3966@linux.vnet.ibm.com>
References: <1221018492.22713.24.camel@localhost.localdomain>
Reply-To: Chirag Jog <chirag@linux.vnet.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
To: Steven Rostedt <rostedt@goodmis.org>,
	linux-rt-users <linux-rt-users@vger.kernel.org>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from E23SMTP01.au.ibm.com ([202.81.18.162]:48751 "EHLO
	e23smtp01.au.ibm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751075AbYIJG6Y (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Wed, 10 Sep 2008 02:58:24 -0400
Received: from sd0109e.au.ibm.com (d23rh905.au.ibm.com [202.81.18.225])
	by e23smtp01.au.ibm.com (8.13.1/8.13.1) with ESMTP id m8A6wWMv000638
	for <linux-rt-users@vger.kernel.org>; Wed, 10 Sep 2008 16:58:32 +1000
Received: from d23av01.au.ibm.com (d23av01.au.ibm.com [9.190.234.96])
	by sd0109e.au.ibm.com (8.13.8/8.13.8/NCO v9.1) with ESMTP id m8A6wGuX273934
	for <linux-rt-users@vger.kernel.org>; Wed, 10 Sep 2008 16:58:16 +1000
Received: from d23av01.au.ibm.com (loopback [127.0.0.1])
	by d23av01.au.ibm.com (8.12.11.20060308/8.13.3) with ESMTP id m8A6wGen025893
	for <linux-rt-users@vger.kernel.org>; Wed, 10 Sep 2008 16:58:16 +1000
Content-Disposition: inline
In-Reply-To: <1221018492.22713.24.camel@localhost.localdomain>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

* Steven Rostedt <rostedt@goodmis.org> [2008-09-09 23:48:12]:

> We are pleased to announce the 2.6.26.5-rt8 tree, which can be
> downloaded from the location:
> 
>   http://rt.et.redhat.com/download/
> 
> Information on the RT patch can be found at:
> 
>   http://rt.wiki.kernel.org/index.php/Main_Page
> 
> Changes since 2.6.26.3-rt7
> 
>   - Ported to 2.6.26.5
> 
>   - x86_32 tlb flush use raw spinlock (Chirag Jog)
> 
>   - seqlock fix non PREEMPT_RT and cleanup (Steven Rostedt)
> 
>   - add sysctl to warn on RT task using not PI futex (Steven Rostedt)
> 
> to build a 2.6.26.5-rt8 tree, the following patches should be applied:
> 
>   http://www.kernel.org/pub/linux/kernel/v2.6/linux-2.6.26.tar.bz2
>   http://kernel.org/pub/linux/kernel/v2.6/patch-2.6.26.5.bz2
>   http://rt.et.redhat.com/download/patch-2.6.26.3-rt8.bz2
This link ^^ is incorrect.
Correct one is :
http://rt.et.redhat.com/download/patch-2.6.26.5-rt8.bz2 
> 
> 
> And like always, my RT version of Matt Mackall's ketchup will get this
> for you nicely:
> 
>   http://people.redhat.com/srostedt/rt/tools/ketchup-0.9.8-rt3
> 
> 
> The broken out patches are also available.
> 
> 
> -- Steve
> 
> 
> --
> To unsubscribe from this list: send the line "unsubscribe linux-rt-users" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> 

-- 
-Thanks,Chirag
