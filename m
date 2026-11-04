Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.219.47
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793824279;
	b=4gY2Vy+ay7AfbdZr7Aq1hg2nMkLJTMqW/g44I1ZEj/sS21fkFUHAr6udMjMJD8nKlKME
	 Qb6o4ssFInWq0SAc1bevOBlJ8FdgTGam20nQS0ME0W1l+iodjVQEMjjQaMuGGj+5L2xX9
	 heQTrcibzhjt8S4oyfvoBJafLjAOhw3phXtsoLyB3vHh9hfH9H2frawqqRbqOtkaWfqds
	 SG0mfy/2jdJcpcpiuZ4gWuPTaEHnR3GMY1E8H9BYBX0v0KxRJ0KwjTrqd7jBMEzmk/ejN
	 nLOvrT8EhNRYA9pQLK7n4G8sqLlVY97gHEF1i6uxVAbawIJfmxCbRgcdlt/SjBAw3Hw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793824279;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:Sender:From:To:Cc:
	 Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Type:Content-Transfer-Encoding;
	bh=HkIXGFYdcqcJD/ei25t609T370Ykg+QmRbltr9zpKaI=;
	b=laU8aMfVJwHAb/Xh1ibvWlKrjOaszpqsLYaU7UYs8Jn2CB9gJK9sBKeRvvf16+Sj8o8J
	 MzOzzyV/UY+lzhoaeCL4k3d8WT8TehqQ0liPlhT9zC7p5URzjNI39Q//Ujf4MxeykbMrY
	 /69OvZvR48lqBh19lVF8fxUV83ascM9a4gTI90DQs0g9uXwzFjoi5HYZJ1Jo9u7uRO3LR
	 Garcg5Kn0qSxJMjm2NuSIfos6ep2HnUwI/6J2bcnucYk4f9NVAGUNAEHYic/MhZthDR+A
	 Lq70bdO5IpG1DdocN1FqOS5M6ZV5jv5Wux3gLvO+kGR3XAys5T+pR3ZqOvN2y0qRFtQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=fail header.from=redhat.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b="rWsL/fXb";
	arc=none smtp.remote-ip=209.85.219.47
Received: from mail-qv1-f47.google.com (mail-qv1-f47.google.com [209.85.219.47])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 069C76082BE0
	for <linux-rt-users@vger.kernel.org>; Wed,  4 Nov 2026 20:31:18 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 069C76082BE0
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=rWsL/fXb
Received: by mail-qv1-f47.google.com with SMTP id 6a1803df08f44-91e7af9a67fso8834936d6.2
        for <linux-rt-users@vger.kernel.org>; Wed, 04 Nov 2026 12:31:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793824278; x=1794429078; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:sender:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=HkIXGFYdcqcJD/ei25t609T370Ykg+QmRbltr9zpKaI=;
        b=rWsL/fXbeRZMhuFHqvBoky4w01CE+VrSVtGxBQdS9V+9An4+mgUsgwQGy6psjzlNni
         snVewIaxIjopvc3Yt+aem97EIofwubWlcYqGVRiDQfekA6tV9rwZwHdrN9Nc1CN6E8nQ
         XTJqLnsgr2MEvpmWcMIIisFDq4GBG7l+ez1FdZ1XMy4vVS0cBE+ajZp9T1X/fU3Ab2ZX
         f4Xo+5rn8/Pbt4wHQHLhMyfZ7h8MjmVZjH/rwr2bkIUtLABXpu19Yk6/X4RiTnwvC4g0
         ca66kby8ZbfZVXa1JCDFSd3m1VDhPQz8iv9qZjQxRJyvZXz9l8DfrGxc0Tjf4S1VkJ9s
         1wvA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793824278; x=1794429078;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:sender:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=HkIXGFYdcqcJD/ei25t609T370Ykg+QmRbltr9zpKaI=;
        b=bAtBw84kTRpOfekggmTM7oyPYX+5pG3Dsn6GJanJUB2I1NMWEbXDtVhSImXtk/sGns
         kj2VacNY7cqBVMYhcKpPqJz2U7FslZUXhG01LHfosO7q0HCALv5na1FJdgzKis1xeXsw
         5EbIh64HFVNj0HznB4E8+KD6iC08sajZiLMyTPVJ4T8KHjhEyV95IfITMANsrKnBgZUR
         dOaWSZT/5tqlT1jmo23Eq+BaslnXSDL0VQJHfrD2LdQ8jFmt2xDrlssQN8PjiwRAhPcr
         z4VsU8m1wuxP2fhlODPubMj2JoTxUEq27xXbXV6uOhq9Icw19R3+1itI8M52cFTojUQS
         Xs+g==
X-Gm-Message-State: APuU4Z/8x0l0VD/gKVl9W13U0zSDAGSpXIiH3X9SavymyQmQP9/Ojgjx
	x2GkhAHHetzOdUzS84jLe9Ehn0ILL9SU68fcobUM6LhxutI48+aXB6hB
X-Gm-Gg: AYBFou0HRQMVL9tKNRer+Tz05eI+774i2HSxydERDZkcmDC0y52nk/D+KfBEzuoV26t
	Y0H/RtkLhBj/ILlIXWsKdhMIt9ka66XVoDtsBFHSSNvy4kykbQ4kt10luF+HsPOkMepZPFeTA0C
	ICjSbeVpnVA9G+LwlOQz6JVbkbw6swOLE/Qtmn2Wv8ldVyU+2NWA3HALfF3n3LOBpPbkcrLzI6J
	hCCOWaAJkgVx0/JiWKn64JIznN5kTSemz8YcXmABO1IeTNUYit+mcALDTVemXRraYynnDuRGgoD
	bgGKwnPsHM3fxK+6pHoTRBCz5i+nx6LF+XKxhA1iu4+Tq9Rp05sTsGZHRgyxFf7UwjFBOzdEdzS
	LM8D2f8q9LGqJ814sYd0O9/ZWebZAeZOzlvnkAaao5C7QYW8C1hvPbs3ws+3NYB/8VGxqEi8EMA
	MKq4K7r1rhH1WJj06rYDwFCiJMGY376CJNBvjuiiE0rHyGmxU3d0BKNgvdPSvC09AhX1LeZvhCf
	adNSnK4dvaQYR2zUvJZgBIIiRe1oZwzMY/Wspc+6Jq3EQFsjPdnYbINg8TUZM0BC9dNiN3Fb3FR
	x9wPlOvV1MZ1CHV+sbAOg9s7hpHXmpNw2Qudkg6WDNdmoOTGA8qLrYImzXf7KubQdBy9F254s48
	hMhWZNKqcpLMPqWP7Nhkab5VdVFjepxDbXwH0bw==
X-Received: by 2002:a05:620a:28c6:b0:93f:22be:8daa with SMTP id af79cd13be357-944215422a7mr2814090485a.11.1793824277816;
        Wed, 04 Nov 2026 12:31:17 -0800 (PST)
Received: from jkacur-thinkpadp1gen2.rmtcaon.csb ([70.53.46.49])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-945d4854ea2sm289853085a.32.2026.11.04.12.31.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 04 Nov 2026 12:31:17 -0800 (PST)
Sender: John Kacur <jkacur@gmail.com>
From: John Kacur <jkacur@redhat.com>
To: Khem Raj <raj.khem@gmail.com>
Cc: linux-rt-users@vger.kernel.org
Subject: Re: [PATCH] tuna: Do not import tuna from setup.py
Date: Wed,  4 Nov 2026 15:31:02 -0500
Message-ID: <20261104203102.49920-1-jkacur@redhat.com>
X-Mailer: git-send-email 2.56.0
In-Reply-To: <20261028061243.4061773-1-raj.khem@gmail.com>
References: 
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

On Tue, 27 Oct 2026 at 11:12:43PM -0700, Khem Raj wrote:
> tuna: Do not import tuna from setup.py

Thanks for the patch, but I'd prefer not to take this one.

Keeping the version in setup.py is deliberate. A downstream build
(RHEL9/CentOS Stream 9) still builds via the legacy setup.py path on
setuptools 53, which predates PEP 621 and so does not read the dynamic
version from pyproject.toml. Dropping "version=" from setup.py would
leave that build without a version.

The failure you hit is specific to a setuptools whose build_meta backend
doesn't put the source dir on sys.path. It's easy to work around without
changing setup.py:

  - PYTHONPATH="$PWD" python3 -m build --no-isolation --wheel
  - or build the legacy way: python3 setup.py bdist_wheel
  - or use a newer setuptools, whose build_meta adds the project root to
    sys.path and builds this unmodified.

Thanks,
John
