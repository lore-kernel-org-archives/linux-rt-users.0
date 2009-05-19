From: Steven Rostedt <rostedt@goodmis.org>
Subject: Re: [PATCH 0/9] Backport of ftrace's function profiler
Date: Tue, 19 May 2009 11:06:55 -0400 (EDT)
Message-ID: <alpine.DEB.2.00.0905191105530.7816@gandalf.stny.rr.com>
References: <20090519143607.GH27687@unix.sh>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: linux-rt-users <linux-rt-users@vger.kernel.org>,
	Ingo Molnar <mingo@elte.hu>, williams <williams@redhat.com>,
	tglx <tglx@linutronix.de>
To: "Luis Claudio R. Goncalves" <lclaudio@uudg.org>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from hrndva-omtalb.mail.rr.com ([71.74.56.123]:56613 "EHLO
	hrndva-omtalb.mail.rr.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752124AbZESPG5 (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Tue, 19 May 2009 11:06:57 -0400
In-Reply-To: <20090519143607.GH27687@unix.sh>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>


On Tue, 19 May 2009, Luis Claudio R. Goncalves wrote:

> Hello,
> 
> The following patches are the backport of Steven Rostedt's ftrace's
> function profiler, as published in his RFC series posted to LKML. This
> backport has been done on top of 2.6.29.3-rt14.
> 
> The feature is fully functional but we do have one known problem, a kernel
> panic when stressing the function profiler (a fast sequence of start, stop,
> read in loop for 30+ minutes). This problem has a Bugzilla entry at:
> 
> 	https://bugzilla.redhat.com/show_bug.cgi?id=500156

Luis,

I'm fine with this, but if you want me to review the patches, it would 
help if you have the reject files that you had to solve (or merge conflict 
files). Then I can see if changes were made correctly.

-- Steve

