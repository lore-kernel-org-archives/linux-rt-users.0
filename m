Received: from mail.nearlyone.de (mail.nearlyone.de [49.12.199.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8025F81720;
	Mon, 13 May 2024 20:47:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=49.12.199.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715633268; cv=none; b=FdmNkTcOXAIIvDHHEt2jXqMWewNG8iz+k0BK9167cnL9MyMOFuQZF+ObRWs/2Z/m1rLLFZJBkV+HqL93tzvgK/2bsOjMs6XDFXwpc2thJn63vNSy5KzqYK6scJ2dL2enFK09XoM3IQgSLpRmoYlY6YWsTLvDQi9TfmBEYAYJwsk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715633268; c=relaxed/simple;
	bh=UJBBxco8vlCXFrwL2rdHorUqQeY5Agk5Kikd6UwKDDs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ovgqBcz7sjI6Bk00p89CD1ol/sHLBC2t6191MlRJGlHKxsbZEP9WrxIlAVWRx4kuR/yiqlGarvJGmH6XeFGSNdPLq0zoBNsw8yDyD/DODiR082gQbXaWu0ds/FmPkZBD5zoX0/jPRDTS+WFhh88Oh1Ev/eGvrS5O4w9fJkmrovI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=monom.org; spf=pass smtp.mailfrom=monom.org; dkim=pass (2048-bit key) header.d=monom.org header.i=@monom.org header.b=hdTBfAO/; arc=none smtp.client-ip=49.12.199.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=monom.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=monom.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=monom.org header.i=@monom.org header.b="hdTBfAO/"
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 51BE2DB422;
	Mon, 13 May 2024 22:47:32 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=monom.org; s=dkim;
	t=1715633256; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 in-reply-to:references; bh=0uJiQ582lHn4ACjeoU6ecYjd0v8F9pqkd0xe3q/N7j4=;
	b=hdTBfAO/yWWjw2bJdgpCL0+drpq8qDhZLsg2jfb95XPbFefJsBQNK7ZqTC6+wmO/iX9x4+
	GezJe/cpuwYg3D8lyy6JTWWOuIfSghEv0Yyu3dtbDDtPrSx9k2nSWmPALi1tN3p8zhPKWZ
	WK1LUfb1CtduA78BrNOiWqdyCNBZjVbhGt3cgv7Qy977plhOqQagpgxE2bX8eUP3Im0j+/
	77R15m8StPKxPDR3n335MAN/OydKqH51cklILfaT/HpF4wDFv5eE7OkGrHx8qf047t2j4G
	1BkCN7o1BcZxCENGWP1M8UA8i3NHL6nkklBbzZk4B72yWjzPN9xE1dkn/qIyfg==
Date: Mon, 13 May 2024 22:47:29 +0200
From: Daniel Wagner <wagi@monom.org>
To: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Cc: LKML <linux-kernel@vger.kernel.org>, linux-rt-users@vger.kernel.org, 
	stable-rt@vger.kernel.org, Steven Rostedt <rostedt@goodmis.org>, 
	Thomas Gleixner <tglx@linutronix.de>, Tom Zanussi <tom.zanussi@linux.intel.com>, 
	Clark Williams <williams@redhat.com>
Subject: Re: [PATCH RT 0/1] Linux v4.19.312-rt134-rc3
Message-ID: <af3jd6f5pym7gflg3gzjxfinj7i4zovah4jg36f2p6whtsdfqv@iejgojacrut2>
References: <20240507151648.17883-1-wagi@monom.org>
 <20240513065935.hT5MCimc@linutronix.de>
Precedence: bulk
X-Mailing-List: linux-rt-users@vger.kernel.org
List-Id: <linux-rt-users.vger.kernel.org>
List-Subscribe: <mailto:linux-rt-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rt-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240513065935.hT5MCimc@linutronix.de>
X-Last-TLS-Session-Version: TLSv1.3

On Mon, May 13, 2024 at 08:59:35AM GMT, Sebastian Andrzej Siewior wrote:
> On 2024-05-07 17:16:47 [+0200], Daniel Wagner wrote:
> > Dear RT Folks,
> > 
> > This is the RT stable review cycle of patch 4.19.312-rt134-rc3.
> > 
> > Please scream at me if I messed something up. Please test the patches
> > too.
> >
> > The -rc release is also available on kernel.org
> 
> I do have to complain a bit. The whole diff contains only a diff against
> localversion while the content of interest not here. But but I guess it
> is what we talked about so... but for everyone else it looks like
> version increment.

Sure, the merge diff should also be included. This feature missing in
the tooling. I'll add it, so next time it should also contain also the
merge diff.
