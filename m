From: "Frank Ch. Eigler" <fche@redhat.com>
Subject: preempt-rt, need old style rwlocks for systemtap
Date: Sat, 3 May 2008 09:23:27 -0400
Message-ID: <20080503132327.GA28881@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
To: linux-kernel@vger.kernel.org, linux-rt-users@vger.kernel.org
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from mx1.redhat.com ([66.187.233.31]:47183 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752582AbYECNYU (ORCPT <rfc822;linux-rt-users@vger.kernel.org>);
	Sat, 3 May 2008 09:24:20 -0400
Content-Disposition: inline
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

Hi -

It has come to my attention that the preempt-rt patch suite
deliberately defeats the potential concurrency intended by systemtap's
use of rwlocks to permit concurrent readers of various data
structures.  Since systemtap's probe handlers are all atomic,
nonblocking, nonpreemptable, it does not seem like there is any
real-time-oriented benefit in this.  What can we do to work around
this and permit reader concurrency again in preempt-rt?

- FChE
