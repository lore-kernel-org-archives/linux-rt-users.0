From: Staffan Tjernstrom <stjernstrom@eagleseven.com>
Subject: RE: Observed deadlock in ext4 under 3.2.23-rt37 & 3.2.33-rt50
Date: Thu, 3 Jan 2013 09:52:06 -0600
Message-ID: <7A2FC0CD30EF4745AE15F485252D38AC2F45A70E82@clark>
References: <7A2FC0CD30EF4745AE15F485252D38AC2F45A70C9A@clark>
 <1357182583.10284.16.camel@gandalf.local.home>
 <20130103042224.GB16895@thunk.org>
 <1357219291.10284.21.camel@gandalf.local.home>
 <20130103141837.GC16895@thunk.org>
 <7A2FC0CD30EF4745AE15F485252D38AC2F45A70E59@clark>
 <20130103153634.GD16895@thunk.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Cc: Steven Rostedt <rostedt@goodmis.org>,
	"linux-rt-users@vger.kernel.org" <linux-rt-users@vger.kernel.org>,
	"tglx@linutronix.de" <tglx@linutronix.de>,
	"C.Emde@osadl.org" <C.Emde@osadl.org>,
	"jkacur@redhat.com" <jkacur@redhat.com>
To: Theodore Ts'o <tytso@mit.edu>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from mail.eagleseven.com ([38.98.183.218]:25292 "EHLO
	mail.eagleseven.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753310Ab3ACPwI convert rfc822-to-8bit (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Thu, 3 Jan 2013 10:52:08 -0500
In-Reply-To: <20130103153634.GD16895@thunk.org>
Content-Language: en-US
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

From: Theodore Ts'o [mailto:tytso@mit.edu] 
Sent: Thursday, January 03, 2013 9:37 AM
To: Staffan Tjernstrom
Cc: Steven Rostedt; linux-rt-users@vger.kernel.org; tglx@linutronix.de; C.Emde@osadl.org; jkacur@redhat.com
Subject: Re: Observed deadlock in ext4 under 3.2.23-rt37 & 3.2.33-rt50

>In fs/jbd2/transaction.c?  Can you give me the code snippit and/or function and line number that you're concerned about?

Rather in fs/fs.h and fs/namei.c - I think that' where I ended up in my trace of a previous encounter with the issue (either via open() and/or truncate() calls from user land). Coming in from jbd2/transaction.c would make more sense than what I thought I manually traced out however.

See http://lxr.linux.no/#linux+v2.6.33.20/fs/namei.c#L325 vs http://lxr.linux.no/#linux+v3.2.33/include/linux/fs.h#L2286 for the change I got suspicious about.

>Yeah, but do_get_write_access() blocks (usually waiting for the jbd2 kernel thread to complete, but possibly on a memory allocation); we don't return >EAGAIN or anything like that.  So I don't see how that would cause a wait loop.

>It's possible we could be returning -ENOMEM; are you looping for all write failures, or just for EAGAIN/EINTR and partial writes?

Blocking would make more sense with what I was seeing - the loop around the write() failures deep inside libstdc++'s output stream code may just have been me not manging to navigate that library particularly well.
