Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 01AC41FBBE4
	for <linux-rt-users@vger.kernel.org>; Tue, 14 Jan 2025 06:40:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736836858; cv=none; b=lclpqZBF4aL28GU1TEsFLQcf4ZpF7XasbNaZFxsPiYY+7MX3Z04J69KmySc30Nad3cNZF+cc/HEFG0GbdYRo5nouf4TOeeiIlDpmu8AEAt1Q2xt1JGE1abghba5Fc5sbbZqj1G7jYa9J9LCuYdv94QcF4hyyoKDZrsOEy0zOuRo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736836858; c=relaxed/simple;
	bh=UyEGOq7i0Ic0E4+gJ7U58Rix3eCxeIz+yvUvkGXcnxU=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=GoDh6MM4jrVRD65K3RBTUsIvkMm3NSojHc6MMwU/U96ClEXPQilbp+qoi0iBldJui9iwXSr8c+UbMzJR56cvkV6LIYPKPIPIlXncyHafL1a5Hy1Y651+dDS5QETZZ5gboxaiCAZpLK5er1YnFIo2O3LLNZvqEPhmDtW4yd04QKI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=E7aUEkFc; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="E7aUEkFc"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1736836855;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=UyEGOq7i0Ic0E4+gJ7U58Rix3eCxeIz+yvUvkGXcnxU=;
	b=E7aUEkFcst5gwIQgS1M51s/b8D8i6SKYgCE+GVqtTRReFhmhcQm55F7se0dsfMrOffkv5s
	/YxBLCQG4cj4+3kbrp0N3bQ+WFiu40qu7TjeqKQoZLEw97Xir0terQuIJ85CIEIVCN7nJB
	Fk6BWqCDVjLbfEvH8i6w2w/Hl+Johbg=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-671-vNxe3hvgPT2iX9MwGLUoBA-1; Tue, 14 Jan 2025 01:40:54 -0500
X-MC-Unique: vNxe3hvgPT2iX9MwGLUoBA-1
X-Mimecast-MFC-AGG-ID: vNxe3hvgPT2iX9MwGLUoBA
Received: by mail-wr1-f69.google.com with SMTP id ffacd0b85a97d-38639b4f19cso1106402f8f.0
        for <linux-rt-users@vger.kernel.org>; Mon, 13 Jan 2025 22:40:53 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1736836853; x=1737441653;
        h=mime-version:user-agent:content-transfer-encoding:autocrypt
         :references:in-reply-to:date:cc:to:from:subject:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=UyEGOq7i0Ic0E4+gJ7U58Rix3eCxeIz+yvUvkGXcnxU=;
        b=oBt1dBeH/eGeq6njq79YaPMjDKMxSR+fH+gPZSWw5zCaDJPH6KMcHhgcYrdNgzcL92
         JlD2ZcX9TCNdAU2wX5BNcDBn6xC6I+dnet1bMVqq8ET2mRSnODePap4s1yHySTFtf5hN
         4MLPT8TFbEyLncJPiD+0T18OKhsLBhzCmy7mKaMAdSR6MoIVo3WL/BGq0hEbtvGdNfxe
         obkX8I425Cjr1FFUHOjbSpJhXtLWin9sh+d+VjGEFPcE83jqhYmySyrFhFr7DNy3ZELa
         J5+7ks8w+O579jbPB2xhILoRiOj5Sxo/2B+TF8nNADBiGctxYFDm3ggk+/ZsDZocSUZ8
         kRog==
X-Forwarded-Encrypted: i=1; AJvYcCWIFjC8Ah/iFpvSh4PbdbF5sjPIK4iEV26KpZkPRAwYHl1WPuNdFQrFg6yBQa/j30Jiocs+VCEUcvc+ywKlIg==@vger.kernel.org
X-Gm-Message-State: AOJu0YxMGqEgEcyOX3fJwbgbbISjAEtetB9lE+BMiV4QWDFZJZ6jYVJP
	fCSu62cMo3zf53b9HCcnvLtzTJn092TLZJ7D4p7Ixp05vPKV4FnsKIWKqeo/RaRAxEcmnVv0ikq
	OWof7bs0isykXtQMw/fxjjbc3BI9qQw3IHZWudMhNgCjfhH+4NJHzU4ppbLCdd8D2
X-Gm-Gg: ASbGnctF9/zRRlglCoToERv3Mn3VqDLA4o3z+DlJ+j0dFiN3XoWiUCts37L1rdZ9kfd
	+8Z4cGlqC9Kz6LutlQO5J1+VmOXxbgRg/x4IVa6cX+3CeV9cgPb1beWP9mUR364jLjBBNnAdT0y
	0szsn60gLdtJLv7P5iAV+rIM1VJGK2xQQOpG0t1f0DFBtAH0ZmoNzDkW/Mi63KPtX925/PNPg/9
	5+Un6jGdfgE/q2HWj1ryTPzygMKhZrPttutimZwPUhd7xpSEJZeV6ywYo5hjraPOgpewz+NxNnE
	RlXcMsc=
X-Received: by 2002:a5d:6da2:0:b0:382:3959:f429 with SMTP id ffacd0b85a97d-38a872fbcdbmr22930871f8f.5.1736836852907;
        Mon, 13 Jan 2025 22:40:52 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGxGYACE+VcJITlOqzSfGbaw3l73/dQ7Q2ZoFV74uJczkg2pTPX13dOPdb5TcnnrgGZusgdIw==
X-Received: by 2002:a5d:6da2:0:b0:382:3959:f429 with SMTP id ffacd0b85a97d-38a872fbcdbmr22930860f8f.5.1736836852635;
        Mon, 13 Jan 2025 22:40:52 -0800 (PST)
Received: from gmonaco-thinkpadt14gen3.rmtit.csb ([185.107.56.40])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-38a8e37d050sm14238583f8f.15.2025.01.13.22.40.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 13 Jan 2025 22:40:52 -0800 (PST)
Message-ID: <7323d02c15095c659749147c3d2e9d4b777df2a2.camel@redhat.com>
Subject: Re: [PATCH] rteval: Allow configuration from stdin
From: Gabriele Monaco <gmonaco@redhat.com>
To: John Kacur <jkacur@redhat.com>
Cc: Clark Williams <williams@redhat.com>, Tomas Glozar <tglozar@redhat.com>,
 	linux-rt-users@vger.kernel.org
Date: Tue, 14 Jan 2025 07:40:49 +0100
In-Reply-To: <8d23151f-af7c-1b75-eae9-c8d88fa1ec3d@redhat.com>
References: <20250113121856.225406-1-gmonaco@redhat.com>
	 <8d23151f-af7c-1b75-eae9-c8d88fa1ec3d@redhat.com>
Autocrypt: addr=gmonaco@redhat.com; prefer-encrypt=mutual;
 keydata=mDMEZuK5YxYJKwYBBAHaRw8BAQdAmJ3dM9Sz6/Hodu33Qrf8QH2bNeNbOikqYtxWFLVm0
 1a0JEdhYnJpZWxlIE1vbmFjbyA8Z21vbmFjb0ByZWRoYXQuY29tPoiZBBMWCgBBFiEEysoR+AuB3R
 Zwp6j270psSVh4TfIFAmbiuWMCGwMFCQWjmoAFCwkIBwICIgIGFQoJCAsCBBYCAwECHgcCF4AACgk
 Q70psSVh4TfJzZgD/TXjnqCyqaZH/Y2w+YVbvm93WX2eqBqiVZ6VEjTuGNs8A/iPrKbzdWC7AicnK
 xyhmqeUWOzFx5P43S1E1dhsrLWgP
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.54.2 (3.54.2-1.fc41) 
Precedence: bulk
X-Mailing-List: linux-rt-users@vger.kernel.org
List-Id: <linux-rt-users.vger.kernel.org>
List-Subscribe: <mailto:linux-rt-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rt-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0


On Mon, 2025-01-13 at 16:34 -0500, John Kacur wrote:
>=20
>=20
> On Mon, 13 Jan 2025, Gabriele Monaco wrote:
>=20
> > Modules can currently be set only via configuration file, if rteval
> > is
> > called from a script run on different systems, the only way to make
> > sure
> > the loaded modules are known is to provide (or generate) a
> > configuration
> > file and pass it via -f/--infile .
>=20
> The config files are almost obsolete.
> Everything has a reasonable default, or can be set from the CMI
> The one exception is for the measurement module.
>=20
> What would be useful would be a CMI interface to switch from rtla
> timerlat
> to cyclictest.
>=20

Mmh, that was actually my first idea, something like --measurement-
modules=3Dtimerlat,cyclictest --loads-modules=3Dhackbench
Basically behaving just like the measurement and loads sections in the
config.

I opted for this as it was simpler but if the config file is getting
obsolete, I think you can just ignore the patch.

I could start drafting a patch for the CLI options to specify modules
if they look alright to you.

Another not too different option could be kinda like stress-ng,
specifying the modules just like --cyclictest , --timerlat , --
hackbench , etc.

Both would require a bit of refactoring how we load modules.
I don't have any strong opinion on this, thoughts?

Thanks,
Gabriele

