Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8201B48CFC
	for <linux-rt-users@vger.kernel.org>; Fri, 25 Jul 2025 17:53:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753466004; cv=none; b=DzTk2E3mNZ814PS2CVa8mXbEn0iLyr6v60gzVZ8/KtMt7Z/XSAVqD17JasHmqkd+JlroPpcsmdfeCsbdU4gZHg3PkIDGuEF3se/XjgSvHVazG9Wq4UrKRK7o8ojuIjf1D71i+foCouV36mhMCBqEL1MBhuvPTBf1SmNniQmG3EA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753466004; c=relaxed/simple;
	bh=O+uziNYlOVGTwYaOXlV4pNnO+ZIl+ctN9ZN/p+pYQEg=;
	h=Date:From:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=EmiXstVXT4Zcbo54ZwnmoOzWj9a7+cApXTM/jguUB9zQ0CXpSsakj6gJ6/v5/IOhwbn8To0mm6ZDSM4J69iQ+6zHMpqhYHnDpJGxHM4WvSsz9Y8LP6PyNJnAgIN/9fWP/0qr9Llk4EqlDHbcUyL9LWdYdL4LS9GxF8jadVnkxWk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=N3NJ9YZW; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="N3NJ9YZW"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1753466001;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=sixZnuBWuLtFknj2nXdWpR1G7qNkq8sM/QqdwuX4u6E=;
	b=N3NJ9YZWWrVRavG9IAyvMkcemkqfUkorWbcH8BpgigDZSiuSAOY2iGZC16mIo/17rdRAd4
	t2KYIL4dFqTLV//ni4+inkN+s7JqNKzfUetGQTWjDn5cTWLud9atg6dQdaZ9848WZjCB3M
	HAret1R3imkgH0FXTyG17vXAyWdz53U=
Received: from mail-qt1-f200.google.com (mail-qt1-f200.google.com
 [209.85.160.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-362-5-BUFgNnMui9YCO4EpZepQ-1; Fri, 25 Jul 2025 13:53:19 -0400
X-MC-Unique: 5-BUFgNnMui9YCO4EpZepQ-1
X-Mimecast-MFC-AGG-ID: 5-BUFgNnMui9YCO4EpZepQ_1753465999
Received: by mail-qt1-f200.google.com with SMTP id d75a77b69052e-4ab55eb74bbso64087021cf.0
        for <linux-rt-users@vger.kernel.org>; Fri, 25 Jul 2025 10:53:19 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753465999; x=1754070799;
        h=mime-version:references:message-id:in-reply-to:subject:cc:to:from
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=sixZnuBWuLtFknj2nXdWpR1G7qNkq8sM/QqdwuX4u6E=;
        b=WASKOQykc+i7CXXmKse//6fXANEZ78j7gbwk7pIqxgGph92Oa4yui9CeERwcL5wVio
         DwtHbMWAwZw+D1BgO1PikMNKWVU0XE1BoF7U48M0iYe9iAN8xP9+PvaiojMJDfSgf46U
         WEW5qGBjHZMvRQ3+WDCphafI5VIkET1bKT3rZV1l8xh6RCWYXk7rJobGuIH+nyrgrLXZ
         wqvxtoIjRcKd6oyU1tJe8PuErKc8hX63k86I/Me535bFzumYKoveZHfYD7f+FWxjCMiv
         0lKVJH+/5kYYTesde7LHi9UGYLfXL62rREUG+mDiKVvZRbwchZJbNd2eKKgu5eVrxZMV
         i7qA==
X-Forwarded-Encrypted: i=1; AJvYcCVmELGvl6bcX4t/FZejyeUqmiwT3GgJL9dUfjrvkkhlIwz1gjyeZwTfD/E1D9CUibHjDNiCP1TbG5gIQTTmPw==@vger.kernel.org
X-Gm-Message-State: AOJu0YxUy8B833C4Qdf5yXxIOBvwyvDeKKRdt7fv5PseGa/wKeNG+LMp
	lIYYEijdYAJGWohmeymsp7n3myIlOk55jYgOMWCEul9W5MhSThCJF4pIFcA0tXwHZYGqEpjRk9S
	TYJnXyI/pfT+NpmQaImrdTqgBz0hteItYSU7CY7c6AGeHetaux4Al3qGxDkxBr7aWoKRX
X-Gm-Gg: ASbGncseiDT/G25dz89DlM2mTANr0ffG/PT3H0WwubW3+HsWKrEtD2tM9sYUP6SlYip
	eapyks5TLUVAo+9QefjMrvlyZx7SgvlpMXxPn/Icr6u/IAudmxarpfcOeFPaxRdk6SEtaVr32YB
	cNc0FjPkJICCrT5nuoImaoVkshTgOO0Hfh/RARKthjs7wbWSWbVh+XMboN6WHem7qttHGwpbrtt
	ofSEP+qFGbgfOmBB4GYlqp0Z5J3NHfnzAnEgocjtubxPBAzu6rNfhwhjG8R6DUuntcbQkIRG0yh
	xIIrNSid2FswaTc34H8lNiYk3irWtw==
X-Received: by 2002:ac8:5913:0:b0:4a4:2c4c:ccb3 with SMTP id d75a77b69052e-4ae8f108a4amr41999021cf.38.1753465998610;
        Fri, 25 Jul 2025 10:53:18 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHBAYeFPcGFbBDex2vOIPp61k0RwnWbMwelIlhK9ii3UXxu54HjjNhgIom2Av/rvFOJceHJKg==
X-Received: by 2002:ac8:5913:0:b0:4a4:2c4c:ccb3 with SMTP id d75a77b69052e-4ae8f108a4amr41998541cf.38.1753465998167;
        Fri, 25 Jul 2025 10:53:18 -0700 (PDT)
Received: from fionn ([142.189.102.151])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-4ae9951752fsm2816871cf.4.2025.07.25.10.53.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 25 Jul 2025 10:53:17 -0700 (PDT)
Date: Fri, 25 Jul 2025 13:53:16 -0400 (EDT)
From: John Kacur <jkacur@redhat.com>
To: "John B. Wyatt IV" <jwyatt@redhat.com>
cc: Clark Williams <williams@redhat.com>, linux-rt-users@vger.kernel.org, 
    kernel-rts-sst <kernel-rts-sst@redhat.com>, 
    "John B. Wyatt IV" <sageofredondo@gmail.com>
Subject: Re: [PATCH] tuna: Update man page with cpu_power command
In-Reply-To: <20250716202329.520768-1-jwyatt@redhat.com>
Message-ID: <14f05188-5d4a-6dfa-2982-7aa0b60a1e04@redhat.com>
References: <20250716202329.520768-1-jwyatt@redhat.com>
Precedence: bulk
X-Mailing-List: linux-rt-users@vger.kernel.org
List-Id: <linux-rt-users.vger.kernel.org>
List-Subscribe: <mailto:linux-rt-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rt-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII



On Wed, 16 Jul 2025, John B. Wyatt IV wrote:

> [1] added support for the Python libcpupower bindings to control the
> cpu power state. This patch documents those changes.
> 
> [1]
> https://lore.kernel.org/linux-rt-users/20250409193136.44411-1-jwyatt@redhat.com/
> 
> Signed-off-by: John B. Wyatt IV <jwyatt@redhat.com>
> Signed-off-by: John B. Wyatt IV <sageofredondo@gmail.com>
> ---
>  docs/tuna.8 | 18 ++++++++++++++++++
>  1 file changed, 18 insertions(+)
> 
> diff --git a/docs/tuna.8 b/docs/tuna.8
> index 2423894..6e30537 100644
> --- a/docs/tuna.8
> +++ b/docs/tuna.8
> @@ -24,6 +24,24 @@ Log application details to file for given LOG-LEVEL
>  Print DEBUG level logging details to console
>  .SH "COMMANDS"
>  .TP
> +\fBtuna cpu_power\fR
> +usage: tuna-cmd.py cpu_power [-h] (-c CPU-LIST)
> +
> +Set or query the idle (power) states of all or a selection of cpus in the CPU-LIST. Modifiers \fB\-c\fR may be used to pass the CPU-LIST of cpus to perform the command on.
> +
> +optional arguments:
> +  -h, --help            show this help message and exit
> +  -i, --idle-info       Print general idle information for the selected CPUs, including
> +                        index values for IDLE-STATE.
> +  -s, --status IDLE-STATE
> +                        Print whether IDLE-STATE is enabled on the selected CPUs.
> +  -d, --disable IDLE-STATE
> +                        Disable IDLE-STATE on the selected CPUs.
> +  -e, --enable IDLE-STATE
> +                        Enable IDLE-STATE on the selected CPUs.
> +  -c CPU-LIST, --cpus CPU-LIST
> +                        CPU-LIST affected by commands
> +.TP
>  \fBtuna isolate\fR
>  usage: tuna-cmd.py isolate [-h] (-c CPU-LIST | -S CPU-SOCKET-LIST | -N)
>  
> -- 
> 2.50.1
> 
> 
Signed-off-by: John Kacur <jkacur@redhat.com>

