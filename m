Return-Path: <linux-rt-users-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 060D2C7EE2E
	for <linux-rt-users@archiver.kernel.org>; Mon, 12 Jun 2023 18:51:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235905AbjFLSvl (ORCPT
        <rfc822;linux-rt-users@archiver.kernel.org>);
        Mon, 12 Jun 2023 14:51:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33774 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232904AbjFLSvk (ORCPT
        <rfc822;linux-rt-users@vger.kernel.org>);
        Mon, 12 Jun 2023 14:51:40 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CAB10189
        for <linux-rt-users@vger.kernel.org>; Mon, 12 Jun 2023 11:50:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1686595850;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=Lm0gCdRKCiifU2L0PHzGgqnRWi/cKFy2dj0LHa40h2s=;
        b=O8NbasM7qmF9NGoSh2zJG3iVTfIwasfneoRl2pW+fr9dHOOjnjVUNdJytnUAqLzRJRCM15
        IQfYslCQy4JuNcH5x86J4IqRlJGkuh2hFyzgxPLEtTyNr7ph4K6PEIPLN/LjPZtm97xOJH
        QUgqNhkDCC2Yv6AyAiKcOujysUQFuGo=
Received: from mail-qk1-f197.google.com (mail-qk1-f197.google.com
 [209.85.222.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-34-KhRaK019OJ-0HIOQW2PGQA-1; Mon, 12 Jun 2023 14:50:42 -0400
X-MC-Unique: KhRaK019OJ-0HIOQW2PGQA-1
Received: by mail-qk1-f197.google.com with SMTP id af79cd13be357-75d54ceee5cso27361385a.3
        for <linux-rt-users@vger.kernel.org>; Mon, 12 Jun 2023 11:50:42 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686595842; x=1689187842;
        h=mime-version:references:message-id:in-reply-to:subject:cc:to:from
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Lm0gCdRKCiifU2L0PHzGgqnRWi/cKFy2dj0LHa40h2s=;
        b=Yqa2UpJSf949MCiDvSZ6gyFaFr7x4BCgwovSsPawlMBOJ7A9PYjcWJi8HLq0nNAoh3
         aHOTGjYjWnFTEi708mOMf4siqwZ8ijzSLvqlOEwn0+lNjPqAiZoo4BSZ3ZdlBDyaY4qg
         GoovEB+ABsOZoPwi/FbjR/tKgni4R3VI4x/yF1FnRD9P7VYYDHaoqYkQczrZIDAHVQ6u
         2BOYXrL0SwXQ1oETk3b1iH8FZFZ3Soi09Qp9SGot9s3O0lvj8b8q1xdbuH6ArgfneDqr
         jXGg4TL/U34466TwYndbY3dCjTTBEHcyNzjVMzo1aebCZWBLuH/n+TSB1pQYuH3PWGBu
         bPqQ==
X-Gm-Message-State: AC+VfDwV9NU7hD7HDzn1bQy90UAW4Txg4ZlMUlsK4c9DjxdALP15tZzt
        U6QBRcG9fjNjGo4QcZysMTDODEDKmf/A9+FogukHUO8q+TQIhlYIfhfavKKNRcgJSbfJV9V+rjD
        ZM2q5q8BDEUzcAytG8fsRZr4FKBE8HFWCG7Y=
X-Received: by 2002:a05:620a:25c7:b0:75e:c21f:bc3c with SMTP id y7-20020a05620a25c700b0075ec21fbc3cmr9365850qko.76.1686595841905;
        Mon, 12 Jun 2023 11:50:41 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ4oIE0Gg/rHTbhr3X3aPdtSVUluhWDJBQASnAYtz6cVuubB8LP4b1e4ocAoTo7dyMU0R5Jnew==
X-Received: by 2002:a05:620a:25c7:b0:75e:c21f:bc3c with SMTP id y7-20020a05620a25c700b0075ec21fbc3cmr9365841qko.76.1686595841670;
        Mon, 12 Jun 2023 11:50:41 -0700 (PDT)
Received: from fionn (bras-base-rdwyon0600w-grc-07-184-147-141-56.dsl.bell.ca. [184.147.141.56])
        by smtp.gmail.com with ESMTPSA id o16-20020ae9f510000000b0075b1c6f9628sm3058167qkg.71.2023.06.12.11.50.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 12 Jun 2023 11:50:41 -0700 (PDT)
Date:   Mon, 12 Jun 2023 14:50:40 -0400 (EDT)
From:   John Kacur <jkacur@redhat.com>
To:     Anubhav Shelat <ashelat@redhat.com>
cc:     linux-rt-users@vger.kernel.org
Subject: Re: [PATCH v2 06/10] rteval: Use f-strings in osinfo
In-Reply-To: <20230601202734.813515-7-ashelat@redhat.com>
Message-ID: <38c31f4-2c24-e437-f763-4b1b3c51f74d@redhat.com>
References: <20230601202734.813515-1-ashelat@redhat.com> <20230601202734.813515-7-ashelat@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Precedence: bulk
List-ID: <linux-rt-users.vger.kernel.org>
X-Mailing-List: linux-rt-users@vger.kernel.org



On Thu, 1 Jun 2023, Anubhav Shelat wrote:

> Use f-strings in osinfo.py
> 
> Signed-off-by: Anubhav Shelat <ashelat@redhat.com>
> ---
>  rteval/sysinfo/osinfo.py | 12 ++++++------
>  1 file changed, 6 insertions(+), 6 deletions(-)
> 
> diff --git a/rteval/sysinfo/osinfo.py b/rteval/sysinfo/osinfo.py
> index ead5e3939cfa..83dc78b96fdd 100644
> --- a/rteval/sysinfo/osinfo.py
> +++ b/rteval/sysinfo/osinfo.py
> @@ -55,9 +55,9 @@ class OSInfo:
>              shutil.copyfile(dpath, os.path.join(repdir, "dmesg"))
>              return
>          if os.path.exists('/usr/bin/dmesg'):
> -            subprocess.call('/usr/bin/dmesg > %s' % os.path.join(repdir, "dmesg"), shell=True)
> +            subprocess.call(f'/usr/bin/dmesg > {os.path.join(repdir, "dmesg")}', shell=True)
>              return
> -        print("dmesg file not found at %s and no dmesg exe found!" % dpath)
> +        print(f"dmesg file not found at {dpath} and no dmesg exe found!")
>  
>  
>  
> @@ -69,16 +69,16 @@ class OSInfo:
>          else:
>              raise RuntimeError("Can't find sosreport/sysreport")
>  
> -        self.__logger.log(Log.DEBUG, "report tool: %s" % exe)
> +        self.__logger.log(Log.DEBUG, f"report tool: {exe}")
>          options = ['-k', 'rpm.rpmva=off',
>                     '--name=rteval',
>                     '--batch']
>  
>          self.__logger.log(Log.INFO, "Generating SOS report")
> -        self.__logger.log(Log.INFO, "using command %s" % " ".join([exe]+options))
> +        self.__logger.log(Log.INFO, f"using command {' '.join([exe]+options)}")
>          subprocess.call([exe] + options)
>          for s in glob('/tmp/s?sreport-rteval-*'):
> -            self.__logger.log(Log.DEBUG, "moving %s to %s" % (s, repdir))
> +            self.__logger.log(Log.DEBUG, f"moving {s} to {repdir}")
>              shutil.move(s, repdir)
>  
>  
> @@ -118,7 +118,7 @@ def unit_test(rootdir):
>          log = Log()
>          log.SetLogVerbosity(Log.DEBUG|Log.INFO)
>          osi = OSInfo(logger=log)
> -        print("Base OS: %s" % osi.get_base_os())
> +        print(f"Base OS: {osi.get_base_os()}")
>  
>          print("Testing OSInfo::copy_dmesg('/tmp'): ", end=' ')
>          osi.copy_dmesg('/tmp')
> -- 
> 2.31.1
> 
> 
Signed-off-by: John Kacur <jkacur@redhat.com>

