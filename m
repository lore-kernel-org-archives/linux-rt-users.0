Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DB292151CE5
	for <linux-rt-users@vger.kernel.org>; Tue, 20 Feb 2024 22:24:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708467891; cv=none; b=McVDXSykEm14IO7VskUp83RxOpBfvBKZ6jkS+4wRGTOXcPnWac8J5ZFEktJ11xxTfs+dYhCMUK9crNECl7YOkoMRI+V0hTBtyH589/IBgHPXv0aGf6wdO77JYdg86nmLAjjA/h9lj7rycYSmm69g4Bkafodz5tznhDwN6dLsV0o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708467891; c=relaxed/simple;
	bh=g5UH7tdCMPlNrjY5k7QwcIoKNj4+ocCFWLo1As6HTYA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=DWc1Gm6WeHshr4grKrH5n0YS4vXLS9wPf1UJ4KJNBOi56zToD6REVwoy9oiHmTm7jXywgnL415OW6rt9EyF+J92hW9gJCXxzfEFc8X74rQ3RzGOId9cKTvBIXnleBdcJfwChK8gDKc4Lyy6ppEm6uFQVe6MTHZLm1YTNZtRndFQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=LlSRq0rk; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="LlSRq0rk"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1708467886;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=0NjQBQA/lUjdbHUMGa7rbh+2FLAyaGbRLlsYMTVFpfo=;
	b=LlSRq0rkVRzaYuqyiOobQ+oOV+pbg16DuSnT4EepKufc9qv6r2Q5Crs9vje2ZCRwxQ2b+l
	oeXfk8W3yyLBij7iLQOh5dV5lUqjUsaNJ2q0ZNF+Cva5XOnjSOsfaUPci3aS4bkr3lzjLE
	h+4aFkog2JLJcFduipGTChHYR0tsIOg=
Received: from mail-ot1-f72.google.com (mail-ot1-f72.google.com
 [209.85.210.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-329-ul7TyaPfPCy__wcYpFGCrg-1; Tue, 20 Feb 2024 17:24:40 -0500
X-MC-Unique: ul7TyaPfPCy__wcYpFGCrg-1
Received: by mail-ot1-f72.google.com with SMTP id 46e09a7af769-6e2dc6c07d8so5466262a34.3
        for <linux-rt-users@vger.kernel.org>; Tue, 20 Feb 2024 14:24:40 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708467879; x=1709072679;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=0NjQBQA/lUjdbHUMGa7rbh+2FLAyaGbRLlsYMTVFpfo=;
        b=EW6F6AZkQMyEUE3C38EUuM00AmtxgeQmFGEcYs8PPb38gRoXKLF4QV6zmIMv9vtAhC
         EwqCaWQnWJokCvm5buhi0YZzn2aDCwvCh07Wu8yJJAbneLpPqR3CqM8q5vBRQcmXo3gC
         zdL1vjFTnSh+n/DOTreJBH99X5Be6fEST3MliJ1pL9bCYt+oATNBIBU5/ibz/nBWIuJa
         0J3+6lsvlaaivRYNPnYZzir+BViHgIvogvFaLQxG+NvrEGGTDBMOFW2PU2RHHaPIHCdM
         XjG2hWtST1dANlokJGYVGAR/4jKzfo+ykB2nwmVgmmotxZxbc5+nZlVOL4gfn6DuvvY2
         wVDQ==
X-Forwarded-Encrypted: i=1; AJvYcCUzDC9/eonmX5Gq2zVH26THxEV+YUNIkcz30a2QY/Jtxk2Px/CANrnkW34gH798S5IOlbpwCGrXIEZhaEBXb3vYZUKuyD3QQQ2m+BDbj9U=
X-Gm-Message-State: AOJu0YwnET5FK4kefFH76ChXBY+Mj9Xo43oGQNZ3bkHFr4jA8mp1mU3C
	+0/821qrTWA+3Kof6EgVCtmd/JF0YE5qiVyS/Lyqn/SKGnbR+NskVyoQf/F+dodiUXPAFV8OqEo
	Kb3lVDFLfHkMbNzM8G0Rc16tCtP22t1NasJR5+Bb43Kx2vrb/o4NjT2dx18ZS5Z/x
X-Received: by 2002:a9d:6d83:0:b0:6e2:e09b:a68a with SMTP id x3-20020a9d6d83000000b006e2e09ba68amr18311079otp.21.1708467879811;
        Tue, 20 Feb 2024 14:24:39 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHaeGvlNNYy2/qSVFub612PKKR6oUapbT/TJ9+26EU3vkcvx2qMSi6pHYZKV/zhPQa3oaHgnw==
X-Received: by 2002:a9d:6d83:0:b0:6e2:e09b:a68a with SMTP id x3-20020a9d6d83000000b006e2e09ba68amr18311066otp.21.1708467879565;
        Tue, 20 Feb 2024 14:24:39 -0800 (PST)
Received: from thinkpad2021 ([71.217.33.204])
        by smtp.gmail.com with ESMTPSA id j18-20020ac86652000000b0042c7c1b51absm3823798qtp.77.2024.02.20.14.24.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 20 Feb 2024 14:24:39 -0800 (PST)
Date: Tue, 20 Feb 2024 17:24:37 -0500
From: "John B. Wyatt IV" <jwyatt@redhat.com>
To: John Ogness <john.ogness@linutronix.de>
Cc: Petr Mladek <pmladek@suse.com>, Clark Williams <williams@redhat.com>,
	jlelli@redhat.com, Derek Barbosa <debarbos@redhat.com>,
	"John B. Wyatt IV" <sageofredondo@gmail.com>,
	LKML <linux-kernel@vger.kernel.org>,
	linux-rt-users <linux-rt-users@vger.kernel.org>
Subject: Re: NMI Reported with console_blast.sh
Message-ID: <ZdUmpblrzX0pcPjz@thinkpad2021>
References: <ZcQjxa4UA6hzXHnU@thinkpad2021>
 <87v86yc88b.fsf@jogness.linutronix.de>
Precedence: bulk
X-Mailing-List: linux-rt-users@vger.kernel.org
List-Id: <linux-rt-users.vger.kernel.org>
List-Subscribe: <mailto:linux-rt-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rt-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87v86yc88b.fsf@jogness.linutronix.de>

On Fri, Feb 09, 2024 at 10:17:48AM +0106, John Ogness wrote:
> I am curious why early_printk is here. Are you using KDB or KGDB?
> 

Missed answering this in my previous email. I was not using KGDB was
disabled.

-- 
Sincerly,
John Wyatt
Software Engineer, Core Kernel

