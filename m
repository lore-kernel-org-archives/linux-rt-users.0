Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2CE6953E22
	for <linux-rt-users@vger.kernel.org>; Thu, 18 Jul 2024 20:23:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721334217; cv=none; b=Xm+4lC1u9JQqpP05OKkfmaV6qsVFtYnw97kkmrrly/G8yn9yjjD1MymaNy+6i8C3TCbE+lzso9IUZRFQmrVhApbW5kO1rOZx+NHHhOSgevI4Aw1r0E3Yh1l4carTIYQ+giYyFUY18qIR6YIXpIFvK4wy/7tKa1wzGXOejFz+Yng=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721334217; c=relaxed/simple;
	bh=CM/lqvgja60vHu3TktUrzcqiz07Nprq4du2yc892a94=;
	h=Date:From:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=XDXmLvDSZmk6R4SPrc2zwexk8fwNNzxwk8loSHZg3AjOI4/X49jmCX/yaKyyKoC9O99oyXblHnYu9DBAFulUu/4lfHFbo+V7OskTq/d5t4646nqS1V9Dx6DRuSpGmFSMiEJ7x3jL0khrV9lqVg2kgfmf+QolGsJ4yA4mMUbhVSw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=AHMF2opb; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="AHMF2opb"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1721334215;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=WKbj4lYfTCCAAV/AKoeM/r689JptYMB12HXgJwcI3jE=;
	b=AHMF2opbtMYisqCNhV0wtEgYpxD2lSvJfcyv9lQJ/CCeuS8RUZFfvjqXgSXugPBlxYVWnZ
	DeyH7gjzagKsO/0FnL5F9UVp9iYnMhOj0c/Ve1AFYGKwLQPCXB1psMO/W/FTmFY3J4B4Zd
	udTRsSm0DZSJNbbCxV9m01wlPBExXA4=
Received: from mail-qk1-f199.google.com (mail-qk1-f199.google.com
 [209.85.222.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-611-JHwpVb6pNCu0Dovi2oPO8w-1; Thu, 18 Jul 2024 16:23:33 -0400
X-MC-Unique: JHwpVb6pNCu0Dovi2oPO8w-1
Received: by mail-qk1-f199.google.com with SMTP id af79cd13be357-7a1633381e5so91763185a.0
        for <linux-rt-users@vger.kernel.org>; Thu, 18 Jul 2024 13:23:33 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721334213; x=1721939013;
        h=mime-version:references:message-id:in-reply-to:subject:cc:to:from
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=WKbj4lYfTCCAAV/AKoeM/r689JptYMB12HXgJwcI3jE=;
        b=iXeWRQWeWvxJHHiS7Fe1dJWE8D88n5Yq+tJfQlNgcRhMcVx13lq70HqivW3ncf7Pvv
         TaOfJvADF1wiC77h5kMEJitIJREunWerBbBnfc8Sesb5AEc9qV508bmLFnlLW6a+76Bl
         QpV5ZYjGfqpVxDzv4iFqie4X1CSPQGq8X7Vt9iQfygRkXAkJJX/jKYbZa7O37c30CyG9
         i8yTXQzF5MTpUm+lQgO+ExgNpy7vR7BYFnHi4D/KhNXJ6rdn5xaJrlwqHmm0gYgRbPj8
         Dm7dANoCt+8g2V4HcHbXbjbvyNIDozoBjLMYbC0DRTBuiOUk8o+8Dbi/EOcuuOcSvitk
         kbag==
X-Forwarded-Encrypted: i=1; AJvYcCW9WdECLfVsPPmz4Ni5dAjSnsJhHIZg4KxTXVtdDmKZIZi2Gh261BxFkwdXH9/fuE0FoDjHnzawVJSrXKbBVqe2IYfavNBFteOYig1/0SY=
X-Gm-Message-State: AOJu0YyGsZbQ8NSST0hnCet8MVIck55dOUAOjwQIlVy6Nrj8o7ME5PlL
	dcTx8+tIeKGhOZxKKQQKdNUsRb9wqEvjrI4/Tc0pH+uy39wXdVeOi/RENMQNNNfKOGXG1WqUPxu
	BOcJur3eN8KrEE933As/z1yaL9i14002YrrDiiJf7ta7ebT4L8Z23mlCoeL6tTF5czk2mgEhq
X-Received: by 2002:a05:620a:40c8:b0:79f:5d5:1bc1 with SMTP id af79cd13be357-7a1874fe52dmr673142185a.58.1721334213148;
        Thu, 18 Jul 2024 13:23:33 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGeP3wTGW3UxUE3Jd7fkrHicHywcvk3xyj6n+q4d4aMxTJuktxXFuzjJe90yoVXkcmeBenaEw==
X-Received: by 2002:a05:620a:40c8:b0:79f:5d5:1bc1 with SMTP id af79cd13be357-7a1874fe52dmr673140585a.58.1721334212723;
        Thu, 18 Jul 2024 13:23:32 -0700 (PDT)
Received: from fionn ([142.189.102.234])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-7a1938b5f62sm61253485a.11.2024.07.18.13.23.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 18 Jul 2024 13:23:32 -0700 (PDT)
Date: Thu, 18 Jul 2024 16:23:31 -0400 (EDT)
From: John Kacur <jkacur@redhat.com>
To: Crystal Wood <crwood@redhat.com>
cc: Clark Williams <williams@redhat.com>, linux-rt-users@vger.kernel.org
Subject: Re: [PATCH v2] rteval: Add --noload option
In-Reply-To: <20240708194822.221496-1-crwood@redhat.com>
Message-ID: <521af844-9710-a58b-56e1-d68d955c21fc@redhat.com>
References: <20240708194822.221496-1-crwood@redhat.com>
Precedence: bulk
X-Mailing-List: linux-rt-users@vger.kernel.org
List-Id: <linux-rt-users.vger.kernel.org>
List-Subscribe: <mailto:linux-rt-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rt-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII



On Mon, 8 Jul 2024, Crystal Wood wrote:

> This option allows measurement to be done without any loads.
> 
> Signed-off-by: Crystal Wood <crwood@redhat.com>
> ---
> v2: I forgot to update the man page
> 
> This patch is on top of the "rteval: Remove measurement profiles and
> make latency mods exclusive" patchset I previously sent.
> 
>  doc/rteval.8           |  3 +++
>  rteval-cmd             |  9 +++++++
>  rteval/__init__.py     | 54 ++++++++++++++++++++++--------------------
>  rteval/rtevalReport.py |  3 ++-
>  4 files changed, 42 insertions(+), 27 deletions(-)
> 
> diff --git a/doc/rteval.8 b/doc/rteval.8
> index bfdeb9d36d9e..1eca63721b75 100644
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
> -- 
> 2.45.1
> 
> 
> 

When I run with loads, I the report says something like,
 "Loads:        3 loads run on cores 0-11"

When I run with your --noload option, it says:
"Loads:         loads run on cores"

It should probably say, 0 loads, run on 0 cores

John

