From: Frank Rowand <frank.rowand@am.sony.com>
Subject: Re: [PATCH 0/3] cyclictest: improvements to histogram overflow instance
 mode
Date: Wed, 19 Dec 2012 15:17:47 -0800
Message-ID: <50D24B1B.9020808@am.sony.com>
References: <1355947233-31451-1-git-send-email-bhavesh@vmware.com>
Reply-To: <frank.rowand@am.sony.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"
Content-Transfer-Encoding: 7bit
Cc: "linux-rt-users@vger.kernel.org" <linux-rt-users@vger.kernel.org>,
	"Rowand, Frank" <Frank_Rowand@sonyusa.com>
To: Bhavesh Davda <bhavesh@vmware.com>,
	"jkacur@redhat.com" <jkacur@redhat.com>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from co1ehsobe001.messaging.microsoft.com ([216.32.180.184]:54788
	"EHLO co1outboundpool.messaging.microsoft.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752088Ab2LSXZ0 (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Wed, 19 Dec 2012 18:25:26 -0500
In-Reply-To: <1355947233-31451-1-git-send-email-bhavesh@vmware.com>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

On 12/19/12 12:00, Bhavesh Davda wrote:
> This patch series makes usability improvements to the histogram overflow
> instance tracking mode, as suggested by Frank Rowland.
                                                ^^^^^^^
                                                Rowand

It happens all the time....

> 
> Bhavesh Davda (3):
>   cyclictest: new command line switch for histogram overflow instance
>     tracking
>   cyclictest: Report histogram overflow instances in seconds since
>     start
>   cyclictest: Print histogram overflow instances only if asked for
> 
>  src/cyclictest/cyclictest.c |   72 +++++++++++++++++++++++++++++++++---------
>  1 files changed, 56 insertions(+), 16 deletions(-)
> 

For patches 1 - 3:


Reviewed-by: Frank Rowand <frank.rowand@am.sony.com>
Tested-by: Frank Rowand <frank.rowand@am.sony.com>


Thanks for improving cyclictest Bhavesh!

John, all good for you to commit?

-Frank

