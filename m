From: Darren Hart <dvhltc@us.ibm.com>
Subject: Re: Fedora 10 as basis for RT?
Date: Thu, 09 Apr 2009 12:38:57 -0700
Message-ID: <49DE4ED1.7030509@us.ibm.com>
References: <loom.20090409T134400-381@post.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Cc: linux-rt-users@vger.kernel.org
To: Al Dorrington <albert.dorrington@lmco.com>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from e36.co.us.ibm.com ([32.97.110.154]:47877 "EHLO
	e36.co.us.ibm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1759526AbZDITi7 (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Thu, 9 Apr 2009 15:38:59 -0400
Received: from d03relay02.boulder.ibm.com (d03relay02.boulder.ibm.com [9.17.195.227])
	by e36.co.us.ibm.com (8.13.1/8.13.1) with ESMTP id n39JbWkH001576
	for <linux-rt-users@vger.kernel.org>; Thu, 9 Apr 2009 13:37:32 -0600
Received: from d03av01.boulder.ibm.com (d03av01.boulder.ibm.com [9.17.195.167])
	by d03relay02.boulder.ibm.com (8.13.8/8.13.8/NCO v9.2) with ESMTP id n39Jcwwv202112
	for <linux-rt-users@vger.kernel.org>; Thu, 9 Apr 2009 13:38:58 -0600
Received: from d03av01.boulder.ibm.com (loopback [127.0.0.1])
	by d03av01.boulder.ibm.com (8.12.11.20060308/8.13.3) with ESMTP id n39Jcwms023606
	for <linux-rt-users@vger.kernel.org>; Thu, 9 Apr 2009 13:38:58 -0600
In-Reply-To: <loom.20090409T134400-381@post.gmane.org>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

Al Dorrington wrote:
> Hi,
> 
> I am working on a proof of concept project where we are going to try moving an
> application that runs on VxWorks to Linux. I believe with what I've read on this
> mailing list, and the RTwiki site that Linux is definitely up to the task with
> these kernel patches.
> 
> However, I am not really sure which distribution of Linux we should use as the
> base, nor am I sure if it would be better to stick with the 'i386' distribution
> or go with the x86_64 variant.
> 
> I am considering Fedora 10, either i386 or x86_64. 
> 
> Does anyone have any comments or recommendations for which might be better to
> use, or if we would be better off using another distribution?

As far as the distro goes, the one caveat used to be making sure you had 
one with a recent enough glibc so you could take advantage of Priority 
Inheritance with the pthread mutexes and such.  That's pretty much no 
longer an issue, but FC10 does ship glibc2.9 which has the advantage of 
using PROCESS_PRIVATE futexes by default, which should give you slightly 
better performance in some situations.

-- 
Darren Hart
IBM Linux Technology Center
Real-Time Linux Team
