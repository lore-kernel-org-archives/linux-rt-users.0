From: Nivedita Singhvi <niv@us.ibm.com>
Subject: Re: Changing real time priority of interrupt handler thread
Date: Tue, 18 May 2010 08:04:58 -0700
Message-ID: <4BF2AC9A.3060301@us.ibm.com>
References: <20100505130845.GA9118@rivendell>  <4BE1BADA.3040902@us.ibm.com> <1273168487.22438.44.camel@gandalf.stny.rr.com> <1274192889.17960.14.camel@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Cc: linux-rt-users@vger.kernel.org
To: "Darcy L. Watkins" <dwatkins@tranzeo.com>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from e5.ny.us.ibm.com ([32.97.182.145]:43445 "EHLO e5.ny.us.ibm.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756686Ab0ERPFM (ORCPT <rfc822;linux-rt-users@vger.kernel.org>);
	Tue, 18 May 2010 11:05:12 -0400
Received: from d01relay06.pok.ibm.com (d01relay06.pok.ibm.com [9.56.227.116])
	by e5.ny.us.ibm.com (8.14.3/8.13.1) with ESMTP id o4IEn5BZ027175
	for <linux-rt-users@vger.kernel.org>; Tue, 18 May 2010 10:49:05 -0400
Received: from d01av04.pok.ibm.com (d01av04.pok.ibm.com [9.56.224.64])
	by d01relay06.pok.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id o4IF4xOW2224276
	for <linux-rt-users@vger.kernel.org>; Tue, 18 May 2010 11:04:59 -0400
Received: from d01av04.pok.ibm.com (loopback [127.0.0.1])
	by d01av04.pok.ibm.com (8.14.3/8.13.1/NCO v10.0 AVout) with ESMTP id o4IF4wa8022151
	for <linux-rt-users@vger.kernel.org>; Tue, 18 May 2010 11:04:59 -0400
In-Reply-To: <1274192889.17960.14.camel@localhost.localdomain>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

Darcy L. Watkins wrote:

>>> Have you tried using the rtctl utility and the /etc/rtgroups file?
> 
> Where are the source tarball projects for these located so I can try
> porting/using them [at least some of it] on my embedded linux?  ... or
> is this a proprietary Redhat utility only in RPM binaries?  Google
> search seems to mainly land me at IBM and Redhat user docs and FAQs.

rtctl is GPL, not proprietary. A quick google search brought
up the following:

http://ftp.riken.go.jp/pub/Linux/cern/mrg/slc5X/SRPMS/

http://ftp.riken.go.jp/pub/Linux/cern/mrg/slc5X/SRPMS/rtctl-1.7-1.el5rt.src.rpm

> Perhaps my issue earlier with serial buffer overruns is just a tune up
> issue.
> 
> I want to tune up RT on PowerPC 405 and ARM11 MX.31 based embedded
> systems where the rootfs is built (cross compiled) using
> buildroot/uclibc, etc and not x86 binaries from a full feature distro
> such as Fedora, Debian, etc.

Setting thread priorities for your environment will certainly
be a good thing in general.

thanks,
Nivedita
