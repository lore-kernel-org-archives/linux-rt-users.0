From: Frank Rowand <frank.rowand@am.sony.com>
Subject: Re: [PATCH RT-TESTS] cyclictest: new command line switch for histogram
 overflow instance tracking
Date: Fri, 16 Nov 2012 18:01:17 -0800
Message-ID: <50A6EFED.9000501@am.sony.com>
References: <99151396.32193.1352945832244.JavaMail.root@vmware.com> <50A584BE.2000107@am.sony.com>
Reply-To: <frank.rowand@am.sony.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Cc: Bhavesh Davda <bhavesh@vmware.com>,
	"linux-rt-users@vger.kernel.org" <linux-rt-users@vger.kernel.org>,
	John Kacur <jkacur@redhat.com>
To: unlisted-recipients:; (no To-header on input)
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from [216.32.180.184] ([216.32.180.184]:4629 "EHLO
	co1outboundpool.messaging.microsoft.com" rhost-flags-FAIL-FAIL-OK-OK)
	by vger.kernel.org with ESMTP id S1753101Ab2KQCC1 (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Fri, 16 Nov 2012 21:02:27 -0500
In-Reply-To: <50A584BE.2000107@am.sony.com>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

On 11/15/12 16:11, Frank Rowand wrote:

< snip >

>> I would like to address all your suggestions. Which ones did I miss?
> 
> | Add a line to the histogram overflow cycle report that merges all
> | threads into a single time line.  This is controlled by the -H
> | option which already serves a similar purpose for histograms.
> 
> The merged data line is an enhancement.  If there is no strong request
> from anyone for the feature then no need to include.  But it seems
> useful to me.

After adding in timestamps instead of cycle numbers, and playing
around with some actual data, I think that this feature is not
needed.  It adds code complexity.  The same result can be
achieved by sorting the data outside of cyclictest.

-Frank

