From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Subject: Re: Hung task for proc_cgroup_show
Date: Fri, 11 Dec 2015 17:14:50 +0100
Message-ID: <20151211161450.GA6720@linutronix.de>
References: <CALqGcGoMqJuvzQpGb84LzyxQCJADB73YEreND0HgOFK5DOQ6ig@mail.gmail.com>
 <20150714150016.GC21820@linutronix.de>
 <CALqGcGqzWsNacBHRUgFOrtJB6MSoqR+kDJteA8mgi9E4_o8vxw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Linux RT Users <linux-rt-users@vger.kernel.org>
To: Christoph Mathys <eraserix@gmail.com>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from www.linutronix.de ([62.245.132.108]:46873 "EHLO
	Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751134AbbLKQOw (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Fri, 11 Dec 2015 11:14:52 -0500
Content-Disposition: inline
In-Reply-To: <CALqGcGqzWsNacBHRUgFOrtJB6MSoqR+kDJteA8mgi9E4_o8vxw@mail.gmail.com>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

* Christoph Mathys | 2015-08-03 08:19:59 [+0200]:

>I could reproduce the lockup with cgroup stuff again, this time I with
>information about locks.

According to the info you sent, we have:
|Showing all locks held in the system:
|1 lock held by kswork/69:
| #0:  (cgroup_mutex){......}, at: [<ffffffff810e3d4f>] css_release_work_fn+0x2f/0xd0
|2 locks held by systemd-logind/583:
| #0:  (&p->lock){......}, at: [<ffffffff811d077b>] seq_read+0x3b/0x380
| #1:  (cgroup_mutex){......}, at: [<ffffffff810ea122>] proc_cgroup_show+0x52/0x200
|3 locks held by polkitd/913:
| #0:  (&f->f_pos_lock){......}, at: [<ffffffff811ca69a>] __fdget_pos+0x4a/0x50
| #1:  (&p->lock){......}, at: [<ffffffff811d077b>] seq_read+0x3b/0x380
| #2:  (cgroup_mutex){......}, at: [<ffffffff810ea122>] proc_cgroup_show+0x52/0x200
|3 locks held by kworker/3:0/10502:
| #0:  ("cgroup_destroy"){......}, at: [<ffffffff8106a88d>] process_one_work+0x15d/0x5b0
| #1:  ((&css->destroy_work)){......}, at: [<ffffffff8106a88d>] process_one_work+0x15d/0x5b0
| #2:  (cgroup_mutex){......}, at: [<ffffffff810e549f>] css_killed_work_fn+0x1f/0x170
|3 locks held by kworker/2:3/19520:
| #0:  ("cgroup_destroy"){......}, at: [<ffffffff8106a88d>] process_one_work+0x15d/0x5b0
| #1:  ((&css->destroy_work)){......}, at: [<ffffffff8106a88d>] process_one_work+0x15d/0x5b0
| #2:  (cgroup_mutex){......}, at: [<ffffffff810e549f>] css_killed_work_fn+0x1f/0x170
|2 locks held by lxc-start/21854:
| #0:  (&p->lock){......}, at: [<ffffffff811d077b>] seq_read+0x3b/0x380
| #1:  (cgroup_mutex){......}, at: [<ffffffff810ea122>] proc_cgroup_show+0x52/0x200
|2 locks held by lxc-ls/21856:
| #0:  (&p->lock){......}, at: [<ffffffff811d077b>] seq_read+0x3b/0x380
| #1:  (cgroup_mutex){......}, at: [<ffffffff810ea122>] proc_cgroup_show+0x52/0x200

One of them owns the lock, the others are blocked on it. We see
cgroup_mutex multiple times because we first tell lockdep that we own it
and then we block on it. I think none of proc_cgroup_show() functions
really own the mutex because I would expect to see css_set_rwsem as well
in the list of owned locks which I don't.

This means css_release_work_fn() or css_killed_work_fn(). Can you issue
a task dump which says what the tasks are doing?
What is it that you are doing exactly?

Sebastian
