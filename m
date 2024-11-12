Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 64F69200121
	for <linux-rt-users@vger.kernel.org>; Tue, 12 Nov 2024 14:53:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731423195; cv=none; b=rxQ738ic4mteCb4CCPdR8PjfUKMmG8NpLTJGw+2bUsXwSxG319mUaD0EffSmINlCnPfOybQtpe23QGujQmS8eGLPuon67iumFJyR7CX9bmgerBappTLTV4YtHMWYLZdbrY96Yv81Aq1wG2gzJ4ABYMz8BydF4M6zOykh9gL440k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731423195; c=relaxed/simple;
	bh=d74c37Wnve7bz7atyaNmCT0872rFO7xwSkJCrx7lop0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Q0G5U/jiyFE7NUPizN4K+NGBp5KmXibzISn8V4Iey6Y6ctwLhIxlGxSoKlcA2/LZMxf6oi7H6rdfZ5wXUCbGSpLSyJO6VJofBLe7cirkidVAoUVJ7nBJy0sd7DlspZEvdU1X+LZSsW9KJAtAFrsSn2te5Xdfo5A4AIBOFiyv3IA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=cmNnac4E; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="cmNnac4E"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1731423193;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=CWsK4McBSswFpriD7K7dvE5I2YapnbjAeHEc8fjaLlw=;
	b=cmNnac4E6q0diz4URKV0U6g/IoLWRz1o5USwlQ7QQqonLH2NmaDrvYjeyzO6Vh9IaHYEHM
	aj9jAvfAEaVFwG/gO00Iv6SbGmqqINgLwwGQQ+QAhFYBgeim3b2D6xUuyt1uXgpxmiYHYV
	MASPoQsJnSMBp1LX01ja8plJIYHaEAw=
Received: from mail-lj1-f198.google.com (mail-lj1-f198.google.com
 [209.85.208.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-427-8gnYZN4JPcKOxgm7ToVEvw-1; Tue, 12 Nov 2024 09:53:12 -0500
X-MC-Unique: 8gnYZN4JPcKOxgm7ToVEvw-1
X-Mimecast-MFC-AGG-ID: 8gnYZN4JPcKOxgm7ToVEvw
Received: by mail-lj1-f198.google.com with SMTP id 38308e7fff4ca-2fb5cdaba8aso41681941fa.1
        for <linux-rt-users@vger.kernel.org>; Tue, 12 Nov 2024 06:53:11 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731423190; x=1732027990;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=CWsK4McBSswFpriD7K7dvE5I2YapnbjAeHEc8fjaLlw=;
        b=NWLdQUr56GtpAvFsEVkLUXwnRZ6w5ZM9C/P3kkCU2Xqbjc3eKE9DQX0A4ejmTtnv2J
         FlquS/ASZIxfW1zk/0/anlG3gMqT1jdDWtBLs/0AyqSa/+yJkrZgeKfezvrY54nYXTGP
         0m/CmATGn30Qq7gTahn4ASS5ZTr85XP29k/0Dxzumi6vCI37/ujzme3YP9mIGtDg7WlE
         dZQEZhKb4CZLAWYgfvpGqVeOVjxUQD+r/P2dAe06+GmEMMfWGAGxhFg2F/PAp1kmCZLg
         CClS8XaRxlZmF/Jq3hVQnymGhFJkqfyq2GLrqfD7zRgDymabye8rMuzlYovlxzAiGsd5
         MLMA==
X-Gm-Message-State: AOJu0YztkgkYupETm4/e7NCmXNBbooPT1kdqEwucD686sQIzSwFdkDlQ
	JIo/6HTF1wPnf3f+OxRi9FN4Z8i4mosPx26N/NYisJeWc2oq+BBeTzYsOk4X+/xAMjKjhomeCDA
	Bd4y99jboX5tK2EukdHKovOK0pMYM1nPovAdSpySQx8MyGhpeexHS1FDRjkUQQBz3eabRoKF4OH
	Y4lLguogeoys8D/8RZV4KhFlDWQULZBcBT6nlDyKg=
X-Received: by 2002:a2e:a995:0:b0:2fb:5206:1675 with SMTP id 38308e7fff4ca-2ff2028a9a5mr118814501fa.27.1731423190407;
        Tue, 12 Nov 2024 06:53:10 -0800 (PST)
X-Google-Smtp-Source: AGHT+IG2dW1B56nxcqIUJnIYRR9T/Qcp2CJ116/2uoeqaGeefx0x/Zm7jB/6CDqv3wU0R83ORQ3TFf+2E8F4vYWTenU=
X-Received: by 2002:a2e:a995:0:b0:2fb:5206:1675 with SMTP id
 38308e7fff4ca-2ff2028a9a5mr118814231fa.27.1731423190065; Tue, 12 Nov 2024
 06:53:10 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-rt-users@vger.kernel.org
List-Id: <linux-rt-users.vger.kernel.org>
List-Subscribe: <mailto:linux-rt-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rt-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241107152049.822810-1-tglozar@redhat.com> <3030d57a-8d22-66c9-72ba-2b7d17e415d0@redhat.com>
In-Reply-To: <3030d57a-8d22-66c9-72ba-2b7d17e415d0@redhat.com>
From: Tomas Glozar <tglozar@redhat.com>
Date: Tue, 12 Nov 2024 15:52:59 +0100
Message-ID: <CAP4=nvQQsPwrx37u_mHxZ1qcLfrO0qt7GJ61mpcqLOWDghRMjQ@mail.gmail.com>
Subject: Re: [PATCH 1/2] rt-tests: Detect libcpupower presence
To: John Kacur <jkacur@redhat.com>
Cc: linux-rt-users <linux-rt-users@vger.kernel.org>, Clark Williams <williams@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

=C3=BAt 12. 11. 2024 v 15:49 odes=C3=ADlatel John Kacur <jkacur@redhat.com>=
 napsal:
>
> This seems overly complicated, how about just doing
>
> ldconfig -p | grep -q libcpupower
>
> if it returns 0, the lib is there, if it returns 1, it's not there.
>
> This is the mechanism that perf uses, you can see in
> tools/perf/Makefile.config
>
>         ifneq ($(shell ldconfig -p | grep libasan >/dev/null 2>&1; echo $=
$?), 0)
>           $(error No libasan found, please install libasan)
>         endif
>

Is that really enough? We also need to check for the presence of the
header, taking CPPFLAGS into account, and also account for any
addition LDFLAGS. I think this is the simplest solution to ensure that
libcpupower is present for both header and library and working with
the current configuration of the compiler.

Tomas

