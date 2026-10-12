Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0FC5C4BD782
	for <linux-rt-users@vger.kernel.org>; Mon, 12 Oct 2026 17:46:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791827164; cv=none; b=NTUoSdUl3ZdsT4Q1TDw/cGmfT18GPTnbHJ35fACCn4RZRmVlboDAhx4iSsPOvm7YYDLwZkqVkumUWS0yvKGSTJJzTVjWnYrkjXPNTww9tv+FcjBZsQH4OwF+2fYhytJ9mcvbIMnZf6/ezRDHhulBKntkEC0Lz2Y5GZigSTzOSZM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791827164; c=relaxed/simple;
	bh=zZF9EqFdZwxu5Fw3+PWrysZ1XN13CPiEUzJoZRxDJAk=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=lThn7lrnAAFkwyCVt14D/aaXHOyVcHEoIBco4lHvT6lDKEnmgmWltngd6iXIkK4elqsX8UU/E//mV7OD5uaPt/+MTwGw/UMSF8aFOlV2XQuLEghwV54FWIwH03qx09nkGI/9qnnjKuEFZZiOLONoGgcrMircrCXsVabXfjY0fJw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=A/QkYAv1; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=btlqKPoj; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="A/QkYAv1";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="btlqKPoj"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1791827161;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=QYW0PopOAaRvPuR+L6JhRwJ2rf1kO7BRG6yM1RtINDg=;
	b=A/QkYAv1FhlwpOxb9Y0IToEwoQa4KAVMISNbtPJknuaKtUp8tqXg11fx6UtVRF3s8MUeOa
	yCMx22yTbGMa6T8SJAIl5zv7W44BYt1VSngVhvkLA1Hn9DTHXspRH1X3fOfSatybaB2rwP
	p18EAimosQ2PW4RYV4/7hSYbVd40ItY=
Received: from mail-qk1-f198.google.com (mail-qk1-f198.google.com
 [209.85.222.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-146-qee91CdSMb2CtrOk8iGu4A-1; Mon, 12 Oct 2026 17:46:00 +0000
X-MC-Unique: qee91CdSMb2CtrOk8iGu4A-1
X-Mimecast-MFC-AGG-ID: qee91CdSMb2CtrOk8iGu4A_1791827160
Received: by mail-qk1-f198.google.com with SMTP id af79cd13be357-93dd3c3badbso482627685a.2
        for <linux-rt-users@vger.kernel.org>; Mon, 12 Oct 2026 10:46:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1791827160; x=1792431960; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:content-type
         :references:in-reply-to:date:cc:to:from:subject:message-id:from:to
         :cc:subject:date:message-id:reply-to:content-type;
        bh=QYW0PopOAaRvPuR+L6JhRwJ2rf1kO7BRG6yM1RtINDg=;
        b=btlqKPojAQ5cj+ZtKf2HemEABo9s9M0QuLBg5szbxgXtnEg9k+fmEbT5kbM9go4b8X
         jKnsCPTADiiD4HBbxH1WGYvtRV6RfPZFAIus9diYg6G0uKlXz3+qZcvwTqzS1JxecfLF
         2uplweJqPC8FOKE20c897/VlYf3oONgJfB7b4rgHQmQiYQjHgLolRm2xdJ+iyMII8RcQ
         WCi+HRZ2eb5xKzggCb2ebAoqBMq1mB8uoPqF6EInAczC1NkaLDD1yvXQKzR89Ezyrfxs
         7bpaIHS/YkcbaJn+8VVDJUxYfGzbRUtlqDt+fR48H/FG+bX7EqzlRccAHY9CVnBD1Bb7
         e5+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791827160; x=1792431960;
        h=mime-version:user-agent:content-transfer-encoding:content-type
         :references:in-reply-to:date:cc:to:from:subject:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=QYW0PopOAaRvPuR+L6JhRwJ2rf1kO7BRG6yM1RtINDg=;
        b=Zw3BDdtXo2q92U9poHTonSyxHxm+L4gTC9IFmGZozVfoE+Pd1lRsR6O+h0QccGM4br
         LEodF+1Er12KLG9o11bYssfAN7km59rNXStt8zBUzq6KKQKETkTHa0kFOxrUlcE5CCAW
         0QMY8lTw0T3GMPxEJI40r2bgKMfnsaa2dUUZbzan3XqEj3WwHqCKQTZtKssRHxfyR+Kn
         Dg4k2gXR2FQ/wjZ3IndPlixf10b9CGouaDrF/1wCcq1R4XqrfwXiKh5eWEUEvPTgWnM2
         3b/EYVHs3gTN9+2EcaI22QtZioFevT7Qj0chfMW1NL6I4T5CO7vzrx3KbybBngQCueGi
         NQcQ==
X-Gm-Message-State: AFq9FYJcvK+KuctxD8FAZgEW79Ojb1xyR7ehqtgt/AMidyDc/enjXZJQ
	Xg0mp2yf5KA3AmH0xoLo3CM9csnITDBFXlK0ndK9KlX8q6pid7a+933XjXvsMJS7jxaSjWGExbF
	0LSQXbwZNiNCyHEXYO2vDEAGIuQLJUpYNyd8Ev8D8I+IflanP5ujIrPuvmrJcWmb9+2oX
X-Gm-Gg: AYBFou0+ivIKvzx3l6Y2sJas00UvGD1k0vqeG2/MO8A3W1vXrMcFkKyYVyNJIkTDyRL
	YsnXdDJEfc9JIJ7l31J5jr885uDhcb9jmHiqZpxdXInxZ7FvnzVMRF88z+WdVDN9FbwjKigGJUf
	bKI94hYwCwhfcGKkRKQyHl35K7wB0U31G9vWG2JaD5P+0HDy73vmBsgktvFN47ud3A+I+jqV2Ma
	NsyFNXKEv41T78DLvpbMN9uYq1hfHiAb6ROU03kMnbGnN45nlZc0/wspyjltwzqRtcwYXmOyCn/
	GpK4fHcRjfMVQKle7YOQMweW5hp/GWvvCHyYd9gBM2C/s9cxl//KH53OELww2emaD9MzPrX9ryH
	iIbWFZQos/2BZNIwoZV3V+91+tbnak6UldX09r393BHiC3Kdo1/3/90c=
X-Received: by 2002:a05:620a:46ac:b0:93a:11a4:223c with SMTP id af79cd13be357-93ebd0c6dcfmr1604862285a.9.1791827159969;
        Mon, 12 Oct 2026 10:45:59 -0700 (PDT)
X-Received: by 2002:a05:620a:46ac:b0:93a:11a4:223c with SMTP id af79cd13be357-93ebd0c6dcfmr1604860385a.9.1791827159485;
        Mon, 12 Oct 2026 10:45:59 -0700 (PDT)
Received: from crwood-thinkpadp16vgen1.minnmso.csb (71-34-25-140.mpls.qwest.net. [71.34.25.140])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-93ef5055eb3sm38397585a.33.2026.10.12.10.45.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 12 Oct 2026 10:45:58 -0700 (PDT)
Message-ID: <b922c748910362ecdfaf90e79ac8bcb18d45dfa7.camel@redhat.com>
Subject: Re: [PATCH v1] rt-tests: hwlatdetect: Restore tracing parameters on
 request
From: Crystal Wood <crwood@redhat.com>
To: Costa Shulyupin <costa.shul@redhat.com>, John Kacur <jkacur@redhat.com>,
  "Luis Claudio R. Goncalves"	 <lgoncalv@redhat.com>
Cc: linux-rt-users <linux-rt-users@vger.kernel.org>
Date: Mon, 12 Oct 2026 12:45:57 -0500
In-Reply-To: <20261011192959.2122274-1-costa.shul@redhat.com>
References: <20261011192959.2122274-1-costa.shul@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.60.2 (3.60.2-1.fc44) 
Precedence: bulk
X-Mailing-List: linux-rt-users@vger.kernel.org
List-Id: <linux-rt-users.vger.kernel.org>
List-Subscribe: <mailto:linux-rt-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rt-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Sun, 2026-10-11 at 22:29 +0300, Costa Shulyupin wrote:
> hwlatdetect leaves tracing parameters changed after a run. These
> parameters can affect later tests. When --cpu-list is omitted,
> hwlatdetect reuses the existing tracing_cpumask.
>=20
> Add --restore to save the CPU mask, current tracer, threshold, window
> and width before changing them. Restore them during cleanup, including
> after SIGTERM or an unhandled exception. Leave tracing disabled, as
> before, and keep the default cleanup behavior.
>=20
> Add a shell test for successful and failing runs, SIGTERM handling,
> --cpu-list changes, and restoration of the tracing settings.
>=20
> Assisted-by: Codex:GPT-6
> Signed-off-by: Costa Shulyupin <costa.shul@redhat.com>
> ---
>  src/hwlatdetect/hwlatdetect.8       |  4 +++
>  src/hwlatdetect/hwlatdetect.py      | 31 +++++++++++++++--
>  src/hwlatdetect/test_hwlatdetect.sh | 54 +++++++++++++++++++++++++++++
>  3 files changed, 86 insertions(+), 3 deletions(-)
>  create mode 100755 src/hwlatdetect/test_hwlatdetect.sh

Is there a use case for *not* restoring?  Though I'm curious which tests
are just using the default parameters.

> @@ -323,6 +326,12 @@     def __init__(self):
>          self.samples =3D []
>          self.first =3D None
>          self.last =3D None
> +        self.saved =3D None
> +        if restore:
> +            fields =3D ("cpumask", "current_tracer", "threshold", "windo=
w", "width")
> +            self.saved =3D {f: self.get(f).strip() for f in fields}
> +            atexit.register(self.cleanup)
> +            signal.signal(signal.SIGTERM, lambda sig, _: sys.exit(128 + =
sig))
>          self.set("enable", 0)
>          self.set('current_tracer', 'hwlat')

Why only SIGTERM?  I'd think SIGINT would be more likely.  And why only
when --restore is used, given that there is other cleanup that is done
unconditionally?

> +trap 'echo $original > $mask' EXIT
> +out=3D
> +trap 'echo -e "FAIL: ${BASH_SOURCE[0]}:${LINENO}: $BASH_COMMAND -> $?\no=
utput:\n$out" >&2' ERR

Why is cpumask the only setting that gets restored on exit?

Likewise, it seems to be the only setting that you force to have a
different value than what hwlatdetect will set.

-Crystal

