From: Bhavesh Davda <bhavesh@vmware.com>
Subject: Re: [PATCH 0/3] cyclictest: improvements to histogram overflow
 instance mode
Date: Wed, 30 Jan 2013 09:18:49 -0800 (PST)
Message-ID: <165003533.16449800.1359566329275.JavaMail.root@vmware.com>
References: <alpine.LFD.2.03.1301301805170.4078@tycho>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Cc: linux-rt-users@vger.kernel.org,
	Frank Rowand <frank.rowand@am.sony.com>,
	Clark Williams <williams@redhat.com>
To: John Kacur <jkacur@redhat.com>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from smtp-outbound-2.vmware.com ([208.91.2.13]:60369 "EHLO
	smtp-outbound-2.vmware.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1754277Ab3A3RSt (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Wed, 30 Jan 2013 12:18:49 -0500
In-Reply-To: <alpine.LFD.2.03.1301301805170.4078@tycho>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

> On Wed, 19 Dec 2012, Bhavesh Davda wrote:
> 
> > This patch series makes usability improvements to the histogram
> > overflow
> > instance tracking mode, as suggested by Frank Rowland.
> > 
> > Bhavesh Davda (3):
> >   cyclictest: new command line switch for histogram overflow
> >   instance
> >     tracking
> >   cyclictest: Report histogram overflow instances in seconds since
> >     start
> >   cyclictest: Print histogram overflow instances only if asked for
> > 
> >  src/cyclictest/cyclictest.c |   72
> >  +++++++++++++++++++++++++++++++++---------
> >  1 files changed, 56 insertions(+), 16 deletions(-)
> > 
> 
> Thanks for submitting these patches - I'm afraid I either missed them
> or
> forgot about them since they were submitted so close to Christmas.
> Review
> pending.
> 
> John


Thank you John,

As you might have noticed, Frank has already signed off on this patch set.

- Bhavesh
