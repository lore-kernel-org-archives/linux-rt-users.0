Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.219.45
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793653760;
	b=wVRkLAXNAXrVGfRF4xf3OQRnR5UTCUqJ9VZrtdCqZs8bDQ7C2B50fSx39CoLiMehD8a0
	 RXru/CQoy7TQq+oxtz5Wu50w4xmAMruatmLI3km0znyThK4wsG9m7VQhcWo0+b46KhzTT
	 jGaR6287475r3cDKJ5MLxyUHrz4Cn6+K8Z+sw+CO7FAhSi3SpsRSjxJX8Pmki/EcuzXm1
	 /TYbxUvuX9AI7R2ZWkHCvC4u3KigsAhXHDuBzUawTVzojwydxHfosWZMmWqIKM1c9k1sP
	 B4SrOdXmkLgRwJoJ/moc7FJ7Qe3j/qPT0F6LiktUarj9D3oGdubyqUi9/pumKJPJCYQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793653760;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:Sender:From:To:Cc:
	 Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Type:Content-Transfer-Encoding;
	bh=b4HNXk7a1WDB2Y77HkTIftoKOAfBuPm6gIaFkuxHZ7g=;
	b=GeO55VPAGaDBM8/aWDK2+lNZbMcmuKbQ9N/eT2HM0TJCpwZxejaGAynA1Rf4l1/Q3I4r
	 VBoc4rYpslgHIc6zS9u0qZG5biQI6IeGRSRgKdDf3E4i8FcFZIevkZX79rGEVNM3ZyC91
	 LKr1zyfRzWMUu0oNDnKm7Eoormm/eGdRS99kVlBvkjBrOZzyeVEPfuRTtNOj1alQbagXt
	 UniRLdC80AUNmbFSIqHK+7R92ku7NqjcgTUtWInVfFdOIW3FHKQ4cmUOKFb9KoeIx0Rsz
	 1EvmOaz6s0o4pn2l8SwLcaSO0HklU678hlyylleJBMkBepSlafZeXa9AYpIWocLKR5g==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=fail header.from=redhat.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=i4S0UfVg;
	arc=none smtp.remote-ip=209.85.219.45
Received: from mail-qv1-f45.google.com (mail-qv1-f45.google.com [209.85.219.45])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BAB5E606A324
	for <linux-rt-users@vger.kernel.org>; Mon,  2 Nov 2026 21:09:19 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org BAB5E606A324
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=i4S0UfVg
Received: by mail-qv1-f45.google.com with SMTP id 6a1803df08f44-91c791d5460so40086656d6.0
        for <linux-rt-users@vger.kernel.org>; Mon, 02 Nov 2026 13:09:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793653759; x=1794258559; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:sender:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=b4HNXk7a1WDB2Y77HkTIftoKOAfBuPm6gIaFkuxHZ7g=;
        b=i4S0UfVgT0tLI6AkAkzQv6yIi3yZdOVkcN+dtbY5iXNNEAR4R/iYonX09X1KYHPB80
         n9OXmwiV//FaoFdJLSpiSMkIlgh3OjA0GLwZqfosO+tuFWJ8EwSD66PepoJv4fXfkJ4M
         T0+D243w37UvKQmB/aIRThhRDlUhK4k9BI6lbjXBJP8hlXWMWAyOjtWWb3Y64uhdihK9
         KjK90hqCTaOR5FZI9o30pjnud6V/VlZhRCfsx9GVmVbu7wlBZRwprLxT7GSW5nC0YIMN
         IH8F0i6jOKDWahNcIxvueoV5oMP6aN3pvHj5GNCheeCgwEM1hR2irL0TsKPAKI7GXJFW
         akWQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793653759; x=1794258559;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:sender:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=b4HNXk7a1WDB2Y77HkTIftoKOAfBuPm6gIaFkuxHZ7g=;
        b=L2GQuAk6WVHu2KE9qAlkJ8akefpg8+cHsMRcMb9kJVVfT166+rqa/otGpVqTQhQ3wd
         WxGz4qdLPQjeCEO+HdJv/7l/YDs6qc+QK+Gb2VxJiYMRu9TDfzpnb6nsXk9LAD1fS5W3
         Hl/5lP5o/GbJo1h+lHte/ZFZeQe6kK410t3anOtpvJt8zwSqGRgrrs2eQpM9RyuZ7BLA
         geAKzlIFMw9RSJ8nd+6IAWCHq0A8/gL0OqT91+tH8ETJnxZKar2kPFVeu4t3JNs9v2mj
         HQnuRZnnSmo2E0hmEg6KakbvmTRzZeN6bWqdZL9mQ/5Dv76dlCFVDXbLKtxpBp/EAr0e
         dvbg==
X-Gm-Message-State: APuU4Z8n3PmhFSh7yzmcJJQlhSsHe97+iGz/ex/dJ4XL9bd9B8wwvZEh
	3Fpz61K+t61DbZ5KF9PMzF7sRKXYOC4H10BaFzqgM0JNsRT8wNG4T9eK
X-Gm-Gg: AYBFou0wvg5uKkZaaVYT9bybXdpgsj51SRjRt3xbQLwX9yeSgCmXEI/PR3RdFYCHTjZ
	CjOMrZf8JtKb8u7UUes+gidr33wIK6Xs08wgbUSDwTT+gNZAiowatN5YjvNUbtMxsH6+Hx3Srgp
	+PkDTMCewkXnpa8Tc9AJqkFVu/u2FfrBQe6Dgp3hs7ID6AwX1bQk4bR+u1zNt8VkMu7f2Dd1nIg
	u/8V7V0dvmZn2ayercMAYesXDu15wzxZE+QT9txrmwdXiNx9gn0z5qA2hYOQ6FGTx78aBcpMuaM
	ysKBzCVzegn4LZL+kd1Hvt++/CAdiK6bHPM4LcXiuCvE1r/EntjDu1GVfcYuoEdfYpHs+q5LMpX
	AsiYSYdlTAYDs+DxQpETXIviKDegq+11oVuxFYrj3bqI1RPHv5T/ATO7kOXZBrMsXP9jqPQiwh4
	iPHjhvghDqFvcUe2c30lWcJIHgiZK+ocQLkEF6cMyI6xv1mkalBxgBbzMhmrch+8Z9jdA+LGgtb
	FRQbLkUQgsAHuyHyHJb2YE7BjDL4ydRxrxev35dFQW4xeTfsnhuiDplnqglEAw+mThABzes9oeA
	ELSr6qlv6E0h7t2z67SZSo4Bh/dUo6+V4jl+RnC2dK+kyAToJuWWTQIqIkOdl5SWMBest80gnrB
	rnbofI1YrgezqmzBIuh92+IGoau/DzGGIlaBIuqE0osqDaYY0kvyxGcQSkIbYUyTN3PSejqbLkM
	kj3HmP3u87ZXuD+5sHx9VsYkCfrQY=
X-Received: by 2002:a05:6214:1310:b0:91c:62b7:296f with SMTP id 6a1803df08f44-91ca4b933a7mr175951756d6.50.1793653758617;
        Mon, 02 Nov 2026 13:09:18 -0800 (PST)
Received: from jkacur-thinkpadp1gen2.rmtcaon.csb (bras-base-toroon01zb3-grc-09-70-50-116-123.dsl.bell.ca. [70.50.116.123])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-91ca7f4367dsm100705856d6.20.2026.11.02.13.09.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 02 Nov 2026 13:09:18 -0800 (PST)
Sender: John Kacur <jkacur@gmail.com>
From: John Kacur <jkacur@redhat.com>
To: Costa Shulyupin <costa.shul@redhat.com>
Cc: linux-rt-users@vger.kernel.org,
	Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Subject: Re: [PATCH v4] cyclictest, cyclicdeadline: Exit with failure when breaktrace threshold is exceeded
Date: Mon,  2 Nov 2026 16:09:13 -0500
Message-ID: <20261102210913.89391-1-jkacur@redhat.com>
X-Mailer: git-send-email 2.56.0
In-Reply-To: <20261001101121.1451706-1-costa.shul@redhat.com>
References: <20261001101121.1451706-1-costa.shul@redhat.com>
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

On Thu, 01 Oct 2026 at 13:11:21 +0300, Costa Shulyupin wrote:
> cyclictest, cyclicdeadline: Exit with failure when breaktrace threshold is exceeded

Applied, thanks!

Signed-off-by: John Kacur <jkacur@redhat.com>
