Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="UL29HK3P"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A475AD68
	for <linux-rt-users@vger.kernel.org>; Thu, 23 Nov 2023 23:06:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1700809563;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=7L9A9cV3J6wUSD5c+4lbncnmK6URmy1GXDZXVlCh3/U=;
	b=UL29HK3PiLw98MPspshGr0gyPrl1YlkOu6KJwd5E6M6xm6+4HSbcQ8QYxlZUovNWFgU6WO
	nGr/jGulkLV/zuoVOO59i9C2qmlmaUZJYqhaT4wbwyEbVyaBd5VmoqEB8ur+cLyvgTp4eI
	JAhGyYQ+YWggerRMzW9YiFEn4o0BJi8=
Received: from mail-ej1-f71.google.com (mail-ej1-f71.google.com
 [209.85.218.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-193-vI3HN0-bPeqLKH6pu94yNQ-1; Fri, 24 Nov 2023 02:06:01 -0500
X-MC-Unique: vI3HN0-bPeqLKH6pu94yNQ-1
Received: by mail-ej1-f71.google.com with SMTP id a640c23a62f3a-a0180b0190eso99957066b.3
        for <linux-rt-users@vger.kernel.org>; Thu, 23 Nov 2023 23:06:01 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700809560; x=1701414360;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=7L9A9cV3J6wUSD5c+4lbncnmK6URmy1GXDZXVlCh3/U=;
        b=Wq3/0GMBy8htQmJF+igTxJrmnlZJ6oe/f8AYHupLqR7GUZMH35tDF9fkCpAUw3j7O4
         9ni/tUK82GqshlxmgQjX0VU87pEPuD9JFqC2dJOanYNzjD9LzmxG7vhgARO2xeTnFhQd
         BvCiOQf+OvmCANSPU+roeMHnrERxyHE5qJvvkrxUiWSBrv/WBqXmcgcT48BjKnEdXjBc
         fsuOlZAkPlC6U80HV2wVL5XWElTqAd1HDjCE4IY1tftTzgi4ZWf6O2b+3yHRbTEGTUDq
         doQWOp028d7JQToYOWFxr1RAfJZKyqBOabZZRETQrdNVayE612Ly4iRd0fw84E+Rgd3k
         Nu4Q==
X-Gm-Message-State: AOJu0YyVjKjx7yX8fuzaG9oV80jh9OPA+NUDQCSvHQ8/XRjo8zO4spIn
	dJ6puTt3hgdA8vZKfyndhVJhpLz8C9+DwuXcHBCuXoYpyxaithqBNSRudxP+G1umUk44D07ScrY
	1G2Hjbc3krUOGdjOj/q3WVif7vXbbKLK36yXBFAamMvIfdm1DlLU=
X-Received: by 2002:a17:906:d28b:b0:a00:47fa:2251 with SMTP id ay11-20020a170906d28b00b00a0047fa2251mr1333054ejb.32.1700809560458;
        Thu, 23 Nov 2023 23:06:00 -0800 (PST)
X-Google-Smtp-Source: AGHT+IG4u2txL4fTyW1kiH+r8m5Y3es2pbpOdKw6B9UlJCFl2kuaS0Ga6ND079irVpSJwacvjaKr20L/HDX04q5Iyd4=
X-Received: by 2002:a17:906:d28b:b0:a00:47fa:2251 with SMTP id
 ay11-20020a170906d28b00b00a0047fa2251mr1333034ejb.32.1700809560184; Thu, 23
 Nov 2023 23:06:00 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-rt-users@vger.kernel.org
List-Id: <linux-rt-users.vger.kernel.org>
List-Subscribe: <mailto:linux-rt-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rt-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20231123072436.270267-1-tglozar@redhat.com> <20231123072436.270267-3-tglozar@redhat.com>
 <7b393164-b0fa-5c2f-45f9-6289ad8813fc@redhat.com>
In-Reply-To: <7b393164-b0fa-5c2f-45f9-6289ad8813fc@redhat.com>
From: Tomas Glozar <tglozar@redhat.com>
Date: Fri, 24 Nov 2023 08:05:49 +0100
Message-ID: <CAP4=nvQ3cQU+8XwxsHkNckj87EpkyrJeNPA+T71-XqswNJaRuQ@mail.gmail.com>
Subject: Re: [PATCH v2 2/3] rteval: Minor improvements to CpuList class
To: John Kacur <jkacur@redhat.com>
Cc: linux-rt-users@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

=C4=8Dt 23. 11. 2023 v 17:21 odes=C3=ADlatel John Kacur <jkacur@redhat.com>=
 napsal:
> The reason we check cpu1 is that on some hardware where you can't turn of=
f
> cpu0, the online file also doesn't exist even though it is available for
> other cpus. We only want to learn whether we can use it in general or not=
.
>
> For example on my laptop
>
> [jkacur@fionn rteval]$ ls /sys/devices/system/cpu/cpu0/online
> ls: cannot access '/sys/devices/system/cpu/cpu0/online': No such file or
> directory
> [jkacur@fionn rteval]$ ls /sys/devices/system/cpu/cpu1/online
> /sys/devices/system/cpu/cpu1/online
>
> John
>

Oh I've never encountered that, thanks for pointing that out, that's
interesting. I'd say we should check for cpu0 || cpu1 then.

Tomas

