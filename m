From: Steven Rostedt <rostedt@goodmis.org>
Subject: Re: [LTP] LTP RT Tests (Cyclic, rt-migrate, etc)
Date: Thu, 30 Jul 2009 16:03:06 -0400 (EDT)
Message-ID: <alpine.DEB.2.00.0907301600560.21267@gandalf.stny.rr.com>
References: <1224509719.5152.116.camel@subratamodak.linux.ibm.com> <1246890698.4887.24.camel@subratamodak.linux.ibm.com> <1247076833.5405.48.camel@subratamodak.linux.ibm.com> <200907102200.12804.sripathik@in.ibm.com> <1247244446.5040.0.camel@subratamodak.linux.ibm.com>
 <4A57884C.10401@us.ibm.com> <alpine.DEB.2.00.0907201039140.3858@gandalf.stny.rr.com> <4A64A369.8040808@us.ibm.com> <1248978525.5788.55.camel@subratamodak.linux.ibm.com> <alpine.DEB.2.00.0907301440460.21267@gandalf.stny.rr.com>
 <4A71F964.1060507@us.ibm.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Subrata Modak <subrata@linux.vnet.ibm.com>,
	Sripathi Kodi <sripathik@in.ibm.com>,
	Gowrishankar <gomuthuk@linux.vnet.ibm.com>,
	ltp-list <ltp-list@lists.sf.net>,
	linux-rt-users <linux-rt-users@vger.kernel.org>,
	Gregory Haskins <ghaskins@novell.com>,
	Clark Williams <clark.williams@gmail.com>
To: Darren Hart <dvhltc@us.ibm.com>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from hrndva-omtalb.mail.rr.com ([71.74.56.125]:48235 "EHLO
	hrndva-omtalb.mail.rr.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751095AbZG3UDI (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Thu, 30 Jul 2009 16:03:08 -0400
In-Reply-To: <4A71F964.1060507@us.ibm.com>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>


On Thu, 30 Jul 2009, Darren Hart wrote:
> 
> Just to be clear, Steven you want us to modify this test case so that it uses
> the librttest facilities, including those for standardized argument parsing,
> buffered out, and thread creation, then commit this to the repository?  I
> don't feel it should go in without those changes.  We've expended a lot of
> effort making the tests in ltp/realtime be consistent in those areas (they all
> use some common command line arguments and coding styles).  This ensures that
> they can be easily maintained along with the other tests in the suite and that
> users can know what to expect from the test in terms of output, etc.

The test is GPL, do what you want ;-)

I have my own version that I may play with, but I have no qualms about 
changing the interface. Especially if it is to be consistent with the rest 
of LTP. But please CC me on any changes. I can tell if the changes modify 
the the way the test works, or I may want to incorporate the changes into 
my local copy.

Thanks,

-- Steve

