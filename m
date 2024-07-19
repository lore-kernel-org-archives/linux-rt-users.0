Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5D56E208BA
	for <linux-rt-users@vger.kernel.org>; Fri, 19 Jul 2024 08:26:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721377595; cv=none; b=lcLfRTyKFWMOnGthXrUeYcSWjuQF1TG7qeplrTLBH7uql/5Qucyi/4EDhDPeqi5Qx/gDhdPSdS330oF8LpSytjq9oiEZkeutWPuZYs90djhv34nUMWhXJwVaVJRLi/O8mcd0uml4ttgkfi7qjftZxxiY+/5NcZEwSBKBAS198JU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721377595; c=relaxed/simple;
	bh=1x9ajM7MkIYllRGocqSCWWqVUo7EHYCFjDG08Uo601s=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=rs4Gknw8/yKIK/ayOjgma/P/8jU8GwOIV3rk6oUTcaWHrFV3mg2qotV5/gfJjKfqtdj+KbZT2uHfj3XrRiqOTMgrIQ5EJXtrwGKClMFrSrYbo+N414q4dmEHzfjQ6VejnqlZDvhLGsxpdVmS9mwvWgp9Xt/u4GP53hD9KhMQqCk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=AiZIXI/o; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=jkZEoIJP; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="AiZIXI/o";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="jkZEoIJP"
From: John Ogness <john.ogness@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1721377592;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=xBi43tqAqiIbbDQyAP7Wc711Z6ItD7Rcuts+kqUdNGQ=;
	b=AiZIXI/oo0nQL2kfytRN1mEH1WnpDXmMIkMqd1k47vz4XBXCAWx9d3tQkqrV6rd9GHE+tH
	w+EFGMMbFtkHyOyYIT8LI7x0YDgm1+IWvKVmVodbMY4rZeD1SH8vqRyZvgcebvOqysI1gt
	iX0eCOAswdFgK9zEarvVH1Rd4N0FcvLjcql8VlmMSmNk0fMSDq+7LPiEyLDKHxOrKTIWd4
	M0esOdm8/QVyQiDhg/iPCKK1SJxlQRMP0DqyMKVWz1Foi5XqVuZdrcGyekwgWecQpe7mYm
	kixGoY1ripyzPgsz1C2eiwsMNTgkKPVC71AXcTkm3JVoHWrp8AM159hcDpgz6A==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1721377592;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=xBi43tqAqiIbbDQyAP7Wc711Z6ItD7Rcuts+kqUdNGQ=;
	b=jkZEoIJPbJKtr0DQAnqi70GMRyL8D/5iOfvAqA9ZI4IaWRegb0OmJX92AUr9rOi2Jfi/Xl
	fA92z1xZJs6DwaAw==
To: Andrew Halaney <ahalaney@redhat.com>, Steven Rostedt <rostedt@goodmis.org>
Cc: pmladek@suse.com, senozhatsky@chromium.org, debarbos@redhat.com,
 williams@redhat.com, jlelli@redhat.com, linux-rt-users@vger.kernel.org
Subject: Re: [BUG] printk/nbcon can use RCU illegally prior to CPU online
In-Reply-To: <436jncgrfxwcizjw5gxw3yar5ybo62zdctout6sti6gamwtnlw@gqrmo5ine6d2>
References: <5x4nejpojrtny37k7l6loewqwuaituq77zc3tkkojvawcuvmml@thwg65fdb3vn>
 <20240718115704.0cd768bc@rorschach.local.home>
 <436jncgrfxwcizjw5gxw3yar5ybo62zdctout6sti6gamwtnlw@gqrmo5ine6d2>
Date: Fri, 19 Jul 2024 10:32:32 +0206
Message-ID: <87a5idlrd3.fsf@jogness.linutronix.de>
Precedence: bulk
X-Mailing-List: linux-rt-users@vger.kernel.org
List-Id: <linux-rt-users.vger.kernel.org>
List-Subscribe: <mailto:linux-rt-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rt-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

On 2024-07-18, Andrew Halaney <ahalaney@redhat.com> wrote:
>     [ 5.061942] =============================
>     [ 5.061942] WARNING: suspicious RCU usage
>     [ 5.061942] 5.14.0-467.el9.x86_64+debug #1 Not tainted
>     [ 5.061942] -----------------------------
>     [ 5.061942] kernel/printk/nbcon.c:1118 suspicious rcu_dereference_check() usage!

In Petr Mladek's review of my latest printk-threading series, he pointed
out [0] that I was using the wrong RCU API in rcuwait_has_sleeper().

The patch below was his suggestion, which I was already folding into the
next version of my series.

John Ogness

[0] https://lore.kernel.org/lkml/ZmsLcu2tHmCfLiu0@pathway.suse.cz

diff --git a/kernel/printk/nbcon.c b/kernel/printk/nbcon.c
index 0951c2c7fb1b..da462661876c 100644
--- a/kernel/printk/nbcon.c
+++ b/kernel/printk/nbcon.c
@@ -1181,9 +1181,6 @@ static void nbcon_irq_work(struct irq_work *irq_work)
 
 static inline bool rcuwait_has_sleeper(struct rcuwait *w)
 {
-	bool has_sleeper;
-
-	rcu_read_lock();
 	/*
 	 * Guarantee any new records can be seen by tasks preparing to wait
 	 * before this context checks if the rcuwait is empty.
@@ -1196,10 +1193,7 @@ static inline bool rcuwait_has_sleeper(struct rcuwait *w)
 	 * This pairs with nbcon_kthread_func:A.
 	 */
 	smp_mb(); /* LMM(rcuwait_has_sleeper:A) */
-	has_sleeper = !!rcu_dereference(w->task);
-	rcu_read_unlock();
-
-	return has_sleeper;
+	return rcuwait_active(w);
 }
 
 /**
