Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F1165139598
	for <linux-rt-users@vger.kernel.org>; Thu, 28 Mar 2024 21:07:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711660041; cv=none; b=i1xFq50Ez5zHFhmKkQgJEzrr4WWX24RX4xTno5F/srNzGJR6bAc27CdlIbMhdJTQI0oiUBQWDCaMbBxBqlcsOkG544rWdXDV+tFFJdesYGgXRO2chaSVfvaK9w3fqWIsLlaowjzptUaXO5fHCZ9jVPqf6jO9rmMjME61CB/GtMg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711660041; c=relaxed/simple;
	bh=EgR8Di9k2l1IdHnOjDoiCn5hKgh3QXGLUf9N5BzFwNI=;
	h=Date:From:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=KrOYhhJAIodX6SgP5FdWA5u1D93hKizb+LX3AL3sNE5V8YtFZPvx2FSJV73GKFxjUv2jtPAdmQ81QulEZ1L06P9ovNgyHVSFOy4J2mzhXA+s7YoQY88UtKlkFziPyPdeRkvuMUT4ghjDw/RCh6+RNqHWkjPRKQ5c/xQ54mwzPfc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=fq80I1B3; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="fq80I1B3"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1711660039;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=vlFCcQirhPtK8Se4G6y5qGwHELUc9fY/H9SBR7LICGs=;
	b=fq80I1B30mBbGCrMB7Mhui5jt+w5Lpri0tr9dAvNrOLCmEY37csk9AyZIe6uXMHo1QIcbY
	YI+0Yu6pdfskK+YcfHYQgrQPBWXXqDV5GvC7QeR89oRPN7G4g4HtCBaDd9r7A3A2nFOSJJ
	KFqGETw5kFNChK9iCJ2iQYRXdOiRVT8=
Received: from mail-oi1-f198.google.com (mail-oi1-f198.google.com
 [209.85.167.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-665-2LIJdq_uMYmmPZpcR7xCpg-1; Thu, 28 Mar 2024 17:07:16 -0400
X-MC-Unique: 2LIJdq_uMYmmPZpcR7xCpg-1
Received: by mail-oi1-f198.google.com with SMTP id 5614622812f47-3c3d20c5b3aso1634464b6e.0
        for <linux-rt-users@vger.kernel.org>; Thu, 28 Mar 2024 14:07:16 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711660036; x=1712264836;
        h=mime-version:references:message-id:in-reply-to:subject:cc:to:from
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=vlFCcQirhPtK8Se4G6y5qGwHELUc9fY/H9SBR7LICGs=;
        b=aGHYIs4CsMsQVaz5EIdIFCN5TpYdnpcEUWmDq4ipP2hR2ryr6e8D99nNIsafIzHASE
         nmuAwMNdwYd4qrbP4WR5Q6qnhzmlnKm7kLTBX/4qysoGOWksd1hEcXgoAzHlGPbqhllW
         lbjh1VMJA9U6TMgAqIuuEU4q0crujyZQFnGTNLJpefpuZ4qyAdrmv2oTI87m100kUPGH
         PyamoDFQaDswvYz7udqfNMxjGkxPHdmMbulKjr418yquFdH7jH7/sKPGsZ4XVHY2XgSH
         afN2Cm6yzK3He/8bNSWqY5ra7DgMLFIAyxo752uPfk66XBA4J+4zCHUekDn3Pi5tO3nF
         6p3Q==
X-Forwarded-Encrypted: i=1; AJvYcCW3klOTfC+n49fL7Lc9rl6cime1suLHltlmNW5p3HjR8eRb1kg4XY6gH1w3IPqiC3zaXch+8tXPJ2PNcHjypg0sGkyjk1QDlVFkTUqGkps=
X-Gm-Message-State: AOJu0Yx1ucp4MJUdZe8WYqeQuEw2CY0VD4NidBxP5hmqYfTIkRMOBBvx
	evlaVIuhpKFE+9ezHTlJcy9EE/BH6qGujIaC09Gor7Qq/rQvRN9ocBIahW0CWJqxvXUcOkPEYOZ
	ud7mhdHpudhqFkVP+1P5FvrlCEyLv6QV2g1Q/ZUoeX5Pmi/aNHVSQBwdtwddrQm6qddN12Yil
X-Received: by 2002:a05:6808:1446:b0:3c3:d60d:e8e2 with SMTP id x6-20020a056808144600b003c3d60de8e2mr414133oiv.34.1711660035857;
        Thu, 28 Mar 2024 14:07:15 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFhbQV66xba52zvryotr9SAykIobyDergY9UI5qhIrRuTsW9InJH4tUVBXi/JDob4QogphWOQ==
X-Received: by 2002:a05:6808:1446:b0:3c3:d60d:e8e2 with SMTP id x6-20020a056808144600b003c3d60de8e2mr414123oiv.34.1711660035573;
        Thu, 28 Mar 2024 14:07:15 -0700 (PDT)
Received: from fionn (bras-base-rdwyon0600w-grc-08-184-147-142-166.dsl.bell.ca. [184.147.142.166])
        by smtp.gmail.com with ESMTPSA id m12-20020a05620a220c00b00789f34f225dsm843702qkh.71.2024.03.28.14.07.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 28 Mar 2024 14:07:15 -0700 (PDT)
Date: Thu, 28 Mar 2024 17:07:09 -0400 (EDT)
From: John Kacur <jkacur@redhat.com>
To: Crystal Wood <crwood@redhat.com>
cc: Clark Williams <williams@redhat.com>, linux-rt-users@vger.kernel.org
Subject: Re: [PATCH 2/5] rteval: kcompile: Fix path lookups in
 _remove_build_dirs
In-Reply-To: <20240304211655.20174-3-crwood@redhat.com>
Message-ID: <2202c832-c69e-e432-dd96-55ac07eabb23@redhat.com>
References: <20240304211655.20174-1-crwood@redhat.com> <20240304211655.20174-3-crwood@redhat.com>
Precedence: bulk
X-Mailing-List: linux-rt-users@vger.kernel.org
List-Id: <linux-rt-users.vger.kernel.org>
List-Subscribe: <mailto:linux-rt-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rt-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII



On Mon, 4 Mar 2024, Crystal Wood wrote:

> - Use the actual source directory rather than the incorrect kernel* to
>   match what the tarball generates
> - Use glob to expand the node* wildcard
> - Fix the incorrect variable name in the error message
> 
> Signed-off-by: Crystal Wood <crwood@redhat.com>
> ---
>  rteval/modules/loads/kcompile.py | 5 ++---
>  1 file changed, 2 insertions(+), 3 deletions(-)
> 
> diff --git a/rteval/modules/loads/kcompile.py b/rteval/modules/loads/kcompile.py
> index b606f7aad202..de1539986723 100644
> --- a/rteval/modules/loads/kcompile.py
> +++ b/rteval/modules/loads/kcompile.py
> @@ -145,12 +145,11 @@ class Kcompile(CommandLineLoad):
>              return
>          self._log(Log.DEBUG, f"removing kcompile directories in {self.builddir}")
>          null = os.open("/dev/null", os.O_RDWR)
> -        cmd = ["rm", "-rf", os.path.join(self.builddir, "kernel*"),
> -               os.path.join(self.builddir, "node*")]
> +        cmd = ["rm", "-rf", self.mydir, *glob.glob(os.path.join(self.builddir, 'node*'))]
>          ret = subprocess.call(cmd, stdin=null, stdout=null, stderr=null)
>          if ret:
>              raise rtevalRuntimeError(self, \
> -                f"error removing builddir ({self.buildir}) (ret={ret})")
> +                f"error removing builddir ({self.builddir}) (ret={ret})")
>  
>      def _find_tarball(self):
>         # If the user specifies the full kernel name, check if available
> -- 
> 2.43.0

Signed-off-by: John Kacur <jkacur@redhat.com>

