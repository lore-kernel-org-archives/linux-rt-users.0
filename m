From: Steven Rostedt <rostedt@goodmis.org>
Subject: Re: Observed deadlock in ext4 under 3.2.23-rt37 & 3.2.33-rt50
Date: Wed, 02 Jan 2013 22:09:43 -0500
Message-ID: <1357182583.10284.16.camel@gandalf.local.home>
References: <7A2FC0CD30EF4745AE15F485252D38AC2F45A70C9A@clark>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-15"
Content-Transfer-Encoding: 7bit
Cc: "linux-rt-users@vger.kernel.org" <linux-rt-users@vger.kernel.org>,
	"tglx@linutronix.de" <tglx@linutronix.de>,
	"C.Emde@osadl.org" <C.Emde@osadl.org>,
	"jkacur@redhat.com" <jkacur@redhat.com>
To: Staffan Tjernstrom <stjernstrom@eagleseven.com>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from hrndva-omtalb.mail.rr.com ([71.74.56.122]:6543 "EHLO
	hrndva-omtalb.mail.rr.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752861Ab3ACDJq (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Wed, 2 Jan 2013 22:09:46 -0500
In-Reply-To: <7A2FC0CD30EF4745AE15F485252D38AC2F45A70C9A@clark>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

On Thu, 2012-12-27 at 09:34 -0600, Staffan Tjernstrom wrote:
> First of all apologies if this should have gone to the ext4
> maintainers instead, but I figured since I'd seen some -rt specific
> patches from you folks in the last few weeks I'd send this your way
> first.
> 
No your issue is most likely caused by -rt.

I guess the question is, can you try 3.2.35-rt53 and even better, the
latest -rt kernel, or even 3.4.24-rt36.


> Unfortunately all I have available to help trace it down at this time
> is the kernel (via /proc/pid/stack) stack of the tasks involved - it
> seems that it can get cleared by a signal hitting the blocking task(s)
> (eg attaching gdb seems to clear the problem). The stack dumps are
> transcribed rather than cut/pasted due to the security regimen around
> the systems the issue has been observed on - apologies for
> transcription errors.
> 

The fact that it clears up when you attach gdb, is probably due to a
live lock. That is, something is preventing something else from running.
Not necessarily a deadlock where something is blocked on something
that's blocked on it.


> The traces below are from 3.2.23-rt37.56.el6rt (but we've also
> observed it under 3.2.33-rt50.66.el6rt).
> 

It would be best if you could give a full task dump:

Boot the kernel with something like log_buf_len=10M (a printk buffer of
10 megs). And then 'echo t > /proc/sysrq-trigger' when the lock up
happens. If you can get a copy of the dmesg, that would be great. Of
course you may need to higher a few secretaries to transcribe the
output ;-)

Thanks,

-- Steve

> Trace 1:
> 
>  
> 
> [<ffffffffa01a085d>] jbd2_log_wait_commit+0xcd/0x150
> 
> [<ffffffffa01b74a5>] ext4_sync_file+0x1e5/0x480
> 
> [<ffffffff8117a42b>] vfs_fsync_range+0x2b/0x30
> 
> [<ffffffff8117a44c>] vfs_fsync+0x1c/0x20
> 
> [<ffffffff8117a68a>] do_fsync+0x3a/0x60
> 
> [<ffffffff8117a6c3>] sys_fdatasync+0x13/0x20
> 
> [<ffffffff814e7feb>] system_call_fastpath+0x16/0x1b
> 
>  
> 
> Trace 2:
> 
> [<ffffffffa0199dc5>] do_get_write_access+0x2a5/0x4d0
> 
> [<ffffffffa019a021>] jbd2_journal_get_write_access+0x31/0x50
> 
> [<ffffffffa01e93ce>] __ext4_journal_get_write_access+0x3e/0x80
> 
> [<ffffffffa01be028>] ext4_reserve_inode_write+0x78/0xa0
> 
> [<ffffffffa01be0a6>] ext4_mark_inode_dirty+0x56/0x270
> 
> [<ffffffffa01be41d>] ext4_dirty_inode+0x3d/0x60
> 
> [<ffffffff81173ee0>] __mark_inode_dirty+0x40/0x250
> 
> [<ffffffff81165282>] file_update_time+0xd2/0x160
> 
> [<ffffffff810f9968>] __generic_file_aio_write+0x208/0x460
> 
> [<ffffffff810f9c36>] generic_file_aio_write+0x76/0xf0
> 
> [<ffffffffa01b6f89>] ext4_file_write+x069/0x280
> 
> [<ffffffff8114a9ea>] do_sync_write+0xea/0x130
> 
> [<ffffffff8114af78>] vfs_write+0xc8/0x190
> 
> [<ffffffff8114b141>] sys_write+0x51/0x90
> 
> [<ffffffff814e7feb>] system_call_fastpath+0x16/0x1b
> 
>  
> 
> When the situation occurs (for us about once every two days or so) we
> get multiple procs in Trace1, one in Trace2. Stopping the Trace2 task
> clears the situaition.
> 
>  
> 
> Hopefully that's enough information to give you good folks a clue as
> to what is going on. If you want more detail, please drop me a line
> and I will see what I can do to obtain it.
> 
>  
> 



