From: Paul Gortmaker <paul.gortmaker@windriver.com>
Subject: [PATCH-rt 0/2] Fix up aio splats at reboot garbage collection
Date: Sun, 15 Feb 2015 15:52:37 -0500
Message-ID: <1424033559-63051-1-git-send-email-paul.gortmaker@windriver.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: Mike Galbraith <umgwanakikbuti@gmail.com>,
	Benjamin LaHaise <bcrl@kvack.org>,
	Kent Overstreet <kmo@daterainc.com>,
	Paul Gortmaker <paul.gortmaker@windriver.com>
To: <linux-rt-users@vger.kernel.org>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from mail1.windriver.com ([147.11.146.13]:46175 "EHLO
	mail1.windriver.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754889AbbBOUwz (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Sun, 15 Feb 2015 15:52:55 -0500
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

We ran into a splat during reboot that was caused by the percpu_ref_kill
garbage collection in the fs/aio code.

After researching a bit, it was determined that this was the same
problem reported by Mike a few months ago[1].  In that thread, several
possibilities were discussed, but no patches were added to -rt in
the end out of that discussion.

This implements one of the possible solutions discussed there, which
is -rt specific and not mainline appropriate.

After using that patch, we found another new follow on splat that
was also in aio garbage collection and so we deal with that by using
the callback ("confirm") version of percpu_ref_kill to delay the
schedule_work to a non-atomic context to avoid the second splat.  I
think this second patch could be used in mainline, if one desired to
do so.

[1] https://lkml.org/lkml/2014/6/8/10

Paul.
---

Paul Gortmaker (2):
  aio: don't take the ctx_lock during rcu garbage collection at reboot
  aio: fix splat in free_ioctx_reqs by using percpu callback

 fs/aio.c | 14 +++++++++++++-
 1 file changed, 13 insertions(+), 1 deletion(-)

-- 
2.1.0

