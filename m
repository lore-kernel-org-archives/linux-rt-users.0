Received: from mail-pl1-f195.google.com (mail-pl1-f195.google.com [209.85.214.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A7BCC61FC5;
	Tue, 28 May 2024 06:40:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716878413; cv=none; b=C0J8l/xAcv7Axqx5I6ZuViqGaCQRDbXFGaC1S2xlNXy6XwJjKWMhPvBweoI1ap/1iIzSLCAdkhNFXxTSsgTJ9hv5alxSOzYU6IPArAoFx297HO/qF29VpdkbXIOwDAMmd4Yfp5QHNC0SwhPMPUJYF9rHIYJoa7sezk7vuKS0sls=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716878413; c=relaxed/simple;
	bh=L1uIjANRuY9eh6UNDVsTMZQL6aVuyTCCg8ZM+/uJs4E=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=LvgIGpY6fseFv+JHOc625Gie6x8ijO5w5v5dMhekxaHo7eDbm/m9/jDfB+4REHLrfW+pVrk7eFepS0HRvxleeXlrTV3BnG/KlwvkiuJ4yw81ZWeLf3RRHf4nz8DyebSCvAfedSbHARZPaWsVrlQKiJpJ85ASdnJ/4kq/vs9Ph8s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=GW0LnRHJ; arc=none smtp.client-ip=209.85.214.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GW0LnRHJ"
Received: by mail-pl1-f195.google.com with SMTP id d9443c01a7336-1f47f07acd3so4206685ad.0;
        Mon, 27 May 2024 23:40:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1716878411; x=1717483211; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=GyT1AQYmZjQqmzbCWjENPJaJCrng/s09BLOsFY4/P2o=;
        b=GW0LnRHJYQaMvQlr5Bjm9jwqQZ9j1XB0c8r1ZaPAODYl9+0671Z6cnAg1Wactiimlx
         vhjTqJyNP1tLwAbd8QLenNrf9a+MWYRUs2uh88eilXADvG834DjSYkV1AaoKdggoilca
         VUXBShgYK9ufU8JAk+XS//FfSz1tcvuO8NKMBu3REUYb1UvYQmO4hjF2QqKdKvWqUyEQ
         CdYU+9gGCWFa8SB81GFM/El5P0KtzX5X8oJjkj1PBe4wsJXfZzvF2TcCHX3sbgt8H1QI
         a2IsTf8XLnYDDu2mRTFAVjbdaYl45VpCOeb8+x4horB9iZfT0eGlNfe1bt2KLeRH91pe
         LYBg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1716878411; x=1717483211;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=GyT1AQYmZjQqmzbCWjENPJaJCrng/s09BLOsFY4/P2o=;
        b=hEDfAGtHj9IH67LB5faArQ2q/r6RrWAPE4QkSmWFyZjRIRX4JBUB+CHChA9BmoNmUm
         dSYPVp0C7rG2OTdtHTikVrbYAW6hqZiRwPsDs3YCgHECpezjbgmrv7KI4SahRxT/mSKd
         3lPebONfsNMyvWW7OhLrH59qsdfcOnyl9sgwW2A2mpb/WCKgxHSWSaKpZAcW6ro5ybuK
         w/Zb+tY8lDa4g1lmFf5K0n0NOoq39dUXKXfK9DQE5Zjl7t9T53TSQRs4CwGLM4jdb5UL
         BGVKyWb0VyrQRS4F+ecIG7tT2ooyID+1ogufX0AcqZHKa7SIn/hBfqW78e7/BUsZYqPd
         dg/w==
X-Forwarded-Encrypted: i=1; AJvYcCXlkiIvBD2z9lUmK88jrU1JelwpyqBMNDHrZ2StBeOXsgn9oXRqwWVO3uVCs+HCOsTzRwfeMKImHpfkRnD8VAl+lIxe1+hiSaEUOTJ1ir+e3tOnlM983Pgw7M5C0RYlsPlMgzgTxm3GSIbxJYc=
X-Gm-Message-State: AOJu0YxxttPOuiRXzReqz5WnjbXjjNhk/6W/s6BeE/IgMZ/KQ6qX49Wi
	2ZSQMUGeulu3VCHcuopTZAcbg8nFMYELNRdFzHP+b+zBcOvHWjM5Do5jHG1K
X-Google-Smtp-Source: AGHT+IE+wVIUiVMByDVOTzItPu0y9LRbh5m3oAn4AgD1IzHZL4RsM/uEAC3sIYVL89q22RxzjyhwFw==
X-Received: by 2002:a17:902:d2cd:b0:1f4:5685:b159 with SMTP id d9443c01a7336-1f45685b4f9mr129964065ad.31.1716878407789;
        Mon, 27 May 2024 23:40:07 -0700 (PDT)
Received: from localhost.localdomain ([193.203.214.57])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-1f4a77a4047sm25782125ad.255.2024.05.27.23.40.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 27 May 2024 23:40:07 -0700 (PDT)
From: xu xin <xu.xin.sc@gmail.com>
X-Google-Original-From: xu xin <xu.xin16@zte.com.cn>
To: xu.xin16@zte.com.cn
Cc: bigeasy@linutronix.de,
	john.ogness@linutronix.de,
	linux-kernel@vger.kernel.org,
	linux-rt-users@vger.kernel.org,
	liu.chun2@zte.com.cn,
	rostedt@goodmis.org,
	si.hao@zte.com.cn,
	yang.yang29@zte.com.cn,
	zhang.yunkai@zte.com.cn
Subject: Re: [PATCH  5.10-rt] printk: ignore that console preempted by irq/softirq
Date: Tue, 28 May 2024 06:40:03 +0000
Message-Id: <20240528064003.776618-1-xu.xin16@zte.com.cn>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20240523235537910_yxfGMbTcSOmMkcfuK2d8@zte.com.cn>
References: <20240523235537910_yxfGMbTcSOmMkcfuK2d8@zte.com.cn>
Precedence: bulk
X-Mailing-List: linux-rt-users@vger.kernel.org
List-Id: <linux-rt-users.vger.kernel.org>
List-Subscribe: <mailto:linux-rt-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rt-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

> > diff --git a/kernel/printk/printk.c b/kernel/printk/printk.c
> > index 7f27cfee283e..faab85dd4439 100644
> > --- a/kernel/printk/printk.c
> > +++ b/kernel/printk/printk.c
> > @@ -3735,6 +3735,14 @@ bool pr_flush(int timeout_ms, bool reset_on_progress)
> > diff = 0;
> > 
> > for_each_console(con) {
> > + /*
> > + * When we're in the unpreemptible context on the same cpu
> > + * with which the thread of console locates on, we should
> > + * ignore this console, because it's a vain.
> > + */
> > + if (!preemptible() && con->thread &&
> > + task_cpu(con->thread) == smp_processor_id())
> > + continue;
> > if (!(con->flags & CON_ENABLED))
> > continue;
> > printk_seq = read_console_seq(con);
> 
> This does not apply.
> There is `may_sleep' set earlier.
> 
> There is no console_lock() around for each…
> 

Sorry, I don't get it.

To clarify it again, this patch aims to solve the useless waiting of pr_flush
when the console is preempted by the current irq/softirq. This has nothing to
do with might_sleep().

> The other question is which kernel started enforcing might_sleep() for
> pr_flush(). This should be applied to all kernel or none so we don't
> have random behaviour across kernels (5.4 yes, 5.10 no, 5.15 yes).
>

Sorry, my understanding is that pr_flush didn't start enforcing might_sleep().
This patch can apply to 5.10 and 5.15 where the problem exist.

> This is a delay of max 1 sec during bug() and panic(). Not sure how
> "critical" this is…

In some industrial control scenarios, bugs and warnings containning a
pr_flush delay of 1 sec is very critical to the upper services.

Especiall for watchdog timeout(< 2s), just WARN can easily lead to system reset,
which is unacceptible.

