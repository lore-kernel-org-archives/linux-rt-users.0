Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8F70BEEB3;
	Thu,  1 Aug 2024 09:40:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722505245; cv=none; b=oca33kRwUZ2ycoeaTmsKmssQXVOs0qU/0PLzUuqKF/xJXbOcUlcfx7zU6oorzqQAfa91M4zTdZbdzabQoF0o8qnNL0niw7bhiULuI3z59E+ppJJZW/gBVhkm4H1Ta80urV7LM5G04UUfAnVWLjAu1m7JclssmOWRvp3OObTm2zc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722505245; c=relaxed/simple;
	bh=slx9GME8fpCyBB5+RUUSCj5M9YwkH+vofD8BNrGzCSU=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=makT2u0+E6mB408uJfMKmNzV4NbXqDzM994zYa6o3K9QMAaDUkWjMnjQJ7aHrbiR3ZeK9UgpqrahQ1nls8Q7TwQPIirshNgK24wUl94tD49aBqaKrsjdpCJ9NngKZpfe1pWbblKs09hueukH08M0lFs7hgigGhc4r6cJYBBAo4c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=lSJuRtXi; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=U8dHQ5R3; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="lSJuRtXi";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="U8dHQ5R3"
Date: Thu, 1 Aug 2024 11:40:40 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1722505241;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type;
	bh=rPX5ai+QQ/sOOeKlbiKU69vZ/qTP4RNjkrEJ+PcP1r0=;
	b=lSJuRtXiqPMeWYsBjkepjA+Y2Rv9KnSF6Ieqi3GqtLo1xwTQVSkrtCRuhi5s0aQ0YKjpOp
	HuHsI+6P2H1cz0eQkEQk7iObalvV2PraKH+pvSnD5Ty2EWeBbekfQ35V4ITBGcAA2to2kc
	ZZ2WCooC8Lm86JJuPoJfkS80aMPU/YgzhO0QZDFMYu9bbRg5y815NrObyPacEFMZts9RAA
	skvHm/hOWusr5wmjlCOhxcRaUoRi7IAL7FPT2PxxKBsUp//HlWVRJibg+ohuiutHOznys9
	0sI3UPs9uloFhyDpQBLM/3//vHmxpzWvQ6ogUu9wN908oDN4ONzF264uUyX+kA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1722505241;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type;
	bh=rPX5ai+QQ/sOOeKlbiKU69vZ/qTP4RNjkrEJ+PcP1r0=;
	b=U8dHQ5R3wv7AiywICf5jqN9yKvIfadIuCs4s85sI/VdONsTg5TQwwArCgWEKXvFsFbgQff
	F+n/tEGek92lmgDQ==
From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To: Thomas Gleixner <tglx@linutronix.de>
Cc: LKML <linux-kernel@vger.kernel.org>, linux-rt-users@vger.kernel.org,
	Steven Rostedt <rostedt@goodmis.org>
Subject: [ANNOUNCE] v6.10.2-rt13
Message-ID: <20240801094040.pdwf9TLs@linutronix.de>
Precedence: bulk
X-Mailing-List: linux-rt-users@vger.kernel.org
List-Id: <linux-rt-users.vger.kernel.org>
List-Subscribe: <mailto:linux-rt-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rt-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline

Dear RT folks!

I'm pleased to announce the v6.10.2-rt13 patch set. 

Changes since v6.10.2-rt12:

  - Guenter Roeck reported that tinyconfig builds broke. Patch by Linus
    Torvalds.

  - syzbot reported crashes with the tun driver. Patch by Jeongjun Park. 

Known issues
    None.

The delta patch against v6.10.2-rt12 is appended below and can be found here:
 
     https://cdn.kernel.org/pub/linux/kernel/projects/rt/6.10/incr/patch-6.10.2-rt12-rt13.patch.xz

You can get this release via the git tree at:

    https://git.kernel.org/pub/scm/linux/kernel/git/rt/linux-rt-devel.git v6.10.2-rt13

The RT patch against v6.10.2 can be found here:

    https://cdn.kernel.org/pub/linux/kernel/projects/rt/6.10/older/patch-6.10.2-rt13.patch.xz

The split quilt queue is available at:

    https://cdn.kernel.org/pub/linux/kernel/projects/rt/6.10/older/patches-6.10.2-rt13.tar.xz

Sebastian

diff --git a/kernel/task_work.c b/kernel/task_work.c
index 05fb41fe09f5d..8f9c30e732a0a 100644
--- a/kernel/task_work.c
+++ b/kernel/task_work.c
@@ -7,12 +7,14 @@
 
 static struct callback_head work_exited; /* all we need is ->next == NULL */
 
+#ifdef CONFIG_IRQ_WORK
 static void task_work_set_notify_irq(struct irq_work *entry)
 {
 	test_and_set_tsk_thread_flag(current, TIF_NOTIFY_RESUME);
 }
 static DEFINE_PER_CPU(struct irq_work, irq_work_NMI_resume) =
 	IRQ_WORK_INIT_HARD(task_work_set_notify_irq);
+#endif
 
 /**
  * task_work_add - ask the @task to execute @work->func()
@@ -58,6 +60,8 @@ int task_work_add(struct task_struct *task, struct callback_head *work,
 	if (notify == TWA_NMI_CURRENT) {
 		if (WARN_ON_ONCE(task != current))
 			return -EINVAL;
+		if (!IS_ENABLED(CONFIG_IRQ_WORK))
+			return -EINVAL;
 	} else {
 		/* record the work call stack in order to print it in KASAN reports */
 		kasan_record_aux_stack(work);
@@ -82,9 +86,11 @@ int task_work_add(struct task_struct *task, struct callback_head *work,
 	case TWA_SIGNAL_NO_IPI:
 		__set_notify_signal(task);
 		break;
+#ifdef CONFIG_IRQ_WORK
 	case TWA_NMI_CURRENT:
 		irq_work_queue(this_cpu_ptr(&irq_work_NMI_resume));
 		break;
+#endif
 	default:
 		WARN_ON_ONCE(1);
 		break;
diff --git a/localversion-rt b/localversion-rt
index 6e44e540b927b..9f7d0bdbffb18 100644
--- a/localversion-rt
+++ b/localversion-rt
@@ -1 +1 @@
--rt12
+-rt13
diff --git a/net/core/dev.c b/net/core/dev.c
index 78184fe9e3882..cf00b2f662d54 100644
--- a/net/core/dev.c
+++ b/net/core/dev.c
@@ -5150,6 +5150,7 @@ int do_xdp_generic(struct bpf_prog *xdp_prog, struct sk_buff **pskb)
 			bpf_net_ctx_clear(bpf_net_ctx);
 			return XDP_DROP;
 		}
+		bpf_net_ctx_clear(bpf_net_ctx);
 	}
 	return XDP_PASS;
 out_redir:
