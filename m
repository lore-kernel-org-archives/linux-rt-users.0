Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 760BB3A1DB
	for <linux-rt-users@vger.kernel.org>; Fri, 25 Jul 2025 18:17:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753467423; cv=none; b=rzCRsyUnG8xVvBxNScb5gZxkZ6FN0s1IuPo03+KnW5zTdlbFJ/0bv+qXoL/yA2rJUdGpG/+GRbxKAW229H4rfG1DCfaWJebwXpcKutiarXMDsA9GeTaugrY63ye5NrOEofvHTLbz8/+8Q4qGkRuEgtHn7+M6GsdqAqg+NUukhU4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753467423; c=relaxed/simple;
	bh=8RtJpcD3ppqrLgdINgoAfa0EnDqmKnuiXp4JOksdDR0=;
	h=Date:From:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=O1YIGhzEcNSIVXJbGV9PfJSFtvvWSEle/bKIA8Mc6j014HeJDprLlsqcwe2M0HQoW7KyM9K2RXHOw5+ucLpgmXXAHgWq/Iy3tHmaDzqkCV/XvkNreGgIYwJ0x5mbTaN6Q8zXD6khwQroNMAoEeTwlqs+eWRWoI1Kra1dc6KF4M0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=aQXa9xlq; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="aQXa9xlq"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1753467419;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=gVGOG+dHregGZjM1U+sldIG1OgGtQDQYo39yR2u+Ciw=;
	b=aQXa9xlqKL3u8MqLAr0ATOQd2EuICKL+VqcFIWmlSefkATubHecPbtnLlPQaIz2e0XQJ2U
	W88BE49JsyYZcTx0434GhH3+MkOsEKns45Kdm9wgWdDomz0Y6pjhV0xlysLtKUhEaCHv/6
	CIXNgAIrfTzXAjAacO++pUZ2+2L5CD4=
Received: from mail-qv1-f69.google.com (mail-qv1-f69.google.com
 [209.85.219.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-463-Jvmv5WVTPwOTDbM4PPy3PQ-1; Fri, 25 Jul 2025 14:16:58 -0400
X-MC-Unique: Jvmv5WVTPwOTDbM4PPy3PQ-1
X-Mimecast-MFC-AGG-ID: Jvmv5WVTPwOTDbM4PPy3PQ_1753467417
Received: by mail-qv1-f69.google.com with SMTP id 6a1803df08f44-70707a55da1so73648706d6.2
        for <linux-rt-users@vger.kernel.org>; Fri, 25 Jul 2025 11:16:57 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753467417; x=1754072217;
        h=mime-version:references:message-id:in-reply-to:subject:cc:to:from
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=gVGOG+dHregGZjM1U+sldIG1OgGtQDQYo39yR2u+Ciw=;
        b=DC00WvDQ76QdQForj4RSzOsiQ3mGnx8DAxfmMunGyoARwu5jZenWlTkfNFCI2nh2R3
         MKj5wArswFZGUQ7C1NJiyRkRLnpH+u3u37O2yDvt9Vn2YwFJcVP+t3UYx/4Tb//jwNCE
         EQ3W4utyg+gOCQdfzo0pE+fQoeVnY96aTR+oPnf9DVMVb3FVXjhJK06VDCXNR4NEDutx
         /K3Tv2BWUkTaxIcM3DhMRMHLEA63K20zY0sstjnu7zsyo4VOEP1KGi6Cv6RGQ5Cq5yCQ
         0Wf7oNcURk4E9FPKwZzq2ZIX7zyBEwj9hVpY4DgqivvgSMx8KbrsyZ7pdFBchzdrqcNG
         btRw==
X-Forwarded-Encrypted: i=1; AJvYcCXZAaNoAxkZ0nA/WAN8nWn7cmjgW+w+rlS+07jMhIT52ja4+D4oX9eiDeJVlGsGd66ZbX0yQqZ4hDQPHvDAzA==@vger.kernel.org
X-Gm-Message-State: AOJu0YxrMUYpgi5+auBBZidaObdWAWzAMuyXMJhws0PdJO0Rdn6FWXKA
	R2fgt7BwgDLMsoSrZxDoOzFtbFqB2pqF/XOc2WNXRFL1NFZZOP9+l7OSX6fnKNnwoCG4PTrcgFg
	tvZ3Ap2CSwkOB88IyzHGmABLKAWrRY/E1DRDrL604AfvEIhlh6ygtjBn5a2zut3WySA/m
X-Gm-Gg: ASbGnctp5Nf7/25V2SXz9Jf38jRoyN+fRA8BgU8/YyKTvWv2MbM+M9j8wX8NIunOAR4
	05AaGDqGpr+aj6reXZk4VwqWLZrbIAr7u54S+SftW080UtM/DOuUBWN671N5iZVwPq6JNS6NZ5o
	qO0L97d4SvMhDIAioyRl0FxyEmTHs+IS0Wv4x2MoriCVhDgbEHS4OYG8Eb8khmMOou/HKFp9UK7
	mGiYwZSmwGn9hD3pLnQZCqlGtboa6zsN7/Cs9k1mGf/sgzpevVJHjs9dQvEVmRdONeMt/Dw2PZZ
	FCwXZTOBwaNOpGNPHkCiU8BYgaXXCg==
X-Received: by 2002:a05:6214:1c86:b0:704:f952:1884 with SMTP id 6a1803df08f44-70720601d15mr33495866d6.49.1753467417161;
        Fri, 25 Jul 2025 11:16:57 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFcfBsoo5SEx4MyrQP/uUxiZs7ed6KQAVu8tRDnL6PV3FPgukEOrV0JWSBhJTAZFBxuKvgBRw==
X-Received: by 2002:a05:6214:1c86:b0:704:f952:1884 with SMTP id 6a1803df08f44-70720601d15mr33495426d6.49.1753467416604;
        Fri, 25 Jul 2025 11:16:56 -0700 (PDT)
Received: from fionn ([142.189.102.151])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-70729ca07ebsm2927206d6.102.2025.07.25.11.16.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 25 Jul 2025 11:16:56 -0700 (PDT)
Date: Fri, 25 Jul 2025 14:16:55 -0400 (EDT)
From: John Kacur <jkacur@redhat.com>
To: Cheng-Yang Chou <yphbchou0911@gmail.com>
cc: williams@redhat.com, linux-rt-users@vger.kernel.org, 
    jserv@ccns.ncku.edu.tw
Subject: Re: [PATCH 0/8] Fix -Wunused-result warnings by checking return
 values
In-Reply-To: <20250712134213.58582-1-yphbchou0911@gmail.com>
Message-ID: <61792d75-d574-f255-5290-f1818807667e@redhat.com>
References: <20250712134213.58582-1-yphbchou0911@gmail.com>
Precedence: bulk
X-Mailing-List: linux-rt-users@vger.kernel.org
List-Id: <linux-rt-users.vger.kernel.org>
List-Subscribe: <mailto:linux-rt-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rt-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII



On Sat, 12 Jul 2025, Cheng-Yang Chou wrote:

> This patch series adds proper error checking to functions such as write(),
> ftruncate(), and system(), whose return values were previously ignored.
> 
> These warnings were treated as errors under -Werror due to the
> __attribute__((warn_unused_result)) annotation. Instead of suppressing
> them with compiler flags, this series addresses each call site directly
> to improve code robustness and clarity.
> 
> A full list of compiler warnings fixed in this series is available at:
>   https://gist.github.com/EricccTaiwan/a78d6f1950d3cba27be757e405b6626a
> 
> Tested on Ubuntu 25.04 (GCC 14.2.0, glibc 2.41).
> 
> Thanks.
> 
> -chengyang
> 
> ---
> 
> Cheng-Yang Chou (8):
>   rt-utils.c: Suppress warning
>   pmqtest.c: Suppress warning
>   ptsematest.c: Suppress warning
>   rt-migrate-test.c: Suppress warning
>   cyclicdeadline.c: Suppress warning
>   deadline_test.c: Suppress warning
>   sigwaittest.c: Suppress warning
>   svsematest.c: Suppress warning
> 
>  src/lib/rt-utils.c                    |  9 +++++--
>  src/pmqtest/pmqtest.c                 |  6 ++++-
>  src/ptsematest/ptsematest.c           |  6 ++++-
>  src/rt-migrate-test/rt-migrate-test.c |  5 +++-
>  src/sched_deadline/cyclicdeadline.c   | 32 +++++++++++++++++++----
>  src/sched_deadline/deadline_test.c    | 37 +++++++++++++++++++++++----
>  src/sigwaittest/sigwaittest.c         | 13 ++++++++--
>  src/svsematest/svsematest.c           | 13 ++++++++--
>  8 files changed, 102 insertions(+), 19 deletions(-)
> 
> -- 
> 2.48.1
> 
> 
> 

The code is generally okay, but I noticed after I signed off on a few, 
that none of your commits have commit messages.

Please run checkpatch from the kernel on your patches and fix the 
appropriate warnings and resend.

John Kacur

