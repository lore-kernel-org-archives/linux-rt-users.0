Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2755D199EBA;
	Thu, 20 Jun 2024 09:43:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718876585; cv=none; b=A/eyDKUcc5PM6nd0piZUfxPXUpjeLKQU11lFqoRU+IdtQNrjYbO48TM+PzxVD+qDWL6oyplNFNgho99R9HoPQKj8QdG0/Ep3eG7V0i0+BAB8dd3FqkZQIajRXLll7DDBDMnG8qlCQNXA5pbUFZU1KZh1yHPg5+DuLEPlXZQeKBU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718876585; c=relaxed/simple;
	bh=ckZIqKAQIBZWCVhATKH4LnnnLqFAF4d94WwNIp8n4rE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=sXLYz+fZwlI9NxkndSURc5h85cAbFqK3CkumIvdoFVxVkqEgw1PJdeS2zSNFg9EoQiY4h/moGrhCInICN2Wx6q8dwsNMneucxHZe0XtAHCDIP7iLjUe8XBJCQnC9xrrRRl4sXBfEBKeknKM1/gXqgtA1aXXnbaGzPPB/bVGNKsU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=CIWTFU53; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=CH3dmgBm; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="CIWTFU53";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="CH3dmgBm"
Date: Thu, 20 Jun 2024 11:43:00 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1718876582;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=R/Cwv1IASLJuF92Q1vFzjhYjc8NMuEAyjqYnph67Tv4=;
	b=CIWTFU53vjlJjwlDjqdnPrJTZuxroFouglO57MnzzmJ0L0F3BYXzKXLh+Htyu3ncfXPngb
	Is1uIoG1w+YeMl6LJJOCgC5skIp3OunqCqqtq/ewVZtuxJpXGhncybc4XUEhzaE5rslUsd
	ykldxywQFzW2/L4FqCZFKlrJJVOlGz0sT9RapXENEllUDFuPu3o3aOUHCHy2OMFF2kapyK
	a8mKezbWz2dWPqmp5RYA2WMF7Ax/2JlXt/2F4uDgdsSECwF6M7xs+n0zCq5DP54xNGOfuD
	+anzUM+V+SHrE4U9S6yXfUOnf5UsRjph/fXzA8VYG6RHf8tQL+28EE3miy2zlA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1718876582;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=R/Cwv1IASLJuF92Q1vFzjhYjc8NMuEAyjqYnph67Tv4=;
	b=CH3dmgBmKSvxHPJy5AMiF7wFBdS15prad+9evG8ei8Bq4kbVycuyggfG2lku5muFR4Z13f
	kk8njNSRTuP2tvAQ==
From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To: Derek Barbosa <debarbos@redhat.com>, john.ogness@linutronix.de
Cc: pmladek@suse.com, rostedt@goodmis.org, senozhatsky@chromium.org,
	linux-rt-users@vger.kernel.org, linux-kernel@vger.kernel.org,
	williams@redhat.com, jlelli@redhat.com, ahalaney@redhat.com,
	lgoncalv@redhat.com, jwyatt@redhat.com, aubaker@redhat.com
Subject: [PATCH] prinkt/nbcon: Add a scheduling point to nbcon_kthread_func().
Message-ID: <20240620094300.YJlW043f@linutronix.de>
References: <ZnHF5j1DUDjN1kkq@debarbos-thinkpadt14sgen2i.remote.csb>
 <20240620071545.Es9LoyJY@linutronix.de>
 <20240620093246.HE9XDWSZ@linutronix.de>
Precedence: bulk
X-Mailing-List: linux-rt-users@vger.kernel.org
List-Id: <linux-rt-users.vger.kernel.org>
List-Subscribe: <mailto:linux-rt-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rt-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20240620093246.HE9XDWSZ@linutronix.de>

Constant printing can lead to a CPU hog in nbcon_kthread_func(). The
context is preemptible but on !PREEMPT kernels there is no explicit
preemption point which leads softlockup warnings.

Add an explicit preemption point in nbcon_kthread_func().

Reported-by: Derek Barbosa <debarbos@redhat.com>
Link: https://lore.kernel.org/ZnHF5j1DUDjN1kkq@debarbos-thinkpadt14sgen2i.remote.csb
Signed-off-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
---
 kernel/printk/nbcon.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/kernel/printk/nbcon.c b/kernel/printk/nbcon.c
index bb9689f94d302..0813ce88a49c5 100644
--- a/kernel/printk/nbcon.c
+++ b/kernel/printk/nbcon.c
@@ -1119,6 +1119,7 @@ static int nbcon_kthread_func(void *__console)
 		}
 
 		console_srcu_read_unlock(cookie);
+		cond_resched();
 
 	} while (backlog);
 
-- 
2.45.2

