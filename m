From: "Luis Claudio R. Goncalves" <lclaudio@uudg.org>
Subject: Re: [PATCH 0/9] Backport of ftrace's function profiler
Date: Tue, 19 May 2009 12:12:00 -0300
Message-ID: <20090519151200.GR27687@unix.sh>
References: <20090519143607.GH27687@unix.sh> <alpine.DEB.2.00.0905191105530.7816@gandalf.stny.rr.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: linux-rt-users <linux-rt-users@vger.kernel.org>,
	Ingo Molnar <mingo@elte.hu>, williams <williams@redhat.com>,
	tglx <tglx@linutronix.de>
To: Steven Rostedt <rostedt@goodmis.org>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from mail-pz0-f202.google.com ([209.85.222.202]:44384 "EHLO
	mail-pz0-f202.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753498AbZESPTb (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Tue, 19 May 2009 11:19:31 -0400
Received: by pzk40 with SMTP id 40so263632pzk.33
        for <linux-rt-users@vger.kernel.org>; Tue, 19 May 2009 08:19:32 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <alpine.DEB.2.00.0905191105530.7816@gandalf.stny.rr.com>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

On Tue, May 19, 2009 at 11:06:55AM -0400, Steven Rostedt wrote:
| 
| On Tue, 19 May 2009, Luis Claudio R. Goncalves wrote:
| 
| > Hello,
| > 
| > The following patches are the backport of Steven Rostedt's ftrace's
| > function profiler, as published in his RFC series posted to LKML. This
| > backport has been done on top of 2.6.29.3-rt14.
| > 
| > The feature is fully functional but we do have one known problem, a kernel
| > panic when stressing the function profiler (a fast sequence of start, stop,
| > read in loop for 30+ minutes). This problem has a Bugzilla entry at:
| > 
| > 	https://bugzilla.redhat.com/show_bug.cgi?id=500156
| 
| Luis,
| 
| I'm fine with this, but if you want me to review the patches, it would 
| help if you have the reject files that you had to solve (or merge conflict 
| files). Then I can see if changes were made correctly.

So I finally found a use for those ugly reject files I always delete... :)

Steven, I will have to redo part of the work to get the reject files again.
Hopefully it won't take long. Thanks for being available to review the
backport!

Luis
-- 
[ Luis Claudio R. Goncalves             Red Hat  -  Realtime Team ]
[ Fingerprint: 4FDD B8C4 3C59 34BD 8BE9  2696 7203 D980 A448 C8F8 ]

