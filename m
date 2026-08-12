Received: from mail-qv1-f46.google.com (mail-qv1-f46.google.com [209.85.219.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6A8CA395AFE
	for <linux-rt-users@vger.kernel.org>; Wed, 12 Aug 2026 21:14:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786569278; cv=none; b=LR59ITevtfOK+Ak1UP3k5EXGJcwToose7ldnavu3Tln49gFRCT6OLGveif9MKuE6WuMjv2ZZhvWeVs33o/mxqjmlYKBnM7SfPyQ0WMwA3zd1b3HtSChr83fPesfrNZJy7GGxvhCp/42xgeagvU+BFKUQHo/94jQLvxSo78mUJTA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786569278; c=relaxed/simple;
	bh=lTUr9BZ/UyxY/wwslLhJ5K2hVdguFjeiODZhMLy3Usk=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=RI2luSAVjQZChjPlePieGnkRYdC7N6IA1szM2sfX3+lxXGPguDCU3EeumH1PtyAtSPs1ey3y6V8R7vSJLT55aZqBvl0fySUv29brk3CMB5skXg8c3IWDIYTKVOEMRqU0likjbUGUwJEzJRyimZuDoQA7ZYSmAyaLMh5ox7YXmrQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=MLOY3Lry; arc=none smtp.client-ip=209.85.219.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MLOY3Lry"
Received: by mail-qv1-f46.google.com with SMTP id 6a1803df08f44-8edda5d56a5so662296d6.3
        for <linux-rt-users@vger.kernel.org>; Wed, 12 Aug 2026 14:14:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1786569276; x=1787174076; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:date:subject:to:from:sender:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=plmh1l3/Y0w3EfFM3o97kpu0+lTn+MpJijiQxQiqnak=;
        b=MLOY3LrytCiCldm9/Q6WgcI4JSodj61wZRR7qRHsGmu6wgPoTSsp3KNDSY8OsseNcD
         o+UIjgzmvhqbC3BWsg5F4i/rsf4I/mcuzewHx2Bg+JmIqasKuDO2nADzAJZ9/b4wTXQl
         2F1Od+k99hR/P2xFVMTuTNo+x5QoCY0j+7fVP+JbYeNJxiio4Ug1TT3jNIHIqbt38aOi
         lxIshl3IQAo7gMWuhPMzkQMsjoqtfBdqU+38mjsaaAxkRsvt7wvVXyafD+jnq1rbrYTO
         eN6lF1i6cA9QWSP8wIDcwITta9YNnzs5Yh9nZr80R3OCZDOt/yhq76f0URW+eXO9w+Pi
         gEcw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786569276; x=1787174076;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:date:subject:to:from:sender:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=plmh1l3/Y0w3EfFM3o97kpu0+lTn+MpJijiQxQiqnak=;
        b=Agz3DTjTciy5lWo0qVwVtMA0oWiBEa5vblSxNW1fKaiit8BxWwpv1UQS+KV0oCLRSw
         NCmI37+bwDIr+usnGDR9IHIOzVjjtOmabIiSsOR8dRgD+TVmx0IjNtTsSCCyHuhd2J9o
         eb60EaFAdUd9hO9Lih67MYr4dgmvbQ/S7AkhJx/vbWvCn0s8hGk6YJSA4JCFU+LeiLR9
         yADKtY5YgC+uj5kA63yF8w+UcEzlYzS+xzKKU2UBySKeDbuzdCcehHp7wdV5jrSfQkuk
         ZeEujVfbeaxCgI8bsNyDOLt4AmeJp1IvXD/EhDqwXBMaCCAf6Jt+qFSAIVZhgdZcnaJ/
         ayhw==
X-Gm-Message-State: AOJu0YzeHLsWNtkGYzLJwSFsWaf+qmvrCw4rDXwVcpPJvw8R1Zso1leP
	xWrwptfFKP84mnkR0qR1Rcsw1LYzejaDvDL3cNuNJWKEOXF1T20alpmWW9ltkQ==
X-Gm-Gg: AR+sD11Xkx+4o0T+mq3SoDlLCw6pZhxLd5ZPbPLTe12DuD4kluJMDbD9u2zjh2BvqVk
	5gjA9Odl9hvqKZ01j3+a5TTTBNjykM2tNvjqDOLItQwcZJeJWpZ2xnF9m58FiI5jD5d9fQssnZD
	5hH/KynMotTsJlYbMZxYM8J0CD/atFfhHDeBPhK5eeXAT8XhYVYni5HcjMsygkGqT7asamisbch
	rd4baOCejBkSvWkrZ41CInD5vz3WnDt8NrPOpXqEd9mr9tCl/thRrPY6GuZqYtAXtxubCz3p632
	O76zSK3QQP11dlOYEzwmy23+uyL3+TwpRITejLoLiboRJvncQQIC1PUvtdQhsKFZTQ8vOEQZJcT
	SWqKEuZF0qfTcUnLzpHC4r1+OjSbjHelQ22kqmk6PwxYQoh6y0p6v1OxQsbh7NguOLjXST/z3eF
	XKOctL27IBIR1R3JVnftoI+Wf3x1iI7FrRshb+nhuc/YdnjC+82ooJPIgt1alPbwTAPbUFSFYHb
	McC8wY8s96CUd4tm0kgrAb61eHmfp8KichGXAX1HhMkjJOayOrwJeU=
X-Received: by 2002:a05:6214:3a06:b0:8f2:940e:2423 with SMTP id 6a1803df08f44-90a80b5b50dmr7818296d6.11.1786569276175;
        Wed, 12 Aug 2026 14:14:36 -0700 (PDT)
Received: from Cumhall.redhat.com ([174.95.68.136])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-90a81a9e489sm454116d6.35.2026.08.12.14.14.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 12 Aug 2026 14:14:35 -0700 (PDT)
Sender: John Kacur <jkacur@gmail.com>
From: John Kacur <jkacur@redhat.com>
To: linux-rt-users@vger.kernel.org,
	Sana Sharma <sansshar@redhat.com>
Subject: Re: [PATCH] rteval: Updated parameter names
Date: Wed, 12 Aug 2026 17:14:16 -0400
Message-ID: <20260812211420.203625-1-jkacur@redhat.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260812195257.378272-1-sansshar@redhat.com>
References: <20260812195257.378272-1-sansshar@redhat.com>
Precedence: bulk
X-Mailing-List: linux-rt-users@vger.kernel.org
List-Id: <linux-rt-users.vger.kernel.org>
List-Subscribe: <mailto:linux-rt-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rt-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Hi Sana,

Thanks for the patch! I've tested it and it works correctly:

```
rteval --onlyload -D -d 1 --stressng-stressor cpu --stressng-workers 1
[DEBUG] [stressng] starting with stress-ng --cpu 1 --taskset 0,1,2,3,4,5,6,7,8,9,10,11,12,13,14,15
```

The code changes look good and I'll apply this patch. However, the commit
message could be more descriptive. Instead of just saying "to promote
clarity", it would help reviewers to explain:

1. **What problem does this solve?** (the old names were ambiguous/generic)
2. **Why are the new names better?** (they clearly indicate purpose)
3. **What's the user-visible impact?** (command-line option changes)

For example:

```
rteval: Rename stress-ng module parameters for clarity

The stress-ng module used generic parameter names "option" and "arg"
which were ambiguous and didn't clearly indicate their purpose.

Rename for better clarity:
- "option" → "stressor": Better reflects that this specifies which
  stress-ng stressor to run (cpu, vm, etc.)
- "arg" → "workers": More accurately describes the parameter as the
  number of worker processes (default: 0 = one per CPU)

This changes the command-line options:
  --stressng-option → --stressng-stressor
  --stressng-arg → --stressng-workers

Update unit tests to reflect the new parameter names.
```

Good commit messages help future maintainers understand the reasoning
behind changes.

Thanks again for the patch!

Signed-off-by: John Kacur <jkacur@redhat.com>
