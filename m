Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 40A502D030
	for <linux-rt-users@vger.kernel.org>; Wed, 24 Jul 2024 14:35:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721831738; cv=none; b=REd3Ibl5+CFlv8wpDm2AIh3ePUJqZ6zHO7YkNABkayxdvFzUdx1YolfdKTyx2piQL58FynJfbaCZ6AEAsVxaLDqmvmCSPonHv1CET8LTh3SbyV/k7SXeSwt5romnGt8Jp1/BS2uJH9nYMninNikeZHCCKMcKO/GWb3OsvECCQWY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721831738; c=relaxed/simple;
	bh=UO/91e280pNwHngyiXVR/I1Pb8UtnMC7uiBDy0MpX5s=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=prZhXsHXgmC9VKOurtRxJmh0pVgLtfSBJKjU9oT0hhdXqxUa9GPp4OFUTiI5o2d/VSGKPu/inIrhp9Cuap8VROfza5IiKnolfRVwGiiPEyG6Ty21vqGBCQd9ue3YNqYeDQDJtkozneg8Tf7O6qR5TJbp8vVtnHjzPoUysf3SpXc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=CfzlWol4; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="CfzlWol4"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C8642C32781
	for <linux-rt-users@vger.kernel.org>; Wed, 24 Jul 2024 14:35:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1721831737;
	bh=UO/91e280pNwHngyiXVR/I1Pb8UtnMC7uiBDy0MpX5s=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=CfzlWol4bCfg8U6/DwT7G2/lmRCCJjeuChCQyx+8bPeu0qeZuPxeCjHo1f4SD6taB
	 XvhbqNnIf3MHHqjeytgcZG6vUYrRDkI59w42O34mWPHPmf3NuuP2ddq/gBS8xp+g6f
	 ABdu7vvtSkGOAZTafWfbTVjDzlmAHG1b/xSRsLLBI/i4pfu/ZhDqi4wm0HE0a0tBTe
	 vCfC1CORgyok2rhbvHK/5O+5D7m1a5t1Ym3nP2g9dHHkTdwdnyILoi8KlEZ84sKHtB
	 S9AXtY0q0aOBsQKep6638zLdGSXeGKynrajfGwUOyTVQGC0fwLwSobVakFEpV1ACL/
	 3/X1ps3Fop+wg==
Received: by mail-pg1-f180.google.com with SMTP id 41be03b00d2f7-7515437ff16so867909a12.2
        for <linux-rt-users@vger.kernel.org>; Wed, 24 Jul 2024 07:35:37 -0700 (PDT)
X-Gm-Message-State: AOJu0YxuRNj9lhaUajgWidIIedoqyvyc4Qej6QBb6QbvqPExoxVK8JLj
	FOyv1UIOJesUd1dP1w9yeYXQGdRlweQutqh0duAb5jhxdYcHe0ikIpu1fA2fmrCc8RWXR4kaTUr
	XrU0EBu0PzMm+Qw3KGfjQOnwAHoo=
X-Google-Smtp-Source: AGHT+IG5IPqk5JGUmpzt7fnwZoeH11HdOc8e8ymtBzNW8HbrXw7P0AaPVtz1tCBTQ37PIMjAT3Si3SLk0754Mnh/hQk=
X-Received: by 2002:a17:90a:ce97:b0:2c9:cbdd:acd with SMTP id
 98e67ed59e1d1-2cd274a5092mr12344124a91.35.1721831737410; Wed, 24 Jul 2024
 07:35:37 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-rt-users@vger.kernel.org
List-Id: <linux-rt-users.vger.kernel.org>
List-Subscribe: <mailto:linux-rt-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rt-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAMjhiJiqfz67Aba8KAKTHjO7TjGADvM2S0qDVrGfF+XkT5DeAw@mail.gmail.com>
In-Reply-To: <CAMjhiJiqfz67Aba8KAKTHjO7TjGADvM2S0qDVrGfF+XkT5DeAw@mail.gmail.com>
From: Frederic Weisbecker <frederic@kernel.org>
Date: Wed, 24 Jul 2024 16:35:26 +0200
X-Gmail-Original-Message-ID: <CAFTL4hws_4D2-ez+TkGZU5ZWUys=yqmAjxiQa52K6zXwe6nqMA@mail.gmail.com>
Message-ID: <CAFTL4hws_4D2-ez+TkGZU5ZWUys=yqmAjxiQa52K6zXwe6nqMA@mail.gmail.com>
Subject: Re: rcuc/ thread on isolated CPU
To: Leon Woestenberg <leon@sidebranch.com>
Cc: linux-rt-users <linux-rt-users@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Leon,

Le mer. 24 juil. 2024 =C3=A0 16:06, Leon Woestenberg <leon@sidebranch.com> =
a =C3=A9crit :
>
> Hello all,
>
> I am seeing an rcuc "osnoise" on an isolated CPU (#4) that should have
> (per-cpu) rcuc offloaded to, and polled by, other CPUs.
>
> Note this is with vmlinuz-6.9.10-rt5.
>
> I did not expect "rcuc/4" to actually run on CPU #4.
>
> Then I found the email thread "Wakes of the rcuc/ thread on isolated
> CPUs." and also tried with rcutree.nohz_full_patience_delay=3D1000.

Are you sure you have the proper patch applied? It is not yet
upstream:

https://lore.kernel.org/lkml/20240604222355.2370768-6-paulmck@kernel.org/
