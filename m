From: Nivedita Singhvi <niv@us.ibm.com>
Subject: Re: Changing real time priority of interrupt handler thread
Date: Tue, 18 May 2010 08:24:09 -0700
Message-ID: <4BF2B119.9000100@us.ibm.com>
References: <20100505130845.GA9118@rivendell>  <4BE1BADA.3040902@us.ibm.com> <1273168487.22438.44.camel@gandalf.stny.rr.com> <1274192889.17960.14.camel@localhost.localdomain> <4BF2AC9A.3060301@us.ibm.com> <1274195851.9142.9.camel@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Cc: linux-rt-users@vger.kernel.org
To: "Darcy L. Watkins" <dwatkins@tranzeo.com>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from e39.co.us.ibm.com ([32.97.110.160]:52049 "EHLO
	e39.co.us.ibm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752098Ab0ERPYR (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Tue, 18 May 2010 11:24:17 -0400
Received: from d03relay02.boulder.ibm.com (d03relay02.boulder.ibm.com [9.17.195.227])
	by e39.co.us.ibm.com (8.14.3/8.13.1) with ESMTP id o4IFFWuN031332
	for <linux-rt-users@vger.kernel.org>; Tue, 18 May 2010 09:15:32 -0600
Received: from d03av05.boulder.ibm.com (d03av05.boulder.ibm.com [9.17.195.85])
	by d03relay02.boulder.ibm.com (8.13.8/8.13.8/NCO v9.1) with ESMTP id o4IFOBxb257278
	for <linux-rt-users@vger.kernel.org>; Tue, 18 May 2010 09:24:12 -0600
Received: from d03av05.boulder.ibm.com (loopback [127.0.0.1])
	by d03av05.boulder.ibm.com (8.14.3/8.13.1/NCO v10.0 AVout) with ESMTP id o4IFO7pD011991
	for <linux-rt-users@vger.kernel.org>; Tue, 18 May 2010 09:24:07 -0600
In-Reply-To: <1274195851.9142.9.camel@localhost.localdomain>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

Darcy L. Watkins wrote:

>>> is this a proprietary Redhat utility only in RPM binaries?  Google
>>> search seems to mainly land me at IBM and Redhat user docs and FAQs.
>> rtctl is GPL, not proprietary. A quick google search brought
>> up the following:
> 
> Excellent!  and thanks!  I see SRPMs for rt-setup, tuna, etc there as
> well.  Is this FTP site the usual place to pick up SRPMs for these
> utilities as they are updated / released?

I am definitely not authoritative on that - it was something
I happened to look up. You should definitely get the correct
info from RH folks (as it's theirs).

> Darcy
> 
>> http://ftp.riken.go.jp/pub/Linux/cern/mrg/slc5X/SRPMS/
>>
>> http://ftp.riken.go.jp/pub/Linux/cern/mrg/slc5X/SRPMS/rtctl-1.7-1.el5rt.src.rpm


thanks,
Nivedita
