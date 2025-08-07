Received: from mail-yw1-f176.google.com (mail-yw1-f176.google.com [209.85.128.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AA4B02356D9
	for <linux-rt-users@vger.kernel.org>; Thu,  7 Aug 2025 12:21:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754569309; cv=none; b=k33o4U/hOZh99FqYeutZOHzxMk0iiDSVMRz1FcqDoiiIA0TKxqkJ9NVLZLB8Aunq6XccTU4ybOPWYJocLjgJcKDELg0YClIba5mkGsmfJDMtgcpnumM0DPpaKWy+KfXBYbKUzQJroJ0RBxcQFW+2iz/Tr3nQH81yhVn5dI/z2RI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754569309; c=relaxed/simple;
	bh=CYoVaDlzoilTT8ANnjOw++XNdVTmNR6w/TdlZLn6hIQ=;
	h=Date:From:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=Ngtfzn9TpJzGJthfPKCftysrEOR6jUgKA98W67rTWmc/VhG7dZU6g5J/oPjTJ3S4fcqV8KNi6mv34BbyzqjdJPL0Zrw6S6raiIfPGr45YUy2jIgBjeHt46Rd/YgDdCD6/g4AqmU9A5V5kMoyPPl1vCjJCxo+hipCVtKUT8M6isI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=GsYbtoE4; arc=none smtp.client-ip=209.85.128.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="GsYbtoE4"
Received: by mail-yw1-f176.google.com with SMTP id 00721157ae682-71bd028bb5bso9743727b3.2
        for <linux-rt-users@vger.kernel.org>; Thu, 07 Aug 2025 05:21:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1754569305; x=1755174105; darn=vger.kernel.org;
        h=mime-version:references:message-id:in-reply-to:subject:cc:to:from
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=73iH4wasKzrXgaNXIqRiPRT+SR9a1gFj9x2fb3CS49Y=;
        b=GsYbtoE4H0tud4of3mAHgSY39pwhBdlEZze4yfX4KsDSJRPbhsjstNn4BuPpnwES1R
         3S8C/7KKNDGufVF0g1w2C6dfa7FoeO+ZIYSq0Fb7+/Pu0WnmHhB5WSJza7YxKIkhkGS2
         tI1Vv8PeAwvvl1LbewQ6JU2luLrgn54JSc/1y+Kj42skyBr3xDd5dmzIBckZJXQuzzD+
         3Pj7yw/oe6NfBwABYr5PlW97Lpt4PexAJloEAycccpo/NdOCZ5FxAFfxivvNejL7d4sI
         +zEHLAv8fayUy/Kk/SRvwxym6HQkGAu1i0daXHn94mYRO1IUe/DAFGc4uuWoyZ30UzGE
         VJyg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754569305; x=1755174105;
        h=mime-version:references:message-id:in-reply-to:subject:cc:to:from
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=73iH4wasKzrXgaNXIqRiPRT+SR9a1gFj9x2fb3CS49Y=;
        b=G39gpDLZ58QBpcbD1nOdBKj0QIf0FsqzNnknP9PCQ4crmS0jFI5BwkNxDCySyQ73ow
         Yq9ITTe/ozS/R/vIZ+s3pLpkCaLPka/ELUQkQ4uBC2XZg/KtVh4EihorREwk9fgbSXok
         63Y+MuLqmLsh0OXoEkzkUTtTlrGUV6w569c+DbqZYnBJEeML8CBZeBZXZQ6Up44pfN8L
         aJGM77GRy5bMjfi+Fuu5fJA03A2kC5mTZQSdFS/xUylF+tjB7M7FyHgoQCO8dwsK0SFC
         v6LE4YOhG+auZgODLo1sJUHShS58lnirbgQBAtri6O2DxaTC6dy7cp8Z1kHQYUxqpcoN
         GwiQ==
X-Forwarded-Encrypted: i=1; AJvYcCVO53+uo6XsXfMYc4FE/hOjxwcm5Crr6MnyGHrKQ4lVTxmgUXoyffqt2Pbry6/uDo7PLZcFSMgSo263kaGg7g==@vger.kernel.org
X-Gm-Message-State: AOJu0YxYEhg7Ynslhov7YIBWlRYg5dJcPGYuovszbXrSPgM/Kfn5x5LM
	Y2s28Kj1IkFSi1C1H1qGAjJvttRb9AaBlo5Q/k3ehHj92m++vn2qBobowMbUBnrE5Q==
X-Gm-Gg: ASbGncsJi53h//+2R5b1aO8L+3N5Op9oVkxSW3h+lOduVorGSRnFkgS9yC0AppAWHka
	nJhVWksQnAkZp/sUkKIGuUEZWb3gUUMjapZuR7dsDKHNzdmqk1FnfXdZrmtoDkfy1awr3UUgByr
	ky1mx54YmoHXfaE8wWdruuTbt1Ivi9NepC2KfGHDCbtIq7eh25w66aTiiX+zjL/p/IAjogNmI8g
	97QpXgR+IXZyEgVSGoTjRBaldk9UhqoYtvfx6jbXdaTJtZAVlY7PAzxNY3sgtIv6s/kiObB9KTj
	ozLZT1tGPiQCZW9n6SGtKeADfEemHKuNHuOyd5PzpIueyKozSQt3cmAdL15mtNR5SHgP+fo64kp
	c5fad7Ss+8F77QTXMdhL7SiB5RmvFL5H6gZKkwVJLL/rXKBLnVdv87y3M9u9T15CDC2IOHYNsTV
	U8bn7ZBNo=
X-Google-Smtp-Source: AGHT+IFeyMuWjhDETChRuvVfNLHPQN/zNP6Vl7YFSjffHqjMAZtfUTwYyCDFmjGyWYSS5kkc6h/9Og==
X-Received: by 2002:a05:690c:498e:b0:71a:906:2874 with SMTP id 00721157ae682-71bc971a07fmr92320687b3.17.1754569305215;
        Thu, 07 Aug 2025 05:21:45 -0700 (PDT)
Received: from darker.attlocal.net (172-10-233-147.lightspeed.sntcca.sbcglobal.net. [172.10.233.147])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-71bd6af0fddsm7484467b3.11.2025.08.07.05.21.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 07 Aug 2025 05:21:43 -0700 (PDT)
Date: Thu, 7 Aug 2025 05:21:29 -0700 (PDT)
From: Hugh Dickins <hughd@google.com>
To: Vlastimil Babka <vbabka@suse.cz>
cc: Alexander Krabler <Alexander.Krabler@kuka.com>, 
    Frank van der Linden <fvdl@google.com>, Mike Galbraith <efault@gmx.de>, 
    Hugh Dickins <hughd@google.com>, 
    "linux-rt-users@vger.kernel.org" <linux-rt-users@vger.kernel.org>, 
    "linux-mm@kvack.org" <linux-mm@kvack.org>, 
    Dennis Schimmel <Dennis.Schimmel@kuka.com>, 
    Daniel Braunwarth <Daniel.Braunwarth@kuka.com>
Subject: Re: Realtime threads delayed due to kcompactd0
In-Reply-To: <33275585-f2db-4779-89f0-3ae24b455a67@suse.cz>
Message-ID: <771a8fc0-8195-44cc-55ed-c3573d497d2d@google.com>
References: <DU0PR01MB10385345F7153F334100981888259A@DU0PR01MB10385.eurprd01.prod.exchangelabs.com> <CAPTztWYf82p6hq=Q2mVq6_9WTjRaQiH81z4idZL6MZ1PXufPwQ@mail.gmail.com> <71df781c-3ef3-4b26-9ba8-93fc7d4f9eec@suse.cz> <026de9fcd4f0ed17c2df95c4f7c56b878a844012.camel@gmx.de>
 <25ba0d77-eb61-4efc-b2fc-73878cbd85c1@suse.cz> <DU0PR01MB103857873A56FD121984568148226A@DU0PR01MB10385.eurprd01.prod.exchangelabs.com> <c48f2877-4d37-4310-995e-fc5c2ae9a366@suse.cz> <DU0PR01MB10385C08C119276D99A234D978226A@DU0PR01MB10385.eurprd01.prod.exchangelabs.com>
 <33275585-f2db-4779-89f0-3ae24b455a67@suse.cz>
Precedence: bulk
X-Mailing-List: linux-rt-users@vger.kernel.org
List-Id: <linux-rt-users.vger.kernel.org>
List-Subscribe: <mailto:linux-rt-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rt-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII

On Thu, 7 Aug 2025, Vlastimil Babka wrote:
> On 8/1/25 15:40, Alexander Krabler wrote:
> > On 8/1/25 14:57, Vlastimil Babka wrote:
> >> Hm that means something isn't working as intended. Do the pages have also
> >> the unevictable flag?
> >
> > I have checked /proc/<pid>/smaps.
> > Neither the manpage
> (https://www.man7.org/linux/man-pages/man5/proc_pid_smaps.5.html)
> > nor kernel source code (fs/proc/task_mmu.c show_smap_vma_flags) tells me
> about unevictable flag.
> Ah ok, you checked /proc/pid/smaps. Since you said "pages" I thought you
> meant individual pages which would be from /proc/kpageflags
> 
> But IIRC getting a page in a state where it has an mlock flag but (not yet)
> the unevictable flag should be rare so I would be surprised if that was the
> problem here.

Agreed.

> 
> Hm or maybe it's actually that the error can happen only in the other
> direction - page is unevictable (on unevictable list) while not mlocked, at
> least the counters such as UNEVICTABLE_PGRESCUED suggest that.
> 
> Hugh knows this code the best. Do you think we should e.g. test the mlocked
> flag instead/in addition to unevictable flag in compaction to avoid
> violating vm.compact_unevictable_allowed = 0?

No, checking for unevictable should be sufficient.

But another idea has just this moment occurred to me: anon THP splitting
is another user of migration entries.  Is it possible that kcompactd is
not actually the cause of Alexander's issue, but that his RT tasks have
(bad news! shouldn't be allowed) got anon THPs in them?

Back to bed,
Hugh
