Received: from mail-qt1-f177.google.com (mail-qt1-f177.google.com [209.85.160.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6EE68367B8B
	for <linux-rt-users@vger.kernel.org>; Mon, 31 Aug 2026 16:41:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788194507; cv=none; b=PZMJGXiYUMaxV32+OchKLD53BDXncHzwMIxJ1QS0RiBzHtPXB+9ihVooFVMi5sof65SiW+Yne7rflrw6w/2utuouGmEUyRMmCSyiymvZ4gg38kwsc6qRq4MHnDInTf4mbmpSX+aPgPPLqjiLTBEnAi2W8pY7Kn+Xc6aGJWcXg6E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788194507; c=relaxed/simple;
	bh=vqZAWujVlHyhIKgXgnc6vNgO0iKPejmPDsF+yeZsctI=;
	h=Date:From:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=Z14zvk2xoES6gshdscN+8hr6N/1/IBMaeBGJF7IzYbgY2ZoMyt2aRDDxQwqSIyxmeqpA3R7S68YgVQIMXMB+wjVggrCGfagheomN9dAY4UGSUGpWdm4rO3ZyqxQKz7hFr/g2ni+jbKvwoPZWMLMRCfPbA/CDnAFDyHN4vgODl+k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=DLLBcOyX; arc=none smtp.client-ip=209.85.160.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DLLBcOyX"
Received: by mail-qt1-f177.google.com with SMTP id d75a77b69052e-52ff0b7c98aso25567481cf.0
        for <linux-rt-users@vger.kernel.org>; Mon, 31 Aug 2026 09:41:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1788194505; x=1788799305; darn=vger.kernel.org;
        h=content-type:mime-version:references:message-id:in-reply-to:subject
         :cc:to:from:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=AD/CKGCG0s3OpZ6R4sn/qbBozv72MLmWgl9+djz+O/o=;
        b=DLLBcOyXsO8Ak59f3ddr3MZwfrz7Tj8ouJMmrthuxtM4J/L/GHBMi4Ku8F1hWzE9SS
         2CMu0RkZrHRKpY6KISPyVyN2CkXSX81kCnktfiAkh6ffais09/OEilS811Hx2Hh3vxaL
         3Koi07CnRX9CvUv/qHJZqhSe6kywEZv1/VqO2U/w4GUGcnQZUSE7OniowhZP6dxk4AHs
         Z7F2hU5DcuScaCvUx2UFqzlOgf6cZp72Co/hI1O4EV9LpdGgiB3/bPB0Gp1NNotfimUj
         KKtLPE7mVUkH3+MUTyceZqXZOYTtqLheDalvGbzM9yNLqTZu+caHl4OXg3FaTzrSerF4
         9Ntg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788194505; x=1788799305;
        h=content-type:mime-version:references:message-id:in-reply-to:subject
         :cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=AD/CKGCG0s3OpZ6R4sn/qbBozv72MLmWgl9+djz+O/o=;
        b=mA/mtYBcC2UvlvCn2fcYR8wO3kWa5/x2un5JKL/OlmvW01APKwbdtge99HcAtyXDJA
         2ylX7K5zISAxbLdNAzqCW1y5oq07/6ctDBqW1lHX10RXiPbGuNt4mXBEHjoiVo+JL/Bv
         akvHdJMLcsenMbjaSZAl5Y+odWZJlj5LCoLGN+ce2Gg9f6mLD3Pe9bafxBM5AY/xHsrf
         2NGLoCMzM8m8f1UT8Hmy9nhHLTLGvKV82Oe+x4pUiRXIbma4seNwhZBCV012LCU24/el
         hhlqvEU4zWA9nSO78c+mK2K6gMHlway4anVSwtNJ2sLGUynr1+9pEhZwG9/3BeyY1eSu
         z0oA==
X-Gm-Message-State: AFuF++keuN0YjH1e2RKaU54Se+DrqcrIlEPmOSvO8ZS/GkjFkFUt6W0w
	jx4lnPKA0uqel45hyyVS0hqKiaxEIAVRVSYyTyior6yAO/2KPHTKSYMt
X-Gm-Gg: AR+sD12KCfVS0Dlb8+EHTsU6q6DTcERYpJNGjSbc2HD9dlY5hZV99RZ4nNTHgwV5DtL
	1XwD2WoCVdZxqy6mhC022FcjjE/2SqQ7aC1agcI6Qoz41oYJhs8On5Uke3OLV/E8MGZSMMZ70s2
	dyAYQuQSkjwRXBWkXiOP/sDtv5sDSXRSB3TWlWgR5kMcWKH+eB1qOjwOk06JFB3iC32BUXh9qR0
	U+MQz+VbF3xbMfe54OX9P1Yb3P1wxDBlTet23+bG2SRtBLE7RABHN756TiKj9Lf1lppQvaflJ2x
	jnST4TXXE6x4iHrXt/cxw5/tCnZtmcp/EGgcxhYIdK4BZXA9JMWujIuhLs8LTyaBItcFynRBSwZ
	xT9t9ZgOTMW5s/h9m5EeRa6dzqHXppDm2MvKXG18azEiZ4JZh187BNXBLZMm1VItBXbApIfmkHD
	RBOje+ITtD3eUVSWzxUGPZ2OV75qdE5diBWmQaBe1IBu7IPT4RCWM3BURjpEyCLVGeIQWMO1/sI
	hjlrdUShnO1zoXM5lMDuEmpJ3whHoAg0F1I
X-Received: by 2002:a05:622a:11d6:b0:52f:b583:591a with SMTP id d75a77b69052e-52fb96cf61cmr283040671cf.39.1788194504433;
        Mon, 31 Aug 2026 09:41:44 -0700 (PDT)
Received: from Cumhall ([70.53.55.174])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-52fbe7f9fedsm74931881cf.14.2026.08.31.09.41.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 31 Aug 2026 09:41:43 -0700 (PDT)
Date: Mon, 31 Aug 2026 12:41:40 -0400 (EDT)
From: John Kacur <jkacur@gmail.com>
To: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
cc: linux-rt-users@vger.kernel.org, John Kacur <jkacur@redhat.com>
Subject: Re: [PATCH 2/5] cyclictest: Acquire a lock before invoking
 pthread_cond_signal()
In-Reply-To: <20260826132153.2476006-3-bigeasy@linutronix.de>
Message-ID: <4f4d2188-be2c-6972-5827-ddfef6c2edf9@gmail.com>
References: <20260826132153.2476006-1-bigeasy@linutronix.de> <20260826132153.2476006-3-bigeasy@linutronix.de>
Precedence: bulk
X-Mailing-List: linux-rt-users@vger.kernel.org
List-Id: <linux-rt-users.vger.kernel.org>
List-Subscribe: <mailto:linux-rt-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rt-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII




On Wed, 26 Aug 2026, Sebastian Andrzej Siewior wrote:

> With the -M option the output is updated once there is a new max value.
> On system with many threads (say 64) and aligned wake up (all threads
> wake at the same time) it is possible that all of them have a new
> maximal latency and all of them invoke pthread_cond_signal()
> simultaneously. They all will block in the kernel in the futex syscall
> on the same lock. And each of them will wake the printing thread one by
> one. This is not *that* visible with just a few threads and a quick
> CPU. But with many CPUs on a slower system this gets worse.
> 
> Acquire refresh_on_max_lock with a trylock before invoking
> pthread_cond_signal(). This ensures that only one thread will send a
> waking request at a time. Should the lock be contained then delay the
> signalling until the next iteration.
> 
> Make refresh_on_max_lock a PI lock. This shouldn't make much of a
> difference here given the try_lock usage in the RT thread but the
> unconditional locking will lead to complains by the RV-monitor.
> 
> Signed-off-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Signed-off-by: John Kacur <jkacur@redhat.com>
[snip]
