From: Steven Rostedt <rostedt@goodmis.org>
Subject: Re: [ANNOUNCE] 3.2.14-rt24
Date: Tue, 10 Apr 2012 15:57:02 -0400
Message-ID: <1334087822.23924.228.camel@gandalf.stny.rr.com>
References: <alpine.LFD.2.02.1204101638180.2542@ionos>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-15"
Content-Transfer-Encoding: 7bit
Cc: LKML <linux-kernel@vger.kernel.org>,
	linux-rt-users <linux-rt-users@vger.kernel.org>
To: Thomas Gleixner <tglx@linutronix.de>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from hrndva-omtalb.mail.rr.com ([71.74.56.122]:24545 "EHLO
	hrndva-omtalb.mail.rr.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758890Ab2DJT5F (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Tue, 10 Apr 2012 15:57:05 -0400
In-Reply-To: <alpine.LFD.2.02.1204101638180.2542@ionos>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

On Tue, 2012-04-10 at 16:42 +0200, Thomas Gleixner wrote:

> This is my last release based on 3.2. I'm handing the 3.2-rt series
> over to Steven and move on to 3.4.

The branch v3.2-rt has been created in:

   git://git.kernel.org/pub/scm/linux/kernel/git/rt/linux-stable-rt.git

It starts with v3.2.14-rt24 with the patches broken out on top of
v3.2.14.

New releases for v3.2-rt will now be kept in this branch and patch files
will be produced similar to the way the v3.0-rt tree is maintained.

This branch will never rebase, and new mainline stable releases will be
merged into this branch. Fixes will be applied on top of the branch. I
will also create a v3.2-rt-rebase branch (and tags) that will allow you
to make broken out patches (like v3.0-rt-rebase) as long as time permits
me to do so.

-- Steve


