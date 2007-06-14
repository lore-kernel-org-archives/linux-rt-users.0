From: Shane <gnome42@gmail.com>
Subject: Re: [PATCH RT] fix migrating softirq [cause of network hang]
Date: Thu, 14 Jun 2007 12:00:41 -0400
Message-ID: <fa4052ef0706140900g496180fdx75585b004cd59057@mail.gmail.com>
References: <fa4052ef0706131414o27b2281bp81d3f5b3d3104f87@mail.gmail.com>
	 <Pine.LNX.4.58.0706131723430.20636@gandalf.stny.rr.com>
	 <fa4052ef0706131520x619ff3f5ke23cf649b8ff2b79@mail.gmail.com>
	 <Pine.LNX.4.58.0706131954220.20636@gandalf.stny.rr.com>
	 <fa4052ef0706140710s547115d5o13f3dba018caaa78@mail.gmail.com>
	 <Pine.LNX.4.58.0706141017090.891@gandalf.stny.rr.com>
	 <fa4052ef0706140746h487114deqe5b28451ac87e0b2@mail.gmail.com>
	 <fa4052ef0706140808o22f4cc7dua04369db230eaa1e@mail.gmail.com>
	 <fa4052ef0706140814g2e2c8ffdx6b91eaa714b92857@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Cc: linux-rt-users@vger.kernel.org, mingo@elte.hu
To: "Steven Rostedt" <rostedt@goodmis.org>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from py-out-1112.google.com ([64.233.166.180]:32002 "EHLO
	py-out-1112.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752252AbXFNQAm (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Thu, 14 Jun 2007 12:00:42 -0400
Received: by py-out-1112.google.com with SMTP id a29so1033025pyi
        for <linux-rt-users@vger.kernel.org>; Thu, 14 Jun 2007 09:00:41 -0700 (PDT)
In-Reply-To: <fa4052ef0706140814g2e2c8ffdx6b91eaa714b92857@mail.gmail.com>
Content-Disposition: inline
Sender: linux-rt-users-owner@vger.kernel.org
List-Id: linux-rt-users.vger.kernel.org

On 6/14/07, Shane <gnome42@gmail.com> wrote:
> Sorry, that one was incomplete. Full sysrq-T is attached.

I don't know if it helps but here is a 'ls' hung accessing that nfs mount.

ls            S [ec39d6f0] 0000027D     0  4306   4289 (NOTLB)
       d2b47d18 00200086 f7cec50f 0000027d d2b47d00 00000000 00000000 0065b7f4
       00000000 f7cec407 0000027d 00000000 ec39d87c b011e290 ec39d6f0 b180d480
       00000000 f6e5508a 00000648 0065b7f4 00000000 94950179 00000649 f7cec50f
Call Trace:
 [<b011e290>] put_prev_task_fair+0x0/0x480
 [<b0142216>] rt_down+0x16/0x40
 [<b034dab2>] __reacquire_kernel_lock+0x22/0x30
 [<b034bcbf>] schedule+0x2f/0x110
 [<b01360ac>] prepare_to_wait+0x1c/0x60
 [<f0b69fda>] rpc_wait_bit_interruptible+0x1a/0x20 [sunrpc]
 [<b034c7c2>] __wait_on_bit+0x42/0x70
 [<f0b69fc0>] rpc_wait_bit_interruptible+0x0/0x20 [sunrpc]
 [<b0135f60>] wake_bit_function+0x0/0x60
 [<f0b69fc0>] rpc_wait_bit_interruptible+0x0/0x20 [sunrpc]
 [<b034c862>] out_of_line_wait_on_bit+0x72/0x90
 [<b0135f60>] wake_bit_function+0x0/0x60
 [<f0b6a5b1>] __rpc_execute+0xb1/0x260 [sunrpc]
 [<f0b6993b>] rpc_set_active+0x1b/0x60 [sunrpc]
 [<f0b64e08>] rpc_call_sync+0x98/0xa0 [sunrpc]
 [<f0be06db>] nfs3_rpc_wrapper+0x3b/0x60 [nfs]
 [<f0be0a47>] nfs3_proc_getattr+0x47/0x80 [nfs]
 [<f0bd6960>] __nfs_revalidate_inode+0x150/0x2f0 [nfs]
 [<b0182643>] mntput_no_expire+0x13/0x70
 [<b0175a26>] __link_path_walk+0xad6/0xe30
 [<b0182643>] mntput_no_expire+0x13/0x70
 [<b0175de5>] link_path_walk+0x65/0xc0
 [<b015e6b5>] do_mmap_pgoff+0x535/0x7a0
 [<f0bd7663>] nfs_getattr+0x63/0xe0 [nfs]
 [<b0167f6a>] kmem_cache_free+0x6a/0x80
 [<f0bd7600>] nfs_getattr+0x0/0xe0 [nfs]
 [<b016f91c>] vfs_getattr+0x4c/0x70
 [<b016f974>] vfs_lstat_fd+0x34/0x50
 [<b015e6b5>] do_mmap_pgoff+0x535/0x7a0
 [<b016f9df>] sys_lstat64+0xf/0x30
 [<b01421d4>] rt_up_read+0x24/0x50
 [<b0116b37>] do_page_fault+0x1e7/0x620
 [<b0104128>] sys_sigreturn+0xb8/0xcc
 [<b0104232>] sysenter_past_esp+0x5f/0x85

Also, I forgot to mention I found a workaround to keep it from hanging.

while : ;do ls -d /nfs/mount/data*/. ; sleep 5 ;done

Maybe points to something timing out?

Shane
