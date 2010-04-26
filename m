From: Ted Baker <baker@cs.fsu.edu>
Subject: Re: [Fwd: Re: RFC for a new Scheduling policy/class in the Linux-kernel]
Date: Mon, 26 Apr 2010 07:56:58 -0400
Message-ID: <20100426115658.GA21346@cs.fsu.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: baker.tlh@comcast.net
To: raj@ece.cmu.edu, jayhawk@soe.ucsc.edu, a.p.zijlstra@chello.nl,
	raistlin@linux.it, niehaus@ittc.ku.edu, henrik@austad.us,
	linux-kernel@vger.kernel.org, mingo@elte.hu,
	billh@gnuppy.monk
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from smtpout.cs.fsu.edu ([128.186.122.75]:58632 "EHLO
	mail.cs.fsu.edu" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1752429Ab0DZMXW (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Mon, 26 Apr 2010 08:23:22 -0400
Content-Disposition: inline
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

I have not seen any more e-mail on this.  How is it going?  Is there any
chance of rolling in some corrections for the SCHED_SPORADIC treatment?  In
particular, could we have a DO_NOT_RUN priority, that is guaranteed to
prevent a task from running at all?

For more detail, see http://ww2.cs.fsu.edu/~stanovic/papers/rtas10.pdf .

Ted
