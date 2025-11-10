Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A0E11321F31
	for <linux-rt-users@vger.kernel.org>; Mon, 10 Nov 2025 19:13:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762801985; cv=none; b=it2nk1/5KS2b+/+EzwKoD79ObhkAizVyPR7lCXaJiaI2gwiWaq+/0p/6ib5lINoNuDfSUr679I11a7V9s9e4C8SqkiZ+JrjwXOIU2QU8UIU10zx/2ion40C/YYh4bTa0fdEiaV2oagAe5TkgGhWufHIhCuVKFW3qWX8YIREHiRA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762801985; c=relaxed/simple;
	bh=6viUguZeGHSulo8pEiooJQk72QFSCpyvqhSPXq0D/jI=;
	h=Date:From:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=XtQ9VZ8QOuIQQOYvvl8/mui7j9JP7qceBc7Omz4r2JgZcbRMFiwMH0mS+ZHu+w8VHsn7qsqVQ4AO8YasbW0ZifU/7X1kZaS2ql34j/XQR4q9hfJMk96jbam+dc2QduDJIxUrXXfjZzsXtOy+DtnKBF4C7dXsdLqlncx4yP28BqQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=e0ZGtwhY; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=uIWT6Iq4; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="e0ZGtwhY";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="uIWT6Iq4"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1762801982;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=TecpmgOMmFpwDI7tQ5nY0GgdQN39n4+RQMVhA9jhTgI=;
	b=e0ZGtwhYJZv263aEi3nOTzzUX2wGjVoYBKvh+sE/QWSxz5o9nrdH1/32rgnX/ZO3oJNaV7
	CTTfUGf1ksAgGDEAKGgS8/lvXPu/057jaJjFRZlsVsshdK5TA08IymRANe1FY4zk3XCB6X
	iQVWkbauAQPVOh/C67kg7JdY9fdzRHM=
Received: from mail-qv1-f72.google.com (mail-qv1-f72.google.com
 [209.85.219.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-638-WuuF48obMMSy8sixQnkTeg-1; Mon, 10 Nov 2025 14:13:01 -0500
X-MC-Unique: WuuF48obMMSy8sixQnkTeg-1
X-Mimecast-MFC-AGG-ID: WuuF48obMMSy8sixQnkTeg_1762801981
Received: by mail-qv1-f72.google.com with SMTP id 6a1803df08f44-880441e0f93so2363836d6.1
        for <linux-rt-users@vger.kernel.org>; Mon, 10 Nov 2025 11:13:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1762801980; x=1763406780; darn=vger.kernel.org;
        h=mime-version:references:message-id:in-reply-to:subject:cc:to:from
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=TecpmgOMmFpwDI7tQ5nY0GgdQN39n4+RQMVhA9jhTgI=;
        b=uIWT6Iq4VEqfmGrsA1nxQ/OelmIV4YnT2Tc9hFJokPfUONaMRUuidyfRZ+SjmWJEqL
         3dmRaz7e70NtLjj4POwx9P5/XBCC58KQldQkEPgrX3ewWRiFVoNglBlRtI4mSsH98Xao
         +/Qg6filg05LldATwD+eMpIpzti6Uk7cf8/S4bqXrsuwUO0lalGnZ9hZ5EeVgx2WV4Si
         EAnn5h5+CnAAPM/+kIMskfdLGTl1QBDqKxGutxhDvga08e3or9AnNlxXFLDh8Ow3xLMj
         BejBIRxSaYQXk55cNYJ4Ag/VHAiIVy0mP9SKoZ9pNcOjWWSob0prXqGSvelAp9tu0hyE
         5uIw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762801980; x=1763406780;
        h=mime-version:references:message-id:in-reply-to:subject:cc:to:from
         :date:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=TecpmgOMmFpwDI7tQ5nY0GgdQN39n4+RQMVhA9jhTgI=;
        b=FXPV6om9B/xpP0cJURYVWHwcaqg0tiy2zZgy/KuGyo55Cn6ieo5rsQ9U9KEcdCLzmM
         O8Gjey49THTzfpty7th7SzC390F0c03D26yX7ERbdOUQcmz8wazu0uJkADXuwSXki6ZB
         bDBbd60JvvcSdolVFV7TZG0dSJ8DoCplCp8zMm9rf0XEAs/hX06uY1+sUwIxtxC+he9K
         wphkHxg4sFY36ZUB4kS8nr9XLP6h74PNfCcOfQWLpMmBVXuDyZ6N58ibHiWHb5nHyA7b
         g48R0wszpqARPFUyFzVD+wmq3t+yUslzqKjqqF3Y4vCXokxjMSLmZGAVOox2LNTifTph
         TJaA==
X-Forwarded-Encrypted: i=1; AJvYcCUYyd8qxxa2ux9SrnH5iFT2IzCdRslzEgJAGMOYlGXPdqW4MWF6tooMPM9CQ6BCqTQ794m36OSlAhmKfqr3Gg==@vger.kernel.org
X-Gm-Message-State: AOJu0YzssJAQM4naQpn15XW4OIMTgzgSlltZQRrGT29JStdbnOdGXI4e
	skZI7SYV9qdaLU2rGI9ZHdP3+QJn2MiWIrYzSL/HhQeNXVwemobHC90rnHREHQHRqREjzZmTuT7
	FcMAhPSGWguIUUJR7H1+q0SvcQ1HtblVpp5KFazOrHcqrMp4G5WK95k2tOqtRNdpPf4ri
X-Gm-Gg: ASbGncsEIZh9+GL5/UObmyCoV3Ynz16rN2YowQ0dM8LF+VL0oIqwuCZtG6j4GwJX8Yx
	g8JJDzNO/q9eXWzDDcTnKxM0sqPCct2h4+bDwZOUEor9lSBFu5x2sIegzV4N7Gm2l4HHBQyQoLe
	Pi7U4cUBbRvZWxFeLolIuSqZ5xOx8MrDdSsMvOhQTTx1EdIf73Sy8UYD1VoghveiZwTMvKkxFN8
	vz5bKuvxNJbniX8P1OveFPARaNL0OwJTrQrU/ekNPiDaMFK/YMi8CtPHOigg2oCSXfwxs0ufDUA
	2W7ibyWrNo7A382CVPevpmDSdd0gQYMmanBwobIEGlp0fWnMWUQMBd7lDUrnL5IS+6kIq1tlIn+
	OTBiLqkXtLTewsRoBU2MBX6GKJ8rJuFa1R464IyKdzwF1GzZe
X-Received: by 2002:a05:6214:1bc9:b0:882:4378:622b with SMTP id 6a1803df08f44-8825e79d64emr7740796d6.12.1762801980691;
        Mon, 10 Nov 2025 11:13:00 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFVn9hen2h6wxpFCDrXWxgW7azDmmcYADmtRbPgoNAGBgexT+Y/ab6h7q8N3dOqyqCnYKngeQ==
X-Received: by 2002:a05:6214:1bc9:b0:882:4378:622b with SMTP id 6a1803df08f44-8825e79d64emr7740546d6.12.1762801980346;
        Mon, 10 Nov 2025 11:13:00 -0800 (PST)
Received: from fionn (bras-base-rdwyon0604w-grc-08-174-88-40-44.dsl.bell.ca. [174.88.40.44])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-88238b4045csm57183196d6.30.2025.11.10.11.12.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 10 Nov 2025 11:12:59 -0800 (PST)
Date: Mon, 10 Nov 2025 14:12:58 -0500 (EST)
From: John Kacur <jkacur@redhat.com>
To: Tomas Glozar <tglozar@redhat.com>
cc: Clark Williams <williams@redhat.com>, 
    Linux RT Users <linux-rt-users@vger.kernel.org>
Subject: Re: [PATCH v2 3/3] rteval: Add README-tests
In-Reply-To: <20251107134749.257350-3-tglozar@redhat.com>
Message-ID: <a0569c19-f4e8-e818-4dd3-d955bc6c8db6@redhat.com>
References: <20251107134749.257350-1-tglozar@redhat.com> <20251107134749.257350-3-tglozar@redhat.com>
Precedence: bulk
X-Mailing-List: linux-rt-users@vger.kernel.org
List-Id: <linux-rt-users.vger.kernel.org>
List-Subscribe: <mailto:linux-rt-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rt-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII


8<

    - Fixed spelling of Successfully
    - Changed file permissions from 100755 to 100644
    Signed-off-by: John Kacur <jkacur@redhat.com>

