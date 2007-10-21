From: "Dmitry Adamushko" <dmitry.adamushko@gmail.com>
Subject: Re: [patch 6/8] pull RT tasks
Date: Sun, 21 Oct 2007 11:35:56 +0200
Message-ID: <b647ffbd0710210235tf487bb3x1ffe73161fe0c9f7@mail.gmail.com>
References: <20071019184254.456160632@goodmis.org>
	 <20071019184336.983272715@goodmis.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: LKML <linux-kernel@vger.kernel.org>,
	RT <linux-rt-users@vger.kernel.org>,
	"Linus Torvalds" <torvalds@linux-foundation.org>,
	"Andrew Morton" <akpm@linux-foundation.org>,
	"Ingo Molnar" <mingo@elte.hu>,
	"Thomas Gleixner" <tglx@linutronix.de>,
	"Gregory Haskins" <ghaskins@novell.com>,
	"Peter Zijlstra" <a.p.zijlstra@chello.nl>
To: "Steven Rostedt" <rostedt@goodmis.org>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from wa-out-1112.google.com ([209.85.146.180]:34658 "EHLO
	wa-out-1112.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751354AbXJUJf6 (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Sun, 21 Oct 2007 05:35:58 -0400
Received: by wa-out-1112.google.com with SMTP id v27so919720wah
        for <linux-rt-users@vger.kernel.org>; Sun, 21 Oct 2007 02:35:57 -0700 (PDT)
In-Reply-To: <20071019184336.983272715@goodmis.org>
Content-Disposition: inline
Sender: linux-rt-users-owner@vger.kernel.org
List-Id: linux-rt-users.vger.kernel.org

Hi Steven,

> When a pull RT is initiated, all overloaded runqueues are examined for
> a RT task that is higher in prio than the highest prio task queued on the
> target runqueue. If another runqueue holds a RT task that is of higher
> prio than the highest prio task on the target runqueue is found it is pulled
> to the target runqueue.

I think, 2 things should be accomplished here :

(1) be sure to pull the _highest_ prio task ;

i.e. the _highest_ prio task amongst all runnable (but not running) RT
tasks across all the run-queues which is capable of running on
this_cpu ;

(2) don't pull more than 1 task at once.

that said, just pull the highest prio task and run it.

---

why (2)? Just to avoid situations when tasks are being pulled/pushed
back and forth between run-queues.

Let's say we have 4 cpu system:

0:  task(10) , task(92)
1:  task(10), task(91)
2:  task(10), task(90)
3:  task(10)

when task(10) on cpu#3 is inactive, we pull task(92), task(91),
task(90) and then run task(90)... in the mean time, some of cpu[0..2]
becomes inactive and pull task(91) and task(92) back and run them...
that may repeat again and again depending on when/how long task(10)
run on their corresponding cpus...

so it seems to me that the more optimal behavior would be "don't pull
more than you can run at the moment -- that's 1".

to this goal, something like find_lock_highest_rq() would be necessary.

and I guess, {get,put}_task_struct() should be used in pull_rt_task()
for the 'next' in a similar way as it's done in push_rt_task() .


>
> [ ... ]
>

-- 
Best regards,
Dmitry Adamushko
