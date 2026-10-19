Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8614F4CEE7E
	for <linux-rt-users@vger.kernel.org>; Mon, 19 Oct 2026 10:24:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=170.10.129.124
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792405446; cv=pass; b=LocVqh09/C6DI6ROwhFJ6NvdOgXcGXvsZ6E7IZGIsqOLR///rTU3/H2llGp+bcWuNmczmlCOs3qKXzt7em4uv0CQxF9v2bXcFsBHMWH+CGIXsei5ekCt4VKVhCxQY6lsd7cG/f4GKNeObwn5RUQ9cok6um3nxFoGaL3ze7wu/Uk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792405446; c=relaxed/simple;
	bh=w4ecmBS9RcSJvpZHV2T9H8zX8wgB4XDc8bzNKDIkkOM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Envcy8fUAUvISfa5tPYJZ0YMSODhSZYCtIIQBoL1rCBiyqmthV1sxjweKC3n1XIcmebnMNYuoHMrwMH1wNkRDnQcaJ9NnLFVlzQXZ5Xe9YvjgnygGK3Bd2sl1bBO0LPQlJ7w2cCGh05oljiaCvs1xhVf/xuwyBY2gT8Y2RsOv3M=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=E3bCHFyw; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=WPGC1xud; arc=pass smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="E3bCHFyw";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="WPGC1xud"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1792405444;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=W1uyDsMBUaRht2STbrOGrKWI9y7NVw04caCuU34nyMk=;
	b=E3bCHFywsSthdRil8F/2G1aYU2ZvMTPtrG/+3jnK+iYBSZXj438KwSt+CTVBV4AndPqnt2
	bj0EBoY5Uk1/1jvrBumh0I2PEDU9C/UZ2bHfZJWbWgOjM6thbYYJDZGv1aaIWrHnffM6gO
	vbjNVEAOBnoplQoXfKh8ifHVYHN6QWg=
Received: from mail-ej1-f72.google.com (mail-ej1-f72.google.com
 [209.85.218.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-591-Qs0ckEAfOimGiDltomPUhQ-1; Mon, 19 Oct 2026 10:24:03 +0000
X-MC-Unique: Qs0ckEAfOimGiDltomPUhQ-1
X-Mimecast-MFC-AGG-ID: Qs0ckEAfOimGiDltomPUhQ_1792405442
Received: by mail-ej1-f72.google.com with SMTP id a640c23a62f3a-c25edb54d22so215574966b.1
        for <linux-rt-users@vger.kernel.org>; Mon, 19 Oct 2026 03:24:03 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1792405442; cv=none;
        d=google.com; s=arc-20260327;
        b=LmCB2n4UptW0QkJmG2gZtkNfQaKGFHAsLjbLVdDtffTo+OUrgSq5mRMpDD0I9v8ELP
         vBT3QDAVl0Nfz447jJTfHBlnV5dX+Ad99z5gm3Ew75guLIhHFi8hhlG07CC8/Ur9W2gV
         3bEJ7T/Q1z5CxAEvlR7U+u8A4ENe8eycNIv644egnHtUuBFN3wneFtHQePPVXKOPSIX5
         joyO9tqQ5QbddpGaxS5askC+ybT8QsY9Lj2imPeg4CDesgRbcTsadqOd7ylVQIZwkpgC
         iyzsFdrxhtqm8kkMFUnrbSLwBSjcLN7V1UPrbeesvIIrmPUV8SNYBNRske7wW3FZ2x63
         wjOA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=W1uyDsMBUaRht2STbrOGrKWI9y7NVw04caCuU34nyMk=;
        fh=eWqfEurXEsIq82gY41hKEhMWw/woAV0WKEdR0nB4Po0=;
        b=EC2tND1x7f31+eZIparIQTTh0qfk5REt7J/fFLr0eYzikizPKrQfl49DmDwHVvgmjN
         78rGvHPeESkMWnJaE3xkXpL3BsV5Tn/r1YhOkqUdGjOOrfF5/jWu74Ttz5l5AAN9Phw6
         T2rhJA+0DwcglfT7ivLPx6BU+YEUtD7ImosODwaQvAqDzZGn1S2EnP+XQ97oVMdtzwE/
         U5w7SlxK0AB3v3S2OKG7eg9tySZ09i6C36FwYvXyH01ObdkXsOlMfZnTKrW5xUum+MS1
         SZLMEqu0PeHVykrGpcP/27cU9qdFVDc5YMYB+it8eml4aWq7+OK+SLQztZdv2EtQ8Nik
         eRNQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1792405442; x=1793010242; darn=vger.kernel.org;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=W1uyDsMBUaRht2STbrOGrKWI9y7NVw04caCuU34nyMk=;
        b=WPGC1xudL9tG9eCmeAnKzRN2KpGC8kwTMQpgYdSkyxEVGiKHfp6B3Ffj2v8YGI+hET
         WoOGbNSaFbWKlaVwNkNwuzM/E28oUURAUBa/FOYD4hA5elmpDd97FI0DKFpGoBk8kVTs
         yx/VOCXZNh/BmPaK8mUofhTnA7qq1I6s777ZYnNYMXo2L4Epao8PMxKJNs0L9I+sCr6y
         vJriHv0lpdLGkhU40Qicg36f1F/THwnt6FufrbdRkApO9WcRvrDz0/q4toRwmTM7iLnN
         AmMcd21vLWRWVgEonSMciWx/83gJbUJuRXuXW8S9T1FLxf1Xy8s1mEn9DGjMPa6w93Z6
         WNPQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792405442; x=1793010242;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=W1uyDsMBUaRht2STbrOGrKWI9y7NVw04caCuU34nyMk=;
        b=AZ5hV0QBhck7IfVSrDUtClVJAHld8Wknkj1pnsZ5Y05hpamzr9/aN0oqdqDrEBsmvR
         qeukPfD0voD8HxeJvMXRHiqBknf3ldWJOGdtotUJFGfxbDbB+K5VVIuUSE5E4G/onqaz
         5U5wpyOwqCvEymqxnRb7LfBo/nlebrdWF3de+s3d6N60uQbnYclJemteCtIMbPxMzjfB
         jMdsw9Mwnp04MCpyyGb5cngLvp7OM0S9af+4/rDXfGO/nGzGzaJk5SLlGRh8gymrYv58
         JZotmxUXwiovJIvbojNyvRmG8vEzMaelFCe+VOy567gbi6cY+Umdtm7uW+fqtFfs0prO
         Iquw==
X-Forwarded-Encrypted: i=1; AKwUvBxVBln6V+uw6fScrNOQGhZfZzJmbwOfsJ2siwUss1dIQrCCvBl3J3Z/xU7/AMIIfodlosocsdmPvjlkZP/bkQ==@vger.kernel.org
X-Gm-Message-State: AFq9FYJoegsqSiUk78OEsHT0Emge6JKqrKbL2RJUrne/drF8nIvJWChX
	wNFX93KnIA2sPONoeccMM6zFMJXyl0A4ElSjXRM7GWZKQ3cql1L8j3v4u/i7NTe+ID6VHEY9NrL
	s1w4zBTltDhCkmaQ1ALawIPhOl+I5eyjzJldUL5+dmH3JJ1z31ZSHXiSnYpy7y0eNRClhYF4C6q
	S+a3Cc8QCyFlfuJ9tyfHPKXR7tzWDDQLS55KdiRGETzow=
X-Gm-Gg: AYBFou0vhTm+qzoZvhSqqnChJXG/PHK+UJnrc7ln2gi2DRtbPWshf47Q0OaY/mtqlan
	LWl2tPGZSSCD6cahuFEqS1s2OcuD20xSbgwIXLHaMxbBHRIJiBVDzm/bGg9iqY3C8FrfeN8AZEa
	5rzVFRv7tYebgwCi/Jgoy2/70LHQGTD/KwnpYKT4gGSNeDjFB4VqwkPl/QDTb6HQpjPDWHNLofL
	4sSy7EqXTjfD6LqZQ==
X-Received: by 2002:a17:907:c011:b0:c2e:4c59:a3ab with SMTP id a640c23a62f3a-c41a06e5177mr500222766b.48.1792405441921;
        Mon, 19 Oct 2026 03:24:01 -0700 (PDT)
X-Received: by 2002:a17:907:c011:b0:c2e:4c59:a3ab with SMTP id
 a640c23a62f3a-c41a06e5177mr500214666b.48.1792405439787; Mon, 19 Oct 2026
 03:23:59 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-rt-users@vger.kernel.org
List-Id: <linux-rt-users.vger.kernel.org>
List-Subscribe: <mailto:linux-rt-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rt-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20261011192959.2122274-1-costa.shul@redhat.com> <b922c748910362ecdfaf90e79ac8bcb18d45dfa7.camel@redhat.com>
In-Reply-To: <b922c748910362ecdfaf90e79ac8bcb18d45dfa7.camel@redhat.com>
From: Costa Shulyupin <costa.shul@redhat.com>
Date: Mon, 19 Oct 2026 13:23:23 +0300
X-Gm-Features: AclHuK-SyVLNdvssr6baPfyRPe18-HMszETrsEyU1A1ECsOHjusnxaZGJ_N_koM
Message-ID: <CADDUTFxXf+3sB-kbnbTiRQZ6r7FQzdQRKYqxDVYobzQJh4bFFg@mail.gmail.com>
Subject: Re: [PATCH v1] rt-tests: hwlatdetect: Restore tracing parameters on request
To: Crystal Wood <crwood@redhat.com>
Cc: John Kacur <jkacur@redhat.com>, "Luis Claudio R. Goncalves" <lgoncalv@redhat.com>, 
	linux-rt-users <linux-rt-users@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"

On Mon, 12 Oct 2026 at 20:46, Crystal Wood <crwood@redhat.com> wrote:
> Is there a use case for *not* restoring?  Though I'm curious which tests
> are just using the default parameters.
Backward compatibility results in awkward code.

> Why only SIGTERM?  I'd think SIGINT would be more likely.  And why only
> when --restore is used, given that there is other cleanup that is done
> unconditionally?

SIGINT is already covered. Python turns it into KeyboardInterrupt.

Costa

