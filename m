Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B430F352F82
	for <linux-rt-users@vger.kernel.org>; Tue,  6 Jan 2026 17:22:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767720158; cv=none; b=XxiPUe8Q/11nHGNuj2IkqkvCgeATd46v3KuPvdlcyL8gmicq/AGM7EqIr8uuVJxjCSvL42D9IHAq2aqV3QQQESZRwUXe1JUA7jz2KeKjfx6vvhwzwNjRPYKAVeWKzrxNrVezqfaoX0b6ClMHBjLK0QxAdBX/wGz/gZFPLKNoRm4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767720158; c=relaxed/simple;
	bh=HMuqPs8sksL+amzn6unx4UxBe9BooFI+hnx5+RPjWMw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=aZWnjH4oAibTVFeYjFp/bujhbu6atVNGUfoyjZ0vmvCLZ9DVlN9C3vMAHCOfqfba2CfUDdynHqgDp3JKxDMxPipx+m+YIXcjacWWv266NTC0c+lLEUJgFHIHku5cfDAhaK3t3uNQRVNwkIQEuGLI7HJTZQYfM39TthCfnxzs7Cw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=GkvSPqyh; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=CG7lZUXJ; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="GkvSPqyh";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="CG7lZUXJ"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1767720155;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=HMuqPs8sksL+amzn6unx4UxBe9BooFI+hnx5+RPjWMw=;
	b=GkvSPqyhhlM9DGU4L9gr69+MA65i7CLb2BbjNovPGwCzDlV7hOyu58w/kmg5xAEYk2qHwR
	/5Q7LcmLFQqnIPxK86w6T1kxBr5ZDCYqufdSv3bfUaldprInfu8weIDWy0+y0dzXMOrn2a
	vDWVSHfyzpHf4xOpDg/jhS5XrhrAATQ=
Received: from mail-ed1-f72.google.com (mail-ed1-f72.google.com
 [209.85.208.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-479-4ldWzfPRNhm_G-Z5JqcQXQ-1; Tue, 06 Jan 2026 12:22:34 -0500
X-MC-Unique: 4ldWzfPRNhm_G-Z5JqcQXQ-1
X-Mimecast-MFC-AGG-ID: 4ldWzfPRNhm_G-Z5JqcQXQ_1767720153
Received: by mail-ed1-f72.google.com with SMTP id 4fb4d7f45d1cf-64d589a5799so1890929a12.1
        for <linux-rt-users@vger.kernel.org>; Tue, 06 Jan 2026 09:22:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1767720153; x=1768324953; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=HMuqPs8sksL+amzn6unx4UxBe9BooFI+hnx5+RPjWMw=;
        b=CG7lZUXJzKPPqZi0nZwzcmqflzjhosMQd5cLEuAFL8OfoOWUaeqjTLjFi6HsqBT917
         S/61Qq/dNFTw8KLAV+tCAOTL4WcOky4805sAuscviTW4EW9ChzRCxwzcvrh49MqUF7CA
         /39VYkRl26i06viPeYjlzY/9I6MPFNHORRpwlXKLRAoN4nmFCESFr67ugMaLwU3dGlKg
         4m1ki8XfdwfW1BUBd8+WXhZOuO1mkR1BoEWCRkthEe7rf53MMa41GMVEK94NrP4AkoHE
         yInQpVaEankBSSAamkCwWhCq8OiGtDuru1lyveoC3Pw8HiArm+WmzgLQRu+qFfAMg0Nf
         D5aw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1767720153; x=1768324953;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=HMuqPs8sksL+amzn6unx4UxBe9BooFI+hnx5+RPjWMw=;
        b=Mvvjz4QmOwHR+5/QM1+4puIouNuOC6znT+zRzvS1L5sSiWUNp5Ku7j/Qzx7Zv54f1+
         KsMp7GBHFcn0Mp83+5vIfY10Qbcme4QONsNDQpZIOnYEGSxSYMf5v+TAyJOYPl81Zj5Z
         kfkgMl5BnGYV1rqGwakygDg5gCPI1BUXoti4K387/GtvE15rVF3aMZGkF7uF6hYSRHcm
         gQwr/qTn1ZLpOcP23fbNdWkiAyyEH6xaaX8RTk7Kx6hmEaSM3X0HXIl55DoSPyUIbFzu
         7p7AhAnMyGjDA2r7r+bVm5gzPpLgMA2zYM8Fvz4vjt6R51Zrn4P7tX/C8j2cffZ+1qKT
         28/A==
X-Gm-Message-State: AOJu0Yx/pz1a/1TE9INE6bAuebxopOD++Kr1l/fpNTWSV8ph0AiFlG4i
	1UrHBA4selthWAwK+6dUVgs+jznhgzy83oRDxoPoW/9YjIQT7Wher/lCrgasjOeonnxtvPvpWOh
	TWt3Pxp6DSaVGmeK26FtjgtzTLlu6FIXMNlXa0sZVkRBMjjZ4gywe79sCDiis0Awg4YK3HoLGUM
	yuP5kkykT7lYIg48pT7HmStBAoWbzi0r2YlVmpplqrpCU=
X-Gm-Gg: AY/fxX5XcJYaBficTCDY2lfcUN4oMoxZqTps3hvW02JMUcgUhZjUhun2unpuYTp1+Bb
	QBXVFi10+JA1WElM8IauxmSvGln5FXAcodDhEZ27v3RnAN7UsRpI4eBxFmz3d1j7kyV5sALvh72
	1cSn/ry2ZYmcg1QMvfrhzjPujnSLrK3OSNnYsFlzP5IGQDSPJ9ihb+TELqvuAQi+O4ZpucyQ8bX
	ealZc0khiKoCMhQx/SymrwuMQ==
X-Received: by 2002:a17:907:6d21:b0:b7d:1cbb:5deb with SMTP id a640c23a62f3a-b8426a9f126mr413410166b.27.1767720153274;
        Tue, 06 Jan 2026 09:22:33 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFzrH+6exGh2W/jni5oV1i+Lavfxe5up6EKfWppuPuNw2A3I/qhImjRcFT9R5JPG8sM6YKDOHPhiTdQXGa512Y=
X-Received: by 2002:a17:907:6d21:b0:b7d:1cbb:5deb with SMTP id
 a640c23a62f3a-b8426a9f126mr413408466b.27.1767720152926; Tue, 06 Jan 2026
 09:22:32 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-rt-users@vger.kernel.org
List-Id: <linux-rt-users.vger.kernel.org>
List-Subscribe: <mailto:linux-rt-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rt-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260106091023.1375803-1-costa.shul@redhat.com> <aV0N-zTclZAwy1Fv@redhat.com>
In-Reply-To: <aV0N-zTclZAwy1Fv@redhat.com>
From: Costa Shulyupin <costa.shul@redhat.com>
Date: Tue, 6 Jan 2026 19:21:54 +0200
X-Gm-Features: AQt7F2oO4XhwDnl62f4iFsgq6b4gVNPL2hxhIYAeGBg_fvsgCZOwthGKR4E6YSE
Message-ID: <CADDUTFw827s74y0tqkASk1+dobSP05_DQc5Xw9Y8qUC+O4Y8Ng@mail.gmail.com>
Subject: Re: [PATCH v2] rt-tests: hwlatdetect: Add MTBF calculation
To: "Luis Claudio R. Goncalves" <lgoncalv@redhat.com>
Cc: linux-rt-users <linux-rt-users@vger.kernel.org>, John Kacur <jkacur@redhat.com>, 
	Bart Wensley <bwensley@redhat.com>, Clark Williams <williams@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, 6 Jan 2026 at 15:28, Luis Claudio R. Goncalves
<lgoncalv@redhat.com> wrote:
> But that only makes sense if identifying/classifying the latency patterns=
 is
> as helpful as I think it is for debugging.
But I don=E2=80=99t think this is very useful, since we can barely fix it.
I once observed strange patterns on a preproduction machine.
In theory, it is even possible for process failures with FFT.
The next patch I plan to submit will print the time delta between samples.
This patch depends on a previously submitted one, which has not yet
been accepted.

Thanks.
Costa

