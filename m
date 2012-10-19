From: John Kacur <jkacur@redhat.com>
Subject: RE: [PATCH 3/4] Add cyclicload calibration & load generation
 feature
Date: Fri, 19 Oct 2012 11:39:38 -0400 (EDT)
Message-ID: <alpine.LFD.2.02.1210191125480.3251@tycho>
References: <1346320607-6691-1-git-send-email-Priyanka.Jain@freescale.com> <1346320607-6691-4-git-send-email-Priyanka.Jain@freescale.com> <AC83832D6324604BB08FAE5A33553F190B175EC1@039-SN2MPN1-011.039d.mgd.msft.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: "williams@redhat.com" <williams@redhat.com>,
	Aggrwal Poonam-B10812 <B10812@freescale.com>,
	"jkacur@redhat.com" <jkacur@redhat.com>,
	"frank.rowand@am.sony.com" <frank.rowand@am.sony.com>,
	"linux-rt-users@vger.kernel.org" <linux-rt-users@vger.kernel.org>,
	Srivastava Rajan-B34330 <B34330@freescale.com>,
	"dvhart@linux.intel.com" <dvhart@linux.intel.com>
To: Jain Priyanka-B32167 <B32167@freescale.com>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from mail-gg0-f174.google.com ([209.85.161.174]:34449 "EHLO
	mail-gg0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1759088Ab2JSPiV (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Fri, 19 Oct 2012 11:38:21 -0400
Received: by mail-gg0-f174.google.com with SMTP id k5so92725ggd.19
        for <linux-rt-users@vger.kernel.org>; Fri, 19 Oct 2012 08:38:21 -0700 (PDT)
In-Reply-To: <AC83832D6324604BB08FAE5A33553F190B175EC1@039-SN2MPN1-011.039d.mgd.msft.net>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>



On Fri, 19 Oct 2012, Jain Priyanka-B32167 wrote:

> Dear Clark,
> 
> Its along time that since I have send patches for cyclicload.
> I can see patch for cyclicload integrated into work branch on rt-test git tree.
> Did you have any feedback on its working.
> 
> Also I have made some improvements on it. Should I send the next version of the cyclicload patch or a new patch for the changes based on the 'work' branch code.
> 
> Regards
> Priyanka
> 
>
 
------------->o SNIP

Personally I think you should send the next version of the new patch, and 
not based on Clark's work branch. (a working branch is just that, a 
working place to store patches, no guarantees)

I think I should warn you that we have been discussing how difficult it is 
to make an artifical load. I worry that your program just adds a thread or 
threads spinning at another prio level, (which you can do already with 
cyclictest) but not adding any real load. I wouldn't like for you to do
 a lot of work only to have it ultimately rejected.

Why don't you submit the next version of your work, and then perhaps talk 
a little more about what you intend to do, and see what other people on 
the mailing list here think about that.

Thanks

John Kacur
