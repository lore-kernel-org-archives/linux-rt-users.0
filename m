Return-Path: <SRS0=B5od=6O=vger.kernel.org=linux-rt-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.2 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MSGID_FROM_MTA_HEADER,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3E92BC4724C
	for <linux-rt-users@archiver.kernel.org>; Thu, 30 Apr 2020 16:19:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 02507208C3
	for <linux-rt-users@archiver.kernel.org>; Thu, 30 Apr 2020 16:19:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=concurrentrt.onmicrosoft.com header.i=@concurrentrt.onmicrosoft.com header.b="5gqCLsUG"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728120AbgD3QSz (ORCPT
        <rfc822;linux-rt-users@archiver.kernel.org>);
        Thu, 30 Apr 2020 12:18:55 -0400
Received: from mail-eopbgr750132.outbound.protection.outlook.com ([40.107.75.132]:5718
        "EHLO NAM02-BL2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1728274AbgD3QSy (ORCPT <rfc822;linux-rt-users@vger.kernel.org>);
        Thu, 30 Apr 2020 12:18:54 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=khI7uWMAOkeP+xDlrSStDMUIgFCBZU/RQe6hfta3QAFJmd972pajTilY8E9eu3ehUtfwNkNMG/URZRU447140ag3wuYdWoiU/ilHBcmcClc28ciZiA4aYn0QJ/WWnGAcbCI2A1ovS7bX3flVxT1yQJQm9u85/x/Uis4kBuIEbxvxDVJYonFTGNuFk7mlv7aVzO08BK/6glaxiJSeMdMhaEIs9f1EUHcqa9RcRLSjzn4WsM5wnAlQMMG6zKPzDz1YB1ixSwR5CBO/cf7rusGPZbofWtPRxEKSfqHSM+/AWY31eRQ0bj8nDYSuBmaq6bNzLtei9gmC803LW7tSwjL2jA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7lSHvjW5Yi59WUwk9VXuOxFKcqdmTz5uHiMv1JVi8uU=;
 b=RqWGIsqgRwQewPBxYV0x+inr4dGuhXkwDeCFaS+22QCvpQ0dbRWK76JN2/lGh0kR+sRHzqkp+vFkA9bxbUIpeXEMhelm6cOY0ytJq7DtJjVLQNHDPhrZ29WZoV+ep30ojsFNLzI6ksKN/khCKegxXgnNbfokGrKLsv4IBZypQw/IdXsXspYSGrjKDhEAKlTM/Qmd6iY4doR1bMz700XKR4i3VoyWBS+8qLRxK/btPR1usHnwl38oDGPcALrX76sCxnO+ylHHRqA8EkOZ6mU9/NjSplZamyJHLOu2YsdBDN5B37naByL7LM2Alac7/4aC3YC7JClF9ddIoHb4JNdh5A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=concurrent-rt.com; dmarc=pass action=none
 header.from=concurrent-rt.com; dkim=pass header.d=concurrent-rt.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=concurrentrt.onmicrosoft.com; s=selector2-concurrentrt-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7lSHvjW5Yi59WUwk9VXuOxFKcqdmTz5uHiMv1JVi8uU=;
 b=5gqCLsUGVGUTI3uub7sc3vnYBJZKockHdNAZUNoG+e7N8/BGmYyRaA+L849lOdK+kIvn5aUY0EUM/p8p9HMa9BLxVlr0Veu5ykH+nFA8sPf9OYuJ770zZqaVFge317rlZBM+FZsZEiNS/AYETwRyC4vZQ4NelKCCQJuHK+cPqmI=
Authentication-Results: linutronix.de; dkim=none (message not signed)
 header.d=none;linutronix.de; dmarc=none action=none
 header.from=concurrent-rt.com;
Received: from CH2PR11MB4341.namprd11.prod.outlook.com (2603:10b6:610:3c::19)
 by CH2PR11MB4376.namprd11.prod.outlook.com (2603:10b6:610:40::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2958.19; Thu, 30 Apr
 2020 16:18:51 +0000
Received: from CH2PR11MB4341.namprd11.prod.outlook.com
 ([fe80::c988:43f9:15c3:7085]) by CH2PR11MB4341.namprd11.prod.outlook.com
 ([fe80::c988:43f9:15c3:7085%7]) with mapi id 15.20.2937.028; Thu, 30 Apr 2020
 16:18:50 +0000
Date:   Thu, 30 Apr 2020 12:18:48 -0400
From:   Joe Korty <joe.korty@concurrent-rt.com>
To:     Thomas Gleixner <tglx@linutronix.de>
Cc:     linux-rt-users@vger.kernel.org,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Subject: [PATCH] signals: Allow tasks to cache one sigqueue struct, version 2
Message-ID: <20200430161848.GA29113@zipoli.concurrent-rt.com>
Reply-To: Joe Korty <joe.korty@concurrent-rt.com>
References: <20200428154536.GA33300@zipoli.concurrent-rt.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200428154536.GA33300@zipoli.concurrent-rt.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
X-ClientProxiedBy: BN8PR03CA0001.namprd03.prod.outlook.com
 (2603:10b6:408:94::14) To CH2PR11MB4341.namprd11.prod.outlook.com
 (2603:10b6:610:3c::19)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from zipoli.concurrent-rt.com (12.220.59.2) by BN8PR03CA0001.namprd03.prod.outlook.com (2603:10b6:408:94::14) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2958.19 via Frontend Transport; Thu, 30 Apr 2020 16:18:50 +0000
X-Originating-IP: [12.220.59.2]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 2b2010c4-af5c-4d43-cea3-08d7ed222b24
X-MS-TrafficTypeDiagnostic: CH2PR11MB4376:
X-Microsoft-Antispam-PRVS: <CH2PR11MB43763D46BFE67EA4162FCF20A0AA0@CH2PR11MB4376.namprd11.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:8273;
X-Forefront-PRVS: 0389EDA07F
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: vd3s0G86wg9g9DuYLZPzuQVM2IY35M+iDEXqi2tOE+ZZlv/M0hazfy+9r+Xec8tgIOdzGWVSyFPZ3FZQOQem7dPg/GC2HqRH2FnJ0K+iVGyYVqq3YM1eyfbn18t4W+Sgf+wzEfc9HmpgIeToZoBHwo5r7sZux0tXDB3n2I9AnJaMSc3VZdbuHDqIbrKXEguOo3xaLRx2a/Beb+gEdA34HlE/QFG4sOh5JdKMVylWUAOS5DD8HMIfDI5J1wZUda9cI+FsGFLLLicl0SjZhF7QefZaVpdRJBf0lu5iif5vnIBFouWcOeICWL7aLcCdLfpgMmYU8eJg67oDUGQ57aSjy2rMn9UF/cWfJ1SPmU4dTc36SU7ZrHz2nRjDZ0OaqvG0zeSbnPNJfreKY0ENArn5H2bFNtJg/iDID/taaKf61VV15ova5sFQ/BBGv1+Iq4gZ
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH2PR11MB4341.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFTY:;SFS:(39840400004)(366004)(396003)(376002)(346002)(136003)(52116002)(7696005)(4326008)(55016002)(2906002)(1076003)(33656002)(6916009)(3450700001)(8936002)(44832011)(956004)(508600001)(8676002)(86362001)(66556008)(66946007)(66476007)(16526019)(26005)(5660300002)(316002)(186003);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData: Gvz+61CwQTRtzBRkRkgoGF41HuthB1IUiI0KtVTLYufMltPBX7gE4WAArSoVS020K+rn4Ek5JDx+EbYqVIRXawzdkwLtZO6Wz6+9Mo/2fLST1zDaGKs8Tf9KI4ff3LYGA4RG1kTKJ0IlZe1uE62gK53XlNBamDtf+Losu80I1DhAYKVAg1YsWjRnoQxF4EzI6tAy28eyznv6k+q5k9XOLdzQNfhQUROvQ6DzkQUgngsN1PDC78g3fmKvXyF7XIY2wmCo9PyPop66jvzLaEzJd2BZs1ilKuO2jwllpSorixCVpYm8iunl3Xnhco1UWRDUfW9EREb8Xlp/Mxz0iown3t52Q2ZpwUA5jsXh3hIyn4c3yZbsIz5jVwkFpHBhFpk9D4g/0gW4z3IQCTB+O45BURxSPMLyitCg5MbnTqTsqjDTLnzt2tzu76kypXCHRIEB/ipl/ABrcm7B2ZZmOEjPJokCl0uu/2uuOSCvHLS5o86m2VbWe+7JubcOqvK0qjfgZfVEHHc60P37KMX6zsyoczia5OdgZlQ+zFw636UvSOyWlzIOQwxrMekEfM0vbm6AGihplP75D7YH0/ceorJE4a/ix5vchiDYgcCEocwpWoW3kumiFMQPMJxG3aJldRpm9UqveC3Pa+LEI/GdQ3LKDPZ7/CTspZvp3DIaexB8O4BOtDMle4wUlSahSd5eEp5YwutJIXYTpala/bouSX53NB1+TFhXFGQK2VDtGUDhsS9hCnnteGBbKSQJcwuF9wTI2FUqkIkmPslBrsdOUXM2R5o9dmJ8hg+4pDSJfin1/Z0=
X-OriginatorOrg: concurrent-rt.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2b2010c4-af5c-4d43-cea3-08d7ed222b24
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Apr 2020 16:18:50.7496
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38747689-e6b0-4933-86c0-1116ee3ef93e
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: kHh8JouTN48VHIGkfRrSQmRfa+KADSvXvZfiNjBsWqy3ZLpRoJU8n1U5Wj3giO/0v1tPCr1QjorlB+T1tstlr8ce/NiwRwfkaurHhoCHD/E=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR11MB4376
Sender: linux-rt-users-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rt-users.vger.kernel.org>
X-Mailing-List: linux-rt-users@vger.kernel.org

[5.4.28-rt19] Cache up to one sigqueue per task.

This replaces an earlier version of this rt patch,

    signals-allow-rt-tasks-to-cache-one-sigqueue-struct.patch

which is able to generate a kernel splat of the form,

    virt_to_cache: Object is not a Slab page!
    ...
    Call Trace:
     free_uid+0x93/0xa0
     __dequeue_signal+0x21c/0x230
     dequeue_signal+0xb7/0x1b0
     get_signal+0x266/0xce0
     do_signal+0x36/0x640

This most easily happens when the test program, tb.c,
is executed.  That test program can be found in an
earlier linux-rt-users posting,

   Kill(2) and pthread_create(2) interact poorly in 5.4.28-rt19
   Date: Tue, 28 Apr 2020 11:45:36 -0400

After poking around the original patch, not making any
progress, I tried revamping the patch down to its simpliest
possible implementation.  This revamped version has been
tested in both an rt and nort compiled 5.4.28-rt19 kernel.
No issues have been seen so far.

Please consider

  1) dropping the original cache-sigqueue patch, or
  2) replace that patch with this new version, or
  3) rewrite the original patch using your own criteria
     for what a correct patch should be.

and backport whatever fix is selected to all versions of the
rt kernel that have the original patch applied.

Thanks,
Joe

---
signals: Allow tasks to cache one sigqueue struct, version 2

To avoid allocation overhead, allow all tasks to cache one sigqueue struct
in task struct.

[ This replaces version 1, which is unstable in several versions of the
rt patch. ]

Signed-off-by: Joe Korty <joe.korty@concurrent-rt.com>

Index: b/include/linux/sched.h
===================================================================
--- a/include/linux/sched.h
+++ b/include/linux/sched.h
@@ -935,6 +935,7 @@ struct task_struct {
 	/* Signal handlers: */
 	struct signal_struct		*signal;
 	struct sighand_struct		*sighand;
+	struct sigqueue			*sigqueue_cache;
 	sigset_t			blocked;
 	sigset_t			real_blocked;
 	/* Restored if set_restore_sigmask() was used: */
Index: b/include/linux/signal.h
===================================================================
--- a/include/linux/signal.h
+++ b/include/linux/signal.h
@@ -255,6 +255,7 @@ static inline void init_sigpending(struc
 }
 
 extern void flush_sigqueue(struct sigpending *queue);
+extern void flush_task_sigqueue(struct task_struct *tsk);
 
 /* Test if 'sig' is valid signal. Use this instead of testing _NSIG directly */
 static inline int valid_signal(unsigned long sig)
Index: b/kernel/exit.c
===================================================================
--- a/kernel/exit.c
+++ b/kernel/exit.c
@@ -171,6 +171,7 @@ static void __exit_signal(struct task_st
 		flush_sigqueue(&sig->shared_pending);
 		tty_kref_put(tty);
 	}
+	flush_task_sigqueue(tsk);
 }
 
 static void delayed_put_task_struct(struct rcu_head *rhp)
Index: b/kernel/fork.c
===================================================================
--- a/kernel/fork.c
+++ b/kernel/fork.c
@@ -1587,6 +1587,7 @@ static int copy_signal(unsigned long clo
 	init_waitqueue_head(&sig->wait_chldexit);
 	sig->curr_target = tsk;
 	init_sigpending(&sig->shared_pending);
+	tsk->sigqueue_cache = NULL;
 	INIT_HLIST_HEAD(&sig->multiprocess);
 	seqlock_init(&sig->stats_lock);
 	prev_cputime_init(&sig->prev_cputime);
@@ -1924,6 +1925,7 @@ static __latent_entropy struct task_stru
 	spin_lock_init(&p->alloc_lock);
 
 	init_sigpending(&p->pending);
+	p->sigqueue_cache = NULL;
 
 	p->utime = p->stime = p->gtime = 0;
 #ifdef CONFIG_ARCH_HAS_SCALED_CPUTIME
Index: b/kernel/signal.c
===================================================================
--- a/kernel/signal.c
+++ b/kernel/signal.c
@@ -431,7 +431,9 @@ __sigqueue_alloc(int sig, struct task_st
 	rcu_read_unlock();
 
 	if (override_rlimit || likely(sigpending <= task_rlimit(t, RLIMIT_SIGPENDING))) {
-		q = kmem_cache_alloc(sigqueue_cachep, flags);
+		q = xchg(&t->sigqueue_cache, NULL);
+		if (!q)
+			q = kmem_cache_alloc(sigqueue_cachep, flags);
 	} else {
 		print_dropped_signal(sig);
 	}
@@ -454,7 +456,9 @@ static void __sigqueue_free(struct sigqu
 		return;
 	if (atomic_dec_and_test(&q->user->sigpending))
 		free_uid(q->user);
-	kmem_cache_free(sigqueue_cachep, q);
+	q = xchg(&current->sigqueue_cache, q);
+	if (q)
+		kmem_cache_free(sigqueue_cachep, q);
 }
 
 void flush_sigqueue(struct sigpending *queue)
@@ -469,6 +473,15 @@ void flush_sigqueue(struct sigpending *q
 	}
 }
 
+void flush_task_sigqueue(struct task_struct *t)
+{
+	struct sigqueue *q;
+
+	q = xchg(&t->sigqueue_cache, NULL);
+	if (q)
+		kmem_cache_free(sigqueue_cachep, q);
+}
+
 /*
  * Flush all pending signals for this kthread.
  */

