Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="HPY235RG"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C2BD1AF
	for <linux-rt-users@vger.kernel.org>; Tue, 12 Dec 2023 13:23:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1702416224;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=f1IfX8cKP8/5ipGq7kOTVbCi9MUJBkUTPxm8gBDZi9U=;
	b=HPY235RGU+d1FYmaC2MHEXeObwuRLTRX7njwBBGwnvaOZiPoS2Qy/y7ElSMQrfY9GcqZnm
	hYloWf1VANpelACUIpeiotudDoqIf+8ygQXpK2/pcK/Q2xUslkkpfidjgzoZ1XzmozinbF
	v60hb6lcXwZO4vo5xEMwQmwPDpup4Aw=
Received: from mail-oo1-f72.google.com (mail-oo1-f72.google.com
 [209.85.161.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-428-2IS2u4AZMvqttVLJSulouw-1; Tue, 12 Dec 2023 16:23:43 -0500
X-MC-Unique: 2IS2u4AZMvqttVLJSulouw-1
Received: by mail-oo1-f72.google.com with SMTP id 006d021491bc7-58d53348a03so7525921eaf.2
        for <linux-rt-users@vger.kernel.org>; Tue, 12 Dec 2023 13:23:42 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702416222; x=1703021022;
        h=mime-version:references:message-id:in-reply-to:subject:cc:to:from
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=f1IfX8cKP8/5ipGq7kOTVbCi9MUJBkUTPxm8gBDZi9U=;
        b=fRrLp8BviiaS3ARNbmT00oBKVQb9UknFlQX7En3N1lqM9YzaTJ29cnDsj7163xd4wl
         TKZlIJoTxl+r9GpTsM0Giu5uV7MeYhtxrjArekd1mfx4kRK78TpBHYEpSsz8M6uXmIMc
         ueDsyr12ZScwLlbyuG0fr7yFLa6AKY6KL8Lo8chIlL0+6XDoAFFVQkY2jPWDAxDGvse4
         Mdt25IgWwqSM1JjxlpItUC1RNzSDVIVpcwqO7hrgF5xLnmvH28uw0t4Waq+hB1dL3dPp
         T2OP5gx7ooRiEhjk5FFK0Bw6VdM7WE2rT3fR+ldOvOMyvMS6X3mDdE83ZmqLRKcTcx7W
         Nifg==
X-Gm-Message-State: AOJu0Yx2RnKxOfyGsFPO0jeJV3PgCGrZaHppGUlRTK8rko7zQvNelpqJ
	Mchdbp5bsvh5vRFl8V7E2k/00kzgkmDvuZGnwmrnoumSi+WbcZ+mH889GNaA9CZNYG/uL02xuAv
	Q/Q9Yap2+BvquasXI4SRAemXma6EwSZ5bsiU=
X-Received: by 2002:a05:6358:cb30:b0:16e:236d:a6d8 with SMTP id gr48-20020a056358cb3000b0016e236da6d8mr5882489rwb.20.1702416221841;
        Tue, 12 Dec 2023 13:23:41 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHeEI6NTOhURNaCddYnYNYqyDRjokiRnqUGQZwx6u2ZRtO2rnyCPkItKkzQatO5RntAANhx8A==
X-Received: by 2002:a05:6358:cb30:b0:16e:236d:a6d8 with SMTP id gr48-20020a056358cb3000b0016e236da6d8mr5882479rwb.20.1702416221496;
        Tue, 12 Dec 2023 13:23:41 -0800 (PST)
Received: from fionn ([174.88.88.134])
        by smtp.gmail.com with ESMTPSA id z14-20020a0ce98e000000b0067abe3867a0sm4424616qvn.146.2023.12.12.13.23.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 12 Dec 2023 13:23:40 -0800 (PST)
Date: Tue, 12 Dec 2023 16:23:31 -0500 (EST)
From: John Kacur <jkacur@redhat.com>
To: Tomas Glozar <tglozar@redhat.com>
cc: linux-rt-users <linux-rt-users@vger.kernel.org>
Subject: Re: [PATCH 2/4] rteval: Minor improvements to CpuList class
In-Reply-To: <20231129093457.17984-3-tglozar@redhat.com>
Message-ID: <28c8961f-fe4c-4ea2-7cba-55e1cde2f68e@redhat.com>
References: <20231129093457.17984-1-tglozar@redhat.com> <20231129093457.17984-3-tglozar@redhat.com>
Precedence: bulk
X-Mailing-List: linux-rt-users@vger.kernel.org
List-Id: <linux-rt-users.vger.kernel.org>
List-Subscribe: <mailto:linux-rt-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rt-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII



On Wed, 29 Nov 2023, tglozar@redhat.com wrote:

> From: Tomas Glozar <tglozar@redhat.com>
> 
> - Remove unnecessary if-else from online_file_exists
> - Use cpupath in online_file_exists
> - Check for cpu0 instead of cpu1 in online_file_exists

Oops, your code is correct but you left in the old wrong explanation
you need to fix this up before I can apply this.

> - In is_online, remove check for n in cpuset and make it static
> - Mark also the remaining methods static since they do not rely on
> any fields of the class
> 
> Signed-off-by: Tomas Glozar <tglozar@redhat.com>
> ---
>  rteval/systopology.py | 29 +++++++++++++++--------------
>  1 file changed, 15 insertions(+), 14 deletions(-)
> 
> diff --git a/rteval/systopology.py b/rteval/systopology.py
> index ea8e242..60ac8e8 100644
> --- a/rteval/systopology.py
> +++ b/rteval/systopology.py
> @@ -82,12 +82,17 @@ class CpuList:
>      def __len__(self):
>          return len(self.cpulist)
>  
> +    def getcpulist(self):
> +        """ return the list of cpus tracked """
> +        return self.cpulist
> +
>      @staticmethod
>      def online_file_exists():
>          """ Check whether machine / kernel is configured with online file """
> -        if os.path.exists('/sys/devices/system/cpu/cpu1/online'):
> -            return True
> -        return False
> +        # Note: some machines do not have cpu0/online so we check cpu1/online.
> +        # In the case of machines with a single CPU, there is no cpu1, but
> +        # that is not a problem, since a single CPU cannot be offline
> +        return os.path.exists(os.path.join(CpuList.cpupath, "cpu1/online"))
>  
>      @staticmethod
>      def isolated_file_exists():
> @@ -147,14 +152,9 @@ class CpuList:
>                  result.append(a)
>          return [int(i) for i in list(set(result))]
>  
> -    def getcpulist(self):
> -        """ return the list of cpus tracked """
> -        return self.cpulist
> -
> -    def is_online(self, n):
> +    @staticmethod
> +    def is_online(n):
>          """ check whether cpu n is online """
> -        if n not in self.cpulist:
> -            raise RuntimeError(f"invalid cpu number {n}")

Are you sure you want to remove this? We have three states,
1. cpu is online
2. cpu is offline
3. cpus is not legitimate, ie, we have 12 cpus and the code asks
whether cpu number 1000 is online
I think you're trying to write more elegant code than the original 
implementation, but is it safer? Should we maybe check if the path
exists before calling sysread()?

>          path = os.path.join(CpuList.cpupath, f'cpu{n}')
>  
>          # Some hardware doesn't allow cpu0 to be turned off
> @@ -163,16 +163,17 @@ class CpuList:
>  
>          return sysread(path, "online") == "1"
>  
> -    def online_cpulist(self, cpulist):
> +    @staticmethod
> +    def online_cpulist(cpulist):
>          """ Given a cpulist, return a cpulist of online cpus """
>          # This only works if the sys online files exist
> -        if not self.online_file_exists():
> +        if not CpuList.online_file_exists():
>              return cpulist
>          newlist = []
>          for cpu in cpulist:
> -            if not self.online_file_exists() and cpu == '0':
> +            if not CpuList.online_file_exists() and cpu == '0':
>                  newlist.append(cpu)
> -            elif self.is_online(int(cpu)):
> +            elif CpuList.is_online(int(cpu)):
>                  newlist.append(cpu)
>          return newlist
>  
> -- 
> 2.39.3
> 
> 
> 

