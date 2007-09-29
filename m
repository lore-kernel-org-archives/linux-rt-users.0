From: "Jaswinder Singh" <jaswinderlinuxrt@gmail.com>
Subject: Re: FAQ for realtime support in Linux Kernel
Date: Sat, 29 Sep 2007 20:46:20 +0530
Message-ID: <1985e0f60709290816k7f8c9bc2m6fb6c1fc4859243c@mail.gmail.com>
References: <1985e0f60709282200q46af6416v1df50da135d5d01c@mail.gmail.com>
	 <1985e0f60709282344m45b31dd0i2f3016d81f42265a@mail.gmail.com>
	 <1985e0f60709290551j7b79421fs9c8dcca5806a518c@mail.gmail.com>
	 <20070929131338.GF813@unix.sh>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: linux-rt-users@vger.kernel.org
To: "Luis Claudio R. Goncalves" <lclaudio@uudg.org>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from wx-out-0506.google.com ([66.249.82.234]:7451 "EHLO
	wx-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752638AbXI2PQW (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Sat, 29 Sep 2007 11:16:22 -0400
Received: by wx-out-0506.google.com with SMTP id h31so2710469wxd
        for <linux-rt-users@vger.kernel.org>; Sat, 29 Sep 2007 08:16:21 -0700 (PDT)
In-Reply-To: <20070929131338.GF813@unix.sh>
Content-Disposition: inline
Sender: linux-rt-users-owner@vger.kernel.org
List-Id: linux-rt-users.vger.kernel.org

http://rt.wiki.kernel.org/index.php/FAQ_for_realtime_support_in_Linux_Kernel

Thank you,

Jaswinder Singh.

On 9/29/07, Luis Claudio R. Goncalves <lclaudio@uudg.org> wrote:
> Jaswinder,
>
> On Sat, Sep 29, 2007 at 06:21:38PM +0530, Jaswinder Singh wrote:
> | Hello all,
> |
> | Please give contribution with open heart and give answers to max
> | questions as possible and give your reviews :
>
> I believe people were talking about you creating a FAQ entry in the RT Wiki
> page, at http://rt.wiki.kernel.org/index.php/Main_Page.
>
> | FAQ for realtime support in Linux Kernel
> | ---------------------------------------
> | Question Index
> | 1. Realtime Support questions
> | 2. Architecture questions
> | 3. Mailing list questions
> | 4. Realtime Patches questions
> | 5. Configuring/compiling questions
> | 6. Realtime samples/Performance questions
> | 7. Realtime Applications questions
> | 8. Maintainers  questions
> |
> | Section 1 - Realtime Support questions
> |
> | Q1 What is realtime support
> | A1
> |
> | Q2 How realtime works
> | A2 The RT-Preempt patch converts Linux into a fully preemptible
> | kernel. The magic is done with:
> |
> | * Making in-kernel locking-primitives (using spinlocks) preemptible
> | though reimplementation with rtmutexes:
> | * Critical sections protected by i.e. spinlock_t and rwlock_t are now
> | preemptible. The creation of non-preemptible sections (in kernel) is
> | still possible with raw_spinlock_t (same APIs like spinlock_t)
> | * Implementing priority inheritance for in-kernel spinlocks and
> | semaphores. For more information on priority inversion and priority
> | inheritance please consult Introduction to Priority Inversion
> | * Converting interrupt handlers into preemptible kernel threads: The
> | RT-Preempt patch treats soft interrupt handlers in kernel thread
> | context, which is represented by a task_struct like a common userspace
> | process. However it is also possible to register an IRQ in kernel
> | context.
> | * Converting the old Linux timer API into separate infrastructures for
> | high resolution kernel timers plus one for timeouts, leading to
> | userspace POSIX timers with high resolution.
> |
> | Q3 What is the procedure to add realtime support
> | A3 Download latest realtime preemption patch from
> | http://www.kernel.org/pub/linux/kernel/projects/rt/ then related get
> | vanilla kernel from http://kernel.org then patch , configure and
> | compile
> |
> | Section 2 - Architecture questions
> |
> | Q1 Which Architecture are supporting realtime and who is maintainer
> | A1
> |
> | Q2 What is the procedure to support realtime in new architecture
> | A2
> |
> | Section 3 - Mailing list questions
> |
> | Q1 realtime mailing list and archives
> | A1 http://www.mail-archive.com/linux-rt-users@vger.kernel.org/
> |
> | Q2 If I have some doubts or problems regarding realtime, do I need to
> | send mail in realtime mailing list or linux kernel mailing list or
> | both
> | A2
> |
> | Section 4 - Realtime Patches questions
> |
> | Q1 Why I need to download realtime patches, If realtime support is in
> | Linux kernel
> | A1
> |
> | Q2 Download latest realtime patches
> | A2 http://www.kernel.org/pub/linux/kernel/projects/rt/
> |
> | Q3 Where can I post my realtime patches
> | A3 Please send patches for the CONFIG_PREEMPT_RT Patch Set to LKML and
> | put Ingo Molnar and Thomas Gleixner on CC.
> |
> | Please do not send clocksource and clockevents related patches against
> | the -rt patch. Make sure they apply against the latest -hrt-dyntick
> | patch. -hrt-dyntick might be a bit ahead of -rt at times, but the -rt
> | patch pulls -hrt-dyntick on a regular base.
> |
> |
> | Section 5 - Configuring/compiling questions
> |
> | Q1 How to enable/disable realtime support
> | A1
> |
> | Q2 Change realtime support run time or statically
> | A2
> |
> | Q3 Required parameters for configuring realtime kernel
> | A3
> |
> | Q4 Optional parameters for configuring realtime kernel, but they
> | effect realtime performance
> | A4
> |
> | Section 6 - Realtime samples/Performance questions
> |
> | Q1 What effects by realtime support and how much and samples to test
> | it and who maintains these samples
> | a. scheduling, task switching time
> | b. Interrupt latency
> | c. Interprocess communication
> | d. Filesystem
> | e. Device drivers
> | f. Network
> | g. X-Windows
> |
> | Section 7 - Realtime Applications questions
> |
> | Q1 List of realtime APIs
> | A1
> |
> | Q2 How to write realtime applications
> | A2
> |
> | Q3 Which programming languages are suitable for writing realtime applications
> | A3
> |
> | Q4 Keep following things in mind while writing realtime applications
> | A4 Taking care of the following during the initial startup phase:
> | * Call directly from the main() entry the mlockall() call.
> | * Create all threads at startup time of the application, and touch
> | each page of the entire stack of each thread. Never start threads
> | dynamically during RT show time, this will ruin RT behavior.
> | * Never use system calls that are known to generate pagefaults, such
> | as fopen(). (Opening of files does the mmap() system call, which
> | generates a page-fault).
> | * Do not use 'compile time static arrays' without initializing them
> | directly after startup, before RT show time.
> |
> |
> | Q5 Do I need to recompile my applications to get realtime performance
> | A5
> |
> | Section 8 - Maintainers questions
> |
> | Q1 Maintainers of realtime kernel patch
> | A1
> |
> | On 9/29/07, Jaswinder Singh <jaswinderlinuxrt@gmail.com> wrote:
> | > hello all,
> | >
> | > I made sections in FAQ to make it more readable.
> | >
> | > Thank you,
> | >
> | > Jaswinder Singh.
> | >
> | -
> | To unsubscribe from this list: send the line "unsubscribe linux-rt-users" in
> | the body of a message to majordomo@vger.kernel.org
> | More majordomo info at  http://vger.kernel.org/majordomo-info.html
> ---end quoted text---
>
> --
> [ Luis Claudio R. Goncalves             Red Hat  -  Realtime Team ]
> [ Fingerprint: 4FDD B8C4 3C59 34BD 8BE9  2696 7203 D980 A448 C8F8 ]
>
>
