Received: from mail-qk2-f13.google.com (mail-qk2-f13.google.com [74.125.230.205])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C33D241D112
	for <linux-rt-users@vger.kernel.org>; Fri, 11 Sep 2026 19:06:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.230.205
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789153586; cv=none; b=OJk81prl5l1t3gTJEF83BqdnYZeiKt5OU70NJ6ZHboziCUIjpipv6+JkGw+noGPNtNQ9m7NWgle7atjbTQAF5jDhOi5Ihdo+NXkcA3q9YYZENFcHinMAfZ0uaimDs3iUuQ7FOp6MCc/fiWIau7uou69WKTMeAroetWl/nJP2v28=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789153586; c=relaxed/simple;
	bh=LA88UizRcWuIVJ0mTcAACCHG3bS0sCkIIywLoZHxZKc=;
	h=Date:From:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=drdidYyhVV0cf4WlmAZ497sDkabVjepWUTg4eBQltoz4O30TQwx7ResYtnZj8PsYmQa8VkoOks5hJh06CcRqmCd7/v4m4U7JtyJ19HFE2Or8eg1ybAOLickD2qdQlanZ2eVzZ8Dc/s9NpECwsu7QH8ny768jjw03Q9zSXjlKDy4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=P7x7q30o; arc=none smtp.client-ip=74.125.230.205
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="P7x7q30o"
Received: by mail-qk2-f13.google.com with SMTP id af79cd13be357-93910cadeb4so36192385a.1
        for <linux-rt-users@vger.kernel.org>; Fri, 11 Sep 2026 12:06:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1789153579; x=1789758379; darn=vger.kernel.org;
        h=content-type:mime-version:references:message-id:in-reply-to:subject
         :cc:to:from:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=r5e82iwGF5twCcfEfmsg0K1TTifcFwfy0TLUMFCyRJc=;
        b=P7x7q30oLgk7Qdh9IsReQTA1mrrb4teNH1GUYKXjTsBwKyis+vOBaYhvsvap2m9OA8
         1/jms2WLpBBZDGVfZgKjfUK6lOVUiA5EMGQ04HDfO8ceUeUdii+OEv0RjPmv1jaAEPCZ
         7NvG6FI5whvtBFj4656j92qEWMBkYS25L2lU/JtSRWnMM7ulLfmlMi1I1/Jtg1UW/L/E
         RzkLhuTPvvlMVOwB/bl+o8Qrw8oF8TVWGDlHjwpYjFr9eqMdLlHcL/8ylWBtfxFPkHm3
         7z/XMSVdm3XlHoXnt5DdcWgZgJHoBWF68hswLOqTysEc08Rvl6kQ/ukxc1b0v82/Rp1t
         Lh3g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1789153579; x=1789758379;
        h=content-type:mime-version:references:message-id:in-reply-to:subject
         :cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=r5e82iwGF5twCcfEfmsg0K1TTifcFwfy0TLUMFCyRJc=;
        b=dbOoaRogvO9M+88EMGNm1aKwsElkJ5HbvkaOCQ54hzaBjJbb2ILvWoutwhfJ8DsxL/
         WvSFspk4d44+arCSNRJqxQ5mFLcISIBBygLgjqS/+wXqiX6Dj+pHUjsPNNQx7Ck6Xt8s
         Hz3AAOUgmtGJEkgKFNa2cWRHsPxSZJk4sJPgpF0xISD0MHaGvfaA/GSky0L6OAkROCOx
         cihLorUl2Z4sPFXSMu0yuWwN7e4dNlnCiRxqAmqpHmg+3J23FTqZhYLd6xAYlSLiQN3/
         l6pLtKsMYr71Z7CPQ11q5OKFBdfO1IZ4brl8z58U2IFY3017QcZmuoQUfUDusUQFsRYc
         CHhA==
X-Gm-Message-State: AFuF++kF7HWyXrgxZtjp/PdLDuWeWyyOYeLHQTaINHGWuXZHI1vlhQpH
	RouUyFBCyYZ9TWs8AfpiRnhWe+k3oF/Seg5EbPGA9xTnrhLRgu7XrFwh
X-Gm-Gg: AYBFou3g3hRXu7Ocs2rprTTwo7X3RU93up+ZDKlufbTpAt8gwDrdpRyvJTNdsXFmzyo
	30KuwZ/s6vaqkYFkkYibHlwgDlhIYHVG5DW/th4x7QbY5EaF8JiPYOCWhFvz1uGXDF7BOpBkmA6
	9qDjxTLZyYsc0sI5kJzsm7wkMfvT01e9G1GV0Wy5+TvNogdXbcu59RhmNlV/ejAphwWvztG0IxD
	mvAQIOhul5RY/H4kVlVlbWRlb0fF+9suz6UPcJ9CpoKCgTkmA0oGdmdK9yZo5oVVsP9a7bB4YGz
	D/inSTz8YBm4o1zMfzgdezERlkOw8T40Ec7BJddxY8GwWKLpzIxsrhAcP2vnsasjAWJUj8yXmod
	GIIyrZl2nbRFyi305J05kzAqQmjcp40eYhDgUClg+OkgoG/TJHiMq2qW/lkLqZM26Pk+wGnA8zO
	yF6NQiZNlB08oIj829PuLsl5BSMwR3DgyO5wIYPfTnnrfnUI/ZYA/KCj19B8vaE+uzCJh+ig2d9
	FR2nhEnWIEYF0YtGYFNhg0fwsPvSpQBhi6A7xp6I9b7VIE=
X-Received: by 2002:a05:620a:448e:b0:939:b482:d474 with SMTP id af79cd13be357-939ea1ab007mr876402685a.35.1789153578808;
        Fri, 11 Sep 2026 12:06:18 -0700 (PDT)
Received: from Cumhall ([70.53.55.174])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-939e809fd0bsm306217785a.33.2026.09.11.12.06.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 11 Sep 2026 12:06:18 -0700 (PDT)
Date: Fri, 11 Sep 2026 15:06:07 -0400 (EDT)
From: John Kacur <jkacur@gmail.com>
To: Suneeth D <Suneeth.D@amd.com>
cc: linux-rt-users@vger.kernel.org, williams@redhat.com, jkacur@redhat.com, 
    bigeasy@linutronix.de
Subject: Re: [PATCH v3] cyclictest: Fix BUILD failure for GCC_VER < 15
In-Reply-To: <20260911053216.2601-1-Suneeth.D@amd.com>
Message-ID: <218ceea9-abd5-8dfe-1e0c-85c1e81f8e50@gmail.com>
References: <20260911053216.2601-1-Suneeth.D@amd.com>
Precedence: bulk
X-Mailing-List: linux-rt-users@vger.kernel.org
List-Id: <linux-rt-users.vger.kernel.org>
List-Subscribe: <mailto:linux-rt-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rt-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII



On Fri, 11 Sep 2026, Suneeth D wrote:

> timerthread() uses bool, true, and false. Those are keywords in C23,
> which became GCC's default in GCC 15 (-std=gnu23), so the file compiles
> there without stdbool.h. With GCC 14 and earlier the default is gnu17,
> where they are provided by <stdbool.h>, and the build fails without it.
> 
> Fixes: 98fcd661ac59 (cyclictest: Acquire a lock before invoking pthread_cond_signal())
> Closes: https://lore.kernel.org/linux-rt-users/4ce24139-5f7e-4180-a290-bcc15fb4f559@amd.com/
> Signed-off-by: Suneeth D <Suneeth.D@amd.com>
> Signed-off-by: John Kacur <jkacur@redhat.com>
> Reviewed-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
> ---
> 
> Please ignore the previously sent v2. Sorry for the noise.
> 
> Changes since v2 ---> v3:
> 
>  * Add Signed-off tag by John Kacur
> 

You don't need to create a third patch version just to include my 
sign-off. That's just my acknowledgement that I've accepted the patch into 
my repo

Cheers

John Kacur
