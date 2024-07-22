Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0EA5A17C7C
	for <linux-rt-users@vger.kernel.org>; Mon, 22 Jul 2024 23:05:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721689522; cv=none; b=c89Dsy4vRTXwGLtqyiGpJlglylYktFK36yFttCSrrQIFCE2x5sbSN0HBFFuRNpI7qDxDxEtKb200gDWMqok2GeOC5Y3w9kuBrUvO2ch8Dd4s5xeJsTrfVKhIrDq01s6hdwBRxrV69v81wCiCB+wNIeH5DRu6L30fB1S5lZrFTls=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721689522; c=relaxed/simple;
	bh=Bv4rzo2QvjrWlc59MKQ2rrryQ7+lfScqhF5RvNfPazc=;
	h=Date:From:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=A0BXpQ6EhKuTHewMnyDq+iBF8vycR6+1VT3TfrfYdmCZEmyYsg9OjeSf0wJNEg5IANtszEt06PInSTvKJBwhwJEKKHa0sfbYGTEfrJ/c44GnBPmySmVRJL9teB4O0GP41q/NoxZdp86VGsoO0MzPbq/70vr7FD8GpJ0KEE89V+o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=b5g9UOJl; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="b5g9UOJl"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1721689518;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=xecZ5IuranouzLX70kvV9oFZc1CsxSnJcJCYaNW9xMY=;
	b=b5g9UOJlHOoFHtx/G+QWwrUaAsjuA2WyeKHgsfEluALUI54Qo1XuI+TkrVJAIfhaxsLe67
	n+lfS67kqVe7U+ugnWBpfmIrszwGb29JbvAoP/YTwr268/BqDanCodHCx88zq7oi1ScQ3t
	Ua3VaEOQ8tIxOaTTA1K4SbDBZOaaiYI=
Received: from mail-qk1-f198.google.com (mail-qk1-f198.google.com
 [209.85.222.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-45-MH_8TWScMUieaqhgxad_XQ-1; Mon, 22 Jul 2024 19:05:16 -0400
X-MC-Unique: MH_8TWScMUieaqhgxad_XQ-1
Received: by mail-qk1-f198.google.com with SMTP id af79cd13be357-79efc957469so587110485a.2
        for <linux-rt-users@vger.kernel.org>; Mon, 22 Jul 2024 16:05:16 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721689514; x=1722294314;
        h=mime-version:references:message-id:in-reply-to:subject:cc:to:from
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=xecZ5IuranouzLX70kvV9oFZc1CsxSnJcJCYaNW9xMY=;
        b=n0iIIILQdvTSRFynyVcc/N4R/8lCrEMnzKGG90vI492lCiKfavrjLAkI1BGXhwI4Ma
         nV3WMd35pJH9TE8/anzP3wAIk7d7V0W6s7t3NrWC5d2PzNCbLfypQzcJTv+qCJCbNt52
         a+nP//LTfUjwfBoJEOBdgicPZ5Oy+ixVVDPLbSrJxLIIYgBtNJpy8wg2si78jLjl13Ii
         0qJGelYeRf7POF+sKYuIW2BT2PTYZvIR4GdrQ6zK66fw3WbGXXALlLcfr7MCm/dsVkn5
         Ra+BRbUqyFlL1/n/56k+Jl6YYpcidscBl640F2YUjnGOpw/qxVdvV0DvulyRzxFuxDbB
         7Yew==
X-Forwarded-Encrypted: i=1; AJvYcCXwN5Yiymkt7XXlIxz6YSENPjn/mm4XZnGm+KzoVGN78VEMUr+pI5EKbpwLM0Su0iXP7fA2ipOZXDVVitdQbnUvYW5Xi496qH7uXshzc4Y=
X-Gm-Message-State: AOJu0Yy+/0PaQZVpySP3VhYaHxsACPZQ9cVmD8DQk8gk+xuO9NwpyUX+
	4BCm9bHAnUFMc8BaxfXlyI43jimiB4MRhpt5uilHVIOo8UVyhCp8XbzSkfgFJx5zLb/faGf5Ob0
	VqN493UnA3AYCaOYTSpd//NnqWYF7dAW6J4GXaaokrsCX0wy8DefUU5Li/tZERGyK
X-Received: by 2002:a05:620a:2544:b0:79d:8153:57aa with SMTP id af79cd13be357-7a1a13a88d2mr1025449985a.48.1721689513903;
        Mon, 22 Jul 2024 16:05:13 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IH+iKieAdO1sdiI0FBq83S2SX8m1XGwHFp3pV1urYN1/umbq9y/JCtIw12olF+P6I/wfo6uDQ==
X-Received: by 2002:a05:620a:2544:b0:79d:8153:57aa with SMTP id af79cd13be357-7a1a13a88d2mr1025447985a.48.1721689513491;
        Mon, 22 Jul 2024 16:05:13 -0700 (PDT)
Received: from fionn ([142.189.102.234])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-7a198fbda21sm408219985a.36.2024.07.22.16.05.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 22 Jul 2024 16:05:13 -0700 (PDT)
Date: Mon, 22 Jul 2024 19:05:11 -0400 (EDT)
From: John Kacur <jkacur@redhat.com>
To: Crystal Wood <crwood@redhat.com>
cc: Clark Williams <williams@redhat.com>, linux-rt-users@vger.kernel.org
Subject: Re: [PATCH v3] rteval: Add --noload option
In-Reply-To: <20240719195841.88214-1-crwood@redhat.com>
Message-ID: <1ec3232f-3a97-979b-a8cd-445d7d2c46dd@redhat.com>
References: <20240719195841.88214-1-crwood@redhat.com>
Precedence: bulk
X-Mailing-List: linux-rt-users@vger.kernel.org
List-Id: <linux-rt-users.vger.kernel.org>
List-Subscribe: <mailto:linux-rt-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rt-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII



On Fri, 19 Jul 2024, Crystal Wood wrote:

> This option allows measurement to be done without any loads.
> 
> Signed-off-by: Crystal Wood <crwood@redhat.com>
> ---
> v3: Update XSLT to handle the absence of loads
> ---
>  doc/rteval.8           |  3 +++
>  rteval-cmd             |  9 +++++++
>  rteval/__init__.py     | 54 ++++++++++++++++++++++--------------------
>  rteval/rtevalReport.py |  3 ++-
>  rteval/rteval_text.xsl |  9 ++++++-
>  5 files changed, 50 insertions(+), 28 deletions(-)
> 
> diff --git a/doc/rteval.8 b/doc/rteval.8
> index 9e2b377752e5..1981ac7b3913 100644
> --- a/doc/rteval.8
> +++ b/doc/rteval.8
> @@ -108,6 +108,9 @@ Print rteval version and exit.
>  .TP
>  .B \-S KERNEL_VERSION, \-\-source\-download=KERNEL_VERSION
>  download a source kernel from kernel.org and exit
> +.TP
> +.B \-\-noload
> +Only run the measurements (don't run loads)
>  
>  .SH GROUP OPTIONS
>  .TP
> diff --git a/rteval-cmd b/rteval-cmd
> index 5cb6d7a44523..36b167a034e5 100755
> --- a/rteval-cmd
> +++ b/rteval-cmd
> @@ -146,6 +146,9 @@ def parse_options(cfg, parser, cmdargs):
>      parser.add_argument("-S", "--source-download", nargs="*", dest="rteval___srcdownload",
>                          type=str, default=None, metavar="KERNEL_VERSION",
>                          help='download a source kernel from kernel.org and exit')
> +    parser.add_argument("--noload", dest="rteval___noload",
> +                        action="store_true", default=False,
> +                        help="only run the measurements (don't run loads)")
>  
>  
>      if not cmdargs:
> @@ -273,6 +276,12 @@ if __name__ == '__main__':
>          measuremods.SetupModuleOptions(parser)
>          cmd_args = parse_options(config, parser, sys.argv[1:])
>  
> +        if rtevcfg.noload:
> +            if rtevcfg.onlyload:
> +                # Make up your mind!
> +                raise RuntimeError('The --noload and --onlyload options are incompatible.')
> +            loadmods = None
> +
>          # download kernel tarball
>          if rtevcfg.srcdownload:
>              logger.log(Log.DEBUG, f"Kernel Version to download = {rtevcfg.srcdownload}")
> diff --git a/rteval/__init__.py b/rteval/__init__.py
> index 226d14f80f48..4d3e0c23e5ab 100644
> --- a/rteval/__init__.py
> +++ b/rteval/__init__.py
> @@ -46,9 +46,6 @@ class RtEval(rtevalReport):
>          if not isinstance(config, rtevalConfig.rtevalConfig):
>              raise TypeError("config variable is not an rtevalConfig object")
>  
> -        if not isinstance(loadmods, LoadModules):
> -            raise TypeError("loadmods variable is not a LoadModules object")
> -
>          if not isinstance(measuremods, MeasurementModules):
>              raise TypeError("measuremods variable is not a MeasurementModules object")
>  
> @@ -111,20 +108,21 @@ class RtEval(rtevalReport):
>          except Exception as err:
>              raise RuntimeError(f"Cannot create report directory (NFS with rootsquash on?) [{err}]]")
>  
> +        params = {'workdir':self.__rtevcfg.workdir,
> +                  'reportdir':self.__reportdir and self.__reportdir or "",
> +                  'builddir':builddir,
> +                  'srcdir':self.__rtevcfg.srcdir,
> +                  'verbose': self.__rtevcfg.verbose,
> +                  'debugging': self.__rtevcfg.debugging,
> +                  'numcores':self._sysinfo.cpu_getCores(True),
> +                  'logging':self.__rtevcfg.logging,
> +                  'memsize':self._sysinfo.mem_get_size(),
> +                  'numanodes':self._sysinfo.mem_get_numa_nodes(),
> +                  'duration': float(self.__rtevcfg.duration),
> +                  }
> +
>          if self._loadmods:
>              self.__logger.log(Log.INFO, "Preparing load modules")
> -            params = {'workdir':self.__rtevcfg.workdir,
> -                      'reportdir':self.__reportdir and self.__reportdir or "",
> -                      'builddir':builddir,
> -                      'srcdir':self.__rtevcfg.srcdir,
> -                      'verbose': self.__rtevcfg.verbose,
> -                      'debugging': self.__rtevcfg.debugging,
> -                      'numcores':self._sysinfo.cpu_getCores(True),
> -                      'logging':self.__rtevcfg.logging,
> -                      'memsize':self._sysinfo.mem_get_size(),
> -                      'numanodes':self._sysinfo.mem_get_numa_nodes(),
> -                      'duration': float(self.__rtevcfg.duration),
> -                      }
>              self._loadmods.Setup(params)
>  
>          self.__logger.log(Log.INFO, "Preparing measurement modules")
> @@ -144,15 +142,18 @@ class RtEval(rtevalReport):
>  
>              print(f"rteval run on {os.uname()[2]} started at {time.asctime()}")
>              onlinecpus = self._sysinfo.cpu_getCores(True)
> -            cpulist = self._loadmods._cfg.GetSection("loads").cpulist
> -            if cpulist:
> -                print(f"started {self._loadmods.ModulesLoaded()} loads on cores {cpulist}", end=' ')
> -            else:
> -                print(f"started {self._loadmods.ModulesLoaded()} loads on {onlinecpus} cores", end=' ')
> -            if self._sysinfo.mem_get_numa_nodes() > 1:
> -                print(f" with {self._sysinfo.mem_get_numa_nodes()} numa nodes")
> -            else:
> -                print("")
> +            if self._loadmods:
> +                cpulist = self._loadmods._cfg.GetSection("loads").cpulist
> +                if cpulist:
> +                    print(f"started {self._loadmods.ModulesLoaded()} loads on cores {cpulist}",
> +                          end=' ')
> +                else:
> +                    print(f"started {self._loadmods.ModulesLoaded()} loads on {onlinecpus} cores",
> +                          end=' ')
> +                if self._sysinfo.mem_get_numa_nodes() > 1:
> +                    print(f" with {self._sysinfo.mem_get_numa_nodes()} numa nodes")
> +                else:
> +                    print("")
>              cpulist = self._measuremods._cfg.GetSection("measurement").cpulist
>              if cpulist:
>                  print(f"started measurement threads on cores {cpulist}")
> @@ -192,7 +193,7 @@ class RtEval(rtevalReport):
>                      if threading.active_count() < nthreads:
>                          raise RuntimeError("load thread died!")
>  
> -                if not load_avg_checked:
> +                if self._loadmods and not load_avg_checked:
>                      self._loadmods.SaveLoadAvg()
>                      load_avg_checked = 5
>                  else:
> @@ -202,7 +203,8 @@ class RtEval(rtevalReport):
>                      left_to_run = stoptime - currtime
>                      self.__show_remaining_time(left_to_run)
>                      rpttime = currtime + report_interval
> -                    print(f"load average: {self._loadmods.GetLoadAvg():.2f}")
> +                    if self._loadmods:
> +                        print(f"load average: {self._loadmods.GetLoadAvg():.2f}")
>                  currtime = time.time()
>  
>              self.__logger.log(Log.DEBUG, "out of measurement loop")
> diff --git a/rteval/rtevalReport.py b/rteval/rtevalReport.py
> index 57d99f520f50..7379a7904f3f 100644
> --- a/rteval/rtevalReport.py
> +++ b/rteval/rtevalReport.py
> @@ -57,7 +57,8 @@ class rtevalReport:
>          self.__xmlreport.AppendXMLnodes(self._sysinfo.MakeReport())
>  
>          # Add load info
> -        self.__xmlreport.AppendXMLnodes(self._loadmods.MakeReport())
> +        if self._loadmods:
> +            self.__xmlreport.AppendXMLnodes(self._loadmods.MakeReport())
>  
>          # Add measurement data
>          self.__xmlreport.AppendXMLnodes(self._measuremods.MakeReport())
> diff --git a/rteval/rteval_text.xsl b/rteval/rteval_text.xsl
> index b801679abcc5..96846aaf4d54 100644
> --- a/rteval/rteval_text.xsl
> +++ b/rteval/rteval_text.xsl
> @@ -15,7 +15,14 @@
>      <xsl:text>&#10;</xsl:text>
>  
>      <xsl:text>   Loads:        </xsl:text>
> -    <xsl:value-of select="loads/@loads"/><xsl:text> loads run on cores </xsl:text><xsl:value-of select="loads/@loadcpus"/>
> +    <xsl:choose>
> +      <xsl:when test="loads">
> +        <xsl:value-of select="loads/@loads"/><xsl:text> loads run on cores </xsl:text><xsl:value-of select="loads/@loadcpus"/>
> +      </xsl:when>
> +      <xsl:otherwise>
> +        <xsl:text>none</xsl:text>
> +      </xsl:otherwise>
> +    </xsl:choose>
>      <xsl:text>&#10;</xsl:text>
>  
>      <xsl:text>   Measurement:  </xsl:text>
> -- 
> 2.45.2
> 
> 
> 
Signed-off-by: John Kacur <jkacur@redhat.com>

