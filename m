Return-Path: <linux-rt-users-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E61DEEB64D7
	for <linux-rt-users@archiver.kernel.org>; Wed, 28 Jun 2023 20:35:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231220AbjF1UfY (ORCPT
        <rfc822;linux-rt-users@archiver.kernel.org>);
        Wed, 28 Jun 2023 16:35:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36774 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230255AbjF1UfW (ORCPT
        <rfc822;linux-rt-users@vger.kernel.org>);
        Wed, 28 Jun 2023 16:35:22 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 96C4C19B0
        for <linux-rt-users@vger.kernel.org>; Wed, 28 Jun 2023 13:34:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1687984470;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=eEpw5YjfpkmOr2SVcJW209XEoVKxTOb7oVB652qn8VY=;
        b=iRAGnhVWKxnHu9Zqt4luq3LFvqLV96X6nkP24nm6Ha5uXe1kpST7mZZ8c/bSdYVPtcIv6h
        3rKYsnvhcbrwtk7VBB8GuOQIdQ8UJSNXOcc2ZS89j+9fTs1/y593slK2N7JL1dsFn5aw2g
        3OXIr759joya3jWi6MJcyqIwwKfCePY=
Received: from mail-qt1-f198.google.com (mail-qt1-f198.google.com
 [209.85.160.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-218-8XJic0JtOla9NL2vQ6ZV4A-1; Wed, 28 Jun 2023 16:34:28 -0400
X-MC-Unique: 8XJic0JtOla9NL2vQ6ZV4A-1
Received: by mail-qt1-f198.google.com with SMTP id d75a77b69052e-3f9d61c0990so2533011cf.3
        for <linux-rt-users@vger.kernel.org>; Wed, 28 Jun 2023 13:34:28 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687984468; x=1690576468;
        h=mime-version:references:message-id:in-reply-to:subject:cc:to:from
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=eEpw5YjfpkmOr2SVcJW209XEoVKxTOb7oVB652qn8VY=;
        b=S9yt99skP6HUj/ZVJVX8McSWFT9rPOV4mV8QBchiru158GGra8/nNp6C7tak1OxAq+
         Q01RRddZqJ5rUyX8Ts6pOI3Dt4cvWjpHlemDvOUqUCvFSA2ehPFxBoZlJT3FmKI5c8lR
         ivrwez47QP3Y7pAJdOo5t0Z2R6YUQMXOTF6Yuw9DYlTBLGpeSaUpCZaNBTdhpmZhqm2V
         UalnvZJJxXYenaPgh0f93CcyQ0C1NKGpLiZdbufAvdqU3KyeASriLN+GVomoz1U7JwVv
         r/5OLlASTzIAx9daUi/34FflwPIk1HJ6UmQiBBY2emgZ/9R7TNiyL7GrkiuvXy0T7/7+
         5ULA==
X-Gm-Message-State: AC+VfDzTe19uYvea7F82WUeHqDLro00NtidloPvmlAhWV42jtT80uG3i
        E2CzjUL0qtdgL7xmj2g6chLcZwt9hJG9tegOHOydc63ZEDm5QdmeyPp7yUG0tIb5SYv1m3oMXRc
        n85slJvTpSOeHCAfWBjfYOVyK154=
X-Received: by 2002:a05:622a:180d:b0:400:7ff8:db5b with SMTP id t13-20020a05622a180d00b004007ff8db5bmr24206988qtc.33.1687984467917;
        Wed, 28 Jun 2023 13:34:27 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ7Rbs1fYzn0KJKcQJbQZPz4xaD5jXfYf6UmlM5o7LsIZMJasPQ8TTb0VFtliae9s+1ZEh52tw==
X-Received: by 2002:a05:622a:180d:b0:400:7ff8:db5b with SMTP id t13-20020a05622a180d00b004007ff8db5bmr24206975qtc.33.1687984467652;
        Wed, 28 Jun 2023 13:34:27 -0700 (PDT)
Received: from fionn (bras-base-rdwyon0600w-grc-07-184-147-141-56.dsl.bell.ca. [184.147.141.56])
        by smtp.gmail.com with ESMTPSA id r7-20020ac84247000000b00401b060b264sm3696951qtm.9.2023.06.28.13.34.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 28 Jun 2023 13:34:27 -0700 (PDT)
Date:   Wed, 28 Jun 2023 16:34:14 -0400 (EDT)
From:   John Kacur <jkacur@redhat.com>
To:     Anubhav Shelat <ashelat@redhat.com>
cc:     linux-rt-users@vger.kernel.org
Subject: Re: [PATCH 1/3] rteval: added code to download default kernel version
 if no version is specified
In-Reply-To: <20230628195145.636652-2-ashelat@redhat.com>
Message-ID: <a1105dae-e364-cf49-bad1-acf354103c48@redhat.com>
References: <20230628195145.636652-1-ashelat@redhat.com> <20230628195145.636652-2-ashelat@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Precedence: bulk
List-ID: <linux-rt-users.vger.kernel.org>
X-Mailing-List: linux-rt-users@vger.kernel.org



On Wed, 28 Jun 2023, Anubhav Shelat wrote:

> Previously, the usuage was "./rteval-cmd -S [KERNEL_VERSION]", and
> rteval-cmd would throw an error if no kernel version was provided.
> Now, rteval-cmd will download the default kernel version, as specified
> in rteval/modules/loads/kcompile.py.
> 
> Signed-off-by: Anubhav Shelat <ashelat@redhat.com>
> ---
>  rteval-cmd | 10 +++++++++-
>  1 file changed, 9 insertions(+), 1 deletion(-)
> 
> diff --git a/rteval-cmd b/rteval-cmd
> index f715fec1e21c..ae94bd98cc11 100755
> --- a/rteval-cmd
> +++ b/rteval-cmd
> @@ -166,7 +166,7 @@ def parse_options(cfg, parser, cmdargs):
>      parser.add_argument("-V", "--version", dest="rteval___version",
>                        action='store_true', default=False,
>                        help='print rteval version and exit')
> -    parser.add_argument("-S", "--source-download", dest="rteval___srcdownload",
> +    parser.add_argument("-S", "--source-download", nargs="*", dest="rteval___srcdownload",
>                          type=str, default=None, metavar="KERNEL_VERSION",
>                          help='download a source kernel from kernel.org and exit')
>  
> @@ -191,8 +191,16 @@ def parse_options(cfg, parser, cmdargs):
>              ind = cmdargs.index('--raw-histogram')
>          cmd_args = cmdargs[ind+1:]
>          cmdargs = cmdargs[:ind+1]
> +
>      cmd_opts = parser.parse_args(args=cmdargs)
>  
> +    # if no kernel version was provided for --source-download, set version to default
> +    if (sys.argv.count('-S')+sys.argv.count('--source-download')) > 0:
> +        if cmd_opts.rteval___srcdownload == []:
> +            cmd_opts.rteval___srcdownload = ModuleParameters()["source"]["default"].replace(".tar.xz", "")
> +        else:
> +            cmd_opts.rteval___srcdownload = cmd_opts.rteval___srcdownload[0]
> +
>      if cmd_opts.rteval___version:
>          print(f"rteval version {RTEVAL_VERSION}")
>          sys.exit(0)
> -- 
> 2.39.3
> 
> 
Signed-off-by: John Kacur <jkacur@redhat.com>

