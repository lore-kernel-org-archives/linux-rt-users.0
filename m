Received: from mail-ed1-f43.google.com (mail-ed1-f43.google.com [209.85.208.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B0D49278774
	for <linux-rt-users@vger.kernel.org>; Tue, 15 Jul 2025 16:43:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752597795; cv=none; b=XAGN/oJhNsUxf9f2z4daNUYlbSy0zS6as1ecbtZzGuG9d5Fta6z+YiDynIE9XPzMkRypXgloW+/g5XDTXZlFJaeU6h6eBFld3GLgsZzy5zveuFKVZWzrYljx9e3NiKb7mx6ITDej5zG0LcHiu9aNBpApBEn/ZFZOaRq2O3AnUMY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752597795; c=relaxed/simple;
	bh=OZLBdP80AuAPBpQatgV4tnOFj5nsWaDVvWpCLDIyI1k=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=o+vtfnmJx0ESke0CYILHZRGDFaiJVXPjLZMo3xWREljNxRa4V6ElWzy4ZTNeq3xdI5iA/x8ueLOHV+gT5AUUw9KPG6jDidDVTMrU0ys2RtMtguntVp3+EfxCRuuzsPgXVgbnDWW98QFhRYVUEs3+taGjjgHMqTqsa1ezrryPhag=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=SI3kAVwt; arc=none smtp.client-ip=209.85.208.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="SI3kAVwt"
Received: by mail-ed1-f43.google.com with SMTP id 4fb4d7f45d1cf-60700a745e5so11728192a12.3
        for <linux-rt-users@vger.kernel.org>; Tue, 15 Jul 2025 09:43:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1752597790; x=1753202590; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=46zpS+UQ3AzjYrdMtZXy87Fu+5mO7Am2ZTQb8NQ0ZbA=;
        b=SI3kAVwt4n2o1Aq3Hv+RmcxE60FVsLNTY25pw4y83pRPZN+IX1Cj1r8I5mooJ5zAs0
         zmC3mZV+tFEk/UqEF5Sy8eGCWQ2JCuGnN2ZC0y6kwvgGl3ioOoPy/GNX9tnydgCrzEL6
         Fi4b03i+ljxj35R8zMEfjAPKibfDra9z3dx5g=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752597790; x=1753202590;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=46zpS+UQ3AzjYrdMtZXy87Fu+5mO7Am2ZTQb8NQ0ZbA=;
        b=J10RkTKvPIoAQxFkxiD5mMHVwBwFRhHUXP0d5KK0iEdEIavJhU9M8/YspPRNySquCZ
         GcXTGR9RYrwVQUL1UyJ3c41gYvOSPq0cXq8fpYujkrAW+9pMgxa15fuGW1HivzsSzkau
         EjXiLRDrtEsJZR8YpSQJ6QSaTXfm3lr6XlG2EXtn2yiecFPZ7qLjZjIYPEd6Qq/1tnNL
         uehjLjnZN/ETF35GQE6OQpEeo5dXKQsyNSAzZnbByE2hZWggoTL3JV4Vp0051nzhJkT1
         OQOJkMSPs7XHWvtR2O4lsQrlLi6ADPQCII3BoaNDc6o0f9XI8hlXH7bRZQP/6o1u0brG
         NZAQ==
X-Forwarded-Encrypted: i=1; AJvYcCUr1xmQXI+/iiuGDlD2iL5/T1iXelP017GdRdq4LK3lG9xA2y/c/UQ/iRunjOwJo1+wDiwkF5SkPAwR5XHVsA==@vger.kernel.org
X-Gm-Message-State: AOJu0Yx4VAXEoGD241fXflCNtMvS83Twt8Q/6ItoWZkttN96cscq6aYT
	P8e8NMPvhhtWBWizOYCkYDqBk6CFCQJMXovxbn62khbhl9hIvEtEkyozbNV7OzcqZ1YSb05TN/D
	sILvRmy0=
X-Gm-Gg: ASbGncswTgZNtSMYVaLkRO7c/8Q/K8peKrQZuTN2G5CDTs/nrtweOWvZan94TlsRC6C
	R3YSXeR31x684tAHAAOq4ghSOJc/Tba0y6VtA8VqSlRFtYwvYdHU1Lts1w6HXieaYl8NTMJN1ik
	cf67W1P0z/bwAKPDbBJaVyVb4FIhYcWkepnhjxVzgrfoM7tlJ/0HNwp0j/ciXPdzvMvz3KaaYqu
	CrZu4EmkSrwYrbAxoE5qfJXt20NvjWcjdo4jBNTUy3PdsocuLky4L+n6OcNis7fvYXlXy3tBDu/
	NTxw4E/n0VbHxSRqojf2AnplBnc0UVQ/5RXQIfXGQZVlXfwcassl6E8mt4+ESSJW55qpY3Efd19
	2fW9G6V2vRxdBTHEDeU/UaqTTwaROdEs8AmMSMcsxw92UP2A+q6dPmc3zUEGXBmQF5ZEr/6g6
X-Google-Smtp-Source: AGHT+IHYHS4Yz6LfI5gFy1CxT7l6yZwX/FRfE47OrI80Hn2p5WxzRV3ir2yFkaVI9ey4wm/ps5pkOQ==
X-Received: by 2002:a17:907:9493:b0:ae0:d78a:2366 with SMTP id a640c23a62f3a-ae9c9988a8emr20675166b.4.1752597789979;
        Tue, 15 Jul 2025 09:43:09 -0700 (PDT)
Received: from mail-ed1-f48.google.com (mail-ed1-f48.google.com. [209.85.208.48])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-ae6e82dee16sm1029895266b.152.2025.07.15.09.43.09
        for <linux-rt-users@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 15 Jul 2025 09:43:09 -0700 (PDT)
Received: by mail-ed1-f48.google.com with SMTP id 4fb4d7f45d1cf-60bfcada295so8797212a12.1
        for <linux-rt-users@vger.kernel.org>; Tue, 15 Jul 2025 09:43:09 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCUDT+QCMPAVOWluDy7STXhEnnKxUSrlVfx9MVbsbVV8k+ysSy2VZudFAJxkq3mfnuSrmMu7Pj0H7vBJlroCsQ==@vger.kernel.org
X-Received: by 2002:a05:6402:2686:b0:607:f64a:47f9 with SMTP id
 4fb4d7f45d1cf-61281f226d2mr26921a12.3.1752597788853; Tue, 15 Jul 2025
 09:43:08 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-rt-users@vger.kernel.org
List-Id: <linux-rt-users.vger.kernel.org>
List-Subscribe: <mailto:linux-rt-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rt-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <cover.1752581388.git.namcao@linutronix.de> <ec92458ea357ec503c737ead0f10b2c6e4c37d47.1752581388.git.namcao@linutronix.de>
In-Reply-To: <ec92458ea357ec503c737ead0f10b2c6e4c37d47.1752581388.git.namcao@linutronix.de>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Tue, 15 Jul 2025 09:42:52 -0700
X-Gmail-Original-Message-ID: <CAHk-=wheHZRWPyNNoqXB8+ygw2PqEYjbyKQfSbYpirecg5K1Nw@mail.gmail.com>
X-Gm-Features: Ac12FXwEFq81tRpxQQo-YtMJ6UxIp_wzb2appHmE6OGEEPULt8cuT-X-Zaqr3nQ
Message-ID: <CAHk-=wheHZRWPyNNoqXB8+ygw2PqEYjbyKQfSbYpirecg5K1Nw@mail.gmail.com>
Subject: Re: [PATCH v4 1/1] eventpoll: Replace rwlock with spinlock
To: Nam Cao <namcao@linutronix.de>
Cc: Christian Brauner <brauner@kernel.org>, Xi Ruoyao <xry111@xry111.site>, 
	Frederic Weisbecker <frederic@kernel.org>, Valentin Schneider <vschneid@redhat.com>, 
	Alexander Viro <viro@zeniv.linux.org.uk>, Jan Kara <jack@suse.cz>, 
	Sebastian Andrzej Siewior <bigeasy@linutronix.de>, John Ogness <john.ogness@linutronix.de>, 
	K Prateek Nayak <kprateek.nayak@amd.com>, Clark Williams <clrkwllms@kernel.org>, 
	Steven Rostedt <rostedt@goodmis.org>, linux-fsdevel@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-rt-devel@lists.linux.dev, 
	linux-rt-users@vger.kernel.org, Joe Damato <jdamato@fastly.com>, 
	Martin Karsten <mkarsten@uwaterloo.ca>, Jens Axboe <axboe@kernel.dk>, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Tue, 15 Jul 2025 at 05:47, Nam Cao <namcao@linutronix.de> wrote:
>
>  fs/eventpoll.c | 139 +++++++++----------------------------------------
>  1 file changed, 26 insertions(+), 113 deletions(-)

Yeah, this is more like the kind of diffstat I like to see for
eventpoll. Plus it makes things fundamentally simpler.

It might be worth looking at ep_poll_callback() - the only case that
had read_lock_irqsave() - and seeing if perhaps some of the tests
inside the lock might be done optimistically, or delayed to after the
lock.

For example, the whole wakeup sequence looks like it should be done
*after* the ep->lock has been released, because it uses its own lock
(ie the

                if (sync)
                        wake_up_sync(&ep->wq);
                else
                        wake_up(&ep->wq);

thing uses the wq lock, and there is nothing that ep->lock protects
there as far as I can tell.

So I think this has some potential for _simple_ optimizations, but I'm
not sure how worth it it is.

Thanks,
          Linus
