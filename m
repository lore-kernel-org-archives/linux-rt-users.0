Return-Path: <linux-rt-users-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 17CFEEB64D7
	for <linux-rt-users@archiver.kernel.org>; Wed, 21 Jun 2023 21:18:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230095AbjFUVST (ORCPT
        <rfc822;linux-rt-users@archiver.kernel.org>);
        Wed, 21 Jun 2023 17:18:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42432 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229840AbjFUVSS (ORCPT
        <rfc822;linux-rt-users@vger.kernel.org>);
        Wed, 21 Jun 2023 17:18:18 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 20E31197
        for <linux-rt-users@vger.kernel.org>; Wed, 21 Jun 2023 14:17:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1687382249;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=h4S9sKu0l/RLGohnPyEIcp5cSWvaeGnBznRj1YnqsmA=;
        b=B9hi+lwhilJrIsDTUCDVD4pFaVczpGMQgCeT2h+kN/L3UP+ea99DZ+Fh4YiiW6YHhDmvvx
        WoCVMiUdLww28GLNcJvWPv2sFQ/crsWavGMvhAz+evt6ee+56Pg5M0UE8BXllx0HmDbui7
        vHB4N/vVuFee5Ugm8v/mqt8moh7+auI=
Received: from mail-qk1-f199.google.com (mail-qk1-f199.google.com
 [209.85.222.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-481-371nqjtpP060SHcV3Em2CA-1; Wed, 21 Jun 2023 17:17:27 -0400
X-MC-Unique: 371nqjtpP060SHcV3Em2CA-1
Received: by mail-qk1-f199.google.com with SMTP id af79cd13be357-76240ab6d72so854123085a.2
        for <linux-rt-users@vger.kernel.org>; Wed, 21 Jun 2023 14:17:27 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687382247; x=1689974247;
        h=mime-version:references:message-id:in-reply-to:subject:cc:to:from
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=h4S9sKu0l/RLGohnPyEIcp5cSWvaeGnBznRj1YnqsmA=;
        b=Oe9QW4lqelT1VTlCl+Cz0fXFlPF53O6I5kAHBEEy7q8g2w2BqjLdBWwT17Fvq7FluF
         ftMWmyGtLiLHNDYa/irdDrQ3o4ZTVtod09mI8MnVh4rYETmg65i+CIkhp/UNg5rqhOoe
         NWykXFwuI+cETTdD4TFZFUefW5zhQw0NIGHxF2WE4W2WPkIGp+IdfZ9ruaJWM29fOT4r
         IHguvQ8zHqv/ak5zPHi1iZpvCTIPR9JGh3xnaLWSv/oNMb5f7RwghcKCuACt5HJtLbuQ
         9hOj9spNYYhdOOnsCfIPPoehxWp0bIRxCJRCxluRM4U0JImEIU8SzhEKFFBy2ZYGQb/h
         vEZg==
X-Gm-Message-State: AC+VfDyK4afQcVsxKfEhjyFPp1VD+agGTLHqg+qNaWDpGrCVD1zSIjmJ
        +z5a8qJW9Fdw0un+8D06UBr3GBaNdd7Yqmvn5P4tF3exEnv8S4Di+BTGcoUzKc1QexAcNpT8qwv
        grVmjYaJ7PEjWWdxZb1SFgw6RdNY=
X-Received: by 2002:a05:620a:f07:b0:75e:bf7e:e17e with SMTP id v7-20020a05620a0f0700b0075ebf7ee17emr20694255qkl.6.1687382247131;
        Wed, 21 Jun 2023 14:17:27 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ6M3Pz6wGHZ/byDYfZcpaKLhbc/zfVnoaHVP5Wc6yBKdtezpc85JOczwQILkXOd8U/Cvxynrg==
X-Received: by 2002:a05:620a:f07:b0:75e:bf7e:e17e with SMTP id v7-20020a05620a0f0700b0075ebf7ee17emr20694244qkl.6.1687382246913;
        Wed, 21 Jun 2023 14:17:26 -0700 (PDT)
Received: from fionn (bras-base-rdwyon0600w-grc-07-184-147-141-56.dsl.bell.ca. [184.147.141.56])
        by smtp.gmail.com with ESMTPSA id g5-20020a05620a108500b0075f2c1afb7fsm2635163qkk.57.2023.06.21.14.17.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 21 Jun 2023 14:17:26 -0700 (PDT)
Date:   Wed, 21 Jun 2023 17:17:07 -0400 (EDT)
From:   John Kacur <jkacur@redhat.com>
To:     Anubhav Shelat <ashelat@redhat.com>
cc:     linux-rt-users@vger.kernel.org
Subject: Re: [PATCH] rteval: osinfo.py: Added code to use 'sos report' instead
 of sosreport.
In-Reply-To: <20230613180828.1235964-2-ashelat@redhat.com>
Message-ID: <b0155e4f-9460-80a0-259-83644c313f99@redhat.com>
References: <20230613180828.1235964-1-ashelat@redhat.com> <20230613180828.1235964-2-ashelat@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Precedence: bulk
List-ID: <linux-rt-users.vger.kernel.org>
X-Mailing-List: linux-rt-users@vger.kernel.org



On Tue, 13 Jun 2023, Anubhav Shelat wrote:

> sosreport is deprecated, so if available on the system osinfo will try
> to use the sos command instead.
> 
> Signed-off-by: Anubhav Shelat <ashelat@redhat.com>
> ---
>  rteval/sysinfo/osinfo.py | 10 ++++++----
>  1 file changed, 6 insertions(+), 4 deletions(-)
> 
> diff --git a/rteval/sysinfo/osinfo.py b/rteval/sysinfo/osinfo.py
> index 83dc78b96fdd..0c570c0e395b 100644
> --- a/rteval/sysinfo/osinfo.py
> +++ b/rteval/sysinfo/osinfo.py
> @@ -62,12 +62,14 @@ class OSInfo:
>  
>  
>      def run_sysreport(self, repdir):
> -        if os.path.exists('/usr/sbin/sosreport'):
> +        if os.path.exists('/usr/sbin/sos'):
> +            exe = '/usr/sbin/sos report'
> +        elif os.path.exists('/usr/sbin/sosreport'):
>              exe = '/usr/sbin/sosreport'
>          elif os.path.exists('/usr/sbin/sysreport'):
>              exe = '/usr/sbin/sysreport'
>          else:
> -            raise RuntimeError("Can't find sosreport/sysreport")
> +            raise RuntimeError("Can't find sos/sosreport/sysreport")
>  
>          self.__logger.log(Log.DEBUG, f"report tool: {exe}")
>          options = ['-k', 'rpm.rpmva=off',
> @@ -75,8 +77,8 @@ class OSInfo:
>                     '--batch']
>  
>          self.__logger.log(Log.INFO, "Generating SOS report")
> -        self.__logger.log(Log.INFO, f"using command {' '.join([exe]+options)}")
> -        subprocess.call([exe] + options)
> +        self.__logger.log(Log.INFO, f"using command {' '.join(exe.split()+options)}")
> +        subprocess.call(exe.split() + options)
>          for s in glob('/tmp/s?sreport-rteval-*'):
>              self.__logger.log(Log.DEBUG, f"moving {s} to {repdir}")
>              shutil.move(s, repdir)
> -- 
> 2.31.1
> 
> 
Signed-off-by: John Kacur <jkacur@redhat.com>

