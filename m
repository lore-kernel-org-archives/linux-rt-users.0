From: Thomas Gleixner <tglx@linutronix.de>
Subject: Re: [PATCH] PREEMPT_RT_FULL Build error fix
Date: Thu, 1 Sep 2011 21:14:42 +0200 (CEST)
Message-ID: <alpine.LFD.2.02.1109012112100.2723@ionos>
References: <1314360393-13605-1-git-send-email-jkacur@redhat.com>
Mime-Version: 1.0
Content-Type: MULTIPART/MIXED; BOUNDARY="8323328-222593702-1314904483=:2723"
Cc: rt-users <linux-rt-users@vger.kernel.org>,
	Peter Zijlstra <a.p.zijlstra@chello.nl>,
	lkml <linux-kernel@vger.kernel.org>
To: John Kacur <jkacur@redhat.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1314360393-13605-1-git-send-email-jkacur@redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-rt-users.vger.kernel.org

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323328-222593702-1314904483=:2723
Content-Type: TEXT/PLAIN; charset=UTF-8
Content-Transfer-Encoding: 8BIT

On Fri, 26 Aug 2011, John Kacur wrote:

> Problem:
> make O=/bld/3.0.3-rt11/ kernel/fork.o
> /home/jkacur/jk-2.6/kernel/fork.c:91: error: section of ‘name’ conflicts with previous declaration
> 
> __cacheline_aligned is already part of the definition of DEFINE_RWLOCK
> for -rt
> 
> However it is not always used for the tasklist_lock in non-rt, so it can't
> simply be added to the definition of DEFINE_RWLOCK in non-rt, so I modified
> the definition in fork.c

-ENOPARSE

The real question is whether RWLOCKS should be cacheline aligned in
general or the RT addon is just overkill. Slapping an ifdef around
does not answer that.

Thanks,

	tglx
--8323328-222593702-1314904483=:2723--
