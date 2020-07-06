Return-Path: <SRS0=ADFb=AR=vger.kernel.org=linux-rt-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 02E99C433E0
	for <linux-rt-users@archiver.kernel.org>; Mon,  6 Jul 2020 16:50:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D3565206E2
	for <linux-rt-users@archiver.kernel.org>; Mon,  6 Jul 2020 16:50:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="bPNiRKeL";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="c4xPTn9L"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729456AbgGFQuI (ORCPT
        <rfc822;linux-rt-users@archiver.kernel.org>);
        Mon, 6 Jul 2020 12:50:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49582 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729384AbgGFQuI (ORCPT
        <rfc822;linux-rt-users@vger.kernel.org>);
        Mon, 6 Jul 2020 12:50:08 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CCD4BC061755;
        Mon,  6 Jul 2020 09:50:07 -0700 (PDT)
Date:   Mon, 6 Jul 2020 18:50:04 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1594054205;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=/CG85fqqBbn5eKIZULRuWM7oiLGrENgTSZkiqJx1JRc=;
        b=bPNiRKeLIGvE8XKMEf8oZ43m+VsPJvzu9BiCFSKpc6xeN5SnXGSULqnLBIBXdemQPbhLys
        7lHqedX6PThJWhiWgJ9VGhARkhQUVqovF6Bj7QCuyfkxcZO/p+dKoNo5clh//Du2EtiL+k
        DKk+kQIVdT6kXBHIqRTEUeN2REQIaQPJSbSueD7M/hrOzn1cMVEBI0wkgUbeVo17JPYKu0
        T0A83/k40MKcfk+ar3QZuKUxqboGGlDl1/hoBmtu5JhLslXb9lk8Z2DEBAGQP6+Lb+a7nJ
        AWns6Mk0ZFqCHc+JDu1kDRxZjMiz3S3olUtq1mCun5q7tmAx4Y7kz2222GFzMg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1594054205;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=/CG85fqqBbn5eKIZULRuWM7oiLGrENgTSZkiqJx1JRc=;
        b=c4xPTn9LMmcAP797YCJuIxpK8xu+wzQYi5kwM7U6LPDbnmcXT9VY3Qq/FRO5YiYi0GAU47
        QAP2Tdbqwr9dvECg==
From:   Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To:     Mark Marshall <markmarshall14@gmail.com>
Cc:     linux-rt-users <linux-rt-users@vger.kernel.org>,
        Mark Marshall <mark.marshall@omicronenergy.com>,
        thomas.graziadei@omicronenergy.com,
        Thomas Gleixner <tglx@linutronix.de>,
        linux-kernel@vger.kernel.org, rostedt@goodmis.org
Subject: Re: Kernel crash due to memory corruption with v5.4.26-rt17 and
 PowerPC e500
Message-ID: <20200706165004.7m57fvspmwnjcjxh@linutronix.de>
References: <CAD4b4WK9W+dNZZ_WPt-9ZNpSHvyxdwPW86Rtq4AKOONuvyR37A@mail.gmail.com>
 <20200529131452.pgj7mx7xaz7n4kz3@linutronix.de>
 <CAD4b4WLS36JKepz31m98Z3Ve05d63GnfBGsuuWRXpjXZqPoBrA@mail.gmail.com>
 <20200529161518.svpxhkeljafbtdz2@linutronix.de>
 <20200529163722.mdxzrj4n3lyzjtfu@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <20200529163722.mdxzrj4n3lyzjtfu@linutronix.de>
Sender: linux-rt-users-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rt-users.vger.kernel.org>
X-Mailing-List: linux-rt-users@vger.kernel.org

On 2020-05-29 18:37:22 [+0200], To Mark Marshall wrote:
> On 2020-05-29 18:15:18 [+0200], To Mark Marshall wrote:
> > In order to get it back into the RT queue I need to understand why it is
> > required. What exactly is it fixing. Let me stare at for a little=E2=80=
=A6
>=20
> it used to be local_irq_disable() which then became preempt_disable()
> local_irq_disable() due to ARM's limitation.

Any luck on your side?

I *think* if you swap the mm assignment in exec_mmap() then it should be
gone. Basically:
|         tsk->active_mm =3D mm;
|         tsk->mm =3D mm;

However I think to apply something like this:

diff --git a/fs/exec.c b/fs/exec.c
--- a/fs/exec.c
+++ b/fs/exec.c
@@ -1035,11 +1035,15 @@ static int exec_mmap(struct mm_struct *mm)
 		}
 	}
 	task_lock(tsk);
+
+	task_lock_mm();
 	active_mm =3D tsk->active_mm;
 	membarrier_exec_mmap(mm);
 	tsk->mm =3D mm;
 	tsk->active_mm =3D mm;
 	activate_mm(active_mm, mm);
+	task_unlock_mm();
+
 	tsk->mm->vmacache_seqnum =3D 0;
 	vmacache_flush(tsk);
 	task_unlock(tsk);
diff --git a/include/linux/sched/task.h b/include/linux/sched/task.h
--- a/include/linux/sched/task.h
+++ b/include/linux/sched/task.h
@@ -176,4 +176,31 @@ static inline void task_unlock(struct task_struct *p)
 	spin_unlock(&p->alloc_lock);
 }
=20
+#ifdef CONFIG_PREEMPT_RT
+/*
+ * Protects ->mm and ->active_mm.
+ * Avoids scheduling so switch_mm() or enter_lazy_tlb() will not read the
+ * members while they are updated.
+ */
+static inline void task_lock_mm(void)
+{
+	preempt_disable();
+}
+
+static inline void task_unlock_mm(void)
+{
+	preempt_enable();
+}
+
+#else
+
+static inline void task_lock_mm(void)
+{
+}
+
+static inline void task_unlock_mm(void)
+{
+}
+#endif
+
 #endif /* _LINUX_SCHED_TASK_H */
diff --git a/mm/mmu_context.c b/mm/mmu_context.c
--- a/mm/mmu_context.c
+++ b/mm/mmu_context.c
@@ -25,6 +25,7 @@ void use_mm(struct mm_struct *mm)
 	struct task_struct *tsk =3D current;
=20
 	task_lock(tsk);
+	task_lock_mm();
 	active_mm =3D tsk->active_mm;
 	if (active_mm !=3D mm) {
 		mmgrab(mm);
@@ -32,6 +33,7 @@ void use_mm(struct mm_struct *mm)
 	}
 	tsk->mm =3D mm;
 	switch_mm(active_mm, mm, tsk);
+	task_unlock_mm();
 	task_unlock(tsk);
 #ifdef finish_arch_post_lock_switch
 	finish_arch_post_lock_switch();
@@ -55,10 +57,12 @@ void unuse_mm(struct mm_struct *mm)
 	struct task_struct *tsk =3D current;
=20
 	task_lock(tsk);
+	task_lock_mm();
 	sync_mm_rss(mm);
 	tsk->mm =3D NULL;
 	/* active_mm is still 'mm' */
 	enter_lazy_tlb(mm, tsk);
+	task_unlock_mm();
 	task_unlock(tsk);
 }
 EXPORT_SYMBOL_GPL(unuse_mm);
--=20
2.27.0

> > > Best regards,
> > > Mark

Sebastian
