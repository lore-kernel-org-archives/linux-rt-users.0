Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9D2A72517B5
	for <linux-rt-users@vger.kernel.org>; Tue, 20 May 2025 15:15:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747754104; cv=none; b=CLuiM+Uzp/I/wZSmwmyjO7P7o8ydMct+BYKL03/D7l2CimW//sLTSx3qV+oLfTY1kU6bJqEU0P1eBWod2ZNsYUq3oYIoldfRGmrHVKyTbYH1krthRNEzOopljpwzYnwGACCN69fZwnFqOvNUURxmsTz7kP4prP6nFcirDOYgvsY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747754104; c=relaxed/simple;
	bh=plkQ1oLf12TQao6cf+ZTupncVTjT4NspZca49nOGMYg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=WBXY4rjAruG1aCxCPjLrjJIZayOdiQHT6VHsa+tdrmPNRTW8n+2HVc5NGsYcreXz+O8e8U8QNoTcrxEKeIkBKVMvzjjqIt34x+9OOT0KnW4Eu1URizxnjDFbz4s1uQNqjh8rKxmlhaM3aYx/krLxyEqkLghZBKFlsjgYo1hRMeM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=CcLWEd7/; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="CcLWEd7/"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1747754101;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=brRxnNIasiIXZmdeBP4fqwyq/I/KBlv62gvCYwL5UMM=;
	b=CcLWEd7/7xrimanDsZGhYqoPW/zAvIW5efhmDzaAO8DjqfHkJS9DaKNIjDqgr6ml5k/pWN
	4nnWqBjySJKBuDU4L+QvvVMCLm1uSyaQtuCAoBdr/cboLRBdNro/G9St/LPOTwLt95bG5G
	n6V8QHIrS0RF10Ki54znqCeyeKZHYgY=
Received: from mail-yw1-f198.google.com (mail-yw1-f198.google.com
 [209.85.128.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-245-40-JPDDUPzOwvCIJ1iV75Q-1; Tue, 20 May 2025 11:15:00 -0400
X-MC-Unique: 40-JPDDUPzOwvCIJ1iV75Q-1
X-Mimecast-MFC-AGG-ID: 40-JPDDUPzOwvCIJ1iV75Q_1747754099
Received: by mail-yw1-f198.google.com with SMTP id 00721157ae682-703d7a66d77so86315607b3.0
        for <linux-rt-users@vger.kernel.org>; Tue, 20 May 2025 08:15:00 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1747754099; x=1748358899;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=brRxnNIasiIXZmdeBP4fqwyq/I/KBlv62gvCYwL5UMM=;
        b=u6NYmmD43wQqguLARxkJu0yCdCVYq1kj60Bnuneso3S3HvJ/jRwZf+ORk0Y5uCc0N7
         MYDmz+nA2ZkQLYpVtdfQrGZtVkGIVLiXFi0WVEnS425xU+XQe1mD3hn4zHHk9INalhH5
         9yPCJf3qXpePeoBOzCeo0pIw1YL+vidQjC/tO2rLm6xnfVNtosh9Ps6QlyZMkhNFAx5V
         Yr2yntMkKYnnCfHm5Fl5CPfNO5hPQta25amFVt/9JC7LrUGZartjCgIk2F8NP7/4occr
         /KMZSaLGJ/7dPySq/Qi4DxTClyZd/wVqLgmdvkrL6iKzE1Uw0LS9gEH2jfmMTZB3uVvM
         3VgQ==
X-Gm-Message-State: AOJu0YzmyqWOazf5nlijmmGcT4t72Q6pvcnSb2AdS3PUNiuiz0CNjkut
	FGB/b9LGjMZsexmtOrgw+3LW5qB/A35qjTlgDfXv4GTKci+Pv5X0p01uJ+Co6kwhbELf08+Jtul
	Ywm17XPDlZ2EV9RyjOGS1+z63ON9w/mtn9hKg8p7kwywxXfmPr3dR0X4JRUNF5yKWvMoa7tpqHu
	Yfz/dNSt+Nhg7waYdi3jJkrp1bD7BQPXvOHkP/nYiAxMI=
X-Gm-Gg: ASbGncvdw5WMF2F8uzgvBsXyI796CngKfRWGOjM0s2gU3LwLhabReHTvCDfmdlr3zAw
	lWFmbfRQLSmtCn2im04pwAl1gISA0wPrE8n+yi4MOVW6yFYp1xthXTHkw9MUo1UUNSeh0Kj+hIP
	suf8LeuSpMZWSkrwbMfou6kTkf
X-Received: by 2002:a05:690c:6e06:b0:70a:5298:a8cb with SMTP id 00721157ae682-70ca8a35c55mr240143447b3.17.1747754099575;
        Tue, 20 May 2025 08:14:59 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGpkL1ABCNWxa1HrPFWn+zx3HnO5jycF9NJtj0lNxxyFncOgZ9EI7M6mdDQfIOQjrR6DUZYlbkVcaaow5kTIBM=
X-Received: by 2002:a05:690c:6e06:b0:70a:5298:a8cb with SMTP id
 00721157ae682-70ca8a35c55mr240143027b3.17.1747754099157; Tue, 20 May 2025
 08:14:59 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-rt-users@vger.kernel.org
List-Id: <linux-rt-users.vger.kernel.org>
List-Subscribe: <mailto:linux-rt-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rt-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250520035641.533706-1-leobras@redhat.com>
In-Reply-To: <20250520035641.533706-1-leobras@redhat.com>
From: Leonardo Bras Soares Passos <leobras@redhat.com>
Date: Tue, 20 May 2025 12:14:47 -0300
X-Gm-Features: AX0GCFveLYUJYXqlRkzUd2BSBl7dTXbNoT0B43iWXp65IsU5MSAo46Yad1Jg3iI
Message-ID: <CAJ6HWG52+JjRp2OPg6Zf1XMdmHBonDiu-rbWAMUiTOxiuUUWOA@mail.gmail.com>
Subject: Re: [RFC PATCH] cyclictest: Add skip_sec option
To: Clark Williams <williams@redhat.com>, John Kacur <jkacur@redhat.com>
Cc: rt-users <linux-rt-users@vger.kernel.org>, Sana Sharma <sansshar@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, May 20, 2025 at 12:56=E2=80=AFAM Leonardo Bras <leobras@redhat.com>=
 wrote:
> @@ -637,20 +638,21 @@ static void *timerthread(void *param)
>         sigset_t sigset;
>         timer_t timer;
>         struct timespec now, next, interval, stop =3D { 0 };
>         struct itimerval itimer;
>         struct itimerspec tspec;
>         struct thread_stat *stat =3D par->stats;
>         int stopped =3D 0;
>         cpu_set_t mask;
>         pthread_t thread;
>         unsigned long smi_now, smi_old =3D 0;
> +       unsigned long skip_cycles =3D skip_sec * USEC_PER_SEC / par->inte=
rval;
>

BTW, I noticed this is not the best approach: in case cycles take
longer than the interval, we may be skipping longer than the
parameter. Will send a rfc v2 for taking time into account instead of
cycles.


Thanks!
Leo

