From: Steven Rostedt <rostedt@goodmis.org>
Subject: Re: 4.8.6-rt5 ftrace function_graph hangs
Date: Fri, 18 Nov 2016 17:32:48 -0500
Message-ID: <20161118173248.6766c586@gandalf.local.home>
References: <d275a464-c787-6e21-0d3f-bbb3d854176e@windriver.com>
        <20161118113524.43f6ff3c@gandalf.local.home>
        <4315c9ac-47cb-7218-027c-039a0cbfa548@windriver.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Cc: He Zhe <zhe.he@windriver.com>, <tglx@linutronix.de>,
        <linux-rt-users@vger.kernel.org>
To: Yang Shi <yang.shi@windriver.com>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from smtprelay0148.hostedemail.com ([216.40.44.148]:52083 "EHLO
        smtprelay.hostedemail.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1752609AbcKRWcw (ORCPT
        <rfc822;linux-rt-users@vger.kernel.org>);
        Fri, 18 Nov 2016 17:32:52 -0500
In-Reply-To: <4315c9ac-47cb-7218-027c-039a0cbfa548@windriver.com>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

On Fri, 18 Nov 2016 10:36:49 -0800
Yang Shi <yang.shi@windriver.com> wrote:


> Hi Steve,
> 
> > Can't you get a backtrace from this? It's running under qemu right? So
> > it should be able to break it and see where it is at.
> >
> > Note, my PowerPC box has just died, so I'm no longer able to work on
> > it, and don't have time to set up a qemu ppc image at the moment.  
> 
> We found this issue on x86 too. It is not PPC specific problem.
> 

Is it a problem on x86 on qemu or do you see this on bare metal. If you
see it on bare metal, please send me your .config because it works fine
for me. If it's only on qemu let me know that too.

-- Steve
