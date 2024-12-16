Received: from mail-wm1-f46.google.com (mail-wm1-f46.google.com [209.85.128.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EF652206F2A
	for <linux-rt-users@vger.kernel.org>; Mon, 16 Dec 2024 18:04:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734372299; cv=none; b=IYkEwg5V18FflI+7GQup+nCacbX/64nXg48yiuzabToy5Bjp+mB74ZUISXbD6gLemPKmQxNgplJmgeO2dnzL4VybCezLGMCQgYhyOrHZbGqLPwHDRpnx6MD5UG2pnLSXPFZAG7bTXk7Nc/9JkjSMPlHmCeI/yE2C7x7chH0q6gc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734372299; c=relaxed/simple;
	bh=iOs5FI6zEidP9BtBYEtZr5/+t5mNOKsa4ooh7LnvxkI=;
	h=Date:From:To:Subject:Message-ID:MIME-Version:Content-Type; b=XrQjuwLuIMsTOIGk96E0bsgdxxkl4CEMkv14lMNiJ3tQGZMxINIbB4BdzNbpbXWF/7p88O5Q5c5r6lIHCfMMz8HRMUfxrb4H3vEfo0dHpy7vVmE04kMJ8BDJ96fnEgw869r7cLXDt2O3AQhLpmTcjsVqhhtERAhbr0c8m0S+8hY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=clj4o+ai; arc=none smtp.client-ip=209.85.128.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="clj4o+ai"
Received: by mail-wm1-f46.google.com with SMTP id 5b1f17b1804b1-434f398a171so3343345e9.2
        for <linux-rt-users@vger.kernel.org>; Mon, 16 Dec 2024 10:04:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1734372294; x=1734977094; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:subject:to:from
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=iOs5FI6zEidP9BtBYEtZr5/+t5mNOKsa4ooh7LnvxkI=;
        b=clj4o+aizrgraJKyNmgy51wnbIYZKFxDYMIXiAeu4I44xCI13cqbMHwLheEZ1AHfj6
         znj6Qkb5GeW92pdTKYP26AUVxs+0qQFCoLp2FkLtplBr+LyH26GDz6xSGS937Tss3E/c
         CxbeVDB8sa60jAsXLeP2Vp99H0k24uT94+uYwWs/xeZ9mcb0BXvAZf8OQi2/AHFScI7U
         AEmocWw4oztNInBhd66aRDoUhbgoaGNERqpvz8XwLFfH2b2jMQNbC2h8pRuNS+U7I9l/
         76nKMk3y67JsmW00cafkQbtD78S/XSXWjJVVAyY7JCb1u1Y0HD8uru/u+TVWom9SufoW
         968g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1734372294; x=1734977094;
        h=content-transfer-encoding:mime-version:message-id:subject:to:from
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=iOs5FI6zEidP9BtBYEtZr5/+t5mNOKsa4ooh7LnvxkI=;
        b=HYveSmNRGlB9rDiYiEC2Ob+0X+N0xAD9iZlCMZIop/aZwLqbymrf7xeSHxHJDJbAkE
         Vkp68J+PaTPq0KqIAT+dYMaySiHbtFfHw6jdx7nixzNi4DHwvnQQXPE8XsFYg+UgxF0Y
         6seLZTIJTGjwr+YkxjHxhH+DLzvBPgKejPht9Dc7rq5P8AuKSOTrO9AhYFDrbsMaCL7/
         ew24G4x+3h38ZTuNnBK06v/Hk9D5ixA9jgnUmX6Ap4hNth7AdcomGHT+f2Fm72PgZgfi
         qYMQjqHDIt3kKuY5hBITktDD4AhHAkmRKwcjgM0EQZyI6LpFipW3gOdt1pg5zDwsdKxg
         zf1w==
X-Gm-Message-State: AOJu0YxGB+jZ4uu6s7OpJGcaadGnlcRQQuo4quD+8AQmKyqbtmzzdce3
	bL3vPPLS/pifLMwKUnP9nQl18Sm9EiJOKBd4fKIBtXb3V6pbWmCIutCB1kuouR8sOw+HWsR/Izg
	V
X-Gm-Gg: ASbGncuFkE6WUoFcN9tYEU4sH7INQbN5kenb8gcSbje03B9td4707LrKA1lgq7D96kX
	FbtXRC9XAIINt9eAwbNo9rQy5M4mWp6WF/zadIDRJmYPkMSt+QUjsfeBBAxJ/W7YpBlh2UmwFZC
	B4GzkCg8z5sAv+tOl6l8oNQyfGQzeOndDrg8sGf1ASK5mFnqo4emJLZV54hOamsci45MKVNL97T
	jz8y3z8sZ1fIuik/N2ZkPVfBg2Gx2gpSoiXVMZ4LzfsJUHY7ro5fCv/WyaTxf5lCoH5ObbMzRJR
	KeyMQoPySI8wnGsc13YJSUgBpKxOrMJc5rAzM2eF94TH0oyZHlH2MrBzenkoSA==
X-Google-Smtp-Source: AGHT+IHDly+zKXWE5MTJ0lqN+fISGUFRWn5v/P++SQvOR+OlDg8i3oLG66SEgxqBZTMxA36P3AUHCg==
X-Received: by 2002:a05:600c:154b:b0:434:9cb7:7321 with SMTP id 5b1f17b1804b1-4362aa10a0dmr45566485e9.1.1734372294569;
        Mon, 16 Dec 2024 10:04:54 -0800 (PST)
Received: from mordecai.tesarici.cz (dynamic-2a00-1028-83b8-1e7a-3010-3bd6-8521-caf1.ipv6.o2.cz. [2a00:1028:83b8:1e7a:3010:3bd6:8521:caf1])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-436362c6afesm91577285e9.42.2024.12.16.10.04.54
        for <linux-rt-users@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 16 Dec 2024 10:04:54 -0800 (PST)
Date: Mon, 16 Dec 2024 19:04:51 +0100
From: Petr Tesarik <ptesarik@suse.com>
To: linux-rt-users@vger.kernel.org
Subject: Lazy preemption on arm64
Message-ID: <20241216190451.1c61977c@mordecai.tesarici.cz>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.43; x86_64-suse-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-rt-users@vger.kernel.org
List-Id: <linux-rt-users.vger.kernel.org>
List-Subscribe: <mailto:linux-rt-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rt-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

Hi all,

what is the plan for implementing PREEMPT_LAZY on arm64?

There used to be RT patch series which enabled lazy preemption on
arm64, but this architecture was "sacrificed" in v6.6-rc6-rt10, as
collateral damage of switching to PREEMPT_AUTO.

IIUC lazy preemption is currently implemented only for architectures
with CONFIG_GENERIC_ENTRY, but there is no inherent dependency on it.
So, is the plan to convert arm64 to GENERIC_ENTRY (and then get
PREEMPT_LAZY for free), or is somebody working on CONFIG_PREEMPT_LAZY
for arm64 without that conversion?

Cheers
Petr T
