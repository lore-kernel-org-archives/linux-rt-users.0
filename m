Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C494538A9B5
	for <linux-rt-users@vger.kernel.org>; Tue, 13 Jan 2026 12:46:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768308389; cv=none; b=OCczAPSHUWrMskGHpALQ+JNS6K5xapXKtZv5ExrfV05IcPGWQW7Ftahpi08FdoZzcaoHsyCKYqK4ZCULJp27f0Ez9xJ7Wa3pVpbpgsUHwcwexWzAzg08qriE4TvQsJ5Xaex6mNwn9GYdHyw2nGscvNkZUTKj67r5444Wo5CGBKM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768308389; c=relaxed/simple;
	bh=AZwXI2ex/FU7aZjFr8rFGw3jA4I1XYkLrhtYqGwKFG4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=JhqX80Z5wpba7jBNzCFhE+s710Yb8TNzmmeiTclQgrfIDa0hbytlm2cnSiA8UlS0fV8RBaEJtVrpn3b8Zegb6V8rAKbHfUwYQ6EMQb7Cuqfo0jqmTwtpB0z5PYEOTpciEOtJG5xx0cofje7e9A7ntfQJiAE0EYQSWyg2n7WH8VM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=FgA1jP6z; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=jWlKyHBk; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="FgA1jP6z";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="jWlKyHBk"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1768308386;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=x6ehzXTzH6i0REZ1yeKmJ5PRXBd3rNUuaX+tPx0eyDQ=;
	b=FgA1jP6zsHN4ZvCNffswZSETFd5p8SLf9jOCoBcVBOfZBZR0z8gZe2cEEDQlEVFqnH+uEi
	eNHspChDzrjHtZzseu9SyJAGnrL2KZQEnnRbcFnXdQ+uRnlYMAxOmhFwcX8/n8jBP80hoC
	XXUvBd1QSlE77ZZfOreKf5s64KiFIFU=
Received: from mail-ed1-f69.google.com (mail-ed1-f69.google.com
 [209.85.208.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-346-0Di_LgbgOI-T8Rxy5p8upA-1; Tue, 13 Jan 2026 07:46:23 -0500
X-MC-Unique: 0Di_LgbgOI-T8Rxy5p8upA-1
X-Mimecast-MFC-AGG-ID: 0Di_LgbgOI-T8Rxy5p8upA_1768308382
Received: by mail-ed1-f69.google.com with SMTP id 4fb4d7f45d1cf-64d01707c32so13838615a12.1
        for <linux-rt-users@vger.kernel.org>; Tue, 13 Jan 2026 04:46:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1768308382; x=1768913182; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=x6ehzXTzH6i0REZ1yeKmJ5PRXBd3rNUuaX+tPx0eyDQ=;
        b=jWlKyHBki40ahuFSl3aQIDkBHuMs+SDxpx8MhIEgBhxg39FSixiXT+24GNWqNf++3y
         k8ZOwenqOnePxSo5jbph+OLcqSURYmFaiJUbQoG4IOfTElqYZEjatU2IkzqKsmJPMjQn
         5fOI/2Kyf62zwtVtkJFmiVTNYMSzE7EXmXAcpy04g2yLW4S+tmTofoY8G9aeCwCu0DEn
         qYq4VBWQxatePkYZ3uWKLQrgmpsEMDUBHDTMZMHrAxxq0e1ptcxCfl0IzfAOAtA6xSz3
         hW3TB6CA3Sr2N8jY+m/57DMGx2A9SgGp7OdAbH9zqlCx+a8WB/lkBlkItT1gwoWcxPsw
         kFDw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768308382; x=1768913182;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=x6ehzXTzH6i0REZ1yeKmJ5PRXBd3rNUuaX+tPx0eyDQ=;
        b=tV+EoB4ZBR8Q2gQjLb9HJIjl4Bov3Qk1tWj7XS8KvmwlmeI8pxxbaDTuqPdSJlhmn8
         S1dpZN8RcBTTA5ZEMRnfT/qe+v75gykJPLFLZwExAIercf5yhnUcMPX8Xc+pxs7yJ3dX
         gsVPOI7eiRo3spf23v0FzWn5Uga2q1nHDvOVU+j90dvInu5xNUHy90iFkT2paGq+43pO
         FJoHDtpUipIn17HLa4YdOv4BdyOQn5h9ismI1h+8OojgQwLoPgD8et9SZ+BkCsXndVfH
         zqQQqkh+25RAuR53EbaJBS9lfvCAeCVI1BjrHXkGpJj5iztKL9up9lI0OmlGGTjBs6jl
         Rr/A==
X-Gm-Message-State: AOJu0Yz/tZUgDufZgCcQRrptdjIOU0t0+Tltc31lkzQiOJ+Eaf/kku8m
	R2aL+tQCO+la06AQNvVVKWDBAE5hIIiszs2Pjz+l1agxppl6QDqaUVdL+aq+SWZDdrpldGvg5A6
	mQQjBrLDeFeWXOMW87yBxKSXqYlL8iBfxZhLVM7AGuX8+5Z1aIbYHq4omqEKhpErZU3LRxT+Wko
	NpqwUYPSA+3vDxP/cATyB/e0x7OclD1OY0vcOj8wL+Pag=
X-Gm-Gg: AY/fxX4xiMknc7KRlXLa7yzkpz/76Tr3b2lzuTkTfQk5WZ7TPDSgyv7spxBMfJ+RExT
	1yRIDMFbkq1UERM0zQCZOWhf+RK9ZwQCH47P2CwOSC/KlUS0FN3PhZONKrknAbtRzJOx5C7qGeh
	QJAFicUzEWOQVFxfeOH5exYCEW3ls6vLzVRyLe2FRBX5KR8slL8bdrmAzAhr73GGB0HwRs5Mwup
	b+yozKBMBpAyuDpwMGt9KSR9A==
X-Received: by 2002:a05:6402:50cc:b0:640:c460:8a90 with SMTP id 4fb4d7f45d1cf-65097dea447mr20091109a12.12.1768308382280;
        Tue, 13 Jan 2026 04:46:22 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHGEQquTB4QH7hAL7koa3hMRCt1Vu6Wr86CbF4c7czdkc3Q0ET+osHoPqY2xdICdYc8GGDgTgSiNFievXWcU3E=
X-Received: by 2002:a05:6402:50cc:b0:640:c460:8a90 with SMTP id
 4fb4d7f45d1cf-65097dea447mr20091097a12.12.1768308381908; Tue, 13 Jan 2026
 04:46:21 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-rt-users@vger.kernel.org
List-Id: <linux-rt-users.vger.kernel.org>
List-Subscribe: <mailto:linux-rt-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rt-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260110113738.2376456-1-costa.shul@redhat.com> <e64e7188a920634fce126fc71ccc09696984f42f.camel@redhat.com>
In-Reply-To: <e64e7188a920634fce126fc71ccc09696984f42f.camel@redhat.com>
From: Costa Shulyupin <costa.shul@redhat.com>
Date: Tue, 13 Jan 2026 14:45:46 +0200
X-Gm-Features: AZwV_QjvPXnw1YAS81VUyHDqX8hRG99AAoET_nE5YSB_eWUC_Ma2CdlM71uTTx0
Message-ID: <CADDUTFzSt_4oHsCech1Uy8ZA8ZBSPyjAb=aLwiBfzQ_Z0ZOe9w@mail.gmail.com>
Subject: Re: [PATCH v1] cyclictest: Generate optstring dynamically from long_options
To: Crystal Wood <crwood@redhat.com>
Cc: linux-rt-users <linux-rt-users@vger.kernel.org>, John Kacur <jkacur@redhat.com>, 
	Sebastian Andrzej Siewior <bigeasy@linutronix.de>, Tomas Glozar <tglozar@redhat.com>
Content-Type: text/plain; charset="UTF-8"

On Mon, 12 Jan 2026 at 23:13, Crystal Wood <crwood@redhat.com> wrote:
> Why is the implementation (slightly) different here versus the rtla
> patch?  We should probably use an enum in rtla instead of '4', '\1',
> etc. as well.
Just another alternative idea. Let's choose the most suitable implementation.

Costa.

