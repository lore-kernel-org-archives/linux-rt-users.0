Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=80.254.189.73
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794329044;
	b=znyESp7Gd6DpHSCCGDn0B61bHTxYh/IygTEYmbBsoreFjx/CKc3K60QDQkup9l5IPGHo
	 9Ss+10vaAjO2z/uV24CZ4pMddxgQAckUXcwZ52tr+Rh51Mct1HTK5QKBWc+mjax71Tsdw
	 n4bwBEz7FUqCkb2Lt3A4e8ntIPGemS091MfQiVX80WFET7lo7n+CMVaocrR0apu6OuU1l
	 Uph4+NfWhp5O6WiMIPnqIO4+rHovRTunlQrO24QhWoQhxJLJM8lvh3n0BV6RsuwKaiknT
	 +LHPJhRTwGSY4ygJLs/+ksYl3ct0xe9Rl56ls8FXUzkZtr5NoYBiRE1qoYO9mi1k2VA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794329044;
	h=DMARC-Filter:DKIM-Signature:Received:Message-ID:Date:MIME-Version:
	 User-Agent:Subject:To:References:Content-Language:From:In-Reply-To:
	 Content-Type:Content-Transfer-Encoding;
	bh=vyzmlL43AdYNOwktR3n8rzVJn8F633iMenDGmRJRtFc=;
	b=u6C20Og2hIM2NWm39+4x6SoiiOKxOA+6GSSYChsM+S5wInuQRN0E7TCEHqGy08Dnp2xk
	 k8jyGPrU+/l5RXB5De6nPOzWi7ykU0K+9fiocVBHDunAerANEcU7wzYL4vUQVoS2ArcPf
	 Rjoumh75e308ch7LSUeBeEDt2vXngeeq1loJmKvdklCnZdVMtlAjQsXi3Im9JfpycTLr2
	 ozUcSdkNL0Sykl9xe4DcRwwj+C+4PTusZg9Vd+XMEisyca+YQC+d0+Cc07Sj2kGeTY+OO
	 nScR174EqvtPpsLWXl960vCnc6x8aG3LvwKmNVTnqVmkmhm/SqsUKWIgwJrgcjhpefQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=maurer.systems;
	spf=pass smtp.mailfrom=maurer.systems;
	dkim=pass header.d=maurer.systems header.i=@maurer.systems header.a=rsa-sha256 header.s=2021 header.b=ByXFO7C9;
	arc=none smtp.remote-ip=80.254.189.73
Received: from admin.maurer.systems (maurer.systems [80.254.189.73])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8547D606A31C
	for <linux-rt-users@vger.kernel.org>; Tue, 10 Nov 2026 16:44:02 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 8547D606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=maurer.systems
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=maurer.systems
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=maurer.systems header.i=@maurer.systems header.a=rsa-sha256 header.s=2021 header.b=ByXFO7C9
Authentication-Results: OpenDMARC; dmarc=fail (p=quarantine dis=none) header.from=maurer.systems
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=maurer.systems;
	s=2021; t=1794329040;
	bh=vyzmlL43AdYNOwktR3n8rzVJn8F633iMenDGmRJRtFc=;
	h=Date:Subject:To:References:From:In-Reply-To:From;
	b=ByXFO7C994NttGqpnK8HN3VS4Hj9ZJE+cFQwE1W2A5iJa7esNpm384S2qtyvG6I0W
	 mGDaUXDztAVQlU/Z5gc71cZduIsVxsvfuonIsEQ7LjY4Hx6sSe55FN0zryOGM7q/Up
	 6X+B2kL+4vT2rz0FUF3UOCLKK2Aar2w82hMwsvEazZp4vDNaUy2QPdnQ1vH9PRe2MH
	 yzmNuIg0J6rvN1cQKE5V+UEwAVuyHp9zQyoiOw7fTORjTEW5O+nhnlhp3ag89kut9z
	 4m1exJb6qsHKa8tXlinht7pma0IKZpm2ad1bk/ot1zr6ht1Tu5YtKBaT4fYrw9MIgw
	 Bta8HJkTjeCQw==
Received: from [IPV6:2a01:2a8:8108:e900:8c28:9433:3ce8:909e] (unknown [IPv6:2a01:2a8:8108:e900:8c28:9433:3ce8:909e])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange x25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by admin.maurer.systems (Postfix) with ESMTPSA id 04041480349;
	Tue, 10 Nov 2026 17:43:59 +0100 (CET)
Message-ID: <d2036a5e-7d39-467e-924c-f37388d66d56@maurer.systems>
Date: Tue, 10 Nov 2026 17:43:59 +0100
X-Mailing-List: linux-rt-users@vger.kernel.org
List-Id: <linux-rt-users.vger.kernel.org>
List-Post: <mailto:linux-rt-users@vger.kernel.org>
List-Help: <mailto:linux-rt-users+help@vger.kernel.org>
List-Subscribe: <mailto:linux-rt-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rt-users+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-rt-users+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: Real-Time Inter-process Communication
To: John Ogness <john.ogness@linutronix.de>, linux-rt-users@vger.kernel.org
References: <14a6b7b2-8b73-4905-9aad-c2bbdc78f4cd@maurer.systems>
 <87bj7wj4u3.fsf@jogness.linutronix.de>
Content-Language: en-US
From: Simon Maurer <dev@maurer.systems>
In-Reply-To: <87bj7wj4u3.fsf@jogness.linutronix.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hi John,

Thanks for the tip! I'll give the RV monitors a try.

I don't expect any issues, though, since the data transfer algorithm is wait-free and only requires reading and writing a few atomic variables. Furthermore, if both the producer and consumer are polling, no eventfd is needed, so no system calls are involved in the actual data transfer.

Nevertheless, it will be interesting to verify this with the RV monitors.

Best regards,
Simon
