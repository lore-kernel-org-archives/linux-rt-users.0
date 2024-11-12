Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 80397200CBB
	for <linux-rt-users@vger.kernel.org>; Tue, 12 Nov 2024 15:34:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731425646; cv=none; b=ONUnA4OG9BD/xdcZ/pMiA+wPqRRXZk/gtKCHjb+hgI+uTD4BfXphwF4kyNYM2NvtOpwkkS1OFd1TUds4tFR4Y4R8q4Ijn6fotFLbltQqBrgW32aj0h+uVL8oKzHOnQYK/YYnS2Jbr/S4aeE/x2PpyJZQPkTg/2PXp/w6xR0cOJA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731425646; c=relaxed/simple;
	bh=OhSG+F4EQ8KtCdYAL5RCcD2M8w+wlVYZcH2tdBooQas=;
	h=Date:From:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=Q9wyFazqMqahqKOs2OqFB8Ez4HJpwhiIBJcPhTE+n5sdgavTi/QrZCIwIsdn+m96B388oWt9LxkVER5S8sYPzfdzdPWyvoIY7aRuZwGkusVDga2h7pb4SvJgDCtTtP6V4LV+ogagY4167Jkdo8rVp3bM32IhkORWkwaQRCOOPmE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=DI9nQwON; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="DI9nQwON"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1731425643;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=7feorkQCLsdBf/memdBYWYmuI+q/Ulr6qYx+wClK16Q=;
	b=DI9nQwONJ6uxqySwcy//Y72Gmm3jZpBgmQQoWiwpmPoi795s2nWkaqQE2h2LhcXCLCcCe7
	/bHl/WbGxeYCmwvo3fr6VUb6zZQe5zhLbeom+D8jwc+Hua2onSjXHtOJhUck6b0/7A/WBO
	4R5ybdEuRNU+H1AnmP9+MfMzCm7C4ys=
Received: from mail-qt1-f199.google.com (mail-qt1-f199.google.com
 [209.85.160.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-551-i3KFtvQaPhOZqKm3v5AyAw-1; Tue, 12 Nov 2024 10:34:01 -0500
X-MC-Unique: i3KFtvQaPhOZqKm3v5AyAw-1
X-Mimecast-MFC-AGG-ID: i3KFtvQaPhOZqKm3v5AyAw
Received: by mail-qt1-f199.google.com with SMTP id d75a77b69052e-46089122a64so84350091cf.0
        for <linux-rt-users@vger.kernel.org>; Tue, 12 Nov 2024 07:34:01 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731425640; x=1732030440;
        h=mime-version:references:message-id:in-reply-to:subject:cc:to:from
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=7feorkQCLsdBf/memdBYWYmuI+q/Ulr6qYx+wClK16Q=;
        b=u1dHQVOOom/ByCRF4i2RBqSHQHtrGCR2DTuuk7h+9KvoafF0BUw9GUNtLxBFz3wR1u
         PSJjCl3twXbV80nVP8aHWWBGhEupJT6zesEKxzF3xPzdYvXjwqo/NXCDKE7/pX3COyIH
         Z4UMX2y67zGRO2TndLsbmK3XZJEVpQCeUKRjtKbhyqC4HD4m4vQsoZWiiXdA8i6sD9/L
         9nOpw51tKeVONxulc1rYJKX6reNmr7pcwjOENCYjdCUQtmcjoXvLTvJP9hMRcU6rFT+X
         3SGJn7ayg5HyZod5e/qJiLzKQTChrHV3mZKI53xLE4E4/m+ZIA3t7YgLXHq9rA+To0CE
         QfdA==
X-Gm-Message-State: AOJu0YxA9WQOif+YssEjYekkoTffGDavufRsIFswHht41g3OkYe0AVQn
	zKL0vobUITGbLmguRK5YIy3ICj1xDtzvX+dRkWrLH2cC0zUiLEG03YmGA+m+vZ4zKh9GvM7BcLj
	unbAStEXGyr7RiMOd8gMKAkGHbxpEaUlu6OuxiS11F4jUcm+pKGtfd2hgcFZK7Cy3
X-Received: by 2002:a05:622a:1a82:b0:461:18f2:ae6d with SMTP id d75a77b69052e-4634022f525mr37248971cf.24.1731425640677;
        Tue, 12 Nov 2024 07:34:00 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGvaQ7Hqy6kJgIjXzc93dl3R/Z+U+gcm/gK4QgyF3wyYP8KYRXoKY3FMUKthnPoCSTV65JJIQ==
X-Received: by 2002:a05:622a:1a82:b0:461:18f2:ae6d with SMTP id d75a77b69052e-4634022f525mr37248701cf.24.1731425640335;
        Tue, 12 Nov 2024 07:34:00 -0800 (PST)
Received: from fionn ([142.189.102.234])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-462ff41de0asm75971621cf.33.2024.11.12.07.33.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 12 Nov 2024 07:34:00 -0800 (PST)
Date: Tue, 12 Nov 2024 10:33:59 -0500 (EST)
From: John Kacur <jkacur@redhat.com>
To: Tomas Glozar <tglozar@redhat.com>
cc: linux-rt-users <linux-rt-users@vger.kernel.org>, 
    Clark Williams <williams@redhat.com>
Subject: Re: [PATCH 1/2] rt-tests: Detect libcpupower presence
In-Reply-To: <CAP4=nvQQsPwrx37u_mHxZ1qcLfrO0qt7GJ61mpcqLOWDghRMjQ@mail.gmail.com>
Message-ID: <e392f9c8-a7c9-f4fa-522f-376006a5f1fb@redhat.com>
References: <20241107152049.822810-1-tglozar@redhat.com> <3030d57a-8d22-66c9-72ba-2b7d17e415d0@redhat.com> <CAP4=nvQQsPwrx37u_mHxZ1qcLfrO0qt7GJ61mpcqLOWDghRMjQ@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-rt-users@vger.kernel.org
List-Id: <linux-rt-users.vger.kernel.org>
List-Subscribe: <mailto:linux-rt-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rt-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="-1463748606-1786160657-1731425639=:10623"

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

---1463748606-1786160657-1731425639=:10623
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT



On Tue, 12 Nov 2024, Tomas Glozar wrote:

> út 12. 11. 2024 v 15:49 odesílatel John Kacur <jkacur@redhat.com> napsal:
> >
> > This seems overly complicated, how about just doing
> >
> > ldconfig -p | grep -q libcpupower
> >
> > if it returns 0, the lib is there, if it returns 1, it's not there.
> >
> > This is the mechanism that perf uses, you can see in
> > tools/perf/Makefile.config
> >
> >         ifneq ($(shell ldconfig -p | grep libasan >/dev/null 2>&1; echo $$?), 0)
> >           $(error No libasan found, please install libasan)
> >         endif
> >
> 
> Is that really enough? We also need to check for the presence of the
> header, taking CPPFLAGS into account, and also account for any
> addition LDFLAGS. I think this is the simplest solution to ensure that
> libcpupower is present for both header and library and working with
> the current configuration of the compiler.
> 
> Tomas


Ah right, thanks for pointing that out.

John
---1463748606-1786160657-1731425639=:10623--

