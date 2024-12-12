Received: from mail-ed1-f45.google.com (mail-ed1-f45.google.com [209.85.208.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4D7E8205501
	for <linux-rt-users@vger.kernel.org>; Thu, 12 Dec 2024 17:18:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734023904; cv=none; b=TG/pfmfEIBWeyc42hTxh73rSFFfOpnGXDvNA1ViHIRnpjbuwTxNQMmkeq4fqP1RR4yuEzxk79SFvKELcPkATbEeyaOuJJSG280oj1G8iWTr8SU9571o9x6XyzqUM6SeVC7tczyYjEe3qVBVl0Ukzd+mFSxMdL0R72u8bu3Etxvk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734023904; c=relaxed/simple;
	bh=8x/Ez5WPPlJL7WRaLOcVorzkW/qE9MW8NsnRxId+Ouo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=PgdNkVUZwlSrSbP/+oeyNU4DOfu+A84b1PVYgXbq7564Yx4YWIzdOhCod/5gl6iHVAxmj8ma4qnkAF2mmp98QRN6k17RfuZ8lijrhBofpWGl81IF7YY8Y8qoOdsisLkD2qKt7BrT2Sl11t5lILNCuH9rkTFADP5Bq+jpgg5hxg8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=aurora.tech; spf=pass smtp.mailfrom=aurora.tech; dkim=pass (2048-bit key) header.d=aurora.tech header.i=@aurora.tech header.b=TLYnBLrS; arc=none smtp.client-ip=209.85.208.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=aurora.tech
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=aurora.tech
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=aurora.tech header.i=@aurora.tech header.b="TLYnBLrS"
Received: by mail-ed1-f45.google.com with SMTP id 4fb4d7f45d1cf-5d4e2aa7ea9so1581912a12.2
        for <linux-rt-users@vger.kernel.org>; Thu, 12 Dec 2024 09:18:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=aurora.tech; s=google; t=1734023900; x=1734628700; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=xQtZZLWBSlhX8pwYnk8EkE2uO/0Nyz16PVuPAavqlpw=;
        b=TLYnBLrS1FGUIZYv1VOCqNXTTeVkbPkX7vIysCiYnCeNKSTTkoBNL4FFM6KBl5FJMN
         7ON0yMYptebY+lZDwFMzpFnUjJI9CRjz6aWV4/MLz5odQV0CHA9l1iWwZ2Z50SZ71qI6
         VafbwZ1txeu2AkuIvvOTFRZqko0yPizWOLCuJNY49+a8POD8vn/9BUUOjU03TXV/1Ao7
         eM8ub4klVVwAQoxBqy6vikJG7Y9BZDpZQX2HkkAurJR6XP/Gc7/wG+vYJom0T0oPkiwH
         ptstmNebbpZmbGxG0BVGhH4ps8inhC3hvG3hofKaOHGL6m55kB3CQZ/zwEAHxUrEurte
         AbGQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1734023900; x=1734628700;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=xQtZZLWBSlhX8pwYnk8EkE2uO/0Nyz16PVuPAavqlpw=;
        b=UBgDujWwnoGvrNN0FuGr3CPygOCjR0FdvPC458zyJPMsLD74uLXutxFQwoeweOe28v
         IOxLp6NoBMpmAxGkek3bFHmzFYoRkBxTBOlKZQN/Znu43ffpPpAnZTvFaMmgzl562yJH
         vqjZQHK+rHbhNhJQ5BibnychLLJBJxS7kE6zZBxXb26ix7wKWEtHHN/PQ4E75j7DWroE
         S5GMHGykj6OXk012q3ER+CO/V7Ue9Gb3fL4HjaYtDgwOGZ7WyH7kWWBI+Z8H4OitkQVz
         yMYPRsqPhjKPT1w6PNpPNoloSKaZJ8TNW6dTwJ2ixIRgF0Gtz2uNTLsAgEoImZhTli0C
         CP2g==
X-Gm-Message-State: AOJu0YwtMGuWfOChgUXG6lP3QM+M6iV+cVjQy9ztJbjO3tKzB3xOkiof
	e1hs0Lhmd3q8GjVFDKTQwFqOqTyNsZjXBDSLw6XQod7DVFhZi7xTLuOc7VqCZcrMNpYIGwjwEOH
	5d/8Jy+J/qXLSdWa1CYmj5vOMQPU98wyEL4KhJg==
X-Gm-Gg: ASbGncvfNfCff9WdmCoAQHoT0uqF5WuskNqOIm+d1lU/i6y9SlknogSSWIH4sk6bvDA
	s6+3cbpdf+kgLor14bnualzboKj7qeWDzJh6+UZbxI4JIua3Iuvl6d9Fo53eqqnFB7VZzY8NW
X-Google-Smtp-Source: AGHT+IHUh2DOKwTwWpm7DFBrqnvee6pflYcllSqGPeknSeQ37DSkHnVyddm1Qg9jV7EhOqf2XnllHaJ80tD2wYaJr28=
X-Received: by 2002:a17:907:7717:b0:aa6:7cae:db98 with SMTP id
 a640c23a62f3a-aa6c1ab6285mr490785066b.10.1734023900545; Thu, 12 Dec 2024
 09:18:20 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-rt-users@vger.kernel.org
List-Id: <linux-rt-users.vger.kernel.org>
List-Subscribe: <mailto:linux-rt-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rt-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <BN0P110MB20671E1AA07D1F79721DB0B0F33FA@BN0P110MB2067.NAMP110.PROD.OUTLOOK.COM>
In-Reply-To: <BN0P110MB20671E1AA07D1F79721DB0B0F33FA@BN0P110MB2067.NAMP110.PROD.OUTLOOK.COM>
From: Alison Chaiken <achaiken@aurora.tech>
Date: Thu, 12 Dec 2024 09:18:09 -0800
Message-ID: <CAFzL-7ufN7zD2Gdf+9J_+bdiLAYxzqWEw6=WTmzXQpKni658kg@mail.gmail.com>
Subject: Re: Real-time app developer documentation
To: "Weber (US), Matthew L" <matthew.l.weber3@boeing.com>
Cc: "linux-rt-users@vger.kernel.org" <linux-rt-users@vger.kernel.org>, 
	"john.ogness@linutronix.de" <john.ogness@linutronix.de>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Matthew L <matthew.l.weber3@boeing.com> wrote:
> The ELISA (Linux in safety applications) foundation had a workshop this w=
eek with NASA and the topic of RT focused documentation came up.  My team a=
t Boeing is working on material to help application developers understand h=
ow to integrate their source code on a real-time Linux system.
>
> 1) Has anyone else sent a RFC with something similar that we should look =
at?
>
> 2) We'd like to collaborate on this if anyone else is willing to contribu=
te parts of the material.
>
> 3) Suggestions on how to start?  Should we RFC to this list and work to b=
uild up a submission for the main kernel list?
>
>
>
> Hi John,
>
> I've CC'd you as we noticed a lot of great material from your previous ta=
lks/checklist on real-time.  Do you mind if we use that as an outline and f=
or some of the content?
>
> Regards,
> Matt Weber
> Chair ELISA Aerospace WG
> Chief Software Architect Boeing Linux


The realtime wiki (https://wiki.linuxfoundation.org/realtime/start) is
the authoritative source of information.   There is also
Documentation/ in the kernel source tree.   The wiki in particular has
extensive advice for developers new to realtime, and can be edited by
anyone who requests an account.

--=20
Alison Chaiken
Aurora Innovation
