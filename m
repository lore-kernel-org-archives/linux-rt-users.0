Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="JvxTSTkB"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 57E9B1987
	for <linux-rt-users@vger.kernel.org>; Fri, 24 Nov 2023 07:27:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1700839676;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=AUl9+pZolJpnpP2evsSTuinnwCdJadM7wzxNpd+CtCY=;
	b=JvxTSTkBARa553C3jFK1T/pDaS0xvab5GeAmERemb33zn3WhHeSDecMaEpg+i6GiZI2Llp
	rcgaihhTjjE0wm9pqur2j1L0R98uRw+6lZsO4OXkHecCXD8vGIzUUinj2LuOg1DnlX/HKM
	JpWtDoRC1Im/ZGrMowRyGIByOFVG1xo=
Received: from mail-qk1-f199.google.com (mail-qk1-f199.google.com
 [209.85.222.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-394-9hpn5HN9PNePeIf4VuSzbA-1; Fri, 24 Nov 2023 10:27:55 -0500
X-MC-Unique: 9hpn5HN9PNePeIf4VuSzbA-1
Received: by mail-qk1-f199.google.com with SMTP id af79cd13be357-77d6854a3f9so218168685a.3
        for <linux-rt-users@vger.kernel.org>; Fri, 24 Nov 2023 07:27:55 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700839674; x=1701444474;
        h=mime-version:references:message-id:in-reply-to:subject:cc:to:from
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=AUl9+pZolJpnpP2evsSTuinnwCdJadM7wzxNpd+CtCY=;
        b=hjm5bmlvMEZeYLOisT77PGeQotG9ci09KODj4HWo8YiW9pKzrbbMUWlApNU94N/pn4
         OYzp6lGp9mpvvBAxYGgc9dAr+7Rb3c7ZJ1JxP1nPVc1rC/PPGwVico5u8VkG04n2i8Sm
         KK3P2b4TdyiZFZY5CXKqvv1PhItrynxX5JEIvpCon2hAwp6gAZyX5AG2fwakEh2wxkxp
         M1V5+fLpAQnDkL0O8CFLl3h+JmFQZeZKSZbKcxuR195Lzyi/uQKy1glAdsLI/gKvqgGF
         HbILG8eN3+iT6slptHsC4V9yPFjGmEK0ptIbwE73A8T+03cMvWqUCzFhLhqYYctqz0u5
         T/LQ==
X-Gm-Message-State: AOJu0YxH555Vu4rQU3AnFsTGrmZtWJId1CNy7IFJGfkJ5JfWM1drBJV4
	hhWnBBzFpF1xOBdESRU9ICyp3yTbMSnIDISeWTm5hLvN1ySBfO+Z6JLfeZ69nCo5S9BBqk9Izav
	TIrfBfn+nkKbLJAkfvdD46/fWMFdb5hlOgGo=
X-Received: by 2002:a05:620a:6849:b0:77a:413:2d73 with SMTP id ru9-20020a05620a684900b0077a04132d73mr3780186qkn.2.1700839674611;
        Fri, 24 Nov 2023 07:27:54 -0800 (PST)
X-Google-Smtp-Source: AGHT+IH5PALPkPPk9ZWPhIqrp9Oiq083XbDcezFlUN2ZbrOmKLR0KLTtvsvgXXp9fvncvNHU28gdcQ==
X-Received: by 2002:a05:620a:6849:b0:77a:413:2d73 with SMTP id ru9-20020a05620a684900b0077a04132d73mr3780170qkn.2.1700839674320;
        Fri, 24 Nov 2023 07:27:54 -0800 (PST)
Received: from fionn ([174.88.88.134])
        by smtp.gmail.com with ESMTPSA id u21-20020ae9c015000000b0076efaec147csm1292140qkk.45.2023.11.24.07.27.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 24 Nov 2023 07:27:53 -0800 (PST)
Date: Fri, 24 Nov 2023 10:27:44 -0500 (EST)
From: John Kacur <jkacur@redhat.com>
To: Tomas Glozar <tglozar@redhat.com>
cc: linux-rt-users@vger.kernel.org
Subject: Re: [PATCH v2 2/3] rteval: Minor improvements to CpuList class
In-Reply-To: <CAP4=nvQ3cQU+8XwxsHkNckj87EpkyrJeNPA+T71-XqswNJaRuQ@mail.gmail.com>
Message-ID: <b0becd53-9629-51de-4f88-776d2b59f4f5@redhat.com>
References: <20231123072436.270267-1-tglozar@redhat.com> <20231123072436.270267-3-tglozar@redhat.com> <7b393164-b0fa-5c2f-45f9-6289ad8813fc@redhat.com> <CAP4=nvQ3cQU+8XwxsHkNckj87EpkyrJeNPA+T71-XqswNJaRuQ@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-rt-users@vger.kernel.org
List-Id: <linux-rt-users.vger.kernel.org>
List-Subscribe: <mailto:linux-rt-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rt-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="-1463771134-97868556-1700839673=:12855"

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

---1463771134-97868556-1700839673=:12855
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT



On Fri, 24 Nov 2023, Tomas Glozar wrote:

> čt 23. 11. 2023 v 17:21 odesílatel John Kacur <jkacur@redhat.com> napsal:
> > The reason we check cpu1 is that on some hardware where you can't turn off
> > cpu0, the online file also doesn't exist even though it is available for
> > other cpus. We only want to learn whether we can use it in general or not.
> >
> > For example on my laptop
> >
> > [jkacur@fionn rteval]$ ls /sys/devices/system/cpu/cpu0/online
> > ls: cannot access '/sys/devices/system/cpu/cpu0/online': No such file or
> > directory
> > [jkacur@fionn rteval]$ ls /sys/devices/system/cpu/cpu1/online
> > /sys/devices/system/cpu/cpu1/online
> >
> > John
> >
> 
> Oh I've never encountered that, thanks for pointing that out, that's
> interesting. I'd say we should check for cpu0 || cpu1 then.
> 
Or just check cpu1 like we already do! 

John
---1463771134-97868556-1700839673=:12855--

