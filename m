Return-Path: <SRS0=gcb+=EK=vger.kernel.org=linux-rt-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A9229C4742C
	for <linux-rt-users@archiver.kernel.org>; Wed,  4 Nov 2020 00:57:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6CA0D22403
	for <linux-rt-users@archiver.kernel.org>; Wed,  4 Nov 2020 00:57:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=gmx.net header.i=@gmx.net header.b="NFDqKFK3"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729144AbgKDA5J (ORCPT
        <rfc822;linux-rt-users@archiver.kernel.org>);
        Tue, 3 Nov 2020 19:57:09 -0500
Received: from mout.gmx.net ([212.227.15.19]:51067 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728157AbgKDA5J (ORCPT <rfc822;linux-rt-users@vger.kernel.org>);
        Tue, 3 Nov 2020 19:57:09 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1604451402;
        bh=UxyVQWzssxV5RUGWqHvr9JlZinMf8THDw2VxtHoZX30=;
        h=X-UI-Sender-Class:Subject:From:To:Cc:Date:In-Reply-To:References;
        b=NFDqKFK3P9fVjC7SH4Ups9cehCcU+VPgX5WYsgpuL8iCPjaJFfXXKob+52sRTUT6T
         psHW9VNZUBDlU0hzT4L0exl56iX3O9K/zG73Tq4q8BWJnDbeEafd816l/86L1hpy0l
         W8qbnv8iZSvyrph1K7jGmlBVpj4rQzeO5G3Jd5yY=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from homer.fritz.box ([185.221.148.80]) by mail.gmx.com (mrgmx005
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1N8GQs-1kDrEf3UZM-014CCW; Wed, 04
 Nov 2020 01:56:41 +0100
Message-ID: <2376f4e71c638aee215a4911e5efed14c5adf56e.camel@gmx.de>
Subject: Re: BUG_ON(!newowner) in fixup_pi_state_owner()
From:   Mike Galbraith <efault@gmx.de>
To:     Gratian Crisan <gratian.crisan@ni.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Peter Zijlstra <peterz@infradead.org>
Cc:     linux-kernel@vger.kernel.org, linux-rt-users@vger.kernel.org,
        Brandon Streiff <brandon.streiff@ni.com>,
        Ingo Molnar <mingo@redhat.com>,
        Darren Hart <dvhart@infradead.org>,
        James Minor <james.minor@ni.com>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Date:   Wed, 04 Nov 2020 01:56:40 +0100
In-Reply-To: <878sbixbk4.fsf@ni.com>
References: <87a6w6x7bb.fsf@ni.com> <878sbixbk4.fsf@ni.com>
Content-Type: text/plain; charset="ISO-8859-15"
User-Agent: Evolution 3.34.4 
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:sBC4XIHnp+NqNeu8kMp7ODZCa1bw9FoOWdAUlWe2i20LX6iq+da
 k+DSMpwALO7lbxpMdz3pmbKp9gWNBTgz65WdxSt89pMV1sTbfyoXzuSNi2YQRpcmpnM23bP
 H7/JRR+1cviEmj1k+fevOFmGk8XjwFa4/zFFT5soa10hD9MXUfRAlMQKS11UZjR8f8Nc5M4
 2lUxfwx3rf6I/ZIMb8HNA==
X-UI-Out-Filterresults: notjunk:1;V03:K0:EVgi3QojbdM=:STFWUNpyxMXTpqVZtq3O6W
 r4MV4U5CWxT2C98QOeSNALSgshSXKQmaM1G+oUVJse8IXxwMNCIqsKSYD4zFCcHJICZg49GUd
 30r8IohrxP2Kk8psZUzxCQt3FvMHfFaPBUoxbX3ytG+mYDyJO39lvyIHMZt7FUF11vnbszeEW
 3K7P/EGhUBQ+vNiItF5YKWgqxvIbfnJ/SOLdqAWRVM1XR8AiqSSzutxbYEjvxg8pqj6yaVXkZ
 Tc5pJ7U00uiPzfcQbN5SWlkDE3/BX47am0CjNlkVhsJGJpEDP0OaxqCKLzrGWk5K4TfbKHiKw
 adrdRkUH60wMUP+3PjokT5hzfZhr2YNHQnJb81b+fQXse1/I9x16lZNsF8w0NXrFDXW+BEfgj
 1+yju/ui5osAUv1N9XgYUHeSN/P0uSwAK0fX29eoI5SbjqE0KeVnKNGPrNeWc40Ns7XXNBqTk
 K1Y7N43VW7CygQyptFXXZuwdtYcpuTs5Iml3452nsCl02Dc/TVArYTu2raN54/ug3lTawsoKi
 aQsSE4nrp4bgidyMw4dbpBeI3F9rYEFYKPlS6v9cazjBzhiWSWsTDcn8d+Ks0p25gPmtEyYtS
 jUyNzFbFC0XNwJcwFm3AsdpvMGmf+EzTfI6bBQEOb/6xrNVasuSQoqh9ithI7ppPqfSdtETyg
 eq+HzeM2mfGpOuJ81eODzslOg3w+JDeQ64/3BzRTLQYZZuPjFLIwE/omC40xnKiuBeN9q8r6O
 Ubzj2VZRAwIgNI4nUpEGyD3Cm4r7bru9+tTjvBHWRFq3LTUIxf2xCGKhDU44TFHKZ4bkGt4X/
 iQDEpujpDiJGu5lhISl+E8oU+jMhJ1xiUbraSpxQKp/+f22oqR4pNDJSBMMRoRlhdl0gyatyT
 9Qf/t0UODZG64qkPdOyQ==
Precedence: bulk
List-ID: <linux-rt-users.vger.kernel.org>
X-Mailing-List: linux-rt-users@vger.kernel.org

On Tue, 2020-11-03 at 17:31 -0600, Gratian Crisan wrote:
> Hi all,
>
> I apologize for waking up the futex demons (and replying to my own
> email), but ...
>
> Gratian Crisan writes:
> >
> > Brandon and I have been debugging a nasty race that leads to
> > BUG_ON(!newowner) in fixup_pi_state_owner() in futex.c. So far
> > we've only been able to reproduce the issue on 4.9.y-rt kernels.
> > We are still testing if this is a problem for later RT branches.
>
> I was able to reproduce the BUG_ON(!newowner) in fixup_pi_state_owner()
> with a 5.10.0-rc1-rt1 kernel (currently testing 5.10.0-rc2-rt4).

My box says it's generic.

      KERNEL: vmlinux-5.10.0.gb7cbaf5-master.gz
    DUMPFILE: vmcore
        CPUS: 8
        DATE: Wed Nov  4 01:46:56 2020
      UPTIME: 00:02:06
LOAD AVERAGE: 0.25, 0.15, 0.06
       TASKS: 726
    NODENAME: homer
     RELEASE: 5.10.0.gb7cbaf5-master
     VERSION: #26 SMP Tue Nov 3 14:10:35 CET 2020
     MACHINE: x86_64  (3591 Mhz)
      MEMORY: 16 GB
       PANIC: ""
         PID: 4631
     COMMAND: "f_waiter"
        TASK: ffff88818a1fb900  [THREAD_INFO: ffff88818a1fb900]
         CPU: 1
       STATE: TASK_RUNNING (PANIC)

crash.rt> bt
PID: 4631   TASK: ffff88818a1fb900  CPU: 1   COMMAND: "f_waiter"
 #0 [ffff88816a0b3a58] machine_kexec at ffffffff8104b2dc
 #1 [ffff88816a0b3aa0] __crash_kexec at ffffffff810fc97a
 #2 [ffff88816a0b3b60] crash_kexec at ffffffff810fda55
 #3 [ffff88816a0b3b70] oops_end at ffffffff81021813
 #4 [ffff88816a0b3b90] do_trap at ffffffff8101eaec
 #5 [ffff88816a0b3be0] do_error_trap at ffffffff8101ebd5
 #6 [ffff88816a0b3c20] exc_invalid_op at ffffffff816d8bdb
 #7 [ffff88816a0b3c40] asm_exc_invalid_op at ffffffff81800a62
 #8 [ffff88816a0b3cc8] fixup_pi_state_owner at ffffffff810f065c
 #9 [ffff88816a0b3d58] futex_wait_requeue_pi.constprop.0 at ffffffff810f1f=
cb
#10 [ffff88816a0b3ec8] do_futex at ffffffff810f2482
#11 [ffff88816a0b3ed8] __x64_sys_futex at ffffffff810f2ab5
#12 [ffff88816a0b3f40] do_syscall_64 at ffffffff816d88c3
#13 [ffff88816a0b3f50] entry_SYSCALL_64_after_hwframe at ffffffff8180007c
    RIP: 00007f665b94f839  RSP: 00007f665b056e88  RFLAGS: 00000212
    RAX: ffffffffffffffda  RBX: 0000000000000000  RCX: 00007f665b94f839
    RDX: 0000000000000509  RSI: 000000000000008b  RDI: 00000000006020c0
    RBP: 00007f665b056ed0   R8: 00000000006020c4   R9: 0000000000000000
    R10: 00007f665b056ef0  R11: 0000000000000212  R12: 00007ffd42284c3e
    R13: 00007ffd42284c3f  R14: 0000000000000000  R15: 00007ffd42284c40
    ORIG_RAX: 00000000000000ca  CS: 0033  SS: 002b
crash.rt> gdb list *0xffffffff810f065c
0xffffffff810f065c is in fixup_pi_state_owner (kernel/futex.c:2386).
2381
2382                    /*
2383                     * Since we just failed the trylock; there must be=
 an owner.
2384                     */
2385                    newowner =3D rt_mutex_owner(&pi_state->pi_mutex);
2386                    BUG_ON(!newowner);
2387            } else {
2388                    WARN_ON_ONCE(argowner !=3D current);
2389                    if (oldowner =3D=3D current) {
2390                            /*
crash.rt>

