Return-Path: <linux-rt-users-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A780DC77B73
	for <linux-rt-users@archiver.kernel.org>; Mon,  5 Jun 2023 19:32:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232674AbjFETcT (ORCPT
        <rfc822;linux-rt-users@archiver.kernel.org>);
        Mon, 5 Jun 2023 15:32:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50074 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229878AbjFETcS (ORCPT
        <rfc822;linux-rt-users@vger.kernel.org>);
        Mon, 5 Jun 2023 15:32:18 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 28350EA
        for <linux-rt-users@vger.kernel.org>; Mon,  5 Jun 2023 12:31:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1685993490;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=or+CwxyfE3JarrZVAyd0095fleruhUiV8jxzauwTihM=;
        b=SCouVdXzPOE8NrY1+vygHQY096wfL0VZwJ6KYJwvFr5JU/0X9y4EOlWtsHnaXRl7W7hF8e
        4pIpyEqiKd69X13cODybSL2EIc8OF1UPRHMcp26mE3cvsZjRwHAQRlY4XQUvKktK5vdPY2
        Xi6pw82VRJQ2xo3A7QY7BPmdx/TWUsU=
Received: from mail-qk1-f198.google.com (mail-qk1-f198.google.com
 [209.85.222.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-247-IFKLay1KP226hr8MOKCN9A-1; Mon, 05 Jun 2023 15:31:29 -0400
X-MC-Unique: IFKLay1KP226hr8MOKCN9A-1
Received: by mail-qk1-f198.google.com with SMTP id af79cd13be357-75ebb50993fso144322585a.2
        for <linux-rt-users@vger.kernel.org>; Mon, 05 Jun 2023 12:31:28 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1685993488; x=1688585488;
        h=mime-version:references:message-id:in-reply-to:subject:cc:to:from
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=or+CwxyfE3JarrZVAyd0095fleruhUiV8jxzauwTihM=;
        b=kcDI7CnePDZrc/tBxGggXBPpV3GOx/3/ujzAVxwDm6L9T28A6Zcdf+xDpdFIG2gJVk
         +dTReLphDlbpB9vjw6TVZFDSqlGJgF5kEymSO8EsHLa8xOvNQqgMjtSM59RqHPtuAFMQ
         rsX+DYUS84cigIUteyWsVry9Lm3PPt2gKgA6s6V497gRuH2/Tg/6Wj5Wk1VjsHKIQ+oh
         wcwPwT6aVFIIpH2mA13/iKrBVf1j9DXtJuCRUeaNG5vsLgec17u5tY1kyK3hKgR0Zvcj
         +/TneDATQt+vBh7Alqf6WMLMNlWC59LvdUNt/2zgr0W3qhbC1Ggd/G+p1mScVAQlfby0
         KMrQ==
X-Gm-Message-State: AC+VfDyjdqw0O3cdRXERBaVO/qSWeWWn+xLqH1ghMPgS+6ErjkosLdZ9
        GA9e1ZPavZNSM0iLSJZ1O8NlEsWnULTqEC0LkslCIGsS65YUku114vLqWYsH5DF9aJdccVKJpKE
        NgvUDn4ZFN0rFxJrn0BbztNljsH4=
X-Received: by 2002:a05:620a:3984:b0:75e:bf7e:e17e with SMTP id ro4-20020a05620a398400b0075ebf7ee17emr759693qkn.6.1685993488566;
        Mon, 05 Jun 2023 12:31:28 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ52LtRvofqfQUQa+szNWXH+QqkU8Pb4QETq1VyLtXl6K8dvEmq1WhbFXDP4O3yeJBKedKOJKw==
X-Received: by 2002:a05:620a:3984:b0:75e:bf7e:e17e with SMTP id ro4-20020a05620a398400b0075ebf7ee17emr759677qkn.6.1685993488311;
        Mon, 05 Jun 2023 12:31:28 -0700 (PDT)
Received: from fionn (bras-base-rdwyon0600w-grc-07-184-147-141-56.dsl.bell.ca. [184.147.141.56])
        by smtp.gmail.com with ESMTPSA id u26-20020ae9c01a000000b0075d4d5617cdsm2894567qkk.66.2023.06.05.12.31.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 05 Jun 2023 12:31:28 -0700 (PDT)
Date:   Mon, 5 Jun 2023 15:31:27 -0400 (EDT)
From:   John Kacur <jkacur@redhat.com>
To:     Anubhav Shelat <ashelat@redhat.com>
cc:     linux-rt-users@vger.kernel.org
Subject: Re: [PATCH v2 02/10] rteval: Use f-strings in rtevalConfig
In-Reply-To: <20230601202734.813515-3-ashelat@redhat.com>
Message-ID: <96a49d9e-a1b0-6e64-72ce-e1c02f70fbbf@redhat.com>
References: <20230601202734.813515-1-ashelat@redhat.com> <20230601202734.813515-3-ashelat@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Precedence: bulk
List-ID: <linux-rt-users.vger.kernel.org>
X-Mailing-List: linux-rt-users@vger.kernel.org



On Thu, 1 Jun 2023, Anubhav Shelat wrote:

> Use f-strings in rtevalConfig.py
> 
> Signed-off-by: Anubhav Shelat <ashelat@redhat.com>
> ---
>  rteval/rtevalConfig.py | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/rteval/rtevalConfig.py b/rteval/rtevalConfig.py
> index de88924642ca..41f1a567720f 100644
> --- a/rteval/rtevalConfig.py
> +++ b/rteval/rtevalConfig.py
> @@ -115,7 +115,7 @@ class rtevalCfgSection:
>          "Simple method for dumping config when object is used as a string"
>          if not self.__cfgdata:
>              return "# empty"
> -        return "\n".join(["%s: %s" % (k, v) for k, v in list(self.__cfgdata.items())]) + "\n"
> +        return "\n".join([f"{k}: {v}" for k, v in list(self.__cfgdata.items())]) + "\n"
>  
>  
>      def __setattr__(self, key, val):
> -- 

Signed-off-by: John Kacur <jkacur@redhat.com>

