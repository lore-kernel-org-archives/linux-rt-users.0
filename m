Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 444E6244694
	for <linux-rt-users@vger.kernel.org>; Mon, 26 Jan 2026 15:54:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=170.10.129.124
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769442880; cv=pass; b=XGP2uiZhi/FlKo4szjS+XprZp0X/Cc5H14DfBHSLBe5BAqGkh0mciKuPRm3roMpOnB43ayZLXq/ElkFz+01Dw/ry0Uo3OX/BR7oZ2KNJ57YPPjr03DsBnYisgf47NZE7KnbA17L+bRNs8VYTLPAI9MT37ThO027ELW/CqKe7H6w=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769442880; c=relaxed/simple;
	bh=MpMxKP9U06IiAQ0Y4PEcL3yYnGyLyry7ADP6MJQUGZg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=aC+XK/8IgMrhUWb27WXAYJRubibrfopJvusZg+xl8Wf1Fdy2ml/rstxnO152VeCpGaCPZFKSdAMTwmS5kR7H/r5xx8ti/SFf6NkhBrLzHphLSGWVDibtnbPmWPCdUyjkl5ZfR7qaUFmV32gMfhRKj7wZ4GhIu9oGIMAo3tJAHLo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=VTJYiwMK; arc=pass smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="VTJYiwMK"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1769442878;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=9Iaas2Dc8jMH5eXOMvFt7YFwDT13LIBljhZ8iVs6//Y=;
	b=VTJYiwMK2n6mGOSA0M5w07jcU/aR5mFbsofF13VKMoRq2NIBEaTA7P3JS1AHHOrVPoU7Qy
	TYJXKP1bQSCdU4LtGOpyeu1H03A+nFF7UNzx+I6Tco/fTOzhhH9/b9EPq/msMI198TgI6Q
	HHyPdICLlewqMbpmrTipPGa1zkJqX3M=
Received: from mail-lf1-f69.google.com (mail-lf1-f69.google.com
 [209.85.167.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-199-wKu9BjY8O-CTMZgELXeQuw-1; Mon, 26 Jan 2026 10:54:36 -0500
X-MC-Unique: wKu9BjY8O-CTMZgELXeQuw-1
X-Mimecast-MFC-AGG-ID: wKu9BjY8O-CTMZgELXeQuw_1769442875
Received: by mail-lf1-f69.google.com with SMTP id 2adb3069b0e04-59b70088327so2754523e87.1
        for <linux-rt-users@vger.kernel.org>; Mon, 26 Jan 2026 07:54:36 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1769442875; cv=none;
        d=google.com; s=arc-20240605;
        b=NmO6jCmPMWgAxKzaTiatjZKIESzG8IMeSM9ImBOFc6SMje37AuGak/Zx7yNu1QQNPR
         +FTKeEQ1iNQbiCxkEm9C/TsfjpvRnlWOXyfWbsGzZtPTX2NGqxG4YqCCrwivsk7VYWy3
         HJYjiQjh2QTOm4brVRCQcFztgRZO5WHax4jtwnB4zZrZDUkR5H0XQMIQKRWT0IqG2xn8
         margbmP5OMjseG/w2xog0DOhWvH6F9qgQPUxaTeoBDH3Cw3X5Usl9FY6ptP3g6XhZndz
         +OrqEm/TrJC28Az8HdsPgMGykEI2i+omjk7TrolmMn+O1nWgtdtG0dRagJ8csGKXwLnl
         Y/9g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version;
        bh=9Iaas2Dc8jMH5eXOMvFt7YFwDT13LIBljhZ8iVs6//Y=;
        fh=1ZmO+QwsROojI3atSj0hRBJgfHKZ0F6HdUA7Qqb7rI4=;
        b=Cshud4VXvHh0vcazQ9byCEGhCgI/aR71wbiCpS+Fb1+cd3eBMoYz9tMpEeGqpkErrV
         YTVDy3ZcgJx9JNFxoi9nYCU0KPpzbuY8m2CxIfuzbmyhoaZ5pKtI27mJ3RgX5MfKQqDw
         tA36uYYA44tXeada7ELyPTDBTDlkVKZZeyuFp43thn6CSpbj90FD/kpXgU/pD8LxNy0V
         BQreIlXZHMF7qvSw7yWkN5VeM/0cyxLS+WsZlJFE7+XHV5a7WLCZZVoG8/7QqN25pyjV
         NW6JiT5ve5krlNxoBzKpc+M8mMTcbaL7NSEbjigajl/8Pwx5+wNN/BBGNvX0ezg7eGIZ
         xY9Q==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769442875; x=1770047675;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=9Iaas2Dc8jMH5eXOMvFt7YFwDT13LIBljhZ8iVs6//Y=;
        b=cSYr/GmANgOpB0rVlmu8G9PCB1toRuYJUESc29TOl+anhB9WSprAyAZlOvRbhD0TcK
         qYOhcoZO33Jvf8yf/c2/gqfIKI+m9ek+Y1R7OZ9xo+GDvXWfuz8CbojcJlAmAb1Lmif4
         Wp0iqxGmY3c5E4rHIrOs3zjoxibaU6HSOW10mq9VBT8rHqLJhkwGMsqmwB/hZ0ACXwbz
         mBuqL+FHGRUkE7bQVJ7RTvu82pxvs3J/WUR3xeSuzRqgZWEyou161XtueiNKwQBlFPm2
         xbtKvoRQJoRneXWTs5OOX5lpgqKlUrm9GhXyCYpC/6E852/5Pc0+LMSIMjR1g1/3IYev
         O4+Q==
X-Forwarded-Encrypted: i=1; AJvYcCWFapRZpCh2gunpnUdlPsikUcHgEClwwatOQB9mFoeLAXqQ+wnRXig8X6K77N2lWpJ6QwPAVGi+gLPGjBwtJw==@vger.kernel.org
X-Gm-Message-State: AOJu0YwKt70ISThU98LMaYJ4bu75azL/KpPpiSTJ8q4l4WtAI0Gfyek5
	aHxfF3j0dD7D6yKoqa5BNIul78h61mpieDp38WeJd0GB9yMV3roeuZr1gXY6yLG0uh193xVm4iQ
	SrXzX/R4rPH9mVuhOSOKwfAyj68qYYSLAnLW0vhNtTupRL3gYdEd3DgnwwDiFCCgA2DyQfMgRO4
	9fSg361tZXgy63cEG6fCMPk8mLelg8cK1HhiwL8pjEP4c=
X-Gm-Gg: AZuq6aK6Va6CcTovaazxAaWHnqLRDiY7cQOduztjEVPSyBZ2uLasnqopw+pB3OfgSJf
	2bJPndCP9GPQFMYOMo2FdT2InmijBxWXIWk/Djq+8lBm6NdnmhQ9JIkqFCEWRqNQb/Y8e2tPR4T
	73uIDicmOpBl2OKoOyWnsQRkBYcaH6sjBd8ezvV99bWQXTpIbcKDUy9FTFRoSv8F1kms0f+u8GD
	AnpYgukLyf5kPDFJFbfybHkwskzoByooJPgQIcSPt29w6rk/DLBxKkzcrXBMNZ1k49bNvbqXalU
	Xp6iFisIdQNK
X-Received: by 2002:ac2:5695:0:b0:59d:f71b:3608 with SMTP id 2adb3069b0e04-59df71b3791mr1423786e87.31.1769442875056;
        Mon, 26 Jan 2026 07:54:35 -0800 (PST)
X-Received: by 2002:ac2:5695:0:b0:59d:f71b:3608 with SMTP id
 2adb3069b0e04-59df71b3791mr1423774e87.31.1769442874610; Mon, 26 Jan 2026
 07:54:34 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-rt-users@vger.kernel.org
List-Id: <linux-rt-users.vger.kernel.org>
List-Subscribe: <mailto:linux-rt-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rt-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260126130557.45950-2-wander@redhat.com> <6u67jhrwjfkhu3fv2vfr2ejwozruhafuo3xjdkasxiotum5trn@e3uhbogw5qt2>
In-Reply-To: <6u67jhrwjfkhu3fv2vfr2ejwozruhafuo3xjdkasxiotum5trn@e3uhbogw5qt2>
From: Wander Lairson Costa <wander@redhat.com>
Date: Mon, 26 Jan 2026 12:54:23 -0300
X-Gm-Features: AZwV_QjmikNX78RwNX4JvrlxHSePb8vzi0uYMkQjucWrtPL5_XeT80Lx18aCxUk
Message-ID: <CAAq0SUm03h=D39PLGzKG+bgPWBageM2VtR-RrSj8YHTTua+BTw@mail.gmail.com>
Subject: Re: [PATCH stalld] Remove developer-specific configuration files
To: debarbos@redhat.com
Cc: williams@redhat.com, linux-rt-users@vger.kernel.org, jkacur@redhat.com, 
	juri.lelli@redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Jan 26, 2026 at 12:23=E2=80=AFPM Derek Barbosa <debarbos@redhat.com=
> wrote:
>
> On Mon, Jan 26, 2026 at 10:05:30AM -0300, Wander Lairson Costa wrote:
> > These files represent individual developer tooling configurations and
> > should not be tracked in version control. Their presence leads to
> > unnecessary diffs and conflicts as setups vary between contributors.
> >
> > This change removes the .claude directory contents, including project
> > instructions, agent definitions, session state, and behavior rules.
> >
> > Signed-off-by: Wander Lairson Costa <wander@redhat.com>
> > ---
> >  .claude/CLAUDE.md                        |  585 -----------
>
> Hi Wander,
>
> I agree with the sentiment of the patch -- but maybe we would like to kee=
p some
> version of a claude.md/gemini.md file? It would certainly help with anyon=
e
> trying to approach this project with some sort of agent-assisted coding t=
ool
> (rather than having the agent infer the architecture of the project, etc)=
.
>

Both Claude and Gemini provide the /init command to generate the
initialization files. I,
for example, always use Serena [1] and PAL [2] MCPs to improve the
file after I run /init.
This would cause changes in the CLAUDE.md file. I am unsure if any IA
related configuration
file should stay in the repo.

[1] https://github.com/oraios/serena

[2] https://github.com/BeehiveInnovations/pal-mcp-server

> Otherwise, LGTM!
>
> --
> Derek <debarbos@redhat.com>
>

