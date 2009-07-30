From: Darren Hart <dvhltc@us.ibm.com>
Subject: Re: [LTP] LTP RT Tests (Cyclic, rt-migrate, etc)
Date: Thu, 30 Jul 2009 13:10:32 -0700
Message-ID: <4A71FE38.20501@us.ibm.com>
References: <1224509719.5152.116.camel@subratamodak.linux.ibm.com> <1246890698.4887.24.camel@subratamodak.linux.ibm.com> <1247076833.5405.48.camel@subratamodak.linux.ibm.com> <200907102200.12804.sripathik@in.ibm.com> <1247244446.5040.0.camel@subratamodak.linux.ibm.com> <4A57884C.10401@us.ibm.com> <alpine.DEB.2.00.0907201039140.3858@gandalf.stny.rr.com> <4A64A369.8040808@us.ibm.com> <1248978525.5788.55.camel@subratamodak.linux.ibm.com> <alpine.DEB.2.00.0907301440460.21267@gandalf.stny.rr.com> <4A71F964.1060507@us.ibm.com> <alpine.DEB.2.00.0907301600560.21267@gandalf.stny.rr.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Cc: Subrata Modak <subrata@linux.vnet.ibm.com>,
	Sripathi Kodi <sripathik@in.ibm.com>,
	Gowrishankar <gomuthuk@linux.vnet.ibm.com>,
	ltp-list <ltp-list@lists.sf.net>,
	linux-rt-users <linux-rt-users@vger.kernel.org>,
	Gregory Haskins <ghaskins@novell.com>,
	Clark Williams <clark.williams@gmail.com>
To: Steven Rostedt <rostedt@goodmis.org>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from e7.ny.us.ibm.com ([32.97.182.137]:50883 "EHLO e7.ny.us.ibm.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751387AbZG3UKg (ORCPT <rfc822;linux-rt-users@vger.kernel.org>);
	Thu, 30 Jul 2009 16:10:36 -0400
Received: from d01relay02.pok.ibm.com (d01relay02.pok.ibm.com [9.56.227.234])
	by e7.ny.us.ibm.com (8.14.3/8.13.1) with ESMTP id n6UKAFYZ017250
	for <linux-rt-users@vger.kernel.org>; Thu, 30 Jul 2009 16:10:15 -0400
Received: from d01av03.pok.ibm.com (d01av03.pok.ibm.com [9.56.224.217])
	by d01relay02.pok.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id n6UKAaoa255082
	for <linux-rt-users@vger.kernel.org>; Thu, 30 Jul 2009 16:10:36 -0400
Received: from d01av03.pok.ibm.com (loopback [127.0.0.1])
	by d01av03.pok.ibm.com (8.12.11.20060308/8.13.3) with ESMTP id n6UKAYtT017745
	for <linux-rt-users@vger.kernel.org>; Thu, 30 Jul 2009 16:10:35 -0400
In-Reply-To: <alpine.DEB.2.00.0907301600560.21267@gandalf.stny.rr.com>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

Steven Rostedt wrote:
> On Thu, 30 Jul 2009, Darren Hart wrote:
>> Just to be clear, Steven you want us to modify this test case so that it uses
>> the librttest facilities, including those for standardized argument parsing,
>> buffered out, and thread creation, then commit this to the repository?  I
>> don't feel it should go in without those changes.  We've expended a lot of
>> effort making the tests in ltp/realtime be consistent in those areas (they all
>> use some common command line arguments and coding styles).  This ensures that
>> they can be easily maintained along with the other tests in the suite and that
>> users can know what to expect from the test in terms of output, etc.
> 
> The test is GPL, do what you want ;-)
> 
> I have my own version that I may play with, but I have no qualms about 
> changing the interface. Especially if it is to be consistent with the rest 
> of LTP. But please CC me on any changes. I can tell if the changes modify 
> the the way the test works, or I may want to incorporate the changes into 
> my local copy.

OK, will do.

-- 
Darren Hart
IBM Linux Technology Center
Real-Time Linux Team
