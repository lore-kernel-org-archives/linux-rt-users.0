From: John Kacur <jkacur@redhat.com>
Subject: Re: [PATCH RT-TESTS] cyclictest: histogram overflow instance
  tracking
Date: Tue, 23 Oct 2012 15:25:31 -0400 (EDT)
Message-ID: <1802256036.5241288.1351020331171.JavaMail.root@redhat.com>
References: <801391694.11621598.1351018758999.JavaMail.root@vmware.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Cc: linux-rt-users@vger.kernel.org,
	Frank Rowand <Frank_Rowand@sonyusa.com>,
	frank rowand <frank.rowand@am.sony.com>
To: Bhavesh Davda <bhavesh@vmware.com>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from mx3-phx2.redhat.com ([209.132.183.24]:42985 "EHLO
	mx3-phx2.redhat.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756875Ab2JWTZd (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Tue, 23 Oct 2012 15:25:33 -0400
In-Reply-To: <801391694.11621598.1351018758999.JavaMail.root@vmware.com>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>



----- Original Message -----
> Hi Frank,
> 
> Thanks for the review.
> 
> Unfortunately my git-fu is super weak, and I don't know how to
> re-spin the patches by simply editing the source file in my git tree
> and fixing these warnings and errors that checkpatch.pl is
> identifying.
> 
> Can you either (a) help me with step-by-step instructions on how to
> do so in git (perhaps RTFM with a pointer to one), or (b) help fix
> up my 2 patches yourself in preparation for a review and a commit?
> 
> Thanks
> 
> - Bhavesh
> 
> ----- Original Message -----
> 
> From: "Frank Rowand" <frank.rowand@am.sony.com>
> To: "Frank Rowand" <Frank_Rowand@sonyusa.com>
> Cc: "Bhavesh Davda" <bhavesh@vmware.com>,
> linux-rt-users@vger.kernel.org, "John Kacur" <jkacur@redhat.com>
> Sent: Monday, October 22, 2012 6:41:57 PM
> Subject: Re: [PATCH RT-TESTS] cyclictest: histogram overflow instance
> tracking
> 
> Re: [PATCH RT-TESTS] cyclictest: histogram overflow instance tracking
> On 10/22/12 18:16, Frank Rowand wrote:
> > On 10/16/12 10:02, Bhavesh Davda wrote:
> >> From: Bhavesh Davda <bhavesh@vmware.com>
> >> 
> >> Add feature to cyclictest histogram mode to track cycle counts
> >> every time a
> >> sample overflows the histogram limit. This should help identify if
> >> there is a
> >> timing pattern to jitters in cyclictest runs.
> >> 
> >> Example output (with -h 10):
> >> ...
> >> Histogram Overflows: 00001 00007 00000 00009 00004 00007 00000
> >> 00001
> >> Histogram Overflow at cycle number:
> >> Thread 0: 09964
> >> Thread 1: 00000 00004 00006 00008 00010 09962 11594
> >> Thread 2:
> >> Thread 3: 01169 04698 06782 09033 10299 11561 21517 28734 29532
> >> Thread 4: 11574 11580 11583 11586
> >> Thread 5: 00020 09448 13954 14954 18954 20587 24973
> >> Thread 6:
> >> Thread 7: 18950
> >> ...
> >> 
> >> Signed-off-by: Bhavesh Davda <bhavesh@vmware.com>
> > 
> > 
> > After the patches survive checkpatch, I'll review and test them.
> 
> < snip >
> 
> > /home/frowand/tmp/hist_overflow_xxx_1 has style problems, please
> > review.
> > 
> > If any of these errors are false positives, please report
> > them to the maintainer, see CHECKPATCH in MAINTAINERS.
> 
> Oooooops, the following message was about the series file I would
> use to apply the patches with quilt. Please ignore it.
> 
> > ERROR: Does not appear to be a unified-diff format patch
> > 

Let's not overdo it here, I've actually already added these patches in my private repo. I only want to hear if there are functional problems. I'm wondering if this is fine with histograms by default or if we want to protect it with an option? Or do we need to add something to make it easy to filter out?

