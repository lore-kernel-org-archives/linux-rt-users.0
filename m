Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 728393822A8
	for <linux-rt-users@vger.kernel.org>; Mon, 20 Apr 2026 09:33:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=170.10.133.124
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776677603; cv=pass; b=tXg+lTn6ksxmRxK6wsHpCl9FoDt4G1lixQg+5z0sKvQsqW+M0wrUR3CNcpVISRJ9rlzPrOjFOb6WEfdSYbM8YSxn8TeDzS2oZj6x7xh0KCKcWEiWu7HOaheEX2TWPiDdwwN3UMZ/ztjSCTZ9FNVbfSJldbFzmLeUwajpumLjT1E=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776677603; c=relaxed/simple;
	bh=9o37wNZnWGKOebwaLIZHqps4S6G1B2Ybp2oi7Z0sjfE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=przMBJ9QU3mHGtgKv0L82XiolBTfx/CoY0S5YgBABA27E/iDt3iMsEF5KnFwoiIm5eKBQyPMEey1qgMFqVaLlTOkq878pqbk8KhhAo6zDijx3evi4gbXVkTR5PWm7EIiucD0UzY3xKhtQ9JRFmutXMtdEDSlRGP32VGCb6Gy2YU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=RPh6IFkP; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=JKy+wTAB; arc=pass smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="RPh6IFkP";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="JKy+wTAB"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1776677601;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=EBQCIVaGZ19dIlPxuUTWB/foA5812Ope2iKpep01jpE=;
	b=RPh6IFkPjUvTX5b0T+XNgwl9QpFH+nPdRirqyOXs6FXPd5XB4vGFwCIV1RWnDT3na8rbcY
	MQZsWaKh7SNDw3loymddpevWinEf6gvytpbIrZ69Az8VhRfB9zg//ptHn6//pTnFlIE/A0
	4O73Kp0468ItuL3RRyge9dap9ayUH+4=
Received: from mail-ej1-f69.google.com (mail-ej1-f69.google.com
 [209.85.218.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-582-DxeW-k8jMr2pImOph9hAPg-1; Mon, 20 Apr 2026 05:33:19 -0400
X-MC-Unique: DxeW-k8jMr2pImOph9hAPg-1
X-Mimecast-MFC-AGG-ID: DxeW-k8jMr2pImOph9hAPg_1776677599
Received: by mail-ej1-f69.google.com with SMTP id a640c23a62f3a-b90bb54d034so369318066b.0
        for <linux-rt-users@vger.kernel.org>; Mon, 20 Apr 2026 02:33:19 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1776677598; cv=none;
        d=google.com; s=arc-20240605;
        b=P70Bpkeo2hMJeWHJhjcIhMv4yject7IjHFMR8txnESMJecnszk8a2Tl6rci7ZyWYvY
         EwQmGF0scFRX80qqKIrpjGeU8BDS5eBfTLnp2sW3atg28d3ZSahXCeiZ+jWDtElvYDb/
         ScgCp6n8uxkoefquBt/7vBdwzdXYAV882AxkbhDRmpULlHkvYiWfJIFt3yV0PfLu3uvN
         G6nG1hPU2cilMxHN4fAYIj445w7GtXC8MJInWM4d6Urs3T8BuSceuiWlUJAepXh3bTw8
         412znN8Whr1KMsiJTXxLKTbU4Z0fLsCT/yF0U6VlJk7erZjFR1ZQCGUOYqb9WLkoUGha
         onAg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=EBQCIVaGZ19dIlPxuUTWB/foA5812Ope2iKpep01jpE=;
        fh=OkIEyi8OUrK0g1hM0ooVM1ZoZsXqwb2xvg6VnU0U59g=;
        b=eHtHRLktK1MXQxeqo36iPWmk+u9oLEzDnY7PMnZqGEUynzCEPtSMMFGc09NewkjxkG
         mxGxSNYI9//MdCvdsPpK14aB2/ClvZQVf+CAwY/rDmQZzsBQpWmEZHVhDVz1JWd62Vsa
         DsoLf+HXRqK/KnZu6WZO7izSgrN3ZsIyVKB5ADBJYYKyxGvdXUpi4ihPvt00GZ+uY0a3
         fX0Vb8GMc8OpQ0iBXPjQAkqnODgXgaMHhkcnAUyPqGsrL+GSn/1/vLy6pLn/Oz/Av0gs
         Zmlim+tbt1te9jbAgT4dtlDKvyPH/covadXQPB2Y60Xa8Ti9GpYyjnDT9BScurMpMnda
         QRWg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1776677598; x=1777282398; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=EBQCIVaGZ19dIlPxuUTWB/foA5812Ope2iKpep01jpE=;
        b=JKy+wTAB65Y4Z7AhNLaVHtQu1a3oGYyQAE3imSrQyLu8f04u77OHw5r14bryHmAxU/
         4usk8ptTpPJ026uNvTJ4uYWDjTlasA7Ik+Twz6F5RlQyLbAr2OrVsYkOw7OZPTTFztFS
         BSx/wFIpE3AqPTXd4V6mjvOkCFn4c8nfhBKgZ65r+drGC7uY/yD0p9e326St7I+X5DbO
         VJFmilwQwLVDZcgFvK5GAAbi/9S3mlvoDm7z48BvH6TdO3RLa7wmrj9d/SScLqQZ79S4
         hXtLzsWUsMa+NGCr8Qx4rCjYnpIx2KPLYAVPbiNKkgTmzuwMvFN1g97svZhLidvV49EO
         Q+/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776677598; x=1777282398;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=EBQCIVaGZ19dIlPxuUTWB/foA5812Ope2iKpep01jpE=;
        b=ZSoad70iCXJTmbtEBnPitUMYVeLfh7RgRfuMqpurpHHkvHaKmj8/SdG0T+P9lJBjCA
         CHEdH+YqhkAymwwc25F3wmpcyzkRBui7LHBwj10qHl/DtPkdrePTVbHx8T73hhKRuTWr
         Hqu2wy2guekTVtOEySYXk2US1BJGC2stserXQUPSVpnEBV/uTq5aMgOEeztyVC8CtvAz
         NOF5mYEUxOlwfDA2S6jl9GOcpLx3YOSI3qGaLf7BVhIiZTyhyiV15goF+4K/V8RlmIM9
         VOsbW0Unk1p3staRY5VjTT5EgSBpOpqV4pgqBTnMPW+GFNWAx+SUwhM5o1CvKuQ+JO7/
         R0GA==
X-Gm-Message-State: AOJu0YxHd3bSxzefE/qFuJD/QShIoXlxjxOG9O5hBOUc7hR+n1SPJAC1
	iUNEtqprbYS2jkssdPjfTbCdjhr/dJJOwMtCz0+h7zwADcT0IKj+0qZvG/Wt/0EwvZZJrQORzjn
	5dcaZ/ZhR7OuF7Xq/JJxXcXv6MBo+3Grd8K10s4ILnP1D8TgJk8KUot7T2pqT39pY4RdGRdgjk3
	Vz0XeHcrnoPrc4busUfpzPlk4FNxbMcotL6fRTCttX8Yw=
X-Gm-Gg: AeBDiesd4mID670V7CHFdR7olD95pEFwocObNsjZUEsfkwVgk/M3RP/Nm/ecn5wrI3I
	RKlYRh/jmaaIIf4IytWvgTcPH8DdMjleh3V88R+s6mILYJgtE3xSBFZYJxNTMhGugpJzZH+JCll
	LYg16Gs88CFlAoneenV2F26mnl4AiSi9Yc08kE3d1YEnz5mFyTLyO1AaNtVlBYoJVBRPtivo45K
	qOcek6ih0YQYyGFIuHZFw3yMxTk1TrMUihwptdB1vq5BXs=
X-Received: by 2002:a17:907:2dab:b0:b96:e1de:db04 with SMTP id a640c23a62f3a-ba421debdebmr519246166b.18.1776677598534;
        Mon, 20 Apr 2026 02:33:18 -0700 (PDT)
X-Received: by 2002:a17:907:2dab:b0:b96:e1de:db04 with SMTP id
 a640c23a62f3a-ba421debdebmr519244966b.18.1776677598087; Mon, 20 Apr 2026
 02:33:18 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-rt-users@vger.kernel.org
List-Id: <linux-rt-users.vger.kernel.org>
List-Subscribe: <mailto:linux-rt-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rt-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260417195113.177799-1-jkacur@redhat.com> <20260417195113.177799-7-jkacur@redhat.com>
In-Reply-To: <20260417195113.177799-7-jkacur@redhat.com>
From: Tomas Glozar <tglozar@redhat.com>
Date: Mon, 20 Apr 2026 11:33:05 +0200
X-Gm-Features: AQROBzCx9exUfTQKIE4giWg_Iy4OyaUfVLWPARGM7wwkUO52q8cp3hxlypFNWE0
Message-ID: <CAP4=nvQLbPBhQva-fBqeC1_ApGDYmNG7tSzuBNxMFg-EiFp7ag@mail.gmail.com>
Subject: Re: [PATCH 6/6] rteval: Add --housekeeping option to reserve isolated CPUs
To: John Kacur <jkacur@redhat.com>
Cc: linux-rt-users@vger.kernel.org, Clark Williams <williams@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

p=C3=A1 17. 4. 2026 v 21:51 odes=C3=ADlatel John Kacur <jkacur@redhat.com> =
napsal:
>
> Add a new --housekeeping option that allows users to specify isolated CPU=
s
> that should be reserved for system housekeeping tasks and not used by
> rteval's measurement or load modules.
>
> Key features:
> - Validates that housekeeping CPUs are in the isolated CPU list (isolcpus=
)
> - Detects conflicts with explicitly specified --measurement-cpulist or
>   --loads-cpulist options and exits with a clear error message
> - Filters housekeeping CPUs from both measurement and load CPU lists
> - Correctly excludes housekeeping CPUs from inverted CPU lists when only
>   one of measurement/loads is specified
>
> Example usage:
>   rteval --housekeeping 0-3 --measurement-run-on-isolcpus
>     Reserves isolcpus 0-3 for system tasks, runs measurements on
>     remaining isolated CPUs (4+) plus non-isolated CPUs
>
> Implementation:
> - systopology.py: Add validate_housekeeping_cpus() function to validate
>   that housekeeping CPUs are in isolcpus
> - rteval-cmd: Add --housekeeping argument, conflict checking, filtering,
>   and fix inversion logic to exclude housekeeping CPUs
>

This might be a good opportunity to additionally pin the rteval
process to the housekeeping CPUs, as well as pass them to rtla's -H
option.

Tomas

