Return-Path: <linux-rt-users-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ADA23EEEC01
	for <linux-rt-users@archiver.kernel.org>; Fri, 15 Sep 2023 19:00:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236882AbjIOTAT (ORCPT
        <rfc822;linux-rt-users@archiver.kernel.org>);
        Fri, 15 Sep 2023 15:00:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33574 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236903AbjIOTAO (ORCPT
        <rfc822;linux-rt-users@vger.kernel.org>);
        Fri, 15 Sep 2023 15:00:14 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 839F9B3
        for <linux-rt-users@vger.kernel.org>; Fri, 15 Sep 2023 11:59:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1694804366;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=XlanuSgO4EmYKmcZi3k4qzoNLiIYKMCgWtcpmSODoyo=;
        b=Y+9O2XN1b3W8+q8a7vplTrRmMZjjeVsg0zzxxVLDBlMK1C2cbzGChskYYwvJ987I/1mebl
        Xm7txTHVWb2Q6DdeD3V5dBiRhMp9d9jgi02xS8AapO+rzlYLB1k6tHQPepXdfzNWvwilhw
        gC530S0BRfNjQLiE231qBklorqDboYI=
Received: from mail-qv1-f70.google.com (mail-qv1-f70.google.com
 [209.85.219.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-259-JwPjEqj_Pc6rtneGEjXXlg-1; Fri, 15 Sep 2023 14:59:24 -0400
X-MC-Unique: JwPjEqj_Pc6rtneGEjXXlg-1
Received: by mail-qv1-f70.google.com with SMTP id 6a1803df08f44-6562692f945so21293926d6.0
        for <linux-rt-users@vger.kernel.org>; Fri, 15 Sep 2023 11:59:24 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1694804363; x=1695409163;
        h=mime-version:references:message-id:in-reply-to:subject:cc:to:from
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=XlanuSgO4EmYKmcZi3k4qzoNLiIYKMCgWtcpmSODoyo=;
        b=KAld2hy6OpnEzEGH1pjpmmlPcRLWhDHa+nARDBQNXoNRcxtXlFgDOLq/HbFWaZxv7Z
         DCePoB2b9hGsrSGahu8KeXkSpCUCyPIOEpVcdW6q8Hu2bSRXmlRgpkpLMjJnNORmSvWn
         6n3U15Jrpnj/NxNMoMO14CuUDV9AmfqV7golMUIJgkdUyyXDgyE0MotQBBYOV8pQjcM5
         TQgMDr6swfGhal8KKZqCh0I20PEu5ZpQTk6ryWBGPZ5LwM/XN6uq6wWUHvwU//ZdpGbE
         YJCTWDgMrcZhJRHRlOJ//WM0q6OVzhs9DOhYWgJ/3143SgRk9BR2LJ99piO4qgZG8Y3Y
         LdGQ==
X-Gm-Message-State: AOJu0YzCxbKR17ozsRJqCgzCiIFeUqbJ7QEaQ97Z0Aq4J+kTPcqrPjLp
        w4o2IXJn/UKMVANJ+KxgWpkFPSNhrUkOP1px4qLh/U9+86lNhz4uiqVdfQRZCk09saN2+4geTz4
        KZNhh5hAsk+WQ1mz1qrDpNEnoam73jluONBE=
X-Received: by 2002:a0c:b3c3:0:b0:63c:fd89:f045 with SMTP id b3-20020a0cb3c3000000b0063cfd89f045mr2536957qvf.54.1694804363197;
        Fri, 15 Sep 2023 11:59:23 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHxg1d5pUFZmZZ5x7s+A5bmSSIi/8q1Y0XzVcb1hZ7bTIP8NfA89gvm0pHu+P2nMIjE450Iyg==
X-Received: by 2002:a0c:b3c3:0:b0:63c:fd89:f045 with SMTP id b3-20020a0cb3c3000000b0063cfd89f045mr2536944qvf.54.1694804362969;
        Fri, 15 Sep 2023 11:59:22 -0700 (PDT)
Received: from fionn ([174.88.88.130])
        by smtp.gmail.com with ESMTPSA id x16-20020a0ce250000000b0064f70a860d8sm1466992qvl.41.2023.09.15.11.59.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 15 Sep 2023 11:59:22 -0700 (PDT)
Date:   Fri, 15 Sep 2023 14:58:54 -0400 (EDT)
From:   John Kacur <jkacur@redhat.com>
To:     Tomas Glozar <tglozar@redhat.com>
cc:     linux-rt-users@vger.kernel.org
Subject: Re: [PATCH v2 1/3] rteval: Allow arguments specific to module
 group
In-Reply-To: <20230811095228.200772-2-tglozar@redhat.com>
Message-ID: <f739a8e8-2bb7-7fc1-94ed-c6847ed79bf@redhat.com>
References: <20230811095228.200772-1-tglozar@redhat.com> <20230811095228.200772-2-tglozar@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Precedence: bulk
List-ID: <linux-rt-users.vger.kernel.org>
X-Mailing-List: linux-rt-users@vger.kernel.org



On Fri, 11 Aug 2023, Tomas Glozar wrote:

> Return grparser from ModuleContainer.SetupModuleOptions, which allows it
> to be used to setup additional options in *Modules class.
> 
> Signed-off-by: Tomas Glozar <tglozar@redhat.com>
> ---
>  rteval/modules/__init__.py | 18 ++++++++++--------
>  1 file changed, 10 insertions(+), 8 deletions(-)
> 
> diff --git a/rteval/modules/__init__.py b/rteval/modules/__init__.py
> index 794135d..f4fd160 100644
> --- a/rteval/modules/__init__.py
> +++ b/rteval/modules/__init__.py
> @@ -312,7 +312,7 @@ the information provided by the module"""
>                  # Ignore if a section is not found
>                  cfg = None
>  
> -            grparser = parser.add_argument_group("Options for the %s module" % shortmod)
> +            modgrparser = parser.add_argument_group("Options for the %s module" % shortmod)
>              for (o, s) in list(opts.items()):
>                  descr = 'descr' in s and s['descr'] or ""
>                  metavar = 'metavar' in s and s['metavar'] or None
> @@ -327,13 +327,15 @@ the information provided by the module"""
>                      default = 'default' in s and s['default'] or None
>  
>  
> -                grparser.add_argument('--%s-%s' % (shortmod, o),
> -                                    dest="%s___%s" % (shortmod, o),
> -                                    action='store',
> -                                    help='%s%s' % (descr,
> -                                                   default and ' (default: %s)' % default or ''),
> -                                    default=default,
> -                                    metavar=metavar)
> +                modgrparser.add_argument('--%s-%s' % (shortmod, o),
> +                                         dest="%s___%s" % (shortmod, o),
> +                                         action='store',
> +                                         help='%s%s' % (descr,
> +                                                        default and ' (default: %s)' % default or ''),
> +                                         default=default,
> +                                         metavar=metavar)
> +
> +            return grparser
>  
>  
>      def InstantiateModule(self, modname, modcfg, modroot=None):
> -- 
> 2.41.0
> 
> 
Signed-off-by: John Kacur <jkacur@redhat.com>

