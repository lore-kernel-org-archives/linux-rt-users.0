Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.128.169
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793728523;
	b=dZ4ksVv0MHwXOeCRuBrxz02vdVUL9kLWVvJSXVclGMTJyyUwqoq3SRbgDpt0NTCxVtx7
	 0t9X72vOn6iI5dJa2ZrMr0thyk9mA7Ew0fVXj3qGjNpBQrjj36sE2E7H2fWOxeuAK0aK8
	 Agsg1dsIH5l6SO/Bp0CdGgqgZyg6Qk6QjX+KTsXMgSWrMD2enzVNWqsz0Z+tE0C3/a7kN
	 jqjmC3h1mGMyXqFbhfJSImqC2Ld9ODjXlWRPolchyr6OPguf+za5kuJLHFnhF/0JdhlDY
	 07H4sihaOXRJHFNsvYyNu/uNFEaaXXJ7v1STjHtou+svOMobunm0jr/0JiejcwB52vQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793728523;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:Sender:From:To:Cc:
	 Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Type:Content-Transfer-Encoding;
	bh=hgC2jszRhcbrP1Ah6Vr19omv8g4IklUPg6gHa2W5Q9g=;
	b=QUpYXl3EaCQcEcGunQ0PKWu7YemAZVCAGv/vC3xLE5m3IBym/MsMYISiFP6EIc6eaQ8X
	 6gif1MgXJHaRMmZkGwOJoIfzhCpYUHPR4za6MInwprqMR/3t2EJAH1ohtS8KyM8F8b/Ve
	 TRkl5Z1e8CDJs1tgvzjICYRYBZ/3OVX+sqZNCHgMmmBfP/YWPDOz3OTbDnQdZTphG7O49
	 sSvbPCnLigH4tZpA+h7fT/GLszTSnc6IfySmv/6FxBh9NfhdRG7Gn7rx218kDSi2frwBq
	 ZT4JvX+EU2osThxAzoTKLnm5wDrdExnbpBIW8lUDMcJCoEd8hgmTvRyqymq3TTrKZLw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=fail header.from=redhat.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=A6WYB8Fk;
	arc=none smtp.remote-ip=209.85.128.169
Received: from mail-yw1-f169.google.com (mail-yw1-f169.google.com [209.85.128.169])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2B2B2606A31B
	for <linux-rt-users@vger.kernel.org>; Tue,  3 Nov 2026 17:55:23 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 2B2B2606A31B
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=A6WYB8Fk
Received: by mail-yw1-f169.google.com with SMTP id 00721157ae682-8b0dba37a7fso41550997b3.0
        for <linux-rt-users@vger.kernel.org>; Tue, 03 Nov 2026 09:55:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793728522; x=1794333322; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:sender:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=hgC2jszRhcbrP1Ah6Vr19omv8g4IklUPg6gHa2W5Q9g=;
        b=A6WYB8FkX0i9b6cFJw6aXiEjSuN4jA+1oZvK3V+eHKJZ6AGcOSp+Pxg+xsJrvN3Uue
         bp94j4c73o5oLJKoStFKeyBlSDr7QX/8/ATAs3JbV/VzHvi1XdbrTvJzeImY0ThOF56K
         DKYTz8rwI1Wx93kMlRbzmdI/b/UZTs6OTdf8iWEoe9++FWFKUBZ6qOa1YnefEYgmdCle
         3lQ7TBEBddrOy/lBkC3BTzmBleAARTJNoiW4iikNUWQRCsiPLk+Vy9UoPxCgeAXWkhK8
         6MciuQx19jtZtuSzp+7UiayOO/FQz5k0rp9fbOAuzVBOU83+8t6m9Lyy+Sk1LRmTv38t
         6IKQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793728522; x=1794333322;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:sender:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=hgC2jszRhcbrP1Ah6Vr19omv8g4IklUPg6gHa2W5Q9g=;
        b=qhBiXNjFvqEbkSZegJ62U7wOLssQAJ/IlqqWOXazdTWwPTa9kjSTIxB2CHDBl4jvl6
         4SXiKR1EYigYjsJmaihDWCZh1mHLkjFMAumio3w6k/6EyxC2lCzaMg/8xOMqxGkjIzbc
         pXBPl8Wt5kiKkphEGMBKbJiQ/gKYubkCXHtLIEIJXyO66ewpp8VSpaLJ8epjVBlwX6X6
         N0Q2AW2GmaleOLyesiksXuiCAoEN5cwDNzyngK8n0aeKYsTOGLVvgNX3nxHvmINQgKZV
         OctJw+m4Ql2MkeZv1itsHAaO+qvfBxR5IR3T1Sz/bqsjgZ1PQzOBn8IpS6R6yrSTTvNd
         rjMg==
X-Gm-Message-State: APuU4Z/UnC79VRWQ2bgmmVwcRumkMlwDTaDRTvOBwe/6n7PxP7bBED6F
	WHhAV25scgtWyy+43ltdX0na6T47BK/12GJ8jf2PJ/VnKb6hlg7MOa1oNeyOKQ==
X-Gm-Gg: AYBFou0qlOzLeJSmtQI6SYMs6bWbLikZ48R/RWty0mjEt3dTA3K5NoWrAv66d2n1RRn
	zrjX1qgBvTb3yn64iuGjWkngUKH689DPW/jTGf+yfCEVQJgRcgRAws2sPj0lCSsNh98XHJHVPbh
	8zoIZU211SQFr0m15aRQ8YuHgLGFD/2H2kRlSWue1WMgmKD6YCEqIECaijJdIN2FRf244Tj9zvx
	JQDe0fiYHkm9wIKuodYqLTbqZgS/zxPXO3TzkUIAGtZQ34nWfSshicOoJsq1UrnVSwwLyg1Dltj
	Oq8Fixsz5Tv6fTxvgbOjjRBFpnDGVPyZiG+EXjxbnfMB80diuVwDaFO0ynHUI4mX/buhWARlfGq
	7r/zS1Nj7dAbJyi9APvAeYZxCBybh4NXZlyhxT1p4mAKJLu+DVOz17rgSLQgJ5jucSC4uEm6RrB
	q8E/TltHbDUJ+uazjjt85R4dOGGqhpe1BtXW68mvFH4Q00N5+VFs2AA/bWCeXRU3n0D45M+TInk
	5caHvOe7TDUOIkSfx/sv0FwNgDnsl6nFEd0sIaN1FABiB7OHwiR91Izi3wXflsGLczZaubf3YhU
	WTAdgFSFtQKIOoCqKMRy3aaRNeePIWtLVId/pcUvkFDERbTTaFMxFtYUPz8DHce7AEPmlkBR781
	xRZoNNSxYjQZWOb+y/poj6dydapqq+K1BMao6Bm2yp4d9fkhQqT1T1WCXh+XN4NYd1xk9xrAc2A
	==
X-Received: by 2002:a05:690c:e192:20b0:8ae:a5b5:e97a with SMTP id 00721157ae682-8b2b66d26eemr57346977b3.13.1793728522178;
        Tue, 03 Nov 2026 09:55:22 -0800 (PST)
Received: from fionn.home (bras-base-toroon01zb3-grc-09-70-50-116-123.dsl.bell.ca. [70.50.116.123])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-8b30997aa84sm1700707b3.29.2026.11.03.09.55.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 03 Nov 2026 09:55:21 -0800 (PST)
Sender: John Kacur <jkacur@gmail.com>
From: John Kacur <jkacur@redhat.com>
To: Sana Sharma <sansshar@redhat.com>
Cc: linux-rt-users@vger.kernel.org
Subject: Re: [PATCH v1] rteval: Added multi stressor support
Date: Tue,  3 Nov 2026 12:55:15 -0500
Message-ID: <20261103175517.107723-1-jkacur@redhat.com>
X-Mailer: git-send-email 2.56.0
In-Reply-To: <arwPN52esmki-k_f@fedora>
References: <arwPN52esmki-k_f@fedora>
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

On Tue, 29 Sep 2026 at 15:19:19 -0400, Sana Sharma wrote:
> [PATCH v1] rteval: Added multi stressor support

Thanks Sana. The feature works - I ran it end to end
(--stressng-stressor cpu, and --stressng-stressors cpu,vm) and it builds
the right stress-ng command, with workers correctly defaulting to 0.
A couple of small things to fix for a v2:

1. Drop the unused import.

> +import argparse

argparse is not used anywhere in the file.

2. Precedence when both flags are given.

> +        if (hasattr(self.cfg, 'stressor') and self.cfg.stressor is not None):
> +            setattr(self.cfg, 'stressors', list(self.cfg.stressor))

If both --stressng-stressor and --stressng-stressors are passed, the
--stressng-stressors value is silently dropped (the single-stressor form
wins). I'd rather the multi form win: let --stressng-stressors take
precedence, document it, and ideally warn when both are supplied.

Minor: the `continue` at the end of the validate_stressors loop is a
no-op and can be removed.

With those addressed I'm happy to take it.

John
