Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=170.10.133.124
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1792518009;
	b=wUKbmA7tmzrX5YJL8dmS9O/f70ObzuGhYxiKt49SrBi8FGIgnM3OxQ+duGNj97nJCbHc
	 y6rZGuycQ5MWh9Ve0P8t93NCS/rk8p2RS9lOtMv1/Of5LvVKNhhNvY60pQgDLqvuhmtVx
	 RMr9ZGufziuI5pGnr3SJ1gJETs6/DSgjbdrMvSRcTINmBBLmBHrk6G358r+edGQIsb9yF
	 /Dct4ZlkPfDCQ/4OOAI/ynL31ozodSylJqx7U0HoSVJgnS+LqeIkqrSyg+GqrXZJF7SKj
	 wuox18Q6tbgkOwNgKycI8I6AQ5+uC3U78Ic4YX96Jc+PJ27DMQATcLcB7KI0+iykQBw==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792518009;
	h=DMARC-Filter:DKIM-Signature:Received:X-MC-Unique:
	 X-Mimecast-MFC-AGG-ID:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 X-Received:MIME-Version:References:In-Reply-To:From:Date:
	 X-Gm-Features:Message-ID:Subject:To:Cc:Content-Type;
	bh=C5p3n6/2sLgRTlJnTM6trwKTpnETWsnQNNWh86wGEHs=;
	b=wYbGTwJdebn4Jyd8uC8Jei5aoxMhjx1IMPlye68BL/H2HwaIirlL6tNIW/GOv2oOs6pj
	 ROggEt+pOQIrEbyRyJs87l5FN2NrpuGhShLTuh4F9CTzZO5dkYpKcYCz1ZvJhbkF+gWyR
	 mNnM844umrxQD0OL6DH8XdJlQ0rW/ZHq5WYbRbERfv18/zbzDB9lOOmuz0xTmk+GwUOc5
	 MhaPQHUwOC6IHqT/oscImjngd/C+M2H6YarwaMzI/COjqsjHzEgWNs5QnM9oZQdB0rOeA
	 7C91tO2VEC2R62V+ma8+HFd0kG2EPLUnbVRjKfJNallAKiAZmNJhoE4BQgaVv5dVFFg==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=redhat.com;
	spf=pass smtp.mailfrom=redhat.com;
	dkim=pass header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=ImrhL+Oe;
	dkim=pass header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=google header.b=Wf9xwFdx;
	arc=pass header.oldest-pass=0 smtp.remote-ip=170.10.133.124
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1D839606A321
	for <linux-rt-users@vger.kernel.org>; Tue, 20 Oct 2026 17:40:08 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 1D839606A321
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=ImrhL+Oe;
	dkim=pass (2048-bit key, unprotected) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=google header.b=Wf9xwFdx
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1792518008;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=C5p3n6/2sLgRTlJnTM6trwKTpnETWsnQNNWh86wGEHs=;
	b=ImrhL+Oevh3UP0sGCAi8mbTuZ7HRRiFaUazBz4yvMLgfgOsSQn4MTcZOQi+KzK4Ez3nZ8V
	fasJRqYXAWfbLstbZn29E4stgcejRSeMRjiuUctPpDs8lZBwhKfe1L5cf4IYmyvI4GYtxl
	xke5Hmzu50tIhv+1g1tGf982Kf73j6E=
Received: from mail-ej1-f70.google.com (mail-ej1-f70.google.com
 [209.85.218.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-436-fF9XzJ2oN0atUf1LJBFniA-1; Tue, 20 Oct 2026 17:40:06 +0000
X-MC-Unique: fF9XzJ2oN0atUf1LJBFniA-1
X-Mimecast-MFC-AGG-ID: fF9XzJ2oN0atUf1LJBFniA_1792518005
Received: by mail-ej1-f70.google.com with SMTP id a640c23a62f3a-c2dd399f761so334083466b.3
        for <linux-rt-users@vger.kernel.org>; Tue, 20 Oct 2026 10:40:06 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1792518005; cv=none;
        d=google.com; s=arc-20260327;
        b=G1hNcyJbvc2jNL1B+ONkNybDpgfbLUWHJH7slCjonvXx+uJMwEUDTgiV5fujT4RRxp
         aLJxJjPVQB+PAJjufLHVd4LfWSC8L35jsh9D6ssoD9gjLNpR1ziXHZ2I/9zw4dTiOag7
         cgSNwDasuheY1fFxjJNOxrbbANOc5Y+r7tXME6lq0S05R8B5pDQbQXco6Q6GKhZTCCkq
         KRvZ/Pk7ThdB/ZHzZyasz929POABA94ZJoYFWKAQwiB/puMe5WW1gtIgGDRaqv+GTBGr
         +ceQbeir9uvUBMIwsZBwZoeNg2mKqPwTSGbHEPFJ2GEFKxUuXSSEydS+08c42ItV4h+/
         CSWg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=C5p3n6/2sLgRTlJnTM6trwKTpnETWsnQNNWh86wGEHs=;
        fh=trvEHe+JxrKI429OEc38k838p6f1JUpw/gs5Bstuf08=;
        b=pKiJIWWo4AE+Q/HoyMXto9p5FdV+aCnkt30XyAKUvcgr0G0dKjPt1aCgPJc9SJQ1aM
         G2Q+8hK9kfaeKcg1XPUSCXOkb/AbFzYoJuUP3b3+Kr8Xk/nCeijBCTLVQuB2qvJ3E0ez
         cTjNV4is37u82POW0aWqsElcE31W6Nc+JVtvcq5P30uS4+88ELRyawkmwYXfh13x3U8U
         jujsz0qO0hYG8WXThpyycky2I+uKyvLJvETO0rfqAS/mK+4XHCeWvBkYX+DtE378hID3
         mWx4k41FbThr6HblZD3S7ooIT0AvlP2sLYNxb0zoGDDjYP8aat3mRqth5mV09R0Hw85m
         Sttw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1792518005; x=1793122805; darn=vger.kernel.org;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=C5p3n6/2sLgRTlJnTM6trwKTpnETWsnQNNWh86wGEHs=;
        b=Wf9xwFdxR4E4NcrpRpOncUsFC7wZ3uxf/U3dBO/qjtWGXgg7Ciqc2PpIx0eH975CPi
         P0rLkatShqnutYl0SpbdouRHXySddWtK8IPnwU+HmhVdQzofgjq3K1IcTRcS48/kVi5F
         ONzqY0t46qE2Us9ZeKUdrbSgEV5qUC7fEELXWusYRgg/Ff8muqvxdPWi47JvFqdCxEfF
         kfDDVYC4XPkiq2YpsyBRwYsVkpRs1ONFTfBbfYFC7lhAX3Up+uRakPm1d7ZSjhE8kMIq
         GWvdnXD8Vdvflf7/uX5FnZPFQLXJQ2ajoKhMzoNchbMd4IbEgEjYxKodk+RKn9VRSgFh
         Uv7g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792518005; x=1793122805;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=C5p3n6/2sLgRTlJnTM6trwKTpnETWsnQNNWh86wGEHs=;
        b=jxMqIq8kUBUj4MehKAd3YTs7pjof/TAmWgesfjmDmNj6V/UBAJIABvhpplh05VbDqq
         3wpuYoSPZ+VKGZC8eAeH1+LgSxm3SrEEmqizuTLrT8W7QFeHTdWzcgm0ixTEr9BxvrXV
         9ZZzxTKM5y8iBngLde+KzI65ZAaemfj8MhmwAi+mhnEV0ysYpmK4Nj4/vnvsGixfc3fB
         YCntZj9ov8wmLDN2TqoAHxUMXlbsoWsRh0BeNS5Og4PaMxJaBCOW/hTJZO8LIjOIgeDG
         7ztBPO/shi8Cp3tmoQZxD7hQlzSuI1vpN+sTFNVqWK2XsEZabCumUCMwyNf5XrDt+AI5
         21qw==
X-Forwarded-Encrypted: i=1; AKwUvBwnPgVtR+UXs4KV0PyCQC3MQhnO6mg85FU6qVP//1/vCQwYkzVdkszt7pS6qVHQZN3bw5jkF3UwPPd6qEiY8A==@vger.kernel.org
X-Gm-Message-State: AFq9FYLp0kemaclF95XDKHp+aFMYOGK2DRxWAlQNnG2sxd9pNbDUWCi9
	4l5kPGt5oDnbZlzugHVCles0K8RxHumHK++t+ZNtLRXHrulJQuHfraNOI61G9sLKMeETjdYMTKL
	JIUtgeA4dxikqb2ckMD/5p42eMBUwJ0zqfOaTYQnz8YkN0dsiDkp/pS2a0fm/UDhK1uSElikOng
	mxCKCoYa97WnMRaE8YpyvGty9dWrUmWPqqs6ao4krAnIY=
X-Gm-Gg: AYBFou0IP/XhcmHNPVscvFnx2iN3MZEl4xUqV1gXWaZAlgPBcTY41AUe1WYeEDUMuq3
	Ja+EV5ml63BF6X+gJ4PTYq89lmG2OpXqfJzER5alD9GFBj5ipf8XSkXH6vPZ+kSRhBBcxMCCTG5
	HB2v+hc1RHZS7N8+xe92x6H7PJ9uKZYkyeOX8OFw6TRLGAzhtT319/IfE8YLEKwZczsMru/Qr2P
	zbb8FHPsOYbOE2Okg==
X-Received: by 2002:a17:907:3e15:b0:c2e:808a:f78a with SMTP id a640c23a62f3a-c419f31b40emr900200266b.32.1792518005346;
        Tue, 20 Oct 2026 10:40:05 -0700 (PDT)
X-Received: by 2002:a17:907:3e15:b0:c2e:808a:f78a with SMTP id
 a640c23a62f3a-c419f31b40emr900199066b.32.1792518004948; Tue, 20 Oct 2026
 10:40:04 -0700 (PDT)
X-Mailing-List: linux-rt-users@vger.kernel.org
List-Id: <linux-rt-users.vger.kernel.org>
List-Post: <mailto:linux-rt-users@vger.kernel.org>
List-Help: <mailto:linux-rt-users+help@vger.kernel.org>
List-Subscribe: <mailto:linux-rt-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rt-users+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-rt-users+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <20261019102909.3339372-1-costa.shul@redhat.com> <20261020101646.Xb1lEbqY@linutronix.de>
In-Reply-To: <20261020101646.Xb1lEbqY@linutronix.de>
From: Costa Shulyupin <costa.shul@redhat.com>
Date: Tue, 20 Oct 2026 20:39:27 +0300
X-Gm-Features: AclHuK8rB-VOnBwQXdyRXdhkRAqvFamldkrQ3zndwN5gNNtyu4AV1tnLQRuZkFE
Message-ID: <CADDUTFyDT4Bx_MEpF9tCZfm9ECP33WatpfBjQ=2WH0dpRrXodA@mail.gmail.com>
Subject: Re: [PATCH v2] rt-tests: hwlatdetect: Restore tracing parameters
To: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Cc: John Kacur <jkacur@redhat.com>, "Luis Claudio R. Goncalves" <lgoncalv@redhat.com>, 
	Bart Wensley <bartwensley@gmail.com>, Crystal Wood <crwood@redhat.com>, 
	linux-rt-users <linux-rt-users@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"

On Tue, 20 Oct 2026 at 13:16, Sebastian Andrzej Siewior
<bigeasy@linutronix.de> wrote:
> Could you please get rid of the DebugFS class in it?
> The tracing folder should be auto-mounted at /sys/kernel/tracing by the
> distribution. Currently it is also auto mounted at
> /sys/kernel/debug/tracing if something is accessing this folder and this
> is subject to vanish. Mounting it does not help then either.

In the OpenShift/Kubernetes containers tracefs by default is at
/host/sys/kernel/tracing and /host/sys/kernel/debug/tracing.
Therefore, only the DebugFS mount and umount are redundant.

Costa

