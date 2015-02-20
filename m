From: Benjamin LaHaise <bcrl@kvack.org>
Subject: Re: [PATCH-rt 0/2] Fix up aio splats at reboot garbage collection
Date: Fri, 20 Feb 2015 12:39:29 -0500
Message-ID: <20150220173929.GJ26974@kvack.org>
References: <1424033559-63051-1-git-send-email-paul.gortmaker@windriver.com> <20150218112823.GF28763@linutronix.de> <1424266433.7113.1.camel@gmail.com> <54E76F65.7040800@windriver.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Mike Galbraith <umgwanakikbuti@gmail.com>,
	Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
	linux-rt-users@vger.kernel.org, Kent Overstreet <kmo@daterainc.com>
To: Paul Gortmaker <paul.gortmaker@windriver.com>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from kanga.kvack.org ([205.233.56.17]:56460 "EHLO kanga.kvack.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754298AbbBTRja (ORCPT <rfc822;linux-rt-users@vger.kernel.org>);
	Fri, 20 Feb 2015 12:39:30 -0500
Content-Disposition: inline
In-Reply-To: <54E76F65.7040800@windriver.com>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

On Fri, Feb 20, 2015 at 12:31:17PM -0500, Paul Gortmaker wrote:
> On 2015-02-18 08:33 AM, Mike Galbraith wrote:
> >On Wed, 2015-02-18 at 12:28 +0100, Sebastian Andrzej Siewior wrote:
> >>* Paul Gortmaker | 2015-02-15 15:52:37 [-0500]:
> >>
> >>>We ran into a splat during reboot that was caused by the percpu_ref_kill
> >>>garbage collection in the fs/aio code.
> >>
> >>Could you please check if
> >>     https://lkml.org/lkml/2015/2/16/391
> >>works for you?
> >
> >I did not see a gripe with that and ltp.
> 
> Same here ; set aside my two commits and applied the
> sworkqueue implementation and the proposed aio patch
> to the 3.14-rt tree and it doesn't splat on reboot.

Sebastian, is this safe for non-RT kernels?  If so, could you please resend 
against mainline with a Signed-off-by so we can get this properly fixed?

		-ben

> Thanks,
> Paul.
> --
> 
> >
> >	-Mike
> >

-- 
"Thought is the essence of where you are now."
