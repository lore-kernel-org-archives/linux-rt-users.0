Received: from mail-ej1-f45.google.com (mail-ej1-f45.google.com [209.85.218.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6151C25EFB6
	for <linux-rt-users@vger.kernel.org>; Mon, 14 Jul 2025 16:17:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752509839; cv=none; b=DnFcp3Ry/VS/GVHf8Q3sbrsB4XbqCBzklFCBD5UroR1QDfbaiL0nci9fvAIFtPCuWapuXQkbtPRRSI7fFdh0d2Q6hOFU6TcPUuO6FHDzxu84D7B5N45kWwQMM472eaom5PxduV/qwkA8CSzsk6kWX9BF+GIHx8J5OJla2/LSoNM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752509839; c=relaxed/simple;
	bh=i/R26POJP4dDcBivK5gMdeMHp+1pQls5mGnd176yHgM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=oAP+vCdxdb4M7GaWkq8rDoNGSrfglLQhuXtspDaQpGsZwFo2bIqa66IQFyw0fC8NmqhOmBq92yErzL9H2K6u0dWU3Cp9uAvKqhXXc+HqbOJd1Zc1T/YlBcc6r9d93dp6MahLNOWdB16OEDGUKwOW61y3FOWc62JKgSVZQEVYBGM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=D1eWxC3S; arc=none smtp.client-ip=209.85.218.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="D1eWxC3S"
Received: by mail-ej1-f45.google.com with SMTP id a640c23a62f3a-ae0e0271d82so817105366b.3
        for <linux-rt-users@vger.kernel.org>; Mon, 14 Jul 2025 09:17:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1752509835; x=1753114635; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=nEQq66OWWE9JtkTfXjKqpWkex8XQYQ6HwopNDNvjlsc=;
        b=D1eWxC3SuUctDTeonZF/eu1/bEecxFV+y31RuafrNjs1eJQVNdZGzucUTsLMdsUVPB
         ZA117tJLiRLNO+jvSNbMmFr+6QeN7rE871l811kSev5MezYneIF4aBK+bnQw/JoFKbqd
         XGLAz3rhaCEPm4GlZyTUkAqxELHMF0rsERPvs=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752509835; x=1753114635;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=nEQq66OWWE9JtkTfXjKqpWkex8XQYQ6HwopNDNvjlsc=;
        b=Etlc7ia2WDDiFLDpt/Ty28k4QnhQhMLvJJL1+TIW660EqBGvh379r8qE8HJsI+sFOv
         LWywZQjmRtxO87OxgquZlosjh/bRpfa1RphsEO/84hr1unflm2jv+yJS+OrFNEjXMiSD
         oDIaTwvwQ54K5QmczQpr/fNQ3olIpSZpE9Col//T5lyGG/tN1IRLu2K4qNbC0kDMxSES
         FdG6Q6M1zAtWidvLOaE16w3Mr4x3Ct1FncGnnwRcMg++l/lH7nh5bMBV7tSS00z7xSfc
         tg9SNSLRR5MUZgEOljZOqFqWgMkBipwbKMZLBMNH+qLgwF3ZEuDnzXtOF6CDAW0hSH7F
         TlBw==
X-Forwarded-Encrypted: i=1; AJvYcCXp2A+BGkYEVXeIadQFRcQOT++XKosPIK2U3i0Kd/4Bq6F6Xi11uGWhFPHrQLtsepN3Zw8sJ4WGowSMaw32IQ==@vger.kernel.org
X-Gm-Message-State: AOJu0Yx0zKSAoTo/atnyU/RQglyU+wPXAltdYYRVHtKvqeGETp888aod
	rLN+5ID74GOZNGLoRWYp0zTTYisQV1CTjIrQT03MsFoYhm5ajztb7vDloPMJugSscwqmQumPTr4
	nn2skX1E=
X-Gm-Gg: ASbGnctWfDwvxACq3q7rky4jOiONU2+SpU06ptmTB26L/jZ/3apo8+4yo3Wh1q3VJdv
	Jx9J2vD+8yvJDRuxGW6BtxF9SdiLcNzyIgOYIjY3IYh3QBQn8rDukWs2njZWSPzGyX+i/wVCSwj
	7yqiTzphKCeBOxLDtYcJUI/+YTWD2gIA0C+bLGHUzznbpe0mc6rCiFlNixtFiUonm645+kjRZFc
	ONapQeZTY4d4ady7kyv17Uv0v1hy3bLzFNcygQihdFOmI64+50NOcV+YOJSRIaEP4FA2EWUXx9t
	a1ThS0pH3TKM3LLsXbJ5cLQYUXROqYiogRHZiTXzpHgZ68B0dM5trsM/K3eyC1ognmue9lBq48m
	pyCg4oxmXcq+NnHfaPSBDP8oidu+op1yNR1as3BFGG4hfxw864BpzoUbAGlDxFX93PwgHrHVJ
X-Google-Smtp-Source: AGHT+IH2OCATE2itTlX0hBhopYnVa1k3csyOE4WV+IWKyevRwc/SNNGWlaXdLDorJ/FURT2JSatstQ==
X-Received: by 2002:a17:907:1b19:b0:ae0:c0b3:5656 with SMTP id a640c23a62f3a-ae6fbc8c8b7mr1491504866b.22.1752509835286;
        Mon, 14 Jul 2025 09:17:15 -0700 (PDT)
Received: from mail-ed1-f52.google.com (mail-ed1-f52.google.com. [209.85.208.52])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-ae6e8294c0asm828317666b.127.2025.07.14.09.17.13
        for <linux-rt-users@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 14 Jul 2025 09:17:13 -0700 (PDT)
Received: by mail-ed1-f52.google.com with SMTP id 4fb4d7f45d1cf-607cf70b00aso8697677a12.2
        for <linux-rt-users@vger.kernel.org>; Mon, 14 Jul 2025 09:17:13 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCUMOpw9jvyyiMBFhf7CdRFGuvP2dobZpTg7nhX4Apx5aZd1CvongoEV/riVEI+0EIWLSB4Ael39X0O4rlcm6w==@vger.kernel.org
X-Received: by 2002:aa7:d78f:0:b0:602:201:b46e with SMTP id
 4fb4d7f45d1cf-611e84f8dd6mr9695286a12.31.1752509833354; Mon, 14 Jul 2025
 09:17:13 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-rt-users@vger.kernel.org
List-Id: <linux-rt-users.vger.kernel.org>
List-Subscribe: <mailto:linux-rt-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rt-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250710034805.4FtG7AHC@linutronix.de> <20250710040607.GdzUE7A0@linutronix.de>
 <6f99476daa23858dc0536ca182038c8e80be53a2.camel@xry111.site>
 <20250710062127.QnaeZ8c7@linutronix.de> <d14bcceddd9f59a72ef54afced204815e9dd092e.camel@xry111.site>
 <20250710083236.V8WA6EFF@linutronix.de> <c720efb6a806e0ffa48e35d016e513943d15e7c0.camel@xry111.site>
 <20250711050217.OMtx7Cz6@linutronix.de> <20250711-ermangelung-darmentleerung-394cebde2708@brauner>
 <20250711095008.lBxtWQh6@linutronix.de> <20250714-leumund-sinnen-44309048c53d@brauner>
In-Reply-To: <20250714-leumund-sinnen-44309048c53d@brauner>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Mon, 14 Jul 2025 09:16:56 -0700
X-Gmail-Original-Message-ID: <CAHk-=whniDdvSeCEQD5aUzr79HnhZ=A+ftzr0p_mY+n_f0AMHg@mail.gmail.com>
X-Gm-Features: Ac12FXxWB0yp1KMBo5BvpABIxBDtYWLONaWyJRXqnq_-Wkoa7_1NLpHwfbQeSac
Message-ID: <CAHk-=whniDdvSeCEQD5aUzr79HnhZ=A+ftzr0p_mY+n_f0AMHg@mail.gmail.com>
Subject: Re: [PATCH v3] eventpoll: Fix priority inversion problem
To: Christian Brauner <brauner@kernel.org>
Cc: Nam Cao <namcao@linutronix.de>, Xi Ruoyao <xry111@xry111.site>, 
	Frederic Weisbecker <frederic@kernel.org>, Valentin Schneider <vschneid@redhat.com>, 
	Alexander Viro <viro@zeniv.linux.org.uk>, Jan Kara <jack@suse.cz>, 
	Sebastian Andrzej Siewior <bigeasy@linutronix.de>, John Ogness <john.ogness@linutronix.de>, 
	Clark Williams <clrkwllms@kernel.org>, Steven Rostedt <rostedt@goodmis.org>, 
	linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-rt-devel@lists.linux.dev, linux-rt-users@vger.kernel.org, 
	Joe Damato <jdamato@fastly.com>, Martin Karsten <mkarsten@uwaterloo.ca>, Jens Axboe <axboe@kernel.dk>
Content-Type: text/plain; charset="UTF-8"

On Mon, 14 Jul 2025 at 02:00, Christian Brauner <brauner@kernel.org> wrote:
>
> I was on the fence myself and I juggled the commit between vfs.fixes and
> vfs-6.17.misc because I wasn't sure whether we should consider such
> priority inversion fix something that's urgent or not.

Well, this time it actually helped that it didn't come in through the
merge window, because it made the bisection much shorter.

But in general, I do think that eventpoll should be considered to be
something that needs to die, rather than something that needs to be
improved upon. It's horrendous.

The indirections it does have been huge problems, even if they are
"powerful", because we've had lots of issues with recursion and loops,
which are all bad for reference counting - and not using reference
counting for lifetimes is just fundamentally a design bug.

For example, the vfs file close thing has a special
"eventpoll_release()" thing just because epoll can't use file
references for the references it holds (because that would just cause
recursive refs), and dammit, that's just the result of a fundamental
mis-design. And this is all after all the years of fixing outright
bugs (with hidden ones still lurking - unusually we had *another*
long-standing epoll bug fixed last week)

(Don't get me wrong: unix domain fd passing has caused all these
problems and more, so it's not like epoll is the *only* thing that
causes these kinds of horrendous issues, but unix domain fd passing
was something we did due to external reasons, not some self-inflicted
pain)

So this is just a heads-up that I will *NOT* be taking any epoll
patches AT ALL unless they are

 (a) obvious bug fixes

 (b) clearly separated into well-explained series with each individual
patch simple and obvious.

Because it was really a mistake to take that big epoll patch. That was
not a "small and obvious" fix to a big bug. That was literally a
"makes things worse" thing.

I didn't react very much to that patch because epoll has been fairly
calm for the last decade, and I had forgotten how much of a pain it
could be. So I was "whatever".

But this all re-awakened my "epoll is horrendous" memories.

Nam - please disregard performance as a primary thing in epoll. The
*only* thing that matters is "make it simpler, fix bugs".

Because long-term, epoll needs to die, or at least be seen as a legacy
interface that should be cut down, not something to be improved upon.

And yes, I hate epoll. It has caused *so* many problems over the
years. And it causes problems *outside* of epoll, ie we have that
horrendous pipe hackery:

         * Epoll nonsensically wants a wakeup whether the pipe
         * was already empty or not.

and the pipe code has that "poll_usage" flag just to deal with the
fallout of bad epoll fallout.

THAT was fun too.

Not.

              Linus
