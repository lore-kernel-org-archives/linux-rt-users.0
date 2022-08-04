Return-Path: <linux-rt-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A8927C25B06
	for <linux-rt-users@archiver.kernel.org>; Thu,  4 Aug 2022 20:36:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233528AbiHDUgu (ORCPT
        <rfc822;linux-rt-users@archiver.kernel.org>);
        Thu, 4 Aug 2022 16:36:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49564 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229733AbiHDUgt (ORCPT
        <rfc822;linux-rt-users@vger.kernel.org>);
        Thu, 4 Aug 2022 16:36:49 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id B5E9727B0B
        for <linux-rt-users@vger.kernel.org>; Thu,  4 Aug 2022 13:36:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1659645404;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=We+AqDw8cATGYY+PDt4jeJQ7wfghUkOOVdbGrEzdROk=;
        b=YAAbyVMcGZtt4Q092W+HbBnkKue4ZKYyhqcLcw7R7Z8dR22wldwIMek3MCtdxCSyayk5by
        i+Q39qv34eDGt/6wO3iL1CwvwAE2FIuV6+g9jVf2vvpqv6xLH7yOKO/ezkCBP/sgK9rfAm
        IsWrH0MFmW45aB4evTknd7n/b4EumWU=
Received: from mail-qk1-f200.google.com (mail-qk1-f200.google.com
 [209.85.222.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-460-d5hcK63XPuGwINro1GUciw-1; Thu, 04 Aug 2022 16:36:43 -0400
X-MC-Unique: d5hcK63XPuGwINro1GUciw-1
Received: by mail-qk1-f200.google.com with SMTP id bs41-20020a05620a472900b006b8e84d6cddso423297qkb.19
        for <linux-rt-users@vger.kernel.org>; Thu, 04 Aug 2022 13:36:43 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=mime-version:references:message-id:in-reply-to:subject:cc:to:from
         :date:x-gm-message-state:from:to:cc;
        bh=We+AqDw8cATGYY+PDt4jeJQ7wfghUkOOVdbGrEzdROk=;
        b=GGs+iRlcJ/rha8IAv/O9skRTiwjTDgyTywkFYQFP+lwlQlF5pa4IQqAtbVhYvSutoa
         SaV7OC3WKb+ugKC+uhX5jNITAIBOUteTTb7O8uZVUVJ5QKBStZEDKW0MN3Eqb90gsvjH
         IQJs72DtJYIAqbNzZKXeomJeGQR4KCA9Ma2mbc09H0A/eHNGws3k1H7m2Saod5io/KgP
         wz3jymiqRvs7IJ0wkfXr/+RQ5kLjeMBNliXJGrBpn3Y5A2mekOQ6owIOc3exxLghTMe8
         6/XJ8gRTPU4qoUtztCNhVcHR5ePpVcppNL97ejRnDPf9VcASTF9qkGsaMzlEYYTb+6Nn
         igjw==
X-Gm-Message-State: ACgBeo1eCnibfHsvf6PINLsb3S5krhhsb2doeQv2Yedbxc7UIG1G4URL
        /wixkEqGG8st1iy16QHccXNQSR0miKvaSOi/XwnHDDpRdVvSlPV/GEvRNDLDMYqmeAexK8AvyNK
        5UQJkjZYzH8kLkhSU2tX92Zez+8E=
X-Received: by 2002:a0c:a902:0:b0:473:8d3e:f57a with SMTP id y2-20020a0ca902000000b004738d3ef57amr3162152qva.54.1659645402623;
        Thu, 04 Aug 2022 13:36:42 -0700 (PDT)
X-Google-Smtp-Source: AA6agR4MXgH3LjaORALHhs2vRINQeiaBwTXG3zTcpRIQ6YhgLdNgEN/39G7Mju71xD1gunvtRISSNQ==
X-Received: by 2002:a0c:a902:0:b0:473:8d3e:f57a with SMTP id y2-20020a0ca902000000b004738d3ef57amr3162137qva.54.1659645402451;
        Thu, 04 Aug 2022 13:36:42 -0700 (PDT)
Received: from fionn ([142.189.102.90])
        by smtp.gmail.com with ESMTPSA id 7-20020ac85647000000b0031efc91644fsm1251739qtt.33.2022.08.04.13.36.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 04 Aug 2022 13:36:41 -0700 (PDT)
Date:   Thu, 4 Aug 2022 16:36:39 -0400 (EDT)
From:   John Kacur <jkacur@redhat.com>
To:     Manasi Godse <magodse@redhat.com>
cc:     linux-rt-users@vger.kernel.org, lleshchi@redhat.com,
        kcarcia@redhat.com, gmanasi13@gmail.com
Subject: Re: [PATCH] rteval: fix regex in kcompile to calculate patch number
 for kernel prefix
In-Reply-To: <20220804192825.1207283-1-magodse@redhat.com>
Message-ID: <c2ca8d5-f9e5-4e79-b3fc-11a5cdd95059@redhat.com>
References: <20220804192825.1207283-1-magodse@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Precedence: bulk
List-ID: <linux-rt-users.vger.kernel.org>
X-Mailing-List: linux-rt-users@vger.kernel.org



On Thu, 4 Aug 2022, Manasi Godse wrote:

> Updated the regular expression to find the kernel prefix of the source
> file. If there are kernel source files with the same major.minor version
> but different patch numbers, kcompile would pick up the first one that
> is listed based on the kernel prefix and ignore the patch number.
> Example: linux-5.17.11.tar.xz and linux-5.17.13.tar.xz. If 5.17.13 had
> to be tested, kcompile could pick up linux-5.17.11.tar.xz
> 
> Signed-off-by: Manasi Godse <magodse@redhat.com>
> ---
>  rteval/modules/loads/kcompile.py | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/rteval/modules/loads/kcompile.py b/rteval/modules/loads/kcompile.py
> index 4a8659c042e6..6dd8d940f8b3 100644
> --- a/rteval/modules/loads/kcompile.py
> +++ b/rteval/modules/loads/kcompile.py
> @@ -176,7 +176,7 @@ class Kcompile(CommandLineLoad):
>              if not os.path.exists(tarfile):
>                  raise rtevalRuntimeError(self, f" tarfile {tarfile} does not exist!")
>              self.source = tarfile
> -            kernel_prefix = re.search(r"linux-\d{1,2}\.\d{1,3}", self.source).group(0)
> +            kernel_prefix = re.search(r"linux-\d{1,2}\.\d{1,3}\.*\d{1,2}", self.source).group(0)
>          else:
>              tarfiles = glob.glob(os.path.join(self.srcdir, f"{DEFAULT_KERNEL_PREFIX}*"))
>              if tarfiles:
> -- 
> 2.31.1
> 
> 
Signed-off-by: John Kacur <jkacur@redhat.com>

