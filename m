Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.219.49
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793650114;
	b=bJml5MR3TeANiQtUT3kNhgXOJLgNDDXq0zkN5/t13rZVQWaCZjo3OaDA57nErZIva+6+
	 uftTH5R09QgpPnMMold7QigzZ6Y0ARmKQsKDYjO8HpLTVHTei681DRSJ5ym39VUOLoUhc
	 VZbgwqw20JiFaL3mjluJ9ONXJmrvxKJMSVryxKG2dlhvLyxEtjRTtB46pAy/dkvqfRFfJ
	 8PJnid2pZkoYnbUwgWHqQlbKI9Gzmcj1i+uQSFN8OkDF9oq/xqhwh8nujM5GFOn1Qve1h
	 ZIJUAUxKaU/UuQkSE5KUQnOqz7KR4ID/dvw4uyo58NBD1AL7T/y3MbKO9furPG2elBg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793650114;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:Sender:From:To:Cc:
	 Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Type:Content-Transfer-Encoding;
	bh=EDG34sHwJHOt9hPikMkjim2gKrtYMdGzOroZybI2h6o=;
	b=mbV7hHxXFSpsv4NCZTgmDUYW385cAU0rKhS+nO9gwcKx4woFuRz4OxKx4UHL1vC8UmS8
	 i2DIgk+Kq8VQXQbnGstimfncj0qzcmLZNVzAUJzaXad/FUcP4q7PJOeDKIc72kD9oXVJO
	 uaBHPGIzYcXoKsqD1SBNarOyeCFPSCJ8l7VGt8A9uOk1QuPiTeku2N7p544gGhZbdf/hz
	 WhCx/9R/7pd9knbo87eTtWMj4bXdAOmfkeOTsndfZSinLUWpg1GOCz6P2fgZLOYUv0m7Z
	 NyXcsyw/xyeJSaWZBLvEF6ZOa1RvOBKof7CHlfOobu6BSqXzuGB4ezaWPaFEwHENHtw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=fail header.from=redhat.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=IyueY+hQ;
	arc=none smtp.remote-ip=209.85.219.49
Received: from mail-qv1-f49.google.com (mail-qv1-f49.google.com [209.85.219.49])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 46142606A32C
	for <linux-rt-users@vger.kernel.org>; Mon,  2 Nov 2026 20:08:33 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 46142606A32C
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=IyueY+hQ
Received: by mail-qv1-f49.google.com with SMTP id 6a1803df08f44-91c11468b5fso36567436d6.0
        for <linux-rt-users@vger.kernel.org>; Mon, 02 Nov 2026 12:08:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793650112; x=1794254912; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:sender:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=EDG34sHwJHOt9hPikMkjim2gKrtYMdGzOroZybI2h6o=;
        b=IyueY+hQrzFckZZDDzb+dMOa0yBMH4AfL/vlVr6/mJH91OiHu9ZpBpHgvEDm6QfLGo
         f56tghDNE5elYNYt5w3fH/02hTgC6W8Wa4CbHj2x7od23r3DBOeISsf1JbVbBEpyK0lP
         Bp9KS0VLjh6sXSzxjdOm7n+WCaRLSHcPnSgPMi+QT+w0hM5KXqoQ07GNB7AIysLoEp3R
         XulWIWPQw3jdvDG0LC3XXDM5t+0GxDjVNAQjJUF/bT9FpFJIn178ZC1z4mdgKRqA/i/P
         pYOPM5Nzziaer6wv2wU/PH9rtHu/9No4XRW0vyoZDCGukAWDqrJlDzwYk5DsvK4c7923
         WC9Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793650112; x=1794254912;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:sender:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=EDG34sHwJHOt9hPikMkjim2gKrtYMdGzOroZybI2h6o=;
        b=eTdZ7UQH+vzDFrVPd+gd2ZtlQp2su0ROiPh1XYpIwWn9R7hBMZufrqeHQUPpG5DxoZ
         f9ATbVOdSfEJ7UKXHLGN7/jY7lN3j3ZECPzzN/GpwdCZceIJcuRVRJiBSnZ8RBSZYdUG
         8n32yqh+P16ZeaNCds/UZjmd2VjLuhzfKTw99ygk2hCEkbg0cEWfeuM7Wc1J5vEmA7ha
         MrQDp581F9UnEX/8FqGxlEzurqjF2XHpS3aTArHBsiaTpK261BL8dQiLyEbk9+hOsr6j
         +rsVcYJGxe5kFktS15rVc+LB9XLu0v1ri/Z82i/sp5vQubGg33W1Kysc/tbof3qAPDLX
         Ipcw==
X-Gm-Message-State: APuU4Z9NPedZoT+Z7T9MU3JCgcKkdYFJ108l7mhkQJ6q03R9jcVfkrhj
	nDCWtSSEM34RWIKvErmveuc6TRWGWwqodq9lZFghnfof9/HgwqdeEeYU
X-Gm-Gg: AYBFou3yZfUA7PjgXQhl5QNpjUU5qgOfixrjaIYtgNBSEt3/UFmifbOScmK4RQy9ylO
	stEslT/FkyWc6AqgFaRKc+I0z8gYAYaJBXUC9GM2r06wqAtD8nNxrc/h0gG2+1X4CbWwMa+N6PU
	T9izDviEUpfgeFt7QyWatL07j8UWVXRwQTsoQyFMoMdTjfM57QLIbxsjTwh90SmMJQsbkfnQ6lD
	29Bz2glmluizE96WmvyTUSxn2rLqD9aQq84V+94RFXEhCqczz0KEOxKJ6C8IGMIDKKArvenb9u3
	4ESCLqx1h5WxU0eYehZ1l131yJ7etSaSsq+I5onbFiK61E4zkUNs+/s7dbzMpPFFQIUppk/mCqc
	/GWmEFDT4PyHV2kKOlWTSJatBjblYTvwOmrlHutmeRTzUVTt38l8ujZVyEyzIKwRAXazSmG/CAi
	QDAZf/ySlCmpO92OcSTTQlzbjPgsvQIS9dIBe9W/s25SBd0tG3nflZY0SVfjFALFtSYcCcGUx73
	IWOqxwotlwJFjDMaWb1L1zvpFrcChuESwp9opbuXQaZ47YsLILlqfR5850DBh7FzY3CPjTrhY5t
	1Sp3didUNtCLypr0cJ4QLlWUVJOLKMnqWtgcKqr11xAf6gtgju7Ui+b0mu44IfcsONcuUReyZ6X
	CGe5pkRmjTcG1hlCNcnaDj7Oc4OTyhXr8zB816ALZ2KcM6G2wBIpBgaaQAREHId3t5I8mhbe4WG
	8NnqTcZIDJNaPDVX9Vz/gHRwNQl2Q=
X-Received: by 2002:a05:6214:226b:b0:91b:ec0b:9671 with SMTP id 6a1803df08f44-91ca4b9a540mr184969656d6.52.1793650112243;
        Mon, 02 Nov 2026 12:08:32 -0800 (PST)
Received: from jkacur-thinkpadp1gen2.rmtcaon.csb (bras-base-toroon01zb3-grc-09-70-50-116-123.dsl.bell.ca. [70.50.116.123])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-91ca805529csm101343676d6.32.2026.11.02.12.08.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 02 Nov 2026 12:08:31 -0800 (PST)
Sender: John Kacur <jkacur@gmail.com>
From: John Kacur <jkacur@redhat.com>
To: Jinnan Li <jinnan.a.li@ericsson.com>
Cc: linux-rt-users@vger.kernel.org,
	Tomas Glozar <tglozar@redhat.com>,
	Clark Williams <williams@redhat.com>
Subject: Re: [PATCH v2 1/1] cyclictest: add --warm-up option to skip initial cycles from stats
Date: Mon,  2 Nov 2026 15:08:26 -0500
Message-ID: <20261102200826.69075-1-jkacur@redhat.com>
X-Mailer: git-send-email 2.56.0
In-Reply-To: <20260915130938.3703652-2-jinnan.a.li@ericsson.com>
References: <20260915130938.3703652-2-jinnan.a.li@ericsson.com>
X-Mailing-List: linux-rt-users@vger.kernel.org
List-Id: <linux-rt-users.vger.kernel.org>
List-Post: <mailto:linux-rt-users@vger.kernel.org>
List-Help: <mailto:linux-rt-users+help@vger.kernel.org>
List-Subscribe: <mailto:linux-rt-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rt-users+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-rt-users+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On Tue, 15 Sep 2026 at 15:09:38 +0200, Jinnan Li wrote:
> cyclictest: add --warm-up option to skip initial cycles from stats

Thanks for the v2, and for addressing Tomas' feedback - the opt-in default,
the --warm-up spelling to match rtla, and running the warm-up cycles on top
of the requested run all look good.

A few things I'd like fixed before I apply it:

> -		if (par->bufmsk) {
> +		if (!in_warmup && par->bufmsk) {
>  			stat->values[stat->cycles & par->bufmsk] = diff;
>  			if (smi)
>  				stat->smis[stat->cycles & par->bufmsk] = diff_smi;
>  		}

stat->values is now only written when !in_warmup, but it is still indexed
by stat->cycles, which keeps counting during the warm-up period. In verbose
mode (-v) the reader walks stat->cyclesread from 0 and prints each sample as
"n:c:v", so with --warm-up the first N entries it reads were never written.
Since values is memset to 0 at allocation, those cycles print as latency 0
rather than their real (and typically highest) values, and they still show
up in the -v output at cycle numbers 0..N-1 even though they are excluded
from min/max/avg, the histogram and json. For example, -v --warm-up 5
--loops 8 emits 13 lines, the first 5 reading 0.

The stats paths are handled correctly; the -v output needs handling too.
Please either exclude the warm-up cycles from -v consistently, or keep them
intentionally - but it shouldn't report cycles it never recorded either way.

> +			ret = clock_gettime(par->clock, &stop);
> +			if (ret != 0) {
> +				if (ret != EINTR)
> +					warn("clock_gettime() failed. errno: %d\n",
> +					     errno);

clock_gettime() returns -1 on error and sets errno, so "ret != EINTR" is
never false and the EINTR guard is dead code. This should test
"errno != EINTR".

Finally, please rebase on current HEAD - the patch no longer applies
because it adds a second #include <stdbool.h> that is already present.

With those addressed I'll be happy to take a v3.

thanks

John
