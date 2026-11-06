Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.222.169
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793999783;
	b=T6VVDTBccggNg8fbIWy9Xpw2wmpIsAh4O7RTI29XMgcKhMkuc2V1Vo4aFoWseBYgrb1F
	 d/VhCn/C2JU8kIG7f2MMSgK4S+fm6VPyuq69YHHQ9WaZOU8jQtPp9AADw+yypljjvWvJn
	 GO/oWo6NirK7LUCtHI1VGbpEpweiH73At4iZ96m1KHyLI49iUW5ux/3XbIXxUbwBRTHJg
	 GzHDI86av/AtB4SPoUVWG0dCKV8BbWy7RPvsUB36FGJs7odkR13sLkh8dhBfg96a6nTWi
	 znvjU0Ar6yXlAyGUZBIT1Z8nxQ6ctgb0uswKL0ZjdVgCu1PHMfb6TfNpr9nEhC8SU1w==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793999783;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:Sender:From:To:Cc:
	 Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Type:Content-Transfer-Encoding;
	bh=o+tAnYhMV/PpDHtUbvxr/0AV4B3um6pVyx54Im44qIY=;
	b=GYY2nD9AhBt7hzjMRqt+oYGV2VioeBf+CUF6QwJTPGAorTKoEgjUzZgx24g++vjjDfFM
	 uhozqkA8FlWHeLlcDHJBbZZETtLlTnt6rOiv0l3IlYwex1Kx6nvNkP6aXFUIny1DkW5/8
	 /V3VfLwdcli8sYRHCcJ/s54WwsZiLnwTQTdyi9efW17bY0JyECDfe4KbfjjapVeHO1lq/
	 IGHaHNR9kz+J9M1s6+Yhqc0/FUfBn+sWF0u3g03khBArWs2tLdZ0TCVBlEjlFKmfKJeHI
	 fQ/JgVa813BPxf14c6eB09EVlIFoaAkDJLE5oinp+pYRFiEN0bP84qnSfVL/5yFTZ5g==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=fail header.from=redhat.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b="P3/o1Y7O";
	arc=none smtp.remote-ip=209.85.222.169
Received: from mail-qk1-f169.google.com (mail-qk1-f169.google.com [209.85.222.169])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F0F01606A329
	for <linux-rt-users@vger.kernel.org>; Fri,  6 Nov 2026 21:16:22 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org F0F01606A329
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=P3/o1Y7O
Received: by mail-qk1-f169.google.com with SMTP id af79cd13be357-93f20b304c0so104157485a.3
        for <linux-rt-users@vger.kernel.org>; Fri, 06 Nov 2026 13:16:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793999782; x=1794604582; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:sender:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=o+tAnYhMV/PpDHtUbvxr/0AV4B3um6pVyx54Im44qIY=;
        b=P3/o1Y7OWPCgEG6DKsL+fm4uWdmR/9dS9RtiVuKwTIrT9Z3lZD7EsSrXYGIuW7fEqJ
         FVN1I1DzVnmn2d//4vtqlfUcDHVLtMJtYaHPAB6irKuBBwnIc0kieyA0wE/4/RkaUaL6
         k2z++EqWXOCpJc4LsGvErXBhS/+hEFPtP/sqrh9kQEqQuDmBKgSC0Hv9upX1MqrtZYYL
         KhetoIxmCc8MprpLGkEkJPBIa2s7sdtcP46iZWyfKwjA7Hsv+Fswo8Rmp8q43H5iRv1M
         UYW0eQKblWETI8VM357I2Gc0yBgoc+1IAZHfSlkjKm27zbqrfBfRJp8LkLqlQ9EZdzyY
         +V9A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793999782; x=1794604582;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:sender:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=o+tAnYhMV/PpDHtUbvxr/0AV4B3um6pVyx54Im44qIY=;
        b=sAoBRNdQi4UlBg1sdQPG6dfKmi+65NsjThfhLbB6C0fU6ItRPAfYZsgE0yc9Oybh2l
         Uy2WVwnJ6Y5/1TzE0Cara2IRQzzvLQ/EVeGy6yxM3K+leEGB+mTS4xG0PLNzoQdqAXjT
         C99vEwSYQPUtPEOb24LktNgPD3D+yhmX3D3BuaMsIrUCYrlKwtSmF4WohhPrB2xaUUhV
         JV80hHW60HpiCwB0Iz+H9w13qlg8Ue/ligpfdHG8Md16lXRjpHE2E0Tkih+/S/wcqjKe
         9nUN/ohqxKu922mb4jmCkXU20vQRvAURxK14+dCJt3UP1Na9riIXDc6T0qIIrQZdp038
         4OGA==
X-Gm-Message-State: APuU4Z8h8zrem1hRnmuk02DcFpxWrgnNWLgTiTrg/94dnZL1YjFBo+K0
	o8do7mnxBe7N0imcns4RUksIAeee/557YNL+uukOzSV+YQS4Ha0w9d+q
X-Gm-Gg: AYBFou2ErGyigDtYbggOcOeb8qtBUxkgQSXoJSxIuNBIoI2nCFnlKQhHYNEH9gD5wi0
	G3gfu8VyBwulaBADETNiPZ/gHBHpHOUCi/Xn4f51lY445ro3hh+kt7EM5rMoiDE5PcP3fGPFBB/
	b37aq9ZPn6Jcte1pnJRO3YAxSAp/OU+IqknRAiTpTa2OGaxkKH8c2ViUmvynW3L7XgBxceU4IdQ
	YEExF41wa113NJLjLLTa7XMVBFam3ppviopKCFpjvVrmD4ugLCRGO9gXClW5yz1/w+PxDg5qLUi
	nh2Q/vxVox2w+2gIfIHa6DIXnRopmPFyaRpjHJfi9mJUgSjb716O4dfvMf1cGwfQR61O3tD1azs
	Y+ZSf7UPrxSPSgC/+H4fqcFF76Yl1K+5kgyHFKVm6XlDeiIT90RctG9nUQSwIJHT6wRGPSabXO3
	W7FKAi3TXSJBvAXPjAVNJTH3Isnm+iXQZRp4r+GF1Rsr9S7Ji42HfNMgLyHRua7dRL83PNC4444
	t4xdvVBO08rGdviC65cqMka/Xhzp233qxzqq1AswvQn8LW5AtID85TVUJTYDVPwMqGgdqHASQ+e
	/2/40nSb5JkNCFXNRmHnxAoJswr6AS4OOn+BR50e4ctRwBTj2GUBAl+BrPxhEXifLNakoA5kwDK
	4Co6k2nEMzdfnZGkaBTdHDYEyMYW7XIKCLUrg
X-Received: by 2002:a05:620a:26a9:b0:936:df48:d507 with SMTP id af79cd13be357-945f3464c12mr596685285a.18.1793999781713;
        Fri, 06 Nov 2026 13:16:21 -0800 (PST)
Received: from jkacur-thinkpadp1gen2.rmtcaon.csb ([70.53.46.49])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-945f5a95e82sm229403985a.12.2026.11.06.13.16.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 06 Nov 2026 13:16:19 -0800 (PST)
Sender: John Kacur <jkacur@gmail.com>
From: John Kacur <jkacur@redhat.com>
To: Sana Sharma <sansshar@redhat.com>
Cc: linux-rt-users@vger.kernel.org
Subject: Re: [PATCH v3] rteval: Added multi stressor support
Date: Fri,  6 Nov 2026 16:16:03 -0500
Message-ID: <20261106211603.119181-1-jkacur@redhat.com>
X-Mailer: git-send-email 2.56.0
In-Reply-To: <au38NVNsrCvMozbX@sansshar-thinkpadp1gen4i.boston.csb>
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

On Fri, 06 Nov 2026 at 11:11:33 -0500, Sana Sharma wrote:
> [PATCH v3] rteval: Added multi stressor support

Hi Sana,

Two things to fix before this can go in, plus a few nits.

1) Invalid stressors now dump a traceback instead of exiting cleanly

> +    if invalid:
> +        raise ValueError(f"Invalid stress-ng stressors: {', '.join(invalid)}. "
> +                        f"Run 'stress-ng --stressors' to see valid options.")

> -def validate_stressor(stressor_name):
> -    ...
> -        print(f"Invalid stress-ng stressor: '{stressor_name}'. "
> -              f"Run 'stress-ng --stressors' to see valid options.")
> -        sys.exit(1)

The old validate_stressor() printed a one-line message and called
sys.exit(1). validate_stressors() now raises an uncaught ValueError, so
a user who mistypes a stressor on the command line gets a full Python
traceback instead of the friendly error. Please keep the print +
sys.exit(1) behaviour (that also matches get_valid_stressors(), which
still exits cleanly).

Note this also affects the test, which now asserts the ValueError:

> -        with self.assertRaises(SystemExit) as cm:
> -            stressng.validate_stressor('bogus')
> -        self.assertEqual(cm.exception.code, 1)
> +        with self.assertRaises(ValueError):
> +            stressng.validate_stressors('bogus')

so the test is locking in the traceback behaviour. If you go back to
sys.exit(1), please revert this assertion to SystemExit as well.

2) The "workers is not None" guard was dropped

> -        if self.cfg.workers is not None:
> -            self.args.append(self.cfg.workers) #default is 0
> +        workers = str(self.cfg.workers)  # defaults to '0'

str(self.cfg.workers) is now unconditional, so a None workers value
becomes the literal string "None" and stress-ng is called with, e.g.,
"--cpu None". The '0' default usually masks this, but it is worth
keeping the guard.

A few smaller nits while you are in here:

 - Please use the module logger instead of warnings.warn() for the
   "both stressor and stressors invoked" message, i.e.
   self._log(Log.WARN, "..."). See AGENTS.md - warnings.warn() can be
   filtered out and may never reach the user.

 - The hasattr(self.cfg, 'stressor'/'stressors') guards are always true:
   rtevalCfgSection.__getattr__() returns None for missing keys rather
   than raising, so these reduce to plain "is not None" checks. (The
   stressors branch just above omits the hasattr, which confirms it is
   not needed.)

 - The trailing "continue" after invalid.append(stressor) is the last
   statement in the loop body and has no effect - it can be dropped.

Fix 1) and 2) and send a v4.

Thanks,
John
