Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AA00721171D
	for <linux-rt-users@vger.kernel.org>; Mon, 18 Aug 2025 19:18:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755544713; cv=none; b=Xlfw2cwhxMDoSHuHZq0xQkarb1dK8EvJ5uNc1SpAPx6M7iDZo9Vt+J3gn90+xqXMuuvQpcgr+c5koRHyMo3t8rAMILMt9m4lx9EX4+YAiJ9OcHHVDM7vLbzaBWz1uvdEzGXngqwfpvaTSQoplkfFBOafRGm9fc5/DPULXEvaXek=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755544713; c=relaxed/simple;
	bh=dsd0VwrwJpSfhtt/4o54ldUy6Kx1SU28U9FNHOc8zrA=;
	h=Date:From:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=tQctfev2myWJXNNm2JZ3+wXbPbcCgNBbiL9lb8uerSK9PojxRuqcfXnq7CqwmEXqgZ9HWyHx/1FwcJojwNSutz8J8U1t+DywufmLvk1kNDdt6Pct6tJVMs8QamCwKJBtM3abGIAbdffcqzck1V35Wp7+UUkaX5RocB1RAX0zTbc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=C/EJ5wZH; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="C/EJ5wZH"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1755544710;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=IsZfVy+rOo/5KWxxvxBgVedZjzlddxshrwNUqRaEJik=;
	b=C/EJ5wZHDWJC7WkiHUg8ue3EqbeRRN7+ToOkHi22QZClDxD4dQxfiZY1Q8gYtqX5TZIQfO
	XMnE+r8rXg+lFOMxDdb4RiFjPju6Y8/h0FNMZ2whz3/WctBqBcf4wipCjOn2lN0Jhk7ns4
	5f5jiQKDy7QqKeq+ymd/J2Ntx8fPOoI=
Received: from mail-qt1-f198.google.com (mail-qt1-f198.google.com
 [209.85.160.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-549-HsLmZtaAM6WEPeaRDz9y7Q-1; Mon, 18 Aug 2025 15:18:29 -0400
X-MC-Unique: HsLmZtaAM6WEPeaRDz9y7Q-1
X-Mimecast-MFC-AGG-ID: HsLmZtaAM6WEPeaRDz9y7Q_1755544709
Received: by mail-qt1-f198.google.com with SMTP id d75a77b69052e-4b109912dd8so43910611cf.0
        for <linux-rt-users@vger.kernel.org>; Mon, 18 Aug 2025 12:18:29 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755544709; x=1756149509;
        h=mime-version:references:message-id:in-reply-to:subject:cc:to:from
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=IsZfVy+rOo/5KWxxvxBgVedZjzlddxshrwNUqRaEJik=;
        b=BgMmlX9c11F9/p/F0IbKfnH/5lWqiFvGTtEKkOdkJ194iW+kmS90tDapaj5p8Fnipk
         Mm5JikDxSRLiAT9ImzFlpszMogrMHRRrlDlSG2KnyDNtBHEOf8JPkm+1kaUgCApZpyus
         w8Ac4bugRQvozD7l3TMOfWX7a/TRd3y42IjDPldY78uXPWezWI1SmD+hl0w6DpQBYqEv
         G0PfmzeGqTctveHCNPtl/dcF6pWbT1KHJ72VFTlGg56yiBmV1JVIf40rS05iStJQbkZK
         oLl6dV/+muUaJkFU1Xs7o2T56rSImMqVwHxuDBS0DUUzQamCn4qpLD0nkGsQwuMpiRe5
         34Tw==
X-Forwarded-Encrypted: i=1; AJvYcCWc02qpmrb3dNPWJs6N/uIOs+ch7d5ydBoKjsnqeHC1IROhNGnpVnQ8OG3aRoNfpOM1YWcA2g7dYmCGxWstIQ==@vger.kernel.org
X-Gm-Message-State: AOJu0Yx1R+Z7bTPlW4mR5w7oKqtQWPgrBIdWuumK9B/CyloE1yv1QYHD
	7Y7DA2Li51g1UqtQfLK45rYYoaCLh+dCzIkkvW/pXd+OMXUXSSMoHibbPoYket/zx+ZBOowBdf+
	m0UxWnTpyH6dEMVyoK9zUz3AVusBG+LAOv8b0Y98Wbb3Azb3eyTehUZqBWCibxKvoRrw8
X-Gm-Gg: ASbGncsoaS3Se3rErv/IqxlrPZEoblt9KlnernDrKFQWrjT8QTHt+bSP7yRy/0JtZio
	JFG9RXAp7MzjTypdNOhmNydh3vRUYwQUpGuSOPkj5Nrr0u2vYyVVGhbmBNQGuOIG7DpGdi19jab
	GU9jbD+XLoQ3FQN2ayZV7gY+rB+zuAU7jTsMMp9dT1mEu+B83p2/NrKAo516G+Ia7RdVO04Dwi6
	UZnXasTjjQt9PdynfY215G48vMUafdYYqBoqDvGa0VNiqhdZXO2NHXF/jzdlBK38kj4R7bK2J1r
	Mqm3f2z4mJiTITF+9W+wBzdc63+IUeFapNBCq+WIklAoIXw4rg7qy9J6gTRjV2B0wIiiZTk/s3W
	o+UVWBXALXz5r
X-Received: by 2002:a05:622a:4808:b0:4ab:5277:a5ab with SMTP id d75a77b69052e-4b2855f68afmr3952831cf.6.1755544708704;
        Mon, 18 Aug 2025 12:18:28 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEYJhHPCMzQA9T5uFknUXxou402xmRIfZWV1rd6ocJWA9xKDYYiuLzvvDIPfXXKp13C+7EX4w==
X-Received: by 2002:a05:622a:4808:b0:4ab:5277:a5ab with SMTP id d75a77b69052e-4b2855f68afmr3952351cf.6.1755544708292;
        Mon, 18 Aug 2025 12:18:28 -0700 (PDT)
Received: from fionn (bras-base-rdwyon0604w-grc-10-70-49-165-78.dsl.bell.ca. [70.49.165.78])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-7e87e192272sm638271285a.42.2025.08.18.12.18.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 18 Aug 2025 12:18:27 -0700 (PDT)
Date: Mon, 18 Aug 2025 15:18:26 -0400 (EDT)
From: John Kacur <jkacur@redhat.com>
To: Thomas Petazzoni <thomas.petazzoni@bootlin.com>
cc: Sebastian Andrzej Siewior <bigeasy@linutronix.de>, 
    Kurt Kanzenbach <kurt@linutronix.de>, Clark Williams <williams@redhat.com>, 
    linux-rt-users <linux-rt-users@vger.kernel.org>
Subject: Re: rt-tests release tarball location
In-Reply-To: <20250813230637.19e2293e@windsurf>
Message-ID: <af905835-5920-366d-c41c-749555f95200@redhat.com>
References: <20241228114346.6020d6b0@windsurf> <87h66b2c6m.fsf@kurt.kurt.home> <20250107141424.EoC5uS6y@linutronix.de> <f87b2d77-7925-8678-d0fe-9a0d471a38f1@redhat.com> <20250109080555.WpQmRgu0@linutronix.de> <bb91bdda-8a07-1c99-5448-706460fdf1ce@redhat.com>
 <20250813230637.19e2293e@windsurf>
Precedence: bulk
X-Mailing-List: linux-rt-users@vger.kernel.org
List-Id: <linux-rt-users.vger.kernel.org>
List-Subscribe: <mailto:linux-rt-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rt-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII



On Wed, 13 Aug 2025, Thomas Petazzoni wrote:

> Hello John,
> 
> On Fri, 10 Jan 2025 11:46:01 -0500 (EST)
> John Kacur <jkacur@redhat.com> wrote:
> 
> > This option seems the least disruptive from my point of view.
> > I am now keeping all versions including the current version in
> > /pub/linux/utils/rt-tests/older
> 
> I am getting back to you on this, because the latest version is not in
> the /older/ subfolder, i.e the 2.9 version is not in the older/ folder.
> 
> Would it be possible to place it here, so that its URL is stable
> over time? 
> 
> Thanks a lot!
> 
> Thomas
> -- 

Done. Updating my scripts too.

John Kacur

