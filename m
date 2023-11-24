Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="JRb+Re4r"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AB36710F0
	for <linux-rt-users@vger.kernel.org>; Fri, 24 Nov 2023 12:06:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1700856376;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=1CKZA/F4Rn7gz8f0sZLs/ft0ohH76+o+/BZxrfGutN8=;
	b=JRb+Re4r8mGkRLMnet5/73PvIalpOFY/UxFkp2JP/5lpKfqxLWRqGNLyzqt65Pf9Zcmh/0
	q/NzzDJETt2jn0F4oeaEIaXgxCQtkmiSfo2Vd04kArL1crTcnPAGlm08OdaX95e2rGmpm4
	GdmuERvV3tUVI/RZ42u0LRt6dsXCM5c=
Received: from mail-qv1-f69.google.com (mail-qv1-f69.google.com
 [209.85.219.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-300-uAulkI6xOz-vl5VoRlaxuw-1; Fri, 24 Nov 2023 15:06:14 -0500
X-MC-Unique: uAulkI6xOz-vl5VoRlaxuw-1
Received: by mail-qv1-f69.google.com with SMTP id 6a1803df08f44-679f44810d9so22106556d6.0
        for <linux-rt-users@vger.kernel.org>; Fri, 24 Nov 2023 12:06:14 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700856373; x=1701461173;
        h=mime-version:references:message-id:in-reply-to:subject:cc:to:from
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=1CKZA/F4Rn7gz8f0sZLs/ft0ohH76+o+/BZxrfGutN8=;
        b=WcXCZs17/Al7IzBFYGggrovkrgPJHqSWp77ewO/VI5QE1/Q4hA7MVu+pwGL4HBZmYu
         HK2ZE77o+sDxn//vwvBf7DRqa1h0au1SSA5pOBkqlm7aBFeBMTKWtyPcBMtfNOfoIb8L
         c9GYUok/Vb1YPtAlsVLVWobhNtHSV0kuHIZQcew6RHWawY+rWj4u+oJtupTFSV8HET7J
         uMFiFkz7jMO4xyLEN4+W2Se6wzS0Y5JKxmgVC6UZwUR7eoygY30KNv6BjWjb7pLaFk8i
         GfbRF4eO7K1mwVMoR7sB6/Mk3Mf7tDwc8rx4sMYgs/PqfAOtMp3SRKeOR9Csy3I+RX/I
         CSAQ==
X-Gm-Message-State: AOJu0YwraLyNxzJyBulLM/LI1UbqGWg7tn+BHJLAZcum8wayoUHuxPgD
	TsARWZALt4o5CfEsY2wGySVNzuTH2fydgldowOa2U3eKABbnPo0TAGN2A6JIqIrZtnLk5oocXPJ
	aDEKYLJhI9VfhXmKQLppNKQAEi4fvKEl+l1c=
X-Received: by 2002:a0c:f950:0:b0:67a:fe3:face with SMTP id i16-20020a0cf950000000b0067a0fe3facemr3897656qvo.64.1700856373735;
        Fri, 24 Nov 2023 12:06:13 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHYOh31XJIiSaxLOB3oTBIbgMFSjfeAK5X/oBrlI/qNOCzaeEo94EGTQdz+GRT94lsrpSVTFg==
X-Received: by 2002:a0c:f950:0:b0:67a:fe3:face with SMTP id i16-20020a0cf950000000b0067a0fe3facemr3897644qvo.64.1700856373494;
        Fri, 24 Nov 2023 12:06:13 -0800 (PST)
Received: from fionn ([174.88.88.134])
        by smtp.gmail.com with ESMTPSA id z11-20020a0cf24b000000b0065cfec43097sm1639910qvl.39.2023.11.24.12.06.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 24 Nov 2023 12:06:13 -0800 (PST)
Date: Fri, 24 Nov 2023 15:06:04 -0500 (EST)
From: John Kacur <jkacur@redhat.com>
To: Tomas Glozar <tglozar@redhat.com>
cc: linux-rt-users@vger.kernel.org
Subject: Re: [PATCH v2 2/3] rteval: Minor improvements to CpuList class
In-Reply-To: <CAP4=nvTpOYvLoDMFpDcxHuFTMcyr5tdmuPM0W0pvZxrXkOHVPQ@mail.gmail.com>
Message-ID: <7f7f3c57-8c38-6b89-8988-071e3d16a1ee@redhat.com>
References: <20231123072436.270267-1-tglozar@redhat.com> <20231123072436.270267-3-tglozar@redhat.com> <7b393164-b0fa-5c2f-45f9-6289ad8813fc@redhat.com> <CAP4=nvQ3cQU+8XwxsHkNckj87EpkyrJeNPA+T71-XqswNJaRuQ@mail.gmail.com> <b0becd53-9629-51de-4f88-776d2b59f4f5@redhat.com>
 <CAP4=nvTpOYvLoDMFpDcxHuFTMcyr5tdmuPM0W0pvZxrXkOHVPQ@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-rt-users@vger.kernel.org
List-Id: <linux-rt-users.vger.kernel.org>
List-Subscribe: <mailto:linux-rt-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rt-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="-1463771134-1585067869-1700856373=:12855"

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

---1463771134-1585067869-1700856373=:12855
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT



On Fri, 24 Nov 2023, Tomas Glozar wrote:

> pá 24. 11. 2023 v 16:27 odesílatel John Kacur <jkacur@redhat.com> napsal:
> > Or just check cpu1 like we already do!
> >
> > John
> 
> That won't work on machines that have only one CPU though.
> 

Sure it will, because if a machine only has one CPU we assume that it is 
online. :)

if cpu0 has an online file because it can be turned off, we will use it.
if cpu0 doesn't have the online file, it can't be turned off.

Are online files configured? check cpu1, done.

John
---1463771134-1585067869-1700856373=:12855--

