Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9478715AAC8
	for <linux-rt-users@vger.kernel.org>; Tue,  2 Apr 2024 19:07:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712084830; cv=none; b=RBWquONdWvHLppCWeOeZlVZsz4R+41IXGDYiREj5VgSHqygbnUBFR/+F84HaE3UtxMaIBf6XDGGCX5u9IY4lXUf0C2hHTeFwy/wYoqn/S3FnuKimVB0imIFSk9PLdgWpLpUubJvyC9ogbUvtgsXOOwOSSG8dLtZmIAw2IS+0oS4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712084830; c=relaxed/simple;
	bh=+cK7Tkc0u7Sh6JLdxM3R6yjBF7Xqfvb4pTvpVTso5XY=;
	h=Date:From:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=ZQ6gn9I2nReff3FrNoF/cUHTaYp+s4XoWZlvMAcLgVanClXZlk0TJvU4pd1GCeUhU71VHpfMzLNCwAC8mYT1v40z/uQgTT11pmVSomoR2PNnVYle3lduXAB6aeL9DqzJ+KZn7/OUNEFkswT5OrEuau+vJp29OQep1TOcqr47v10=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=aFLdcxZa; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="aFLdcxZa"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1712084827;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=5oh35T649JqqkOudcgEGs/6vGUc5w+nVN9Js6Cpz1/4=;
	b=aFLdcxZao1Rc4Ba1gAOfMfMBi0vNtBwIB5MuOuJw8c2HRRzV/mq1NA5Y1Qsd4VA5rP1iUt
	Wj3UmYhmDaSjY8L16PQ8iV1sod0tHb+sIVIlrLfK1Q4wJebljZldM6tR0PyyNTqoCdAXrm
	nRzevyy7SoxSPsSRkdBoVPtTrhxoQTY=
Received: from mail-qk1-f197.google.com (mail-qk1-f197.google.com
 [209.85.222.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-2-zrZE5ra4M6aQ0gl4m03lXA-1; Tue, 02 Apr 2024 15:07:06 -0400
X-MC-Unique: zrZE5ra4M6aQ0gl4m03lXA-1
Received: by mail-qk1-f197.google.com with SMTP id af79cd13be357-7885dd31632so766185485a.0
        for <linux-rt-users@vger.kernel.org>; Tue, 02 Apr 2024 12:07:06 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712084825; x=1712689625;
        h=mime-version:references:message-id:in-reply-to:subject:cc:to:from
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=5oh35T649JqqkOudcgEGs/6vGUc5w+nVN9Js6Cpz1/4=;
        b=jgn1j7Msu5sOVAVASyQA1kAClxBKD203eibHwtVXyzxby7ZVOKSrDwd+2tZO22GceW
         YFwer2IzOik17egsEBsmMTuZVKxVtO2795Mqfi4KXvUPBNwNNmitJNkVx6ApEq+YgOZg
         c5bhWhNO9NzQmfZe32b4f4l59BLaikxwPEiqLbhVyEgTO6ARF0N6uki93OP4jtJttUXe
         S3gmmkonIdwRVjv1Vb4HK6j1gbo8nqPEHaPiRTgqhgytHsEOPx8Skif7opcZ4CQglzS4
         s/qC2RlxhO5z65JAK+hRKdIXf1zpkbvDtuL9IOmgH66KoU9+8sr8TohvjCPzspfTHzRv
         isPg==
X-Forwarded-Encrypted: i=1; AJvYcCVF8nN9dbv+kBvsI1+jlpbpvfkrPcPXESBDmOZpqwoyy89A8KptutTZha8ALr6nFv21xfIFcWRLAZs1jgNdKVR+jT3uujVDC+Q1gRdiOvI=
X-Gm-Message-State: AOJu0Yzi+dDgCTixSTSd0yFVlN4aUhLb9BcEeyf91jke22+TumlpWRfw
	U96vTY5Xd9IuX7TaXMB92HIKtP3Wuiyb7G6y8vcGBNNQX03m32U1IFXl31ENP8IfhOrknl32Uv7
	8+c24zLry+1fXNcJh6xMQ1GRpLf8XM8Ox1IgfG0u7J2rL0n69Bzm4G4wGQ81cc82b
X-Received: by 2002:a05:620a:5d89:b0:78a:454a:78c with SMTP id xx9-20020a05620a5d8900b0078a454a078cmr13572918qkn.9.1712084825734;
        Tue, 02 Apr 2024 12:07:05 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEvhmQHuSuveSvOqvX+Y8CyDiqvxjRT58TVFfoWheITQ/6acVCwFIEmDGY0kaWiWrm0IkAhdw==
X-Received: by 2002:a05:620a:5d89:b0:78a:454a:78c with SMTP id xx9-20020a05620a5d8900b0078a454a078cmr13572903qkn.9.1712084825429;
        Tue, 02 Apr 2024 12:07:05 -0700 (PDT)
Received: from fionn (bras-base-rdwyon0600w-grc-08-184-147-142-166.dsl.bell.ca. [184.147.142.166])
        by smtp.gmail.com with ESMTPSA id k6-20020a05620a414600b0078a07fc259csm4514335qko.40.2024.04.02.12.07.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 02 Apr 2024 12:07:04 -0700 (PDT)
Date: Tue, 2 Apr 2024 15:07:03 -0400 (EDT)
From: John Kacur <jkacur@redhat.com>
To: Crystal Wood <crwood@redhat.com>
cc: Clark Williams <williams@redhat.com>, linux-rt-users@vger.kernel.org
Subject: Re: [PATCH 3/5] rteval: kcompile: Skip mrproper, and re-extract if
 clean fails
In-Reply-To: <20240304211655.20174-4-crwood@redhat.com>
Message-ID: <0f21e919-9bab-5abf-8844-d4ff8c84b82d@redhat.com>
References: <20240304211655.20174-1-crwood@redhat.com> <20240304211655.20174-4-crwood@redhat.com>
Precedence: bulk
X-Mailing-List: linux-rt-users@vger.kernel.org
List-Id: <linux-rt-users.vger.kernel.org>
List-Subscribe: <mailto:linux-rt-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rt-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII



On Mon, 4 Mar 2024, Crystal Wood wrote:

> We only ever do out-of-tree builds, so the kernel directory should not be
> getting damaged except by incomplete extraction (which mrproper would
> probably not fix) or external meddling.  So, skip the mrproper and
> instead re-extract if a "make clean" fails.
> 
> Also, add -j to cleancmd to further speed things up.  Startup speed may
> not seem all that important given how long rteval is typically run for,
> but this helps make quick tests (e.g. while debugging things, or when
> hunting a latency that shows up very quickly) less painful.
> 
> On my 12-cpu laptop, this patch saves about 15 seconds of startup time.
> 
> Signed-off-by: Crystal Wood <crwood@redhat.com>
> ---
>  rteval/modules/loads/kcompile.py | 40 ++++++++++++++------------------
>  1 file changed, 18 insertions(+), 22 deletions(-)
> 
> diff --git a/rteval/modules/loads/kcompile.py b/rteval/modules/loads/kcompile.py
> index de1539986723..db1941074157 100644
> --- a/rteval/modules/loads/kcompile.py
> +++ b/rteval/modules/loads/kcompile.py
> @@ -54,7 +54,7 @@ class KBuildJob:
>              self.jobs = self.calc_jobs_per_cpu() * cpus_available
>  
>          self.runcmd = f"make O={self.objdir} -C {self.kdir} -j{self.jobs}"
> -        self.cleancmd = f"make O={self.objdir} -C {self.kdir} clean allmodconfig"
> +        self.cleancmd = f"make O={self.objdir} -C {self.kdir} clean allmodconfig -j${self.jobs}"
>          self.cleancmd += f"&& pushd {self.objdir} && {self.kdir}/scripts/config -d CONFIG_MODULE_SIG_SHA1 -e CONFIG_MODULE_SIG_SHA512 && popd && make O={self.objdir} -C {self.kdir} olddefconfig"
>          if self.binder:
>              self.runcmd = self.binder + " " + self.runcmd
> @@ -90,8 +90,8 @@ class KBuildJob:
>      def clean(self, sin=None, sout=None, serr=None):
>          """ Runs command to clean any previous builds and configure kernel """
>          self.log(Log.DEBUG, f"cleaning objdir {self.objdir}")
> -        subprocess.call(self.cleancmd, shell=True,
> -                        stdin=sin, stdout=sout, stderr=serr)
> +        return subprocess.call(self.cleancmd, shell=True,
> +                               stdin=sin, stdout=sout, stderr=serr)
>  
>      def run(self, sin=None, sout=None, serr=None):
>          """ Use Popen to launch a kcompile job """
> @@ -234,6 +234,10 @@ class Kcompile(CommandLineLoad):
>                  self.logger, self.cpus[n] if self.cpulist else None)
>              self.args.append(str(self.buildjobs[n])+";")
>  
> +    def _repair_tarball(self):
> +        self._log(Log.DEBUG, "Invalid state in kernel build tree, reloading")
> +        self._remove_build_dirs()
> +        self._extract_tarball()
>  
>      def _WorkloadBuild(self):
>          if self._donotrun:
> @@ -246,30 +250,22 @@ class Kcompile(CommandLineLoad):
>          else:
>              out = err = null
>  
> -        # clean up any damage from previous runs
> -        try:
> -            cmd = ["make", "-C", self.mydir, "mrproper"]
> -            ret = subprocess.call(cmd, stdin=null, stdout=out, stderr=err)
> +        # clean up object dirs and make sure each has a config file
> +        for n in self.nodes:
> +            ret = self.buildjobs[n].clean(sin=null, sout=out, serr=err)
>              if ret:
> -                # if the above make failed, remove and reinstall the source tree
> -                self._log(Log.DEBUG, "Invalid state in kernel build tree, reloading")
> -                self._remove_build_dirs()
> -                self._extract_tarball()
> -                ret = subprocess.call(cmd, stdin=null, stdout=out, stderr=err)
> -                if ret:
> -                    # give up
> -                    raise rtevalRuntimeError(self, f"kcompile setup failed: {ret}")
> -        except KeyboardInterrupt as m:
> -            self._log(Log.DEBUG, "keyboard interrupt, aborting")
> -            return
> -        self._log(Log.DEBUG, "ready to run")
> +                self._repair_tarball()
> +                ret = self.buildjobs[n].clean(sin=null, sout=out, serr=err)
> +            if ret:
> +                raise rtevalRuntimeError(self, f"kcompile setup failed: {ret}")
> +
>          if self._logging:
>              os.close(out)
>              os.close(err)
> -        # clean up object dirs and make sure each has a config file
> -        for n in self.nodes:
> -            self.buildjobs[n].clean(sin=null, sout=null, serr=null)
> +
>          os.close(null)
> +
> +        self._log(Log.DEBUG, "ready to run")
>          self._setReady()
>  
>      def _WorkloadPrepare(self):
> -- 
> 2.43.0

You would probably achieve close to the same or better by just using '-j' 
with make mrproper

[jkacur@fionn tmp]$ time tar xJf ../linux-6.6.1.tar.xz 

real	0m7.224s
user	0m7.233s
sys	0m2.204s
[jkacur@fionn tmp]$ cd linux-6.6.1/
[jkacur@fionn linux-6.6.1]$ time make mrproper

real	0m14.451s
user	0m7.998s
sys	0m6.307s
[jkacur@fionn linux-6.6.1]$ time make mrproper -j

real	0m1.336s
user	0m3.473s
sys	0m2.147s

John

