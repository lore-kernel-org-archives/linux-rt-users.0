From: David VomLehn <dvomlehn@gmail.com>
Subject: Scheduling while atomic in find_task_lock_mm
Date: Wed, 22 Jul 2015 11:39:55 -0700
Message-ID: <20150722183955.GA3188@Gracie>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
To: "linux-rt-users@vger.kernel.org" <linux-rt-users@vger.kernel.org>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from mail-pd0-f171.google.com ([209.85.192.171]:32870 "EHLO
	mail-pd0-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751236AbbGVSkF (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Wed, 22 Jul 2015 14:40:05 -0400
Received: by pdbnt7 with SMTP id nt7so71765045pdb.0
        for <linux-rt-users@vger.kernel.org>; Wed, 22 Jul 2015 11:40:04 -0700 (PDT)
Received: from Gracie ([2601:647:4d01:93c7:d451:357e:83c1:13e9])
        by smtp.googlemail.com with ESMTPSA id fu2sm4611607pdb.32.2015.07.22.11.40.02
        for <linux-rt-users@vger.kernel.org>
        (version=TLSv1/SSLv3 cipher=OTHER);
        Wed, 22 Jul 2015 11:40:03 -0700 (PDT)
Content-Disposition: inline
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

I'm trying to port the RT patch to Android (based on Linux 3.10) and things have been
going pretty smoothly. However, I've hit a snag--I have to have hot plugging enabled
and when the system tries to take down a CPU, it gets "scheduling while atomic". At
a high level, the code to take the CPU down is trying to clear the CPU's bit in the
mm_struct associated with every task_struct.

In more detail, cpu_stopper_thread() disables preemption, then there is a sequence
of calls, passing through the ARM-specific __cpu_disable(), finally atrriving at
find_lock_task_mm(). That function calls task_lock(), which uses spin_lock() to
lock a task_struct. When it encounters a task_struct that is already locked, schedule()
gets called and Bad Things happen.

So:
o	I don't think I can enable preemption here because it's pretty like another
	task will swoop in and mess things up.

o	Using a raw_spin_lock() just for ARM doesn't seem like a good choice.

o	I *think* I do need the spin_lock() before changing the CPU's bit in the
	cpu_vm_mask_var element of the mm_struct.
