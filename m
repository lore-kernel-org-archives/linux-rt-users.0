Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DFDE815884F
	for <linux-rt-users@vger.kernel.org>; Wed, 24 Jul 2024 14:39:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721831965; cv=none; b=J5BYyaYOohlDAGXWQI8X7t7QTzuZgRYT5YMAe0ykw4HMSLitwfXz6tXsK5h8g3QQfbyEpLic9IEpMA28ovqz8WuES6I2a8rK23BCsX9eUMunKGHnRj0vEmIdZLeU5wT3Q4UdDLn5Dr9j/qbQo8nV56UoEqRGA/bvt0BkzZzG66o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721831965; c=relaxed/simple;
	bh=UAA/akqHWehByaLkIYHTJMcfgwzgZ+Ik9t6FtcXZDlU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=a2F2y8QpsJkctY9QVdyFyt7VJIcJWtKOElAZ+1xArbhRvbfx+MpJE1ILYzPx6E2v1aRRq0okh/DXnsPycRLkO3kYWhcRJ9YXn1cpaZw8FATlVhEexLL7QI8g4CQxHZJ2e8l/MOq5G4cvXxi/OVFtDF4dBRZRqF1YuW856Wg6iEA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Y9G4uAXc; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Y9G4uAXc"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BE339C32782
	for <linux-rt-users@vger.kernel.org>; Wed, 24 Jul 2024 14:39:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1721831964;
	bh=UAA/akqHWehByaLkIYHTJMcfgwzgZ+Ik9t6FtcXZDlU=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=Y9G4uAXchNHdU1ZsnQ8NTexzufWIRnzFo5b96JJAobtMQNT8VlF8IsKDESPQ9Nutx
	 OULUIQP6El4QKOe930xzQACyNTYGjrWKmpOPBSAmKp+bZ3sbmQ9cliftyykZuPeAzf
	 iG/7xz/c92h5aj15QryQo58BgOsAwWD6vZriFgEuWAy10IkuoTMkyqz8u8pUVXVuMu
	 UdRoHLSXseBewAo+Sl5Wtgv9S85vWNmia9sTjVAwL3OaiNPnn9EyQxASHErbRASYrO
	 t7IFgQH4P/ZzmqKndqSV8Y0Qh4VH7PVbZLdk27Gikz4W7jsMgrf0KkoynbCVx6InF5
	 5meZpfOLuIVwA==
Received: by mail-pf1-f181.google.com with SMTP id d2e1a72fcca58-70d19c525b5so2639701b3a.2
        for <linux-rt-users@vger.kernel.org>; Wed, 24 Jul 2024 07:39:24 -0700 (PDT)
X-Gm-Message-State: AOJu0YwGkacZMz5JoZOKJ3loqCdNiEAipxuTNckj5EKWYsX+zpp6+her
	wOPDamTwzffR4+Lw1LB3XamiNeq36brKXlFGg+BQF4hezM1gdoySo60H6v7Rkk6cjx5CVIqzp3e
	8DH40uamSxL8hrAlFFdgXkDQDHho=
X-Google-Smtp-Source: AGHT+IHMCG9ZsxCSbiWNnR9ndu0mc7aOMRdzQ3eVXhvSiCGKEOFzkPbkkLASDyowAaZttUq8rVEruiybbdwix9V/GX0=
X-Received: by 2002:a05:6a20:7494:b0:1c0:e925:f3ea with SMTP id
 adf61e73a8af0-1c472833a50mr92709637.16.1721831964281; Wed, 24 Jul 2024
 07:39:24 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-rt-users@vger.kernel.org
List-Id: <linux-rt-users.vger.kernel.org>
List-Subscribe: <mailto:linux-rt-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rt-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAMjhiJiqfz67Aba8KAKTHjO7TjGADvM2S0qDVrGfF+XkT5DeAw@mail.gmail.com>
 <CAFTL4hws_4D2-ez+TkGZU5ZWUys=yqmAjxiQa52K6zXwe6nqMA@mail.gmail.com>
In-Reply-To: <CAFTL4hws_4D2-ez+TkGZU5ZWUys=yqmAjxiQa52K6zXwe6nqMA@mail.gmail.com>
From: Frederic Weisbecker <frederic@kernel.org>
Date: Wed, 24 Jul 2024 16:39:12 +0200
X-Gmail-Original-Message-ID: <CAFTL4hz-oMQaksJFXee=iJq1oJ=tfGAprcxW7cVC_Zff7Dks7g@mail.gmail.com>
Message-ID: <CAFTL4hz-oMQaksJFXee=iJq1oJ=tfGAprcxW7cVC_Zff7Dks7g@mail.gmail.com>
Subject: Re: rcuc/ thread on isolated CPU
To: Leon Woestenberg <leon@sidebranch.com>
Cc: linux-rt-users <linux-rt-users@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Le mer. 24 juil. 2024 =C3=A0 16:35, Frederic Weisbecker
<frederic@kernel.org> a =C3=A9crit :
>
> Hi Leon,
>
> Le mer. 24 juil. 2024 =C3=A0 16:06, Leon Woestenberg <leon@sidebranch.com=
> a =C3=A9crit :
> >
> > Hello all,
> >
> > I am seeing an rcuc "osnoise" on an isolated CPU (#4) that should have
> > (per-cpu) rcuc offloaded to, and polled by, other CPUs.
> >
> > Note this is with vmlinuz-6.9.10-rt5.
> >
> > I did not expect "rcuc/4" to actually run on CPU #4.
> >
> > Then I found the email thread "Wakes of the rcuc/ thread on isolated
> > CPUs." and also tried with rcutree.nohz_full_patience_delay=3D1000.
>
> Are you sure you have the proper patch applied? It is not yet
> upstream:
>
> https://lore.kernel.org/lkml/20240604222355.2370768-6-paulmck@kernel.org/

Ok it is upstream actually :-) But you may need the latest tree from Linus.
