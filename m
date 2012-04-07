From: Juri Lelli <juri.lelli@gmail.com>
Subject: SCHED_DEADLINE v4
Date: Sat, 07 Apr 2012 09:52:58 +0200
Message-ID: <4F7FF25A.3050807@gmail.com>
References: <1333696481-3433-1-git-send-email-juri.lelli@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
To: linux-dl@retis.sssup.it, RT <linux-rt-users@vger.kernel.org>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from mail-wi0-f178.google.com ([209.85.212.178]:45518 "EHLO
	mail-wi0-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751008Ab2DGHxC (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Sat, 7 Apr 2012 03:53:02 -0400
Received: by wibhq7 with SMTP id hq7so1069222wib.1
        for <linux-rt-users@vger.kernel.org>; Sat, 07 Apr 2012 00:53:00 -0700 (PDT)
In-Reply-To: <1333696481-3433-1-git-send-email-juri.lelli@gmail.com>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

Hello everyone,

This is to inform you that a new version of the SCHED_DEADLINE patchset
is out (v4). What follows is an excerpt of the overview (00/16) messsage
sent on LKML, you can find the thread here:
https://lkml.org/lkml/2012/4/6/39

[...]
Just to recap, the patchset introduces a new deadline based real-time
task scheduling policy --called SCHED_DEADLINE-- with bandwidth
isolation (aka "resource reservation") capabilities. It now supports
global/clustered multiprocessor scheduling through dynamic task
migrations.


  From the previous releases[1]:
   - all the comments and the fixes coming from the reviews we got have
     been considered and applied;
   - better handling of rq selection for dynamic task migration, by means
     of a cpupri equivalent for -deadline tasks (cpudl). The mechanism
     is simple and straightforward, but showed nice performance figures[2].
   - this time we sit on top of PREEMPT_RT (3.2.13-rt23); we continue to aim
     at mainline inclusion, but we also see -rt folks as immediate and
     interested users.

Still missing/incomplete:
   - (c)group based bandwidth management, and maybe scheduling. It seems
     some more discussion on what precisely we want is *really* needed
     for this point;
   - bandwidth inheritance (to replace deadline/priority inheritance).
     What's in the patchset is just very few more than a simple
     placeholder. More discussion on the right way to go is needed here.
     Some work has already been done, but it is still not ready for
     submission.

The development is taking place at:
    https://github.com/jlelli/sched-deadline

Check the repositories frequently if you're interested, and feel free to
e-mail me for any issue you run into.

Furthermore, we developed an application that you can use to test this
patchset:
   https://github.com/gbagnoli/rt-app

We also set up a development mailing list: linux-dl[3].
You can subscribe from here:
http://feanor.sssup.it/mailman/listinfo/linux-dl
or via e-mail (send a message to linux-dl-request@retis.sssup.it with
just the word `help' as subject or in the body to receive info).

As already discussed we are planning to merge this work with the EDF
throttling patches [https://lkml.org/lkml/2010/2/23/239] but we still are in
the preliminary phases of the merge and we intend to use the feedback to this
post to help us decide on the direction it should take.

As said, patchset is on top of PREEMPT_RT (as of today). However, Insop
Song (from Ericsson) is maintaining a parallel branch for the current
tip/master (https://github.com/insop/sched-deadline2). Ericsson is in fact
evaluating the use of SCHED_DEADLINE for CPE (Customer Premise Equipment)
devices in order to reserve CPU bandwidth to processes.

The code was being jointly developed by ReTiS Lab (http://retis.sssup.it)
and Evidence S.r.l (http://www.evidence.eu.com) in the context of the ACTORS
EU-funded project (http://www.actors-project.eu). It is now also supported by
the S(o)OS EU-funded project (http://www.soos-project.eu/).
It has also some users, both in academic and applied research. Even if our
last release dates back almost a year we continued to get feedback
from Ericsson (see above), Wind River, Porto (ISEP), Trento and Malardalen
universities :-).

As usual, any kind of feedback is welcome and appreciated.

Thanks in advice and regards,

  - Juri

[1] http://lwn.net/Articles/376502, http://lwn.net/Articles/353797,
     http://lwn.net/Articles/412410
[2] http://retis.sssup.it/~jlelli/papers/Ospert11Lelli.pdf
[3] from the first linux-dl message:
     -linux-dl should become the place where discussions about real-time
      deadline scheduling on Linux take place (not only SCHED_DEADLINE).
      We felt the lack of a place where we can keep in touch with each
      other; we are all working on the same things, but probably from
      different viewpoints, and this is surely a point of strength.
      Anyway, our efforts need to be organized in some way, or at least it
      is important to know on what everyone is currently working as to not
      end up with "duplicate-efforts".-

Dario Faggioli (10):
       sched: add extended scheduling interface.
       sched: SCHED_DEADLINE data structures.
       sched: SCHED_DEADLINE policy implementation.
       sched: SCHED_DEADLINE avg_update accounting.
       sched: add schedstats for -deadline tasks.
       sched: add resource limits for -deadline tasks.
       sched: add latency tracing for -deadline tasks.
       sched: drafted deadline inheritance logic.
       sched: add bandwidth management for sched_dl.
       sched: add sched_dl documentation.

Juri Lelli (3):
       sched: SCHED_DEADLINE SMP-related data structures.
       sched: SCHED_DEADLINE push and pull logic
       sched: speed up -dl pushes with a push-heap.

Harald Gustafsson (1):
       sched: add period support for -deadline tasks.

Peter Zijlstra (1):
       rtmutex: turn the plist into an rb-tree.
[...]
