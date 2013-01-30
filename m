From: John Kacur <jkacur@redhat.com>
Subject: Re: [PATCH 0/3] cyclictest: improvements to histogram overflow
 instance mode
Date: Wed, 30 Jan 2013 18:07:21 +0100 (CET)
Message-ID: <alpine.LFD.2.03.1301301805170.4078@tycho>
References: <1355947233-31451-1-git-send-email-bhavesh@vmware.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: linux-rt-users@vger.kernel.org,
	Frank Rowand <frank.rowand@am.sony.com>, jkacur@redhat.com,
	Clark Williams <williams@redhat.com>
To: Bhavesh Davda <bhavesh@vmware.com>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from mail-ee0-f48.google.com ([74.125.83.48]:46578 "EHLO
	mail-ee0-f48.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755866Ab3A3RNn (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Wed, 30 Jan 2013 12:13:43 -0500
Received: by mail-ee0-f48.google.com with SMTP id t10so996959eei.35
        for <linux-rt-users@vger.kernel.org>; Wed, 30 Jan 2013 09:13:41 -0800 (PST)
In-Reply-To: <1355947233-31451-1-git-send-email-bhavesh@vmware.com>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>



On Wed, 19 Dec 2012, Bhavesh Davda wrote:

> This patch series makes usability improvements to the histogram overflow
> instance tracking mode, as suggested by Frank Rowland.
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

Thanks for submitting these patches - I'm afraid I either missed them or 
forgot about them since they were submitted so close to Christmas. Review 
pending.

John
