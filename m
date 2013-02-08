From: Frank Rowand <frank.rowand@am.sony.com>
Subject: Re: [PATCH RT-TESTS 0/3] A few Makefile clean-ups
Date: Fri, 8 Feb 2013 15:07:42 -0800
Message-ID: <5115853E.8050004@am.sony.com>
References: <1360334855-10176-1-git-send-email-jkacur@redhat.com>
Reply-To: <frank.rowand@am.sony.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"
Content-Transfer-Encoding: 7bit
Cc: Clark Williams <williams@redhat.com>,
	"Rowand, Frank" <Frank_Rowand@sonyusa.com>,
	rt-users <linux-rt-users@vger.kernel.org>
To: John Kacur <jkacur@redhat.com>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from co9ehsobe004.messaging.microsoft.com ([207.46.163.27]:32653
	"EHLO co9outboundpool.messaging.microsoft.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1947161Ab3BHXHf (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Fri, 8 Feb 2013 18:07:35 -0500
In-Reply-To: <1360334855-10176-1-git-send-email-jkacur@redhat.com>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

On 02/08/13 06:47, John Kacur wrote:
> From: John Kacur <jkacur@redhat.com>
> 
> I have few simple build clean-ups, which should be uncontroversial
> for the rt-tests suite
> 
> John Kacur (3):
>   Makefile: Don't tag tmp files created when making a release
>   Makefile: Add tmp dir to distclean and "make release" call distclean
>   Makefile: Add BUILDROOT and SPECS to the dirs to remove for distclean
> 
>  Makefile | 9 +++++----
>  1 file changed, 5 insertions(+), 4 deletions(-)
> 


All three patches:

  Reviewed-by: Frank Rowand <frank.rowand@am.sony.com>
  Tested-by: Frank Rowand <frank.rowand@am.sony.com>

With the caveat that "make rpm" does not complete on my build system
due to a missing numactl-devel dependency.

Even without "make rpm" completing, it creates the extra objects
that patch 3 removes, so I think my testing is still valid.

-Frank

