From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Subject: Re: Hung task for proc_cgroup_show
Date: Mon, 21 Dec 2015 19:11:53 +0100
Message-ID: <20151221181153.GB6714@linutronix.de>
References: <CALqGcGoMqJuvzQpGb84LzyxQCJADB73YEreND0HgOFK5DOQ6ig@mail.gmail.com>
 <20150714150016.GC21820@linutronix.de>
 <CALqGcGqzWsNacBHRUgFOrtJB6MSoqR+kDJteA8mgi9E4_o8vxw@mail.gmail.com>
 <20151211161450.GA6720@linutronix.de>
 <CALqGcGob5_qWeK1ndErqN9Z3DkGTPciTojjkEOkvauZyNd59Bg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Linux RT Users <linux-rt-users@vger.kernel.org>
To: Christoph Mathys <eraserix@gmail.com>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from www.linutronix.de ([62.245.132.108]:50497 "EHLO
	Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750914AbbLUSLz (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Mon, 21 Dec 2015 13:11:55 -0500
Content-Disposition: inline
In-Reply-To: <CALqGcGob5_qWeK1ndErqN9Z3DkGTPciTojjkEOkvauZyNd59Bg@mail.gmail.com>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

* Christoph Mathys | 2015-12-21 09:58:11 [+0100]:

>On Fri, Dec 11, 2015 at 5:14 PM, Sebastian Andrzej Siewior
><bigeasy@linutronix.de> wrote:
>> This means css_release_work_fn() or css_killed_work_fn(). Can you issue
>> a task dump which says what the tasks are doing?
>
>Here is another of those lockups, this time with 3.18.24-rt22. I took
>the liberty to remove everything not related to cgroups from the logs.
>
>Seeing the memory control group inside one of the call stacks I tried
>disabling this cgroup. I did not see the lockup again, but two system
>freezes instead.
>
So based on this output:

SysRq : Show Locks Held

Showing all locks held in the system:
1 lock held by kswork/69:
 #0:  (cgroup_mutex){+.+.+.}, at: [<ffffffff810ea7bf>] css_release_work_fn+0x2f/0xe0
4 locks held by cgmanager/349:
 #0:  (sb_writers#9){.+.+.+}, at: [<ffffffff811da1c4>] mnt_want_write+0x24/0x50
 #1:  (&type->i_mutex_dir_key#3/1){+.+.+.}, at: [<ffffffff811c7e7c>] do_rmdir+0x15c/0x220
 #2:  (&type->i_mutex_dir_key#3){+.+.+.}, at: [<ffffffff811c2017>] vfs_rmdir+0x57/0x150
 #3:  (cgroup_mutex){+.+.+.}, at: [<ffffffff810ebd40>] cgroup_kn_lock_live+0x50/0x180
3 locks held by kworker/2:2/3642:
 #0:  ("cgroup_destroy"){.+.+.+}, at: [<ffffffff8106b801>] process_one_work+0x171/0x5b0
 #1:  ((&css->destroy_work)){+.+.+.}, at: [<ffffffff8106b801>] process_one_work+0x171/0x5b0
 #2:  (cgroup_mutex){+.+.+.}, at: [<ffffffff810ebf2f>] css_killed_work_fn+0x1f/0x170

and the stack trace below it looks like each one of those three tasks
block on the mutex but none of them owns it.
So the question is if any of those tree waiters are marked as such and
if so why is there no wake up in progress.

Thank you for the steps how to reproduce it. I will try it next year.

Sebastian
