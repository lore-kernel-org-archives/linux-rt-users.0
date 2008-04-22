From: Nivedita Singhvi <niv@us.ibm.com>
Subject: Re: -O option causing test jitter?
Date: Tue, 22 Apr 2008 09:05:44 -0700
Message-ID: <480E0CD8.2070400@us.ibm.com>
References: <1208476794.6307.15.camel@localhost.localdomain> <Pine.LNX.4.58.0804172120001.25316@gandalf.stny.rr.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Cc: john stultz <johnstul@us.ibm.com>,
	linux-rt-users <linux-rt-users@vger.kernel.org>
To: Steven Rostedt <rostedt@goodmis.org>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from e4.ny.us.ibm.com ([32.97.182.144]:39009 "EHLO e4.ny.us.ibm.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751007AbYDVQF6 (ORCPT <rfc822;linux-rt-users@vger.kernel.org>);
	Tue, 22 Apr 2008 12:05:58 -0400
Received: from d01relay02.pok.ibm.com (d01relay02.pok.ibm.com [9.56.227.234])
	by e4.ny.us.ibm.com (8.13.8/8.13.8) with ESMTP id m3MG5wSj002240
	for <linux-rt-users@vger.kernel.org>; Tue, 22 Apr 2008 12:05:58 -0400
Received: from d01av02.pok.ibm.com (d01av02.pok.ibm.com [9.56.224.216])
	by d01relay02.pok.ibm.com (8.13.8/8.13.8/NCO v8.7) with ESMTP id m3MG5v7c217162
	for <linux-rt-users@vger.kernel.org>; Tue, 22 Apr 2008 12:05:57 -0400
Received: from d01av02.pok.ibm.com (loopback [127.0.0.1])
	by d01av02.pok.ibm.com (8.12.11.20060308/8.13.3) with ESMTP id m3MG5rGh015875
	for <linux-rt-users@vger.kernel.org>; Tue, 22 Apr 2008 12:05:57 -0400
In-Reply-To: <Pine.LNX.4.58.0804172120001.25316@gandalf.stny.rr.com>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

Steven Rostedt wrote:
> 
> On Thu, 17 Apr 2008, john stultz wrote:
>> Anyway, I wanted to hit the list with this so folks could look at it and
>> let me know if such severe jitter was expected from just compile
>> options?
>>
> 
> I think this may simply be a simple case of cache misses.
> 
> Attached is two files: sched_jitter-test.c and do_work.S. I found that by
> switching the positions of do_work1 and do_work2, which ever one is first
> performs better. do_work1 is me copying the output of objdump of -O1 of
> do_work, and do_work2 is copying the output from objdump of -O2.

So jitter going down might simply be a case of the
faster cases actually slowing down, right - and
making things uniformly slow?

Do we know if the whole kaboodle is getting faster?

thanks,
Nivedita
